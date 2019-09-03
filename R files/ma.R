ma.spectrum<-function(weights, start=NA, resolution=100){
  len<-length(weights)
  if (is.na(start))
    start<--(len-1)/2
  gain<-array(dim=resolution+1)
  phase<-array(dim=resolution+1)
  for (i in 0:resolution){
    w=i*pi/resolution  
    re<-0
    im<-0
    for (k in start:(start+length(weights)-1)){
      z=w*k
      x<-weights[k-start+1]
      re<-re+cos(z)*x
      im<-im+sin(z)*x 
    }
    gain[i+1]<-sqrt(re*re+im*im)
    phase[i+1]<-atan2(im, re)
  }
  return (list("gain"=gain, "phase"=phase))
}

ma.composite<-function(m,n){
  fm<-array(1/m, m)
  fn<-array(1/n, n)
  p<-m+n-1
  w<-array(0, p)
  for (i in 1:m){
    for (j in 1:n){
      w[i+j-1]<-w[i+j-1]+fm[i]*fn[j]
    }
  }
  return (w)
}

ma.henderson<-function(length){
  if (length%%2 == 0)
    stop("Length of henderson should be odd")
  m <- (length-1) / 2
  c <- array(0, dim=length)
  n <- m + 2
  n2 <- n * n
  for (i in 0:(m+1)) {
    ii <- (i - m) * (i - m)
    up <- 315 * (n2 - n * 2 + 1 - (ii))
    up <- up*( n2 - ii)
    up <- up*(n2 + n * 2 + 1 - ii)
    up <-up*(n2 * 3 - 16 - ii * 11)
    down <- n * 8
    down <- down*(n2 - 1)
    down <- down*(n2 * 4 - 1)
    down <- down*(n2 * 4 - 9)
    down <- down*(n2 * 4 - 25)
    c[length - i] <- up / down
    c[i+1]<-c[length - i]
  }
  return (c)
}

ma.apply<-function(weights, s, start=NA){
  len<-length(weights)
  if (is.na(start)){
    if (len %% 2 == 0)
      start=len/2
    else
      start<-(len+1)/2
  }
  n<-length(data)-len
  idx<-seq(start, start+n)
  q<-array(dim=length(data))
  q[idx]<-s[1:(n+1)]*weights[1]
  for (i in 2:length(weights)){
    q[idx]<-weights[i]*s[i:(n+i)]+q[idx]
  }
  return (q)
}
