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


search_space = ps(
  num.trees = p_int(lower = 1L, upper = 2000L),
  # replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.power = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("4135", "40981", "4134", "1220", "4154", "4538", "40978", "375",
"40496", "40966", "4534", "40900", "40536", "41156", "1590",
"1457", "458", "469", "41157", "11", "1461", "1462", "1464",
"15", "40975", "41142", "40701", "40994", "23", "1468", "40668",
"29", "31", "6332", "37", "40670", "23381", "151", "188", "41164",
"1475", "1476", "1478", "1479", "41212", "1480", "41143", "1053",
"41027", "1067", "1063", "3", "6", "1485", "1056", "12", "14",
"16", "18", "40979", "22", "1515", "334", "24", "1486", "41278",
"28", "1487", "1068", "1050", "1049", "32", "1489", "470", "1494",
"182", "312", "40984", "1501", "40685", "38", "42", "44", "46",
"40982", "1040", "41146", "377", "40499", "50", "54", "41216",
"307", "1497", "60", "1510", "40983", "40498", "181", "41138",
"41163", "1111", "41159", "300", "41162", "23517", "41165", "4541",
"41161", "41166", "40927", "41150", "23512", "41168", "1493",
"40996", "554", "40923", "41169"), tags = "task_id"
  )
)

domain = ps(
  num.trees = p_int(lower = 1L, upper = 2000L),
  # replace = p_lgl(),
  sample.fraction = p_dbl(lower = 0.1, upper = 1),
  mtry.power = p_dbl(lower = 0, upper = 1),
  respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  min.node.size = p_int(lower = 1L, upper = 100L),
  splitrule = p_fct(levels = c("gini", "extratrees")),
  num.random.splits = p_int(lower = 1L, upper = 100L, depends = splitrule == "extratrees"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("4135", "40981", "4134", "1220", "4154", "4538", "40978", "375",
"40496", "40966", "4534", "40900", "40536", "41156", "1590",
"1457", "458", "469", "41157", "11", "1461", "1462", "1464",
"15", "40975", "41142", "40701", "40994", "23", "1468", "40668",
"29", "31", "6332", "37", "40670", "23381", "151", "188", "41164",
"1475", "1476", "1478", "1479", "41212", "1480", "41143", "1053",
"41027", "1067", "1063", "3", "6", "1485", "1056", "12", "14",
"16", "18", "40979", "22", "1515", "334", "24", "1486", "41278",
"28", "1487", "1068", "1050", "1049", "32", "1489", "470", "1494",
"182", "312", "40984", "1501", "40685", "38", "42", "44", "46",
"40982", "1040", "41146", "377", "40499", "50", "54", "41216",
"307", "1497", "60", "1510", "40983", "40498", "181", "41138",
"41163", "1111", "41159", "300", "41162", "23517", "41165", "4541",
"41161", "41166", "40927", "41150", "23512", "41168", "1493",
"40996", "554", "40923", "41169"), tags = "task_id"
  )
)
