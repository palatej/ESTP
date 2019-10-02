library(RJDemetra)

ws<-RJDemetra::load_workspace("./ws/estp.xml")
RJDemetra::compute(ws)
msa1<-get_object(ws)

q<-RJDemetra::get_object(msa1, 1)
tot<-RJDemetra::get_ts(q)
m<-RJDemetra::get_model(q, ws, c("decomposition.s_cmp_f", "preprocessing.model.cal_f", "s_f"))

fs<-m$user_defined$decomposition.s_cmp
fsall<-m$user_defined$s_f           
fcal<-m$user_defined$preprocessing.model.cal_f

plot(fsall)
lines(fs, col="red")
lines(fcal, col="blue")