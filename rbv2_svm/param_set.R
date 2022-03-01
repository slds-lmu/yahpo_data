search_space = ps(
  kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  cost = p_dbl(lower = -10, upper = 10, tags = "log", trafo = function(x) exp(x)),
  gamma = p_dbl(lower = -10, upper = 10, tags = "log", trafo = function(x) exp(x), depends = kernel == "radial"),
  tolerance = p_dbl(lower = -10, upper = log(2), tags = "log", trafo = function(x) exp(x)),
  degree = p_int(lower = 2L, upper = 5L, depends = kernel == "polynomial"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("40981", "4134", "1220", "40978", "40966", "40536", "41156",
"458", "41157", "40975", "40994", "1468", "6332", "40670", "151",
"1475", "1476", "1478", "1479", "41212", "1480", "1053", "1067",
"1056", "12", "1487", "1068", "32", "470", "312", "38", "40982",
"50", "41216", "307", "40498", "181", "1464", "41164", "16",
"1461", "41162", "6", "14", "1494", "54", "375", "1590", "23",
"41163", "1111", "41027", "40668", "41138", "4135", "4538", "40496",
"4534", "40900", "1457", "11", "1462", "41142", "40701", "29",
"37", "23381", "188", "41143", "1063", "3", "18", "40979", "22",
"1515", "334", "24", "1493", "28", "1050", "1049", "40984", "40685",
"42", "44", "46", "1040", "41146", "377", "40499", "1497", "60",
"40983", "4154", "469", "31", "41278", "1489", "1501", "15",
"300", "1485", "1486", "1510", "182", "41169"),
    tags = "task_id"
  )
)

domain = ps(
  kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  cost = p_dbl(lower = exp(-10), upper = exp(10)),
  gamma = p_dbl(lower = exp(-10), upper = exp(10), depends = kernel == "radial"),
  tolerance = p_dbl(lower = exp(-10), upper = 2),
  degree = p_int(lower = 2L, upper = 5L, depends = kernel == "polynomial"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels =c("40981", "4134", "1220", "40978", "40966", "40536", "41156",
"458", "41157", "40975", "40994", "1468", "6332", "40670", "151",
"1475", "1476", "1478", "1479", "41212", "1480", "1053", "1067",
"1056", "12", "1487", "1068", "32", "470", "312", "38", "40982",
"50", "41216", "307", "40498", "181", "1464", "41164", "16",
"1461", "41162", "6", "14", "1494", "54", "375", "1590", "23",
"41163", "1111", "41027", "40668", "41138", "4135", "4538", "40496",
"4534", "40900", "1457", "11", "1462", "41142", "40701", "29",
"37", "23381", "188", "41143", "1063", "3", "18", "40979", "22",
"1515", "334", "24", "1493", "28", "1050", "1049", "40984", "40685",
"42", "44", "46", "1040", "41146", "377", "40499", "1497", "60",
"40983", "4154", "469", "31", "41278", "1489", "1501", "15",
"300", "1485", "1486", "1510", "182", "41169"),
    tags = "task_id"
  )
)

codomain = ps(
  acc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  bac = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  f1 = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  auc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  brier = p_dbl(lower = 0, upper = 1, tags = "minimize"),
  logloss = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  memory = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
