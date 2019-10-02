library(RJDemetra)


ws_components<-function(ws, msa, component, cname=NULL){
  if (is.null(cname))
    cname=component
  n<-count(msa)
  q<-RJDemetra::get_object(msa, 1)
  m<-RJDemetra::get_model(q, ws, component)
  c1<-m$user_defined[component][[1]]
  all<-c1
  for (i in 2:n){
    q<-RJDemetra::get_object(msa, i)
    m<-RJDemetra::get_model(q, ws, component)
    c<-m$user_defined[component][[1]]
    all<-cbind(all, c)
  }
  colnames(all)<-paste(cname,(1:n), sep="")
  return (all)
}
