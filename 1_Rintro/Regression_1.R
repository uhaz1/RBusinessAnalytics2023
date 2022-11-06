
#### Linear Regression model  ####


#large collection of datasets
library(MASS)
#datasets withthe ISLR book
#install.packages("ISLR")
library(ISLR)


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
###   - Test model with test data (We wil skip this step today)
###   - Predict





#### Model 1 : Simple Linear Regression : predict sales form TV spending

### 1. import data 
## This dataset comes with the ISLR book
advertising <- read.csv('./data/Advertising.csv')

## view sample
head(advertising, n=10) #top rows
tail(advertising) # last rows

#check data structure
str(advertising)
# summary of data
summary(advertising)

### 2. clean data 

###   - check for missing values, other data issues

### Dealing with missing data ###
# detect any missing data in dataframe
# - delete rows with missing data or insert NA cells with an estimate eg. an average ###

any(is.na(advertising))

#  check for missing data anywhere in a column
#any(is.na(advertising$sales)) 
#any(is.na(advertising$TV)) 

# delete selected missing data rows - df <- df[!is.na(df$col), ]
# advertising<- advertising[!is.na(advertising$TV), ]

###   - set correct data types for columns
## nsure categorical inout cariables are defined as factor using factor() function
#  df$var <- factor(df$factor)
str(advertising) 


### 3. exploratory Data Analysis (EDA) 
###   - check for assumptions - multicollinearity - high correlations among input variables
# get numeric columns

#install.packages("ggplot2")
library(ggplot2)

## ggplot is based on the philosophy of grammar of graphics
## the idea is to add layers to visualisation
## layers 1-3 
## layer 1: data , layer 2: aesthetics (data columns to use in plotting), 
## layer 3 : geometries (type of plot)

## distribution of variables

### TV ###
## Aesthetic mappings (data columns to use in plotting) ##
p1 <- ggplot(data=advertising, aes(x=TV))
## Geometric objects (type of plot) ##
p1 + geom_histogram()

## histogram of sales
p2 <- ggplot(data=advertising, aes(x=sales))  ## Aesthetic mappings (data columns to use in plotting) ##
p2 + geom_histogram()  ## Geometric objects (type of plot) ##

#ggplot(advertising,aes(x=sales)) + geom_histogram(bins=20,alpha=0.5,fill='blue') + theme_minimal()


##Scatter plot - sales vs TV ###
## Aesthetic mappings (data columns to use in plotting) ##
p3 <- ggplot(data=advertising, aes(x=TV, y=sales))
## Geometric objects (type of plot) ##
p3 + geom_point()

numeric.cols <- sapply(advertising, is.numeric)
print(numeric.cols)

# get correlations onthe numeric columns
correlation.data <- cor(advertising[,num.cols])

correlation.data


#lm.fit = lm(sales)

## package to plot correlations
#install.packages('corrplot')
library(corrplot)

#help(corrplot)
corrplot(correlation.data,method='color')



#####################
### 4. Modelling ####
#####################

###   - Split data into Train and Test Groups

###   - Train model on train group
#model <- lm(y ~ x1 + x2,data)
#model <- lm(y ~. , data) # Uses all features
model <- lm(sales ~ TV,data=advertising)
#model <- lm(sales ~ .,data=advertising)
summary(model)

###   - Interpret model

###   - Plot residuals (errors)
### histograms of residuals to be normally distributed. check textbook ISLR sectton 3.3 for for details on potential problems 
# get residuals (errors)
res <- residuals(model)
class(res)
# Convert to DataFrame for gglpot
res <- as.data.frame(res)

head(res)

# Histogram of residuals/errors
# expect a bell pattern - errors are assumed to be normally distrbuted
ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5)
# broadly the residuals seem to follow a bell pattern

# model diagnostics: check for assumptions
# https://www.youtube.com/watch?v=0MFpOQRY0rw
## Check book ISLR secton 3.3 for model diagnostics

plot(model)








