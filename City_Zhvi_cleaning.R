homesdf <- read.csv("City_Zhvi_AllHomes_MOD.csv")   ##read in data as .csv


str(homesdf)                                         ##structure of df
homesdf$SizeRank <- as.factor(homesdf$SizeRank)      ##pass column "sizerank" as factor
summary(homesdf)                                     ##summary of df

grep("2010", colnames(homesdf))  ##find columns with "2010"  3-14
homesdf[,3:14]
grep("2011", colnames(homesdf))  ## ' ' ' '    "2011"    15-26
homesdf[,15:26]
grep("2012", colnames(homesdf))  ## ' ' ' '    "2012"    27-38
grep("2013", colnames(homesdf))  ## ' ' ' '    "2013"    39-50
grep("2014", colnames(homesdf))  ## ' ' ' '    "2014"    51-62
grep("2015", colnames(homesdf))  ## ' ' ' '    "2015"    63-74

mean2010 <- data.frame(rowMeans(homesdf[3:14], na.rm=TRUE))   #calculate dataframe subset "mean2010" with averages of selected columns.  na.rm= should missing values be ommitted?
colnames(mean2010)<-2010                                     #change column name to "2010"
mean2010
mean2011 <- data.frame(rowMeans(homesdf[5:26], na.rm=TRUE))
colnames(mean2011)<-2011
mean2011
mean2012 <- data.frame(rowMeans(homesdf[27:38], na.rm=TRUE))
colnames(mean2012)<-2012
mean2013 <- data.frame(rowMeans(homesdf[39:50], na.rm=TRUE)) 
colnames(mean2013)<-2013
mean2014 <- data.frame(rowMeans(homesdf[51:62], na.rm=TRUE))
colnames(mean2014)<-2014
mean2015 <- data.frame(rowMeans(homesdf[63:74], na.rm=TRUE))
colnames(mean2015)<-2015

which(grepl("LA", homesdf$State))                     ##display rows with "LA"
LA.2010 <- mean2010[3339:3486,]                  ##create new set of values with mean of 2010 for rows with "LA"
##df.2010<- homesdf[3339:3486,3:14]                        ##create new df with "LA" as state and "2010" year
LA.2011 <- mean2011[3339:3486,]
LA.2012 <- mean2012[3339:3486,]
LA.2013 <- mean2013[3339:3486,]
LA.2014 <- mean2014[3339:3486,]
LA.2015 <- mean2015[3339:3486,]

State <- rep("LA", 148)                              ##Make new vector with "LA" repeated 148 times

df.LA.2010 <- data.frame(Statecol, LA.2010)       ##add the "State" to dataframe
colnames(df.LA.2010) <- c("State", "2010")           ##change column names
df.LA.2010
df.LA.2011 <- data.frame(Statecol, LA.2011)       ##add the "State" to dataframe
colnames(df.LA.2011) <- c("State", "2011")           ##change column names
df.LA.2012 <- data.frame(Statecol, LA.2012)       ##add the "State" to dataframe
colnames(df.LA.2012) <- c("State", "2012")           ##change column names
df.LA.2013 <- data.frame(Statecol, LA.2013)       ##add the "State" to dataframe
colnames(df.LA.2013) <- c("State", "2013")           ##change column names
df.LA.2014 <- data.frame(Statecol, LA.2014)       ##add the "State" to dataframe
colnames(df.LA.2014) <- c("State", "2014")           ##change column names
df.LA.2015 <- data.frame(Statecol, LA.2015)       ##add the "State" to dataframe
colnames(df.LA.2015) <- c("State", "2015")           ##change column names

LA.2010.mean<- data.frame(colMeans(df.LA.2010[2]))  ##calculate total mean for 2010 LA
LA.2011.mean<- data.frame(colMeans(df.LA.2011[2]))
LA.2012.mean<- data.frame(colMeans(df.LA.2012[2]))
LA.2013.mean<- data.frame(colMeans(df.LA.2013[2]))
LA.2014.mean<- data.frame(colMeans(df.LA.2014[2]))
LA.2015.mean<- data.frame(colMeans(df.LA.2015[2]))

LA.VT.df<- data.frame("LA",LA.2010.mean[,], LA.2011.mean[,], LA.2012.mean[,], LA.2013.mean[,], LA.2014.mean[,], LA.2015.mean[,])  ##make new df with all the values
colnames(LA.VT.df) <- c("State", "2010", "2011", "2012", "2013", "2014", "2015")


which(grepl("VT", homesdf$State))                     ##display rows with "VT"   10048-10151
VT.2010 <- data.frame(mean2010[10048:10151,])                  ##create new set of values with mean of 2010 for rows with "VT"
VT.2011 <- data.frame(mean2011[10048:10151,])
VT.2012 <- data.frame(mean2012[10048:10151,])
VT.2013 <- data.frame(mean2013[10048:10151,])
VT.2014 <- data.frame(mean2014[10048:10151,])
VT.2015 <- data.frame(mean2015[10048:10151,])

VT.2010.mean<- data.frame(colMeans(VT.2010[1]))  ##calculate total mean for 2010 VT
VT.2011.mean<- data.frame(colMeans(VT.2011[1]))
VT.2012.mean<- data.frame(colMeans(VT.2012[1]))
VT.2013.mean<- data.frame(colMeans(VT.2013[1]))
VT.2014.mean<- data.frame(colMeans(VT.2014[1]))
VT.2015.mean<- data.frame(colMeans(VT.2015[1]))
VT.means <- data.frame("VT",VT.2010.mean[,], VT.2011.mean[,], VT.2012.mean[,], VT.2013.mean[,], VT.2014.mean[,], VT.2015.mean[,])
VT.means
colnames(VT.means) <- c("State", "2010", "2011", "2012", "2013", "2014", "2015")

LA.VT.df <- rbind(LA.VT.df, VT.means)

write.csv(LA.VT.df, file= "LA_VT_Clean.csv")
