
#######################################################
#### Classification Model - LOGISTIC REGRESSION ####
#######################################################

### 1. import data 
### 2. clean data 
###   - check for missing values , other data issues
###   - set correct data types for columns
### 3. exploratory Data Analysis (EDA) 
###   - check for assumptions - multicollinearity - high correlations among input variables
### 4. Modelling
###   - Split data into Train and Test Groups
###   - Train model on train group
###   - Interpret model
###   - Plot residuals 
### 5. Test model - Test model with test data 


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

# histograms - distribution of income
# since income is a CONTINIOUS numeric variable, we are using a histogram
ggplot(df,aes(income)) + geom_histogram(fill='blue',alpha=0.5) +labs(x="Income band",y="Count",title="Distribution of Amount")

ggplot(df,aes(income)) + geom_histogram(aes(fill=default),alpha=0.5) +labs(x="Income band",y="Count",title="Distribution of Amount")




#### correlation analysis
# Grab only numeric columns
num.cols <- sapply(df, is.numeric)
# Filter to numeric columns for correlation
cor.data <- cor(df[,num.cols])
#cor.data <- cor(Smarket[,-9])

# print correlation matrix
# the correlations between the lag variables and today’s returns are close to zero
print(cor.data)  

## package to plot correlations
#install.packages('corrplot')
#install.packages('corrgram')
#library(corrgram)
library(corrplot)

# help(corrplot)
# plot correlations
corrplot(cor.data,method='color')
#corrgram(correlation.data,order=TRUE, lower.panel=panel.shade, upper.panel=panel.pie, text.panel=panel.txt)

# IF THERE IS MULTICOLLINEARITY, IT NEEDS OT BE DEALT WITH.


#######################
### 4. BUILD MODEL ####
#######################

###   - Split data into Train and Test Groups
#install.packages("caTools")

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


###   - TRAIN model on train group

# logistic regression model in order to predict Default = Yes

# glm() function fits generalized linear models, a class of models that includes 
# logistic regression. The syntax of the glm() function is similar to that of lm(),
# except that we must pass in the argument 
# family=binomial in order to tell R to run a logistic regression rather than some other type of generalized linear model.

# how is dummy variable created for default
contrasts(df$default)  # Yes=1, No=0 ; model will be trained for probability of default

help(glm)
## Train the model for default = Yes
glm.fits=glm(default ~ student + balance + income , data=train ,family=binomial)

#model summary
summary(glm.fits)
# The smallest p-value here is associated with Lag1. The negative coefficient for 
# this predictor suggests that if the market had a positive return yesterday, 
# then it is less likely to go up today. However, at a value of 0.15, the p-value 
# is still relatively large, and so there is no clear evidence of a real 
# association between Lag1 and Direction.

# model trained for probability of default=Yes
contrasts(train$default)  # Yes=1, No=0

# coef() function in order to access just the coefficients for this fitted model
coef(glm.fits)

## FEATURE SELECTION
# If there are lot of features or input variables, 
# it is desirable to use a subset of variables. 
# one way to choose the best subset is using stepwise regression using 
#     the step() function.

help(step)
#step(object, scope, scale = 0,direction = c("both", "backward", "forward"),trace = 1, keep = NULL, steps = 1000, k = 2, ...)
# default direction is both.
#new.step.model <- step(glm.fits)
#summary(new.step.model)
#glm.fits <- new.step.model

##################################
### 5. TEST  MODEL  ####
##################################

## TEST MODEL USING TEST DATA 

# The predict() function can be used to predict the probability that the market 
# will go up, given values of the predictors. 
# ?predict
# vector with predicted PROBABILITY of default using and test data, using the mdoel created using train data
glm.probs=predict(glm.fits,newdata=test,type="response")
# print first 10 probabilities
glm.probs[1:10]

# convert these predicted probabilities into class labels, Yes or No
glm.pred <- ifelse(glm.probs > 0.5,"Yes","No")

## CONFUSION MATRIX 
#in order to determine how many observations were correctly or incorrectly classified.
table(glm.pred,test$default)

# accuracy (tp+tn)/total
(25+2887)/(3000)  # 0.97 -  - But high false negatives. model not good.

# recall tp/(tp+fn) - what proportion of the true defaulters were predicted as defaulter
25/(25+75)  ## 25% recall- not good

# precision tp/(tp+fp) - of the ones predicted Yes (Defaulter), how many are actually Yes (defaulter)
25/(25+13)  ## 66%

# accuracy (tp+tn)/total

## error rate = 1-0.48 = 52% - worse than random guessing - p-values not good.
## error rate
mean(glm.pred!=test$default)


#HOW CAN WE IMPROVE THIS MODEL?

###################################################
### MODELING ITERATION 2 - sort class imbalance ###
###################################################

#install.packages('dplyr')
library(dplyr)

## SORT CLASS IMBALANCE IN PREDICTOR
# defaulters - 333
df.yes <- df[df$default=='Yes',]

# non-defaulters - 9667
df.no <- df[df$default=='No',]

#take a sample of rows from the non-defaulters
df.no.sample <- sample_n(df.no,5000)

## BALANCED DATASET
#combine th dataset with default=Yes and the sampled dataset with default=No
df2 <- union(df.yes,df.no.sample)

###   - Split data into Train and Test Groups
# install.packages("caTools")
library(caTools)
# use set.seed to reproduce results. expect to get the same sample again with the same seed number
set.seed(112) 

# Split up the sample, basically randomly assigns a booleans to a new column "sample"
sample <- sample.split(df2$default, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE

# Training Data
train = subset(df2, sample == TRUE)

# Testing Data
test = subset(df2, sample == FALSE)

#########################
#### 4.2 BUILD MODEL ####
#########################

# logistic regression model in order to predict Default=Yes

# glm() function fits generalized linear models, a class of models that includes 
# logistic regression. The syntax of the glm() function is similar to that of lm(),
# except that we must pass in the argument 
# family=binomial in order to tell R to run a logistic regression rather than some other type of generalized linear model.

# how is dummy variable created for default
contrasts(df$default)  # Yes=1, No=0 ; model will be trained for probability of market going up

## Train the model for default = Yes
glm.fits=glm(default ~ student + balance + income, data=train ,family=binomial)

#model summary
summary(glm.fits)
# The smallest p-value here is associated with Lag1. The negative coefficient for 
# this predictor suggests that if the market had a positive return yesterday, 
# then it is less likely to go up today. However, at a value of 0.15, the p-value 
# is still relatively large, and so there is no clear evidence of a real 
# association between Lag1 and Direction.

# model trained for probability of market going up
contrasts(train$default)  # Up=1, Down=0

# coef() function in order to access just the coefficients for this fitted model
coef(glm.fits)

##################################
### 5.2 TEST  MODEL  ####
##################################

# The predict() function can be used to predict the probability that the market 
# will go up, given values of the predictors. 
# ?predict
# vector with predicted PROBABILITY of default using and test data, using the mdoel created using train data

glm.probs=predict(glm.fits,newdata=test,type="response")
# print first 10 probabilities
glm.probs[1:10]

# convert these predicted probabilities into class labels, Up or Down
glm.pred <- ifelse(glm.probs > 0.5,"Yes","No")

#confusion matrix 
#in order to determine how many observations were correctly or incorrectly classified.
table(glm.pred,test$default)

# accuracy (tp+tn)/total
(45+1485)/(1600)  # 0.92 -  - But high false negatives. model not good.

# recall tp/(tp+fn) - what proportion of the true defaulters were predicted as defaulter
45/(45+55)  ## 45% recall- not good

# precision tp/(tp+fp) - of the ones predicted Yes (Defaulter), how many are actually Yes (defaulter)
45/(45+15)  ## 75%

