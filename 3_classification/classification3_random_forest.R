
#######################################################
#### Classification Model - RANDOM FOREST ####
#######################################################

### 1. import data 
### 2. clean data 
###   - check for missing values , other data issues
###   - set correct data types for columns
### 3. exploratory Data Analysis (EDA) 
###   
### 4. Modelling
###   - Split data into Train and Test Groups
###   - Train model on train group
###   - Interpret model
###   
### 5. EVALUATE model - EVALUATE  model with test data 


#######################
### 1. IMPORT DATA ####
#######################

#import data
## Data: Default dataset in the ISLR has sample data on credit card customers
library(ISLR)
df <- Default


## view sample data
head(df, n=10) #top rows
tail(df) # last rows

#structure of the dataset
str(df)
# summary stats
summary(df)


######################
### 2. CLEAN DATA ###
#####################
###   - check for missing values , other data issues

### Dealing with missing data ###
# detect any missing data in dataframe
# - delete rows with missing data or insert NA cells with an estimate eg. an average #

#check for NAs/missing values
any(is.na(df))

# check for missing data anywhere in a column
# any(is.na(df$col)) 

# omit rows with missing values
# df<- na.omit(df)

## check for frequencies of categorical vairables
# there could be ways to improve the modeling dataset- 
## eg. if there are too many categories in a categorical variable or some of the categories have very low count, it might make sense to combine some categories
## eg. there could be very low number of rows for one of the response classes. 

#2 groups in student
table(df$student)

#too few observations of response default='Yes'. 
table(df$default)

colnames(df)

### set correct data types for columns
## factor() : set categorical columns as factors
# df$var <- factor(df$factor)
df$default <- factor(df$default)
df$student <- factor(df$student)



###########################################
### 3. EXPLORATORY DATA ANALYSIS (EDA)  ###
###########################################

### check for assumptions of multiple regression
#  multicollinearity - high correlations among input variables : use correlation matrix of VIF
#  assumed linear relationship between response and predictors - scatter plot between response and a preditor var or after model building, do a scatter plot of residual error vs. predictor variables/fitted values
#  normality: distribution of numerical variables (eg. in a histogram) should roughly follow a bell curve. If the data is skewed, a transformatoin using log, square or square root might sort this issue

## get the structure of the data
str(df)
# summary stats
summary(df)  ##skewed towards class default YES (defaulter)

#install.packages("ggplot2")
library(ggplot2)
## ggplot is based on the philosophy of grammar of graphics
## the idea is to add layers to visualisation
## layers 1-3 
## layer 1: data , layer 2: aesthetics (data columns to use in plotting), 
## layer 3 : geometries (type of plot)

# bar plot of default - default='Yes' has very few observations
# since default is a categorical variable, we are using a bar plot
ggplot(df,aes(default)) + geom_bar() +labs(x="default",y="Count",title="Distribution of default")

# bar plot of student-  
# since student is a categorical variables, we are using a bar plot
ggplot(df,aes(student)) + geom_bar() +labs(x="Student",y="Count",title="Distribution of student")
#students seem to be higher default rates - overall
ggplot(df,aes(student)) + geom_bar(aes(fill=default)) +labs(x="Student",y="Count",title="Distribution of student")


## box plot of student vs. balance 
ggplot(df,aes(x=student,y=balance)) + geom_boxplot(aes(fill=student))

# histograms - distribution of balance
# since balance is a CONTINIOUS numeric variable, we are using a histogram
ggplot(df,aes(balance)) + geom_histogram(fill='blue',alpha=0.5) +labs(x="Balance band",y="Count",title="Distribution of Amount")
# default rates seem to be higher at higher balance bands
ggplot(df,aes(balance)) + geom_histogram(aes(fill=default)) +labs(x="Balance band",y="Count",title="Distribution of Amount")

ggplot(df,aes(x=balance, y=income)) + geom_point(aes(color=default)) 

# histograms - distribution of income
# since income is a CONTINIOUS numeric variable, we are using a histogram
ggplot(df,aes(income)) + geom_histogram(fill='blue',alpha=0.5) +labs(x="Income band",y="Count",title="Distribution of Amount")

ggplot(df,aes(income)) + geom_histogram(aes(fill=default),alpha=0.5) +labs(x="Income band",y="Count",title="Distribution of Amount")



#######################
### 4. BUILD MODEL ####
#######################

###   - Split data into Train and Test Groups

# install.packages("caTools")

# Import package
library(caTools)
# use set.seed to reproduce results. expect to get the same sample again with the same seed number
set.seed(101) 

dim(df) # row and column count

#split up the sample. a boolean vector split is generated
# SplitRatio = percent of sample==TRUE
split <- sample.split(df$default, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE

# Training Data
train = subset(df, split == TRUE)

# Testing Data
test = subset(df, split == FALSE)


###   - TRAIN model on train data

# RPART PACKAGE IS USED TO BUILD A a RANDOM FOREST MODEL
#install.packages('randomForest')
library(randomForest)

# randomForest() of the randomForest package function fits RANDOM FOREST models 
help(randomForest)

## Train the model for default = Yes. 
# Use train data. Add importance = TRUE to assess importance of predictors
rf <- randomForest(default ~.,method='class',data = train,importance = TRUE)

#model summary
#summary(tree)

## model's confusion on its own trianing set
rf$confusion

#feature importance with model$importance
# https://stats.stackexchange.com/questions/92419/relative-importance-of-a-set-of-predictors-in-a-random-forests-classification-in
# https://stackoverflow.com/questions/736514/r-random-forests-variable-importance
rf$importance


##################################
### 5. EVALUATE MODEL  ####
##################################

## EVALUATE MODEL USING TEST DATA 

# The predict() function can be used to predict the probabilities of 
# default = Yes  and default = No
# ?predict
# test data : matrix with predicted PROBABILITY for YES and NO for Default
rf.pred=predict(rf,newdata=test)
class(rf.pred)
# has  two columns- probabilities for No and Yes
head(rf.pred)


## CONFUSION MATRIX : predicted vs. actual
#in order to determine how many observations were correctly or incorrectly classified.
table(rf.pred,test$default)

# accuracy (tp+tn)/total
(24+2884)/(3000)  # 0.97 -  - But high false negatives. model not good.

# recall tp/(tp+fn) - what proportion of the true defaulters were predicted as defaulter
24/(24+76)  ## 24% recall- not good

# precision tp/(tp+fp) - of the ones predicted Yes (Defaulter), how many are actually Yes (defaulter)
24/(24+16)  ## 60%

# accuracy (tp+tn)/total

## error rate = 1-0.97 = 3% - worse than random guessing - p-values not good.
## error rate
mean(rf.pred!=test$default)


###################################################
### MODELING ITERATION 2 - SORT CLASS IMBALANCE ###
###################################################

#install.packages('dplyr')
library(dplyr)

## SORT CLASS IMBALANCE IN PREDICTOR
# defaulters - 333
df.yes <- df[df$default=='Yes',]

# non-defaulters - 9667
df.no <- df[df$default=='No',]

#take a sample of rows from the non-defaulters : sample_n is in dplyr package
df.no.sample <- sample_n(df.no,5000)

## BALANCED DATASET
#combine th dataset with default=Yes and the sampled dataset with default=No
df2 <- union(df.yes,df.no.sample)

###   - SPLIT DATA INTO TRAIN AND TEST GROUPS
# install.packages("caTools")
library(caTools)
# use set.seed to reproduce results. expect to get the same sample again with the same seed number
set.seed(113) 

# Split up the sample, basically randomly assigns a booleans to a new column "sample"
sample <- sample.split(df2$default, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE

# Training Data
train2 = subset(df2, sample == TRUE)

# Testing Data
test2 = subset(df2, sample == FALSE)

#########################
#### 4.2 BUILD MODEL ####
#########################

###   - TRAIN model on train data

## Train the model for default = Yes. 
# Use train data. Add importance = TRUE to assess importance of predictors
rf2 <- randomForest(default ~.,method='class',data = train2,importance = TRUE)

#model summary
#summary(tree)

## model's confusion on its own training set
rf2$confusion

#feature importance with model$importance
# https://stats.stackexchange.com/questions/92419/relative-importance-of-a-set-of-predictors-in-a-random-forests-classification-in
# https://stackoverflow.com/questions/736514/r-random-forests-variable-importance
rf2$importance



##################################
### 5.2 EVALUATE MODEL  ####
##################################

## EVALUATE MODEL USING TEST DATA 

# The predict() function can be used to predict the probabilities of 
# default = Yes  and default = No
# ?predict
#  matrix with predicted PROBABILITIES for YES and NO for Default.
rf.pred2=predict(rf2,newdata=test2)
class(rf.pred2)
# has  two columns- probabilities for No and Yes
head(rf.pred2)


## CONFUSION MATRIX 
#in order to determine how many observations were correctly or incorrectly classified.
table(rf.pred2,test2$default)

# accuracy (tp+tn)/total
(47+1487)/(1600)  # 0.96 -  - But high false negatives. model not good.

# recall tp/(tp+fn) - what proportion of the true defaulters were predicted as defaulter
47/(47+53)  ## 40% recall- BETTER THAN previous model

# precision tp/(tp+fp) - of the ones predicted Yes (Defaulter), how many are actually Yes (defaulter)
47/(47+13)  ## 78% - better than previous model

# accuracy (tp+tn)/total

## error rate = 1-0.96 = 4% - worse than random guessing - p-values not good.
## error rate
mean(rf.pred2!=test2$default)


