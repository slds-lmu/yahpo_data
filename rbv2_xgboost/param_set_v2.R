search_space = ps(
  booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  nrounds = p_dbl(lower = log(7), upper = log(2981), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  eta = p_dbl(lower = log(0.0009118819655545162), upper = 0, tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  gamma = p_dbl(lower = log(4.5399929762484854e-05), upper = log(7.38905609893065), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  lambda = p_dbl(lower = log(0.0009118819655545162), upper = log(1096.6331584284585), tags = "log", trafo = function(x) exp(x)),
  alpha = p_dbl(lower = log(0.0009118819655545162), upper = log(1096.6331584284585), tags = "log", trafo = function(x) exp(x)),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("dart", "gbtree")),
  min_child_weight = p_dbl(lower = 1, upper = log(148.4131591025766), tags = "log", trafo = function(x) exp(x), depends = booster %in% c("dart", "gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  rate_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  skip_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "554", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "4541", "6332", "23381", "23512", "23517", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40923", "40927", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "40996", "41027", "41138", "41142", "41143", "41146", "41150", "41156", "41157", "41159", "41161", "41162", "41163", "41164", "41165", "41166", "41168", "41169"), tags = "task_id")
)

domain = ps(
  booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  nrounds = p_int(lower = 7L, upper = 2981L),
  eta = p_dbl(lower = 0.0009118819655545162, upper = 1, depends = booster %in% c("dart", "gbtree")),
  gamma = p_dbl(lower = 4.5399929762484854e-05, upper = 7.38905609893065, depends = booster %in% c("dart", "gbtree")),
  lambda = p_dbl(lower = 0.0009118819655545162, upper = 1096.6331584284585),
  alpha = p_dbl(lower = 0.0009118819655545162, upper = 1096.6331584284585),
  subsample = p_dbl(lower = 0.1, upper = 1),
  max_depth = p_int(lower = 1L, upper = 15L, depends = booster %in% c("dart", "gbtree")),
  min_child_weight = p_dbl(lower = exp(1), upper = 148.4131591025766, depends = booster %in% c("dart", "gbtree")),
  colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = booster %in% c("dart", "gbtree")),
  rate_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  skip_drop = p_dbl(lower = 0, upper = 1, depends = booster == "dart"),
  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "554", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "4541", "6332", "23381", "23512", "23517", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40923", "40927", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "40996", "41027", "41138", "41142", "41143", "41146", "41150", "41156", "41157", "41159", "41161", "41162", "41163", "41164", "41165", "41166", "41168", "41169"), tags = "task_id")
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
