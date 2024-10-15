data = read.csv(file.choose())
str(data)
anyNA(data)
data = na.omit(data)
data = as.data.frame(data[-1])

data[] <- lapply(data, function(x) if(is.character(x)) as.factor(x) else x)
data[] <- lapply(data, function(x) if(is.factor(x)) as.numeric(x) else x)
data$Patient.s.Vital.Status = factor(data$Patient.s.Vital.Status)

#to find significant variables:
library(caret)
library(vip)
#install.packages("mnet")
library(mnet)
vipv = train(Patient.s.Vital.Status~., method = "multinom", data = data,
             trControl = trainControl(method = "cv", number = 10))
plot(vip(vipv, num_features = 10))



#make another dataframe for all these significant variables:
importance_scores = vip(vipv)$data
top_10 = head(importance_scores[order(-importance_scores$Importance),],10)

brdata = data[,top_10$Variable]

str(brdata)
brdata$Patient.Status = data$Patient.s.Vital.Status

#sampling:
set.seed(9654694)
smp = sample(2, nrow(brdata), replace = TRUE, prob = c(0.8,0.2))
train = brdata[smp==1,]
test = brdata[smp==2,]



#logistic Regression:

logmod = train(Patient.Status~., data = train, method = "multinom",
               trControl = trainControl(method = "cv", number = 10))

logpred = predict(logmod, test)

tab = table(predicted = logpred, actual = test$Patient.Status)


#0.98

#Decision Tree:
library(party)
dectree = ctree(Patient.Status~., data = train)

plot(dectree)

decpred = predict(dectree, test)
tab = table(decpred, test$Patient.Status)

#0.98


#SVM:

trctrl = trainControl(method = "repeatedcv", number = 10, classProbs = F,
                      repeats = 3)

svm = train(Patient.Status~., data = train, method = "svmLinear",
            trControl = trctrl,
            tuneLength = 10)

#87

