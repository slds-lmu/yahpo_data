search_space = ps(
  num.trees = p_int(lower = 1L, upper = 2000L),
  replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.ratio = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("40981", "41146", "1489", "1067"), tags = "task_id")
)

domain = ps(
  num.trees = p_int(lower = 1L, upper = 2000L),
  replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.ratio = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
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
