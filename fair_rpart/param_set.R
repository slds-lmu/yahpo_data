search_space = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  cp = p_dbl(lower = log(1e-4), upper = log(1), tags = "log", trafo = function(x) exp(x)),
  maxdepth = p_int(lower = 1L, upper = 30L),
  minbucket = p_int(lower = 1L, upper = 100L),
  minsplit = p_int(lower = 1L, upper = 100L),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
)

domain = ps(
  pre_post = p_fct(levels = c("none", "post", "pre")),
  reweighing_os_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "pre"),
  EoD_alpha = p_dbl(lower = 0, upper = 1, depends = pre_post == "post"),
  cp = p_dbl(lower = 1e-4, upper = 1),
  maxdepth = p_int(lower = 1L, upper = 30L),
  minbucket = p_int(lower = 1L, upper = 100L),
  minsplit = p_int(lower = 1L, upper = 100L),
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
  fpp = p_dbl(tags = "minimize"),
  ramtrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rammodel = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rampredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
