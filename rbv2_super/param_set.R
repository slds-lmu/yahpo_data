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
    ranger.mtry.power = p_int(lower = 0, upper = 1),
    ranger.respect.unordered.factors = p_fct(levels = c("ignore", "order", "partition")),
    ranger.min.node.size = p_int(lower = 1L, upper = 100L),
    ranger.splitrule = p_fct(levels = c("gini", "extratrees")),
    ranger.num.random.splits = p_int(lower = 1L, upper = 100L, depends = ranger.splitrule == "extratrees"),
    # aknn
    aknn.k = p_int(lower = 1L, upper = 50L),
    aknn.distance = p_fct(levels = c("l2", "cosine", "ip")),
    aknn.M = p_int(lower = 18L, upper = 50L),
    aknn.ef = p_dbl(lower = 2, upper = 6, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
    aknn.ef_construction = p_dbl(lower = 2, upper = 7, tags = c("int", "log"), trafo = function(x) as.integer(round(exp(x)))),
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
    # learner
    trainsize = p_dbl(lower = 0.05, upper = 1, tags = "budget"),
    repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
    num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
    learner = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
    task_id = p_fct(levels = c("1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068",
      "11", "1111", "12", "14", "1461", "1462", "1464", "1468", "1475",
      "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489",
      "1494", "1497", "15", "1501", "1510", "1515", "16", "18", "181",
      "182", "188", "22", "23", "23381", "24", "28", "29", "3", "307",
      "31", "312", "32", "334", "37", "375", "377", "38", "40496",
      "40498", "40499", "40536", "40670", "40701", "40900", "40966",
      "40975", "40978", "40979", "40981", "40982", "40983", "40984",
      "40994", "41138", "41142", "41143", "41146", "41156", "41157",
      "41212", "4134", "4154", "42", "44", "4534", "4538", "458", "46",
      "469", "470", "50", "54", "60", "6332"),
      tags = "task_id"
    )
)
# Add dependencies
map(search_space$params$learner$levels, function(x) {
    nms = names(search_space$params)[startsWith(names(search_space$params), x)]
    map(nms, function(nm) search_space$add_dep(nm, "learner", CondEqual$new(x)))
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
    aknn.ef = p_int(lower = 7L, upper = 403L),
    aknn.ef_construction = p_int(lower = 7L, upper = 403L),
    # xgboost
    xgboost.booster = p_fct(levels = c("gblinear", "gbtree", "dart")),
    xgboost.nrounds = p_int(lower = 7L, upper = 2980L),
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
    # learner
    trainsize = p_dbl(lower = 0.05, upper = 1, tags = "budget"),
    repl = p_int(lower = 1L, upper = 10L, tags = "budget"),
    num.impute.selected.cpo = p_fct(levels = c("impute.mean", "impute.median", "impute.hist")),
    learner = p_fct(levels = c("aknn", "glmnet", "ranger", "rpart", "svm", "xgboost")),
    task_id = p_fct(levels = c("1040", "1049", "1050", "1053", "1056", "1063", "1067", "1068",
      "11", "1111", "12", "14", "1461", "1462", "1464", "1468", "1475",
      "1476", "1478", "1479", "1480", "1485", "1486", "1487", "1489",
      "1494", "1497", "15", "1501", "1510", "1515", "16", "18", "181",
      "182", "188", "22", "23", "23381", "24", "28", "29", "3", "307",
      "31", "312", "32", "334", "37", "375", "377", "38", "40496",
      "40498", "40499", "40536", "40670", "40701", "40900", "40966",
      "40975", "40978", "40979", "40981", "40982", "40983", "40984",
      "40994", "41138", "41142", "41143", "41146", "41156", "41157",
      "41212", "4134", "4154", "42", "44", "4534", "4538", "458", "46",
      "469", "470", "50", "54", "60", "6332"),
      tags = "task_id"
    )
)
# Add dependencies
map(domain$params$learner$levels, function(x) {
    nms = names(domain$params)[startsWith(names(domain$params), x)]
    map(nms, function(nm) domain$add_dep(nm, "learner", CondEqual$new(x)))
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
