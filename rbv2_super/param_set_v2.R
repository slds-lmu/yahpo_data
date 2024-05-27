search_space = ps(
  # svm
  svm.kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  svm.cost = p_dbl(lower = log(4.5399929762484854e-05), upper = log(22026.465794806718), tags = "log", trafo = function(x) exp(x)),
  svm.gamma = p_dbl(lower = log(4.5399929762484854e-05), upper = log(22026.465794806718), tags = "log", trafo = function(x) exp(x), depends = svm.kernel == "radial"),
  svm.tolerance = p_dbl(lower = log(4.5399929762484854e-05), upper = log(2.0), tags = "log", trafo = function(x) exp(x)),
  svm.degree = p_int(lower = 2L, upper = 5L, depends = svm.kernel == "polynomial"),
  svm.shrinking = p_lgl(),
  # glmnet
  glmnet.alpha = p_dbl(lower = 0, upper = 1),
  glmnet.s = p_dbl(lower = log(0.0009118819655545162), upper = log(1096.6331584284585), tags = "log", trafo = function(x) exp(x)),
  # rpart
  rpart.cp = p_dbl(lower = log(0.0009118819655545162), upper = 0, tags = "log", trafo = function(x) exp(x)),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L),
  rpart.minbucket = p_int(lower = 1L, upper = 100L),
  rpart.minsplit = p_int(lower = 1L, upper = 100L),
  # ranger
  ranger.num.trees = p_int(lower = 1L, upper = 2000L),
  ranger.replace = p_lgl(),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1),
  ranger.mtry.power = p_dbl(lower = 0, upper = 1),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees")),
  ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees"),
  # aknn
  aknn.k = p_int(lower = 1L, upper = 50L),
  aknn.distance = p_fct(levels = c("l2", "cosine", "ip")),
  aknn.M = p_int(lower = 18L, upper = 50L),
  aknn.ef = p_dbl(lower = log(8), upper = log(256), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  aknn.ef_construction = p_dbl(lower = log(8), upper = log(512), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  # xgboost
  xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  xgboost.nrounds = p_dbl(lower = log(7), upper = log(2981), tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
  xgboost.eta = p_dbl(lower = log(0.0009118819655545162), upper = 0, tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.gamma = p_dbl(lower = log(4.5399929762484854e-05), upper = log(7.38905609893065), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.lambda = p_dbl(lower = log(0.0009118819655545162), upper = log(1096.6331584284585), tags = "log", trafo = function(x) exp(x)),
  xgboost.alpha = p_dbl(lower = log(0.0009118819655545162), upper = log(1096.6331584284585), tags = "log", trafo = function(x) exp(x)),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.min_child_weight = p_dbl(lower = 1, upper = log(148.4131591025766), tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
  xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),

  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  learner_id = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "554", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "4541", "6332", "23381", "23512", "23517", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40923", "40927", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "40996", "41027", "41138", "41142", "41143", "41146", "41150", "41156", "41157", "41159", "41161", "41162", "41163", "41164", "41165", "41166", "41168", "41169"), tags = "task_id")
)
# Add dependencies
map(search_space$params$learner_id$levels, function(x) {
    nms = names(search_space$params)[startsWith(names(search_space$params), x)]
    map(nms, function(nm) search_space$add_dep(nm, "learner_id", CondEqual$new(x)))
})

domain = ps(
  # svm
  svm.kernel = p_fct(levels = c("linear", "polynomial", "radial")),
  svm.cost = p_dbl(lower = 4.5399929762484854e-05, upper = 22026.465794806718),
  svm.gamma = p_dbl(lower = 4.5399929762484854e-05, upper = 22026.465794806718, depends = svm.kernel == "radial"),
  svm.tolerance = p_dbl(lower = 4.5399929762484854e-05, upper = 2),
  svm.degree = p_int(lower = 2L, upper = 5L, depends = svm.kernel == "polynomial"),
  svm.shrinking = p_lgl(),
  # glmnet
  glmnet.alpha = p_dbl(lower = 0, upper = 1),
  glmnet.s = p_dbl(lower = 0.0009118819655545162, upper = 1096.6331584284585),
  # rpart
  rpart.cp = p_dbl(lower = 0.0009118819655545162, upper = 1),
  rpart.maxdepth = p_int(lower = 1L, upper = 30L),
  rpart.minbucket = p_int(lower = 1L, upper = 100L),
  rpart.minsplit = p_int(lower = 1L, upper = 100L),
  # ranger
  ranger.num.trees = p_int(lower = 1L, upper = 2000L),
  ranger.replace = p_lgl(),
  ranger.sample.fraction = p_dbl(lower = 0.1, upper = 1),
  ranger.mtry.power = p_dbl(lower = 0, upper = 1),
  ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
  ranger.min.node.size = p_int(lower = 1L, upper = 100L),
  ranger.splitrule = p_fct(levels = c("gini", "extratrees")),
  ranger.num.random.splits = p_int(lower = 1, upper = 100L, depends = ranger.splitrule == "extratrees"),
  # aknn
  aknn.k = p_int(lower = 1L, upper = 50L),
  aknn.distance = p_fct(levels = c("l2", "cosine", "ip")),
  aknn.M = p_int(lower = 18L, upper = 50L),
  aknn.ef = p_int(lower = 8L, upper = 256L),
  aknn.ef_construction = p_int(lower = 8L, upper = 512L),
  # xgboost
  xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
  xgboost.nrounds = p_int(lower = 7L, upper = 2981L),
  xgboost.eta = p_dbl(lower = 0.0009118819655545162, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.gamma = p_dbl(lower = 4.5399929762484854e-05, upper = 7.38905609893065, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.lambda = p_dbl(lower = 0.0009118819655545162, upper = 1096.6331584284585),
  xgboost.alpha = p_dbl(lower = 0.0009118819655545162, upper = 1096.6331584284585),
  xgboost.subsample = p_dbl(lower = 0.1, upper = 1),
  xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.min_child_weight = p_dbl(lower = exp(1), upper = 148.4131591025766, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
  xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
  xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),

  trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
  repl = p_fct(levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), tags = "budget"),
  num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
  learner_id = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
  task_id = p_fct(levels = c("3", "6", "11", "12", "14", "15", "16", "18", "22", "23", "24", "28", "29", "31", "32", "37", "38", "42", "44", "46", "50", "54", "60", "151", "181", "182", "188", "300", "307", "312", "334", "375", "377", "458", "469", "470", "554", "1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068", "1111", "1220", "1457", "1461", "1462", "1464", "1468", "1475", "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489", "1493", "1494", "1497", "1501", "1510", "1515", "1590", "4134", "4135", "4154", "4534", "4538", "4541", "6332", "23381", "23512", "23517", "40496", "40498", "40499", "40536", "40668", "40670", "40685", "40701", "40900", "40923", "40927", "40966", "40975", "40978", "40979", "40981", "40982", "40983", "40984", "40994", "40996", "41027", "41138", "41142", "41143", "41146", "41150", "41156", "41157", "41159", "41161", "41162", "41163", "41164", "41165", "41166", "41168", "41169"), tags = "task_id")
)
# Add dependencies
map(domain$params$learner_id$levels, function(x) {
  nms = names(domain$params)[startsWith(names(domain$params), x)]
  map(nms, function(nm) domain$add_dep(nm, "learner_id", CondEqual$new(x)))
})

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
