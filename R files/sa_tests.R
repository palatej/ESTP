source("./R files/jd_ts.R")


test_jd2r<-function(s){
  if (is.null(s))
    return(NULL)
  desc<-.jfield(s, "S", "description")
  val<-.jfield(s, "D", "value")
  pval<-.jfield(s, "D", "pvalue")
  all<-c(val, pval)
  attr(all, "description")<-desc
  return (all)
}

jd2_seasonality_KruskalWallis<-function(series){
  js<-ts_r2jd(series)
  jtest<-.jcall("ec/tstoolkit/jdr/tests/SeasonalityTests", "Lec/tstoolkit/information/StatisticalTest;", "kruskalWallisTest", js)
  if (is.jnull(jtest))
    return (NULL)
  else{
    return (test_jd2r(jtest))
  }
}

jd2_seasonality_Friedman<-function(series){
  js<-ts_r2jd(series)
  jtest<-.jcall("ec/tstoolkit/jdr/tests/SeasonalityTests", "Lec/tstoolkit/information/StatisticalTest;", "friedmanTest", js)
  if (is.jnull(jtest))
    return (NULL)
  else{
    return (test_jd2r(jtest))
  }
}


jd2_seasonality_FTest<-function(series, ar=TRUE, nyears=0){
  js<-ts_r2jd(series)
  jtest<-.jcall("ec/tstoolkit/jdr/tests/SeasonalityTests", "Lec/tstoolkit/information/StatisticalTest;", "ftest", js, ar, as.integer(nyears))
  if (is.jnull(jtest))
    return (NULL)
  else{
    return (test_jd2r(jtest))
  }
}

jd2_seasonality_QSTest<-function(series, nyears=0, diff = -1, mean=TRUE){
  js<-ts_r2jd(series)
  jtest<-.jcall("ec/tstoolkit/jdr/tests/SeasonalityTests", "Lec/tstoolkit/information/StatisticalTest;", "qstest", js, as.integer(nyears), as.integer(diff), mean)
  if (is.null(jtest))
    return (NULL)
  else{
    return (test_jd2r(jtest))
  }
}

jd2_td_FTest<-function(series, ar=TRUE, nyears=0){
  js<-ts_r2jd(series)
  jtest<-.jcall("ec/tstoolkit/jdr/tests/TradingDaysTests", "Lec/tstoolkit/information/StatisticalTest;", "ftest", js, ar, as.integer(nyears))
  if (is.jnull(jtest))
    return (NULL)
  else{
    return (test_jd2r(jtest))
  }
}


