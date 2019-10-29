library(rjdbench)
library(lubridate)

# Usage:


# Read two csv matrices: the series corrected for calendar effect and the series with SA series.
# The SA series is benchmarked (using multiplicative Denton) on the annual totals of the series corrected for calendar effects.
# 
# The command line is: [Rscript path]\rscript [bench12.R path]\bench12.R sa.csv ycal.csv output.csv
#
# for example:
# ...\R-3.5.1\bin\rscript "...\ESTP\R files\bench12.R" "...\ESTP\Data\series_sa.csv" "...\ESTP\Data\series_ycal.csv" "...\ESTP\Data\sa_bench.csv"
# See Data/series_ycal, series_sa (output from JD+) for examples

a<-commandArgs(TRUE)

bench12<-function(sa_file, ycal_file, output_file){
  sa<-read.csv(sa_file)
  ycal<-read.csv(ycal_file)
  
  y0<-year(ycal[1,1])
  m0<-month(ycal[1,1])
  
  n<-dim(ycal)[2]-1
  ts_ycal<-ts(ycal[,2:(n+1)], frequency=12, start=c(y0, m0))
  ts_sa<-ts(sa[,2:(n+1)], frequency=12, start=c(y0, m0))
  
  for (i in 1:n){
    Y<-rjdbench::jd3_aggregate(ts_ycal[,i])
    M<-rjdbench::jd3_denton(ts_sa[,i], Y)
    sa[,i+1]<-as.numeric(M)
  }
  write.csv(sa, output_file, row.names = FALSE)
}

bench12(a[1], a[2], a[3])