search_space = ps(
  task = p_fct(levels = c("fcnet_naval_propulsion", "fcnet_protein_structure", "fcnet_slice_localization","fcnet_parkinsons_telemonitoring"), tags = "task_id"),
  activation_fn_1 = p_fct(levels = c("relu", "tanh")),
  activation_fn_2 = p_fct(levels = c("relu", "tanh")),
  lr_schedule = p_fct(levels = c("const", "cosine")),
  epoch = p_dbl(lower = log(1), upper = log(100), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x))), tags = "budget"),
  replication = p_int(lower = 1, upper = 4),
  batch_size = p_dbl(lower = log(8), upper = log(64), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  init_lr = p_dbl(lower = log(5e-4), upper = log(1e-1), tags = "log", trafo = function(x) exp(x)),
  dropout_1 = p_dbl(lower = 0, upper = 0.6), 
  dropout_2 = p_dbl(lower = 0, upper = 0.6), 
  n_units_1 = p_int(lower = 16L, upper= 512L),
  n_units_2 = p_int(lower = 16L, upper= 512L)
)
                     
domain = ps(
  task = p_fct(levels = c("fcnet_naval_propulsion", "fcnet_protein_structure", "fcnet_slice_localization","fcnet_parkinsons_telemonitoring"), tags = "task_id"),
  activation_fn_1 = p_fct(levels = c("relu", "tanh")),
  activation_fn_2 = p_fct(levels = c("relu", "tanh")),
  lr_schedule = p_fct(levels = c("const", "cosine")),
  epoch = p_int(lower = 1L, upper = 100L, tags = "budget"),
  replication = p_int(lower = 1, upper = 4),
  batch_size = p_int(lower = 8, upper = 64),
  init_lr = p_dbl(lower = 5e-4, upper = 1e-1),
  dropout_1 = p_dbl(lower = 0, upper = 0.6), 
  dropout_2 = p_dbl(lower = 0, upper = 0.6), 
  n_units_1 = p_int(lower = 16L, upper= 512L),
  n_units_2 = p_int(lower = 16L, upper= 512L)
)
                     
codomain = ps(
  valid_loss = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  valid_mse = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  runtime = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  n_params = p_int(lower = 1, upper = Inf, tags = "minimize")
)
