search_space = ps(
  booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  nrounds = p_dbl(lower = 1, upper = log(2000), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  eta = p_dbl(lower = log(1e-4), upper = log(1), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  gamma = p_dbl(lower = log(1e-4), upper = log(7), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  lambda = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x)),
  alpha = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x)),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("dart", "gbtree")),
  min_child_weight = p_dbl(lower = 1, upper = log(150), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  rate_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  skip_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("40981", "41146", "1489", "1067"), tags = "task_id")
)

domain = ps(
  booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  nrounds = p_int(lower = 3, upper = 2000),
  eta = p_dbl(lower = 1e-4, upper = 1, depends = booster %in% c("dart", "gbtree")),
  gamma = p_dbl(lower = 1e-4, upper = 7, depends = booster %in% c("dart", "gbtree")),
  lambda = p_dbl(lower = 1e-4, upper = 1000),
  alpha = p_dbl(lower = 1e-4, upper = 1000),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("dart", "gbtree")),
  min_child_weight = p_dbl(lower = exp(1), upper = 150, depends = booster %in% c("dart", "gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  rate_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  skip_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
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
