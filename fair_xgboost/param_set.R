search_space = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  booster = p_fct(levels = c("gblinear", "gbtree")),
  nrounds = p_dbl(lower = log(1), upper = log(1000), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  eta = p_dbl(lower = log(1e-4), upper = log(1), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("gbtree")),
  gamma = p_dbl(lower = log(1e-4), upper = log(7), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("gbtree")),
  lambda = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x)),
  alpha = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x)),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("gbtree")),
  min_child_weight = p_dbl(lower = 1, upper = log(150), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("gbtree")),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
)

domain = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  booster = p_fct(levels = c("gblinear", "gbtree")),
  nrounds = p_int(lower = 1L, upper = 1000L),
  eta = p_dbl(lower = 1e-4, upper = 1, depends = booster %in% c("gbtree")),
  gamma = p_dbl(lower = 1e-4, upper = 7, depends = booster %in% c("gbtree")),
  lambda = p_dbl(lower = 1e-4, upper = 1000),
  alpha = p_dbl(lower = 1e-4, upper = 1000),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("gbtree")),
  min_child_weight = p_dbl(lower = exp(1), upper = 150, depends = booster %in% c("gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("gbtree")),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
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
