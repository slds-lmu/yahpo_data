search_space = ps(
  learner = p_fct(levels = c("ranger", "glmnet", "xgboost", "rpart")),
  ranger.num.trees = p_int(lower = 1L, upper = 2000L, depends = learner == "ranger"),
  ranger.replace = p_lgl(depends = learner == "ranger"),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1, depends = learner == "ranger"),
  ranger.mtry.ratio = p_dbl(lower = 0, upper = 1, depends = learner == "ranger"),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition"), depends = learner == "ranger"),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L, depends = learner == "ranger"),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees"), depends = learner == "ranger"),
  ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees" && learner == "ranger"),

  glmnet.alpha = p_dbl(lower = 0, upper = 1, depends = learner == "glmnet"),
  glmnet.s = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x), depends = learner == "glmnet"),

  xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart"), depends = learner == "xgboost"),
  xgboost.nrounds = p_dbl(lower = 1, upper = log(2000), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x))), depends = learner == "xgboost"),
  xgboost.eta = p_dbl(lower = log(1e-4), upper = 0, tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.gamma = p_dbl(lower = log(1e-4), upper = log(7), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.lambda = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x), depends = learner == "xgboost"),
  xgboost.alpha = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x), depends = learner == "xgboost"),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1, depends = learner == "xgboost"),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.min_child_weight = p_dbl(lower = 1, upper = log(150), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart" && learner == "xgboost"),
  xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart" && learner == "xgboost"),

  rpart.cp = p_dbl(lower = log(1e-4), upper = 0, tags = "log", trafo = function(x) exp(x), depends = learner == "rpart"),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L, depends = learner == "rpart"),
  rpart.minbucket = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),
  rpart.minsplit = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),

  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("40981", "41146", "1489", "1067"), tags = "task_id")
)

domain = ps(
  learner = p_fct(levels = c("ranger", "glmnet", "xgboost", "rpart")),
  ranger.num.trees = p_int(lower = 1L, upper = 2000L, depends = learner == "ranger"),
  ranger.replace = p_lgl(depends = learner == "ranger"),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1, depends = learner == "ranger"),
  ranger.mtry.ratio = p_dbl(lower = 0, upper = 1, depends = learner == "ranger"),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition"), depends = learner == "ranger"),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L, depends = learner == "ranger"),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees"), depends = learner == "ranger"),
  ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees" && learner == "ranger"),

  glmnet.alpha = p_dbl(lower = 0, upper = 1, depends = learner == "glmnet"),
  glmnet.s = p_dbl(lower = 1e-4, upper = 1000, depends = learner == "glmnet"),

  xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart"), depends = learner == "xgboost"),
  xgboost.nrounds = p_int(lower = 3, upper = 2000, depends = learner == "xgboost"),
  xgboost.eta = p_dbl(lower = 1e-4, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.gamma = p_dbl(lower = 1e-4, upper = 7, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.lambda = p_dbl(lower = 1e-4, upper = 1000, depends = learner == "xgboost"),
  xgboost.alpha = p_dbl(lower = 1e-4, upper = 1000, depends = learner == "xgboost"),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1, depends = learner == "xgboost"),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.min_child_weight = p_dbl(lower = exp(1), upper = 150, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree") && learner == "xgboost"),
  xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart" && learner == "xgboost"),
  xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart" && learner == "xgboost"),

  rpart.cp = p_dbl(lower = 1e-4, upper = 1, depends = learner == "rpart"),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L, depends = learner == "rpart"),
  rpart.minbucket = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),
  rpart.minsplit = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),

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
