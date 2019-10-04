ws_spec <- function (object) {
  estimate <- s_estimate(object)
  transform <- s_transform(object)
  usrdef <- s_usrdef(object)
  predef.outliers <- s_preOut(object)
  predef.variables <- s_preVar(object)
  trading.days <- s_td(object)
  easter <- s_easter(object)
  outliers <- s_out(object)
  arima.dsc <- s_arima(object)
  predef.coef <- s_arimaCoef(object)
  forecast <- s_fcst(object)
  span <- s_span(object)
  
  if (inherits(object,c("SA","SA_spec")) & inherits(object,"X13")){
    decomp <- s_x11(object)
  } else{
    decomp <- s_seats(object)
  }

  estimate<- rbind(estimate,rep(NA,length(estimate)),estimate)
  transform <- rbind(transform,rep(NA,length(transform)),transform)
  usrdef <- rbind(usrdef,rep(NA,length(usrdef)),usrdef)
  trading.days <- rbind(trading.days,rep(NA,length(trading.days)),trading.days)
  easter <- rbind(easter,rep(NA,length(easter)),easter)
  outliers <- rbind(outliers,rep(NA,length(outliers)),outliers)
  arima.dsc <- rbind(arima.dsc,rep(NA,length(arima.dsc)),arima.dsc)
  forecast <- rbind(forecast,rep(NA,length(estimate)),forecast)
  
  rownames(estimate)=c("Loaded","User_modif","Final")
  rownames(transform)=c("Loaded","User_modif","Final")
  rownames(usrdef)=c("Loaded","User_modif","Final")
  rownames(trading.days)=c("Loaded","User_modif","Final")
  rownames(easter)=c("Loaded","User_modif","Final")
  rownames(outliers)=c("Loaded","User_modif","Final")
  rownames(arima.dsc)=c("Loaded","User_modif","Final")
  rownames(forecast)=c("Loaded","User_modif","Final")
  
  userdef <-list(specification = usrdef, outliers = list(Predefined = predef.outliers, Final = predef.outliers),
                 variables = list(Predefined = predef.variables, Final = predef.variables))
  regression <- list(userdef=userdef, trading.days=trading.days, easter = easter)
  arima <- list(specification = arima.dsc, coefficients = list(Predefined = predef.coef, Final = predef.coef))
  
  regarima <- list(estimate=estimate, transform=transform, regression=regression,
                   outliers=outliers, arima=arima, forecast = forecast , span=span)
  
  if (inherits(object,"X13")){
    class(regarima) <- c("regarima_spec","X13")
    x11 <- rbind(decomp,rep(NA,length(decomp )),decomp)
    rownames(x11)=c("Loaded","User_modif","Final")
    class(x11) <- c("X11_spec","data.frame")
    z <- list(regarima = regarima, x11 = x11)
    class(z) <- c("SA_spec","X13")
    return(z)
  } else {
    class(regarima) <- c("regarima_spec","TRAMO_SEATS")
    seats <- rbind(decomp,rep(NA,length(decomp )),decomp)
    rownames(seats)=c("Loaded","User_modif","Final")
    class(seats) <- c("seats_spec","data.frame")
    z <- list(regarima = regarima, seats = seats)
    class(z) <- c("SA_spec","TRAMO_SEATS")
    return(z)
  }
  
}
