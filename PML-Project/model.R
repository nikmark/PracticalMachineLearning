rm(list = ls(all = TRUE))
setwd('/media/nicolo/Data/Coursera/PracticalMachineLearning/Data/')

library(caret)

# taken from the assignment to write the files
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

inData <- read.table('pml-training.csv', header=TRUE, as.is = TRUE, stringsAsFactors = FALSE, sep=',', na.strings=c('NA','','#DIV/0!'))
