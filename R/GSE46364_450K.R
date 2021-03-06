# for ips methylatin 450K analysis
library("GEOquery")
GSE41169 <- getGEO("GSE46364",destdir="/home/sguo/monod/data/geo")
save(GSE41169, file="GSE46364_matrix.Rdata")

library("GEOquery")
load("GSE41169_matrix.Rdata")
data <- as.data.frame(exprs(GSE41169[[1]]))
phen <- pData(phenoData(GSE41169[[1]]))

phen1<-sapply(strsplit(as.character(phen$characteristics_ch1.7),"[:]"),function(x) as.numeric(unlist(x)[2]))  # status 1:control, 2:scz
phen1[phen1==1]<-"Normal"
phen1[phen1==2]<-"schizophrenia"


phen2<-sapply(strsplit(as.character(phen$characteristics_ch1),"[:]"),function(x) (unlist(x)[2]))  # gender

data1=na.omit(data)

PCAPlot(t(data1),phen1,output="GSE41169.scz.normal.pdf",multifigure=T)  # status
PCAPlot(t(data1),phen2,output="GSE41169.gender.pdf",multifigure=T)  # gender
