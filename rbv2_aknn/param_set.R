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
  k = p_int(lower = 1L, upper = 50L),
  distance = p_fct(levels = c("l2", "cosine", "ip")),
  M = p_int(lower = 18L, upper = 50L),
  ef = p_dbl(lower = 2.07, upper = 5.54, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  ef_construction = p_dbl(lower = 2.07, upper = 6.238, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels =c("41138", "40981", "4134", "40927", "1220", "4154", "41163",
"40996", "4538", "40978", "375", "1111", "40496", "40966", "41150",
"4534", "40900", "40536", "41156", "1590", "1457", "458", "469",
"41157", "11", "1461", "1462", "1464", "15", "40975", "41142",
"40701", "40994", "23", "1468", "40668", "29", "31", "6332",
"37", "4541", "40670", "23381", "151", "188", "41164", "1475",
"1476", "41159", "1478", "41169", "23512", "1479", "41212", "1480",
"300", "41168", "41143", "1053", "41027", "1067", "1063", "41162",
"3", "6", "1485", "1056", "12", "14", "16", "18", "40979", "22",
"1515", "554", "334", "24", "1486", "23517", "41278", "1493",
"28", "1487", "1068", "1050", "1049", "32", "1489", "470", "1494",
"41161", "41165", "182", "312", "40984", "1501", "40685", "38",
"42", "44", "46", "40982", "1040", "41146", "377", "40499", "50",
"54", "41216", "41166", "307", "1497", "60", "1510", "40983",
"40498", "181", "40923"),
    tags = "task_id"
  )
)

domain = ps(
  k = p_int(lower = 1L, upper = 50L),
  distance = p_fct(levels = c("l2", "cosine", "ip")),
  M = p_int(lower = 18L, upper = 50L),
  ef = p_int(lower = 8L, upper = 256L),
  ef_construction = p_int(lower = 8L, upper = 512L),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("41138", "40981", "4134", "40927", "1220", "4154", "41163",
"40996", "4538", "40978", "375", "1111", "40496", "40966", "41150",
"4534", "40900", "40536", "41156", "1590", "1457", "458", "469",
"41157", "11", "1461", "1462", "1464", "15", "40975", "41142",
"40701", "40994", "23", "1468", "40668", "29", "31", "6332",
"37", "4541", "40670", "23381", "151", "188", "41164", "1475",
"1476", "41159", "1478", "41169", "23512", "1479", "41212", "1480",
"300", "41168", "41143", "1053", "41027", "1067", "1063", "41162",
"3", "6", "1485", "1056", "12", "14", "16", "18", "40979", "22",
"1515", "554", "334", "24", "1486", "23517", "41278", "1493",
"28", "1487", "1068", "1050", "1049", "32", "1489", "470", "1494",
"41161", "41165", "182", "312", "40984", "1501", "40685", "38",
"42", "44", "46", "40982", "1040", "41146", "377", "40499", "50",
"54", "41216", "41166", "307", "1497", "60", "1510", "40983",
"40498", "181", "40923"),
    tags = "task_id"
  )
)
