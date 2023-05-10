search_space = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  num.trees = p_int(lower = 1L, upper = 1000L),
  replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.ratio = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "31", "14965", "317599"), tags = "task_id")
)

domain = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  num.trees = p_int(lower = 1L, upper = 1000L),
  replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.ratio = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "31", "14965", "317599"), tags = "task_id")
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
  rammodel = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
