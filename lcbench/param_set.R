search_space = ps(
  OpenML_task_id = p_fct(levels = c(
    "3945",   "7593",  "34539", "126025", "126026", "126029", "146212",
    "167104", "167149", "167152", "167161", "167168", "167181", "167184", "167185",
    "167190", "167200", "167201", "168329", "168330", "168331", "168335", "168868",
    "168908", "168910", "189354", "189862", "189865", "189866", "189873", "189905",
    "189906", "189908", "189909"), tags = "task_id"),
  epoch = p_int(lower = 1L, upper = 52L, tags = "budget"),
  batch_size = p_dbl(lower = log(16L), upper = log(512L), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  learning_rate = p_dbl(lower = log(1e-4), upper = log(1e-1), tags = "log", trafo = function(x) exp(x)),
  momentum = p_dbl(lower = 0.1, upper = 0.99),
  weight_decay = p_dbl(lower = 1e-5, upper = 1e-1),
  num_layers = p_int(lower = 1L, upper = 5L),
  max_units = p_dbl(lower = log(64L), upper = log(1024L), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  max_dropout = p_dbl(lower = 0, upper = 1)
)

domain = ps(
  OpenML_task_id = p_fct(levels = c(
    "3945",   "7593",  "34539", "126025", "126026", "126029", "146212",
    "167104", "167149", "167152", "167161", "167168", "167181", "167184", "167185",
    "167190", "167200", "167201", "168329", "168330", "168331", "168335", "168868",
    "168908", "168910", "189354", "189862", "189865", "189866", "189873", "189905",
    "189906", "189908", "189909"), tags = "task_id"),
  epoch = p_int(lower = 1L, upper = 52L, tags = "budget"),
  batch_size = p_int(lower = 16L, upper = 512L),
  learning_rate = p_dbl(lower = 1e-4, upper = 1e-1),
  momentum = p_dbl(lower = 0.1, upper = 0.99),
  weight_decay = p_dbl(lower = 1e-5, upper = 1e-1),
  num_layers = p_int(lower = 1L, upper = 5L),
  max_units = p_int(lower = 64L, upper = 1024L),
  max_dropout = p_dbl(lower = 0, upper = 1)
)

codomain = ps(
  val_accuracy = p_dbl(lower = 0, upper = 100, tags = "maximize"),
  val_cross_entropy = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  val_balanced_accuracy = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  test_cross_entropy = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  test_balanced_accuracy = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  time = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
