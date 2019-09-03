library("RJDemetra", lib.loc="C:/LocalData/DEV/SOFTWARE/R/R-3.5.1/library")

sts_inpr_all<-ts(read.csv("./Data/sts_inpr_m_all.csv"), freq=12, start=c(2000,1))

q<-x13(sts_inpr_all[,1], spec="RSA4c", c("decomposition.b2", "decomposition.b7", "decomposition.c7", "decomposition.d7"))
ts.plot(q$user_defined$decomposition.b2, q$user_defined$decomposition.b7, q$user_defined$decomposition.c7, q$user_defined$decomposition.d7, col=c("gray", "red", "blue", "green") )

