library(RJDemetra)
library(JDLight)

ws<-RJDemetra::load_workspace("./ws/estp.xml")
RJDemetra::compute(ws)
msa1<-get_object(ws)
n<-count(msa1)
q<-RJDemetra::get_object(msa1, 1)
tot<-RJDemetra::get_ts(q)
m<-RJDemetra::get_model(q, ws)
totsa<-m$final$series[,"sa"]

for (i in 2:n){
  q<-RJDemetra::get_object(msa1, i)
  tot<-tot+RJDemetra::get_ts(q)
  m<-RJDemetra::get_model(q, ws)
  totsa<-totsa+m$final$series[,"sa"]
}

w<-RJDemetra::tramoseats(tot)
totsa_dir<-w$final$series[,"sa"]

plot(tot)
lines(totsa, col="red")
lines(totsa_dir, col="blue")

diff<-100*(totsa/totsa_dir-1)

print(summary(diff))

print(JDLight::jd_seasonality(totsa, "FRIEDMAN"))
print(JDLight::jd_seasonality(totsa, "KRUSKALWALLIS"))
print(JDLight::jd_seasonality(totsa))

print(JDLight::jd_seasonality(diff))
