codomain = ps(
  mmce = p_dbl(lower = 0, upper = 1, tags = "minimize"),
  f1 = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  auc = p_dbl(lower = 0, upper = 1, tags = "maximize"),
  logloss = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timetrain = p_dbl(lower = 0, upper = Inf, tags = "minimize"),
  timepredict = p_dbl(lower = 0, upper = Inf, tags = "minimize")
)
domain = ps(
  cp = p_dbl(lower = -7, upper = 0, default = log(0.01), tags = "log", trafo = function(x) exp(x)),
  maxdepth = p_int(lower = 1, upper = 30, default = 30),
  minbucket = p_int(lower = 1, upper = 100, default = 1),
  minsplit = p_int(lower = 1, upper = 100, default = 20),
  trainsize = p_dbl(lower = 0.05, upper = 1, tag = "budget"),
  repl = p_int(lower = 1, upper = 10, tag = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068",
    "11", "1111", "12", "14", "1457", "1461", "1462", "1464", "1468",
    "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487",
    "1489", "1494", "1497", "15", "1501", "1510", "1515", "1590",
    "16", "18", "181", "182", "188", "22", "23", "23381", "23512",
    "24", "28", "29", "3", "300", "307", "31", "312", "32", "334",
    "37", "375", "377", "38", "40496", "40498", "40499", "40536",
    "40670", "40701", "40900", "40927", "40966", "40975", "40978",
    "40979", "40981", "40982", "40983", "40984", "40994", "41138",
    "41142", "41143", "41146", "41156", "41157", "41159", "41161",
    "41162", "41163", "41164", "41165", "41212", "4134", "4135",
    "4154", "42", "44", "4534", "4538", "458", "46", "469", "470",
    "50", "54", "60", "6332")
    , tags = "task_id")
)