search_space = ps(
  lambda = p_dbl(lower = log(1e-4), upper = log(1e3), tags = "log", trafo = function(x) exp(x)), 
  definition = p_fct(levels = c("sp-komiyama", "eo-komiyama")),
  unfairness = p_dbl(lower = 0, upper = 1),
  trainsize = p_dbl(lower = 1/9, upper = 1, tags = "budget"),
  task_id = p_fct(levels = c("190424", "7592", "31", "14965", "317599"), tags = "task_id")
)

domain = ps(
  lambda = p_dbl(lower = 1e-4, upper = 1e3),
  definition = p_fct(levels = c("sp-komiyama", "eo-komiyama")),
  unfairness = p_dbl(lower = 0, upper = 1),
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
  ramtrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rammodel = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  rampredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
