# Clean up
rm(list = ls(all = TRUE))

#Setting the working directory
#setwd('/media/nicolo/Data/Coursera/PracticalMachineLearning/Data/PracticalMachineLearning')
setwd("D:\\Coursera\\PracticalMachineLearning\\Data\\PracticalMachineLearning")

# Loading the caret library
library(caret)

# Taken from the assignment to write the files
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

# Reading training and testing sets
trainingRaw <- read.csv(file="pml-training.csv",head=TRUE,  dec=",", na.strings=c("NA",""))  
testingRaw <- read.csv(file="pml-testing.csv",head=TRUE,  dec=",", na.strings=c("NA",""))  

trainingRaw$classe <- as.factor(trainingRaw$classe)



# Cleaning the training from invalid values and from the useless variables
discard <- apply(trainingRaw,2,function(x) {sum(is.na(x))})
trainLess <- trainingRaw[,which(discard == 0)] 
discard <- apply(testingRaw,2,function(x) {sum(is.na(x))})
testLess <- testingRaw[,which(discard == 0)] 

trainLess1 <- trainLess[-c(2:7)]
testLess1 <- testLess[-c(2:7)]

for(i in 1:length(trainLess1)){
  
  trainLess1[,i]<-as.numeric(trainLess1[,i])
  testLess1[,i]<-as.numeric(testLess1[,i])
}

# remove near zero values, if any
nzv <- nearZeroVar(trainLess1,saveMetrics=TRUE)
trainLess1 <- trainLess1[,nzv$nzv==FALSE]
testLess1 <- testLess1[,nzv$nzv==FALSE]


#Preproces
preObj <-preProcess(trainLess1[,-length(trainLess1)],method=c('knnImpute', 'center', 'scale'))

trainLess2<-predict(preObj,trainLess1[,-length(trainLess1)])
testLess2<-predict(preObj,testLess1[,-length(testLess1)])

# Remove the higly correlated vars
M <- abs(cor(trainLess2))
diag(M) <-0
corVar <- which(M > 0.85, arr.ind=T)

trainLess2 <- trainLess2[,-corVar]
testLess2 <- testLess2[,-corVar]


trainLess2$classe <- trainLess$classe
#testLess2$classe <- testLess$classe


# Create cross validation set
set.seed(12031987)
inTrain = createDataPartition(trainLess2$classe, p = 3/4, list=FALSE)
training = trainLess2[inTrain,]
crossValidation = trainLess2[-inTrain,]


# Train model with random forest
startTime <- Sys.time();

modFit2 <- train(training$classe ~., method="rf", data=training, trControl = trainControl(method='boot632'))

endTime <- Sys.time()
endTime - startTime


testingPrediction <- predict(modFit, testLess2)
testingPrediction

# Pre-process
#preObjTrain <- preProcess(trainLess2[sapply(trainLess2[,-53])], method=c("center", "scale", "BoxCox"))
#preObjTest <- preProcess(testLess2[sapply(testLess2[,-53])], method=c("center", "scale", "BoxCox"))
library(ipred)
model31 <- bagging(classe ~., data=training, nbagg=25)
pred31_train <- predict(model31, training)


qplot(cvtd_timestamp, classe, data=all, geom="jitter", colour=factor(user_name), 
      main="Classe by time", ylab="Classe", xlab="Time")
