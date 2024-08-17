search_space = ps(
    # svm
    svm.kernel = p_fct(levels = c("linear", "polynomial", "radial")),
    svm.cost = p_dbl(lower = -10, upper = 10, tags = "log", trafo = function(x) exp(x)),
    svm.gamma = p_dbl(lower = -10, upper = 10, tags = "log", trafo = function(x) exp(x), depends = svm.kernel == "radial"),
    svm.tolerance = p_dbl(lower = -10, upper = log(2), tags = "log", trafo = function(x) exp(x)),
    svm.degree = p_int(lower = 2L, upper = 5L, depends = svm.kernel == "polynomial"),
    # glmnet
    glmnet.alpha = p_dbl(lower = 0, upper = 1),
    glmnet.s = p_dbl(lower = -7, upper = 7, tags = "log", trafo = function(x) exp(x)),
    # rpart
    rpart.cp = p_dbl(lower = -7, upper = 0, tags = "log", trafo = function(x) exp(x)),
    rpart.maxdepth = p_int(lower = 1L, upper = 30L),
    rpart.minbucket = p_int(lower = 1L, upper = 100L),
    rpart.minsplit = p_int(lower = 1L, upper = 100L),
    # ranger
    ranger.num.trees = p_int(lower = 1L, upper = 2000L),
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
    aknn.ef = p_dbl(lower = 2.07, upper = 5.54, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
    aknn.ef_construction = p_dbl(lower = 2.07, upper = 6.238, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
    # xgboost
    xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
    xgboost.nrounds = p_dbl(lower = 2, upper = 8, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
    xgboost.eta = p_dbl(lower = -7, upper = 0, tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.gamma = p_dbl(lower = -10, upper = 2, tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.lambda = p_dbl(lower = -7, upper = 7, tags = "log", trafo = function(x) exp(x)),
    xgboost.alpha = p_dbl(lower = -7, upper = 7, tags = "log", trafo = function(x) exp(x)),
    xgboost.subsample = p_dbl(lower = 0.1, upper = 1),
    xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.min_child_weight = p_dbl(lower = 1, upper = 5, tags = "log", trafo = function(x) exp(x), depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
    xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
    trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
    repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
    num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
    learner_id = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
    task_id = p_fct(levels = c("41138", "40981", "4134", "1220", "4154", "41163", "4538",
    "40978", "375", "1111", "40496", "40966", "4534", "40900", "40536",
    "41156", "1590", "1457", "458", "469", "41157", "11", "1461",
    "1462", "1464", "15", "40975", "41142", "40701", "40994", "23",
    "1468", "40668", "29", "31", "6332", "37", "40670", "23381",
    "151", "188", "41164", "1475", "1476", "1478", "41169", "1479",
    "41212", "1480", "300", "41143", "1053", "41027", "1067", "1063",
    "41162", "3", "6", "1485", "1056", "12", "14", "16", "18", "40979",
    "22", "1515", "334", "24", "1486", "1493", "28", "1487", "1068",
    "1050", "1049", "32", "1489", "470", "1494", "182", "312", "40984",
    "1501", "40685", "38", "42", "44", "46", "40982", "1040", "41146",
    "377", "40499", "50", "54", "307", "1497", "60", "1510", "40983",
    "40498", "181"),
      tags = "task_id"
    )
)
# Add dependencies
map(search_space$levels$learner_id, function(x) {
    nms = search_space$ids()[startsWith(search_space$ids(), paste0(x, "."))]
    map(nms, function(nm) search_space$add_dep(nm, "learner_id", CondEqual(x)))
})

domain = ps(
    # svm
    svm.kernel = p_fct(levels = c("linear", "polynomial", "radial")),
    svm.cost = p_dbl(lower = exp(-10), upper = exp(10)),
    svm.gamma = p_dbl(lower = exp(-10), upper = exp(10), depends = svm.kernel == "radial"),
    svm.tolerance = p_dbl(lower = exp(-10), upper = 2),
    svm.degree = p_int(lower = 2L, upper = 5L, depends = svm.kernel == "polynomial"),
    # glmnet
    glmnet.alpha = p_dbl(lower = 0, upper = 1),
    glmnet.s = p_dbl(lower = exp(-7), upper = exp(7)),
    # rpart
    rpart.cp = p_dbl(lower = exp(-7), upper = exp(0)),
    rpart.maxdepth = p_int(lower = 1L, upper = 30L),
    rpart.minbucket = p_int(lower = 1L, upper = 100L),
    rpart.minsplit = p_int(lower = 1L, upper = 100L),
    # ranger
    ranger.num.trees = p_int(lower = 1L, upper = 2000L),
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
    xgboost.eta = p_dbl(lower = exp(-7), upper = exp(0),depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.gamma = p_dbl(lower = exp(-10), upper = exp(2), depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.lambda = p_dbl(lower = exp(-7), upper = exp(7)),
    xgboost.alpha = p_dbl(lower = exp(-7), upper = exp(7)),
    xgboost.subsample = p_dbl(lower = 0.1, upper = 1),
    xgboost.max_depth = p_int(lower = 1L, upper = 15L, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.min_child_weight = p_dbl(lower = exp(1), upper = exp(5), depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.colsample_bytree = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.colsample_bylevel = p_dbl(lower = 0.01, upper = 1, depends = xgboost.booster %in% c("dart", "gbtree")),
    xgboost.rate_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
    xgboost.skip_drop = p_dbl(lower = 0, upper = 1, depends = xgboost.booster == "dart"),
    # learner_id
    trainsize = p_dbl(lower = 0.03, upper = 1, tags = "budget"),
    repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
    num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
    learner_id = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
    task_id = p_fct(levels = c("41138", "40981", "4134", "1220", "4154", "41163", "4538",
    "40978", "375", "1111", "40496", "40966", "4534", "40900", "40536",
    "41156", "1590", "1457", "458", "469", "41157", "11", "1461",
    "1462", "1464", "15", "40975", "41142", "40701", "40994", "23",
    "1468", "40668", "29", "31", "6332", "37", "40670", "23381",
    "151", "188", "41164", "1475", "1476", "1478", "41169", "1479",
    "41212", "1480", "300", "41143", "1053", "41027", "1067", "1063",
    "41162", "3", "6", "1485", "1056", "12", "14", "16", "18", "40979",
    "22", "1515", "334", "24", "1486", "1493", "28", "1487", "1068",
    "1050", "1049", "32", "1489", "470", "1494", "182", "312", "40984",
    "1501", "40685", "38", "42", "44", "46", "40982", "1040", "41146",
    "377", "40499", "50", "54", "307", "1497", "60", "1510", "40983",
    "40498", "181"),
      tags = "task_id"
    )
)
# Add dependencies
map(domain$levels$learner_id, function(x) {
    nms = domain$ids()[startsWith(domain$ids(), paste0(x, "."))]
    map(nms, function(nm) domain$add_dep(nm, "learner_id", CondEqual(x)))
})

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
