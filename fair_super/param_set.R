search_space = ps(
  learner = p_fct(levels = c("fgrrm", "rpart", "ranger", "xgboost")),

  fgrrm.lambda = p_dbl(lower = log(1e-4), upper = log(1e3), tags = "log", trafo = function(x) exp(x), depends = learner == "fgrrm"), 
  fgrrm.definition = p_fct(levels = c("sp-komiyama", "eo-komiyama"), depends = learner == "fgrrm"),
  fgrrm.unfairness = p_dbl(lower = 0, upper = 1, depends = learner == "fgrrm"),

  pre_post = p_fct(levels = c("none", "post", "pre"), depends = learner %in% c("rpart", "ranger", "xgboost")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre" && learner %in% c("rpart", "ranger", "xgboost")),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post" && learner %in% c("rpart", "ranger", "xgboost")),
  
  rpart.cp = p_dbl(lower = log(1e-4), upper = log(1), tags = "log", trafo = function(x) exp(x), depends = learner == "rpart"),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L, depends = learner == "rpart"),
  rpart.minbucket = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),
  rpart.minsplit = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),

  ranger.num.trees = p_int(lower = 1L, upper = 1000L, depends = learner == "ranger"),
  ranger.replace = p_lgl(depends = learner == "ranger"),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1, depends = learner == "ranger"),
  ranger.mtry.ratio = p_dbl(lower = 0, upper = 1, depends = learner == "ranger"),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition"), depends = learner == "ranger"),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L, depends = learner == "ranger"),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees"), depends = learner == "ranger"),
  ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees" && learner == "ranger"),

  xgboost.booster = p_fct(levels = c("gblinear", "gbtree"), depends = learner == "xgboost"),
  xgboost.nrounds = p_dbl(lower = log(1), upper = log(1000), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x))), depends = learner == "xgboost"),
  xgboost.eta = p_dbl(lower = log(1e-4), upper = log(1), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.gamma = p_dbl(lower = log(1e-4), upper = log(7), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.lambda = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x), depends = learner == "xgboost"),
  xgboost.alpha = p_dbl(lower = log(1e-4), upper = log(1000), tags = "log", trafo = function(x) exp(x), depends = learner == "xgboost"),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1, depends = learner == "xgboost"),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.min_child_weight = p_dbl(lower = 1, upper = log(150), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),

  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
)

domain = ps(
  learner = p_fct(levels = c("fgrrm", "rpart", "ranger", "xgboost")),

  fgrrm.lambda = p_dbl(lower = 1e-4, upper = 1e3, depends = learner == "fgrrm"), 
  fgrrm.definition = p_fct(levels = c("sp-komiyama", "eo-komiyama"), depends = learner == "fgrrm"),
  fgrrm.unfairness = p_dbl(lower = 0, upper = 1, depends = learner == "fgrrm"),

  pre_post = p_fct(levels = c("none", "post", "pre"), depends = learner %in% c("rpart", "ranger", "xgboost")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre" && learner %in% c("rpart", "ranger", "xgboost")),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post" && learner %in% c("rpart", "ranger", "xgboost")),
  
  rpart.cp = p_dbl(lower = 1e-4, upper = 1, depends = learner == "rpart"),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L, depends = learner == "rpart"),
  rpart.minbucket = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),
  rpart.minsplit = p_int(lower = 1L, upper = 100L, depends = learner == "rpart"),

  ranger.num.trees = p_int(lower = 1L, upper = 1000L, depends = learner == "ranger"),
  ranger.replace = p_lgl(depends = learner == "ranger"),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1, depends = learner == "ranger"),
  ranger.mtry.ratio = p_dbl(lower = 0, upper = 1, depends = learner == "ranger"),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition"), depends = learner == "ranger"),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L, depends = learner == "ranger"),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees"), depends = learner == "ranger"),
  ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees" && learner == "ranger"),

  xgboost.booster = p_fct(levels = c("gblinear", "gbtree"), depends = learner == "xgboost"),
  xgboost.nrounds = p_int(lower = 1L, upper = 1000L, depends = learner == "xgboost"),
  xgboost.eta = p_dbl(lower = 1e-4, upper = 1, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.gamma = p_dbl(lower = 1e-4, upper = 7, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.lambda = p_dbl(lower = 1e-4, upper = 1000, depends = learner == "xgboost"),
  xgboost.alpha = p_dbl(lower = 1e-4, upper = 1000, depends = learner == "xgboost"),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1, depends = learner == "xgboost"),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.min_child_weight = p_dbl(lower = exp(1), upper = 150, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("gbtree") && learner == "xgboost"),

  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
)

codomain = ps(
  mmce = p_dbl(lower = 0, upper = 1, tags = "minimize"),
  f1 = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  feo = p_dbl(tags = "minimize"),
  fpredp = p_dbl(tags = "minimize"),
  facc = p_dbl(tags = "minimize"),
  ftpr = p_dbl(tags = "minimize"),
  ffomr = p_dbl(tags = "minimize"),
  ffnr = p_dbl(tags = "minimize"),
  #fpp = p_dbl(tags = "minimize"),
  #ramtrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rammodel = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  #rampredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize")
  #timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
