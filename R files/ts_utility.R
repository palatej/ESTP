
difference<-function(s, lag=1){

  x<-as.vector(s)
  f<-frequency(s)
  start<-start(s)
  pos<-start[1]*f+start[2]-1+lag
  np=pos%%f
  nstart<-c((pos-np)/f, np+1)
  dx<-x[seq(1+lag, length(x))]-x[seq(1, length(x)-lag)]
  return (ts(dx, freq=f, start=nstart))
}

