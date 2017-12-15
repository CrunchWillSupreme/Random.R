install.packages("glmnet")
?install.packages
?library
install.packages("coefplot")
install.packages("xgboost")
install.packages("boot")
install.packages("ggplot2")
ACS <- read.table("C:/DAPT/Strata data conference/Machine Learning in R/acs_ny.csv", header=TRUE, sep=',', stringsAsFactors = FALSE)
view(ACS)
acs$Income  <- acs$FamilyIncome >= 120000
view(acs)
summary(acs)
library('tibble')
boros <- tribble(
  ~Boro, ~Pop, ~Size, ~Random,
  'Manhattan', 1644518, 23, 5,
  'Queens', 239150, 109, 1,
  'Brooklyn', 2636735, 71,35,
  'Bronx', 1454440, 42,30,
  'Staten Island', 474558, 58, 10)          

boros
## creating dummy variables
model.matrix(~Pop, data=boros)
model.matrix(~Pop + Size, boros)
model.matrix(~Pop * Size, boros)

model.matrix(~Pop + Size + Boro, boros)

model.matrix(~Pop + Size * Boro, boros)

model.matrix(~Pop + Size + Boro -1, boros)

library('useful')

acsFormula <- Income ~ NumBedrooms + NumChildren + NumPeople + NumRooms + NumUnits + NumVehicles + Numworkers + OwnRent + YearBuilt + ElectricBill + HeatingFuel + Insurance + Language - 1
acsFormula
class(acsFormula)
acsx <- build.x(acsFormula, data=acs, contrasts=FALSE, sparse=TRUE)
acsx

acsy <- build.y(acsFormula, data=acs)
head(acsy)
tail(acsy)

library(glmnet)
set.seed(5)
mod1 <- glmnet(x=acsx, y=acsy,family= 'binomial')

coef(mod1)
plot(mod1, xvar='lambda')
mod1.2 <- glmnet(x=acsx, y=acsy,family= 'binomial', alpha=0)
plot(mod1.2, xvar='lambda')

##alpha closer to 1=L1, alpha closer to 0=L2
mod1.3 <- glmnet(x=acsx, y=acsy, family='binomial', alpha=0.5)
plot(mod1.3, xvar='lambda')

library('animation')
cv.ani(k=10)

mod2.1 <- cv.glmnet(x=acsx, y=acsy, family='binomial', alpha=1,
                    type.measure='class', nfold=5)
plot(mod2.1)
plot(mod2.1$glmnet.fit, xvar='lambda')
library(coefplot)
coefplot(mod2.1, lambda='lambda.lse', sort='magnitude')


acsnew <- read.table('C:/DAPT/Strata data conference/Machine Learning in R/acs_new.csv', header=TRUE, sep=','stringsasfactors=FALSE)
acsxnew <- build.x(acsFormula, data=acsNew, contrasts=FALSE, sparse=TRUE)

preds.2.1 <- predict(mod2.1, newx=acsxnew)

preds.2.1 <- predict(mod2.1, newx-acsnew2, s='lambda.lse')
acsnew2<- acsx[sample(nrow(acsx), size=10, replace=FALSE),]
invlogit(preds.2.1)

preds.2.1.1 <- predict(mod2.1, newx=acsnew2, s='lambda.lse', type='response')
preds.2.1.1

