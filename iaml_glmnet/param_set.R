search_space = ps(
  alpha = p_dbl(lower = 0, upper = 1),
  s = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x)),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("40981", "41146", "1489", "1067"), tags = "task_id")
)

domain = ps(
  alpha = p_dbl(lower = 0, upper = 1),
  s = p_dbl(lower = 1e-4, upper = 1000),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("40981", "41146", "1489", "1067"), tags = "task_id")
)

codomain = ps(
  mmce = p_dbl(lower = 0, upper = 1, tags = "minimize"),
  f1 = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  auc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  logloss = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  ramtrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rammodel = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rampredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  mec = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  ias = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  nf = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
