search_space = ps(
  kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  cost = p_dbl(lower = log(4.5399929762484854e-05), upper = log(22026.465794806718), tags = "log", trafo = function(x) exp(x)),
  gamma = p_dbl(lower = log(4.5399929762484854e-05), upper = log(22026.465794806718), tags = "log", trafo = function(x) exp(x), depends = kernel == "radial"),
  tolerance = p_dbl(lower = log(4.5399929762484854e-05), upper = log(2.0), tags = "log", trafo = function(x) exp(x)),
  degree = p_int(lower = 2L, upper = 5L, depends = kernel == "polynomial"),
  shrinking = p_lgl(),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "6332", "23381", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "41027", "41138", "41142", "41143", "41146", "41156", "41157", "41162", "41163", "41164", "41169"), tags = "task_id")
)

domain = ps(
  kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  cost = p_dbl(lower = 4.5399929762484854e-05, upper = 22026.465794806718),
  gamma = p_dbl(lower = 4.5399929762484854e-05, upper = 22026.465794806718, depends = kernel == "radial"),
  tolerance = p_dbl(lower = 4.5399929762484854e-05, upper = 2),
  degree = p_int(lower = 2L, upper = 5L, depends = kernel == "polynomial"),
  shrinking = p_lgl(),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "6332", "23381", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "41027", "41138", "41142", "41143", "41146", "41156", "41157", "41162", "41163", "41164", "41169"), tags = "task_id")
)

codomain = ps(
  acc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  bac = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  #f1 = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  auc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  brier = p_dbl(lower = 0, upper = 1, tags = "minimize"),
  logloss = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize")
  #memory = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
