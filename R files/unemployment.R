unemployment_all<-ts(read.csv("./Data/unemployment_all.csv"), freq=12, start=c(2000, 1))
unemployment_males<-ts(read.csv("./Data/unemployment_males.csv"), freq=12, start=c(2000, 1))
unemployment_females<-ts(read.csv("./Data/unemployment_females.csv"), freq=12, start=c(2000, 1))
