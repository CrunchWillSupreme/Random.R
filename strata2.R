files <- c('Train', 'Validate', 'Test')
locals <- sprintf('C:/DAPT/Strata data conference/Machine Learning in R/manhattan_%s.csv', files)
locals

data_all <- purrr::map_df(locals, readr::read_csv, .id='set')
data_all

train <- readr::read_csv('manhattan_Train.csv')
test <- readr::read_csv('manhattan_Test.csv')
validate <- readr::read_csv('manhattan_validate.csv')

view(data_all)

# below is the same as above.  Reading in the files in.

download.file('https://www.jaredlander.com/data/manhattan_Train.rds', 'manhattan_Trail.rds', mode='wb')
download.file('https://www.jaredlander.com/data/manhattan_Validate.rds', 'manhattan_Validate.rds', mode='wb')
download.file('https://www.jaredlander.com/data/manhattan_Test.rds', 'manhattan_Test.rds', mode='wb')

train <-readRDS('manhattan_Train.rds')
train
validate <-readRDS('manhattan_Validate.rds')
test <-readRDS('manhattan_Test.rds')

library(useful)

theFormula <- High ~ . - 1

xtrain <- build.x(theFormula, data=train, contrasts=FALSE, sparse=TRUE)
xvalidate <- build.x(theFormula, data=validate, contrasts=FALSE, sparse=TRUE)
xtest <- build.x(theFormula, data=test, contrasts=FALSE, sparse=TRUE)

ytrain <- build.y(theFormula, data=train)
yvalidate <- build.y(theFormula, data=validate)
ytest <- build.y(theFormula, data=test)

library(xgboost)
trainxg <-  xgv.DMatrix(data=xTrain, label=yTrain)
validatexg <- xgv.DMatrix(data=xvalidate, label=yvalidate)

watchList <- list(train=trainxg, validate=validatexg)

xg1 <- xgb.train(data=trainxg, objective='binary:logistic', eval_metric='logloss', nrounds=50, nthread=4, watchlist=watchList, print_every_n=1)

xg2 <- xgb.train(data=trainxg, objective='binary:logistic', eval_metric='logloss', nrounds=50, nthread=4, num_parallel_tree=20, colsample_bytree=0.5, watchlist=watchList, print_every_n=1)