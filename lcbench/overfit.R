library(data.table)
library(mlr3misc)
library(ggplot2)
library(pammtools)
library(gridExtra)
library(progress)
dat = as.data.table(read.csv("raw.csv"))

dat = dat[epoch > 1 & epoch < 52]
dat[, epoch := epoch - 1]

full = dat[epoch == 50]

task_ids = unique(full$OpenML_task_id)

#targets = c("val_balanced_accuracy", "test_balanced_accuracy")
#direction = "maximize"
targets = c("val_cross_entropy", "test_cross_entropy")
direction = "minimize"

# something like a monotonicity loss
overfitting = function(x) {
  tmp = outer(x, x, "-")
  tmp[lower.tri(tmp, diag = TRUE)] = 0
  tmp[tmp > 0] = 0
  - apply(tmp, MARGIN = 2L, FUN = min)  # the previous better solution but sign corrected
}

compute_stats = function(x, target_val, target_test, direction, n, n_repl = 100L) {
  if (direction == "maximize") {
    x[[target_val]] = - x[[target_val]]
    x[[target_test]] = - x[[target_test]]
  }
  x = setorderv(x, cols = target_val)
  tau = cor(x[[target_val]], x[[target_test]], method = "kendall")
  n_10_best = ceiling(nrow(x) * 0.1)
  tau_local = cor(x[[target_val]][seq_len(n_10_best)], x[[target_test]][seq_len(n_10_best)], method = "kendall")

  best = x[, .(min(get(target_val)), min(get(target_test)))]
  colnames(best) = c(target_val, target_test)
  best = best[, c(1L, 2L, 2L)]
  worst = x[, .(max(get(target_val)), max(get(target_test)))]
  colnames(worst) = c(target_val, target_test)
  worst = worst[, c(1L, 2L, 2L)]

  stats = map_dtr(seq_len(n_repl), function(r) {
    x_sampled = x[sample(.N, size = n, replace = TRUE), ]
    result = x_sampled[, .(cummin(get(target_val)), cummin(get(target_test)))]
    colnames(result) = paste0("cummin_", c(target_val, target_test))
    best_test_valid = map_dtr(seq_len(n), function(i) {
      data.table(x_sampled[1:i, ][get(target_val) == min(get(target_val))][sample(.N, size = 1L)][[target_test]])
    })
    colnames(best_test_valid) = "test_by_best_valid"
    result = cbind(result, best_test_valid)
    normalized = (result - best[rep(1L, n), ]) / (worst[rep(1L, n), ] - best[rep(1L, n), ])
    normalized[, overfit := overfitting(test_by_best_valid)]
    normalized[, iteration := seq_len(n)]
    normalized[, replication := r]
    normalized = melt(normalized, measure.vars = c(paste0("cummin_", c(target_val, target_test)), "test_by_best_valid", "overfit"), variable.name = "type", value.name = "normalized")
    normalized
  })
  attr(stats, which = "tau") = tau
  attr(stats, which = "tau_local") = tau_local
  stats
}

pb = progress_bar$new(total = length(task_ids))
all_stats = map_dtr(task_ids, function(task_id) {
  pb$tick()
  tmp = full[OpenML_task_id == task_id]
  stats = compute_stats(tmp, target_val = targets[1L], target_test = targets[2L], direction = direction, n = 1000L)
  mean_stats = stats[, .(mean_normalized = mean(normalized), se_normalized = sd(normalized) / sqrt(.N)), by = .(iteration, type)]
  mean_stats[, task_id := paste0(task_id, "; ", round(attr(stats, which = "tau"), 3), "; ", round(attr(stats, which = "tau_local"), 3))]
  mean_stats
})

overfit = all_stats[type == "overfit", .(integrated_overfit = sum(mean_normalized)), by = .(task_id)]
overfit[, tau := map_dbl(task_id, function(x) {
  as.numeric(strsplit(x, "; ")[[1L]][2L])
})]
overfit[, tau_local := map_dbl(task_id, function(x) {
  as.numeric(strsplit(x, "; ")[[1L]][3L])
})]
lm1 = lm(integrated_overfit ~ tau + tau_local, data = overfit)

#Call:
#lm(formula = integrated_overfit ~ tau + tau_local, data = overfit)
#
#Residuals:
#    Min      1Q  Median      3Q     Max 
#-21.957  -6.193   1.223   4.565  41.558 
#
#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   40.903     17.701   2.311 0.027441 *  
#tau           -7.186     24.559  -0.293 0.771709    
#tau_local    -40.796      9.418  -4.332 0.000137 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 13.42 on 32 degrees of freedom
#Multiple R-squared:  0.5707,    Adjusted R-squared:  0.5439 
#F-statistic: 21.27 on 2 and 32 DF,  p-value: 1.33e-06

#Call:
#lm(formula = integrated_overfit ~ tau + tau_local, data = overfit)
#
#Residuals:
#     Min       1Q   Median       3Q      Max 
#-19.9422  -3.1963  -0.7010   0.7669  29.8807 
#
#Coefficients:
#            Estimate Std. Error t value Pr(>|t|)    
#(Intercept)   42.033      9.749   4.311 0.000145 ***
#tau          -28.541     13.030  -2.190 0.035895 *  
#tau_local    -15.442      5.926  -2.606 0.013798 *  
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Residual standard error: 7.754 on 32 degrees of freedom
#Multiple R-squared:  0.4691,    Adjusted R-squared:  0.436 
#F-statistic: 14.14 on 2 and 32 DF,  p-value: 3.978e-05

all_stats10 = all_stats[iteration >= 10]
g = ggplot(aes(x = iteration, y = mean_normalized), data = all_stats10) +
  geom_step(aes(x = iteration, y = mean_normalized, colour = type)) +
  geom_stepribbon(aes(x = iteration, min = mean_normalized - se_normalized, max = mean_normalized + se_normalized, fill = type), alpha = 0.3, colour = NA) +
  scale_x_log10() +
  facet_wrap(~ task_id, scales = "free", ncol = 7L) +
  theme_minimal() +
  theme(legend.position = "bottom")

#ggsave("overfit_acc.png", plot = g, width = 20, height = 10)
ggsave("overfit_cross.png", plot = g, width = 20, height = 10)

