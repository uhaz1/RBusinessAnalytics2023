
#### Linear Regression model  ####


#large collection of datasets
#library(MASS)
#datasets withthe ISLR book
#install.packages("ISLR")
#library(ISLR)


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
###   
### 5. Test model - Test model with test data  


#### Model 2 : Multiple Linear Regression : predict sales from TV, radio and newspaper spending
## understand relationships

#######################
### 1. IMPORT DATA ####
#######################

## This dataset comes with the ISLR book
advertising <- read.csv('./data/Advertising.csv')

## view sample
head(advertising, n=10) #top rows
tail(advertising) # last rows

#check data structure
str(advertising)
# summary of data
summary(advertising)


######################
### 2. CLEAN DATA ###
#####################

###   - check for missing values , other data issues

### Dealing with missing data ###
# detect any missing data in dataframe
# - delete rows with missing data or insert NA cells with an estimate eg. an average #
any(is.na(advertising))

# check for missing data anywhere in a column
# any(is.na(advertising$sales)) 
# any(is.na(advertising$TV)) 

# delete selected missing data rows - df <- df[!is.na(df$col), ]
# advertising<- advertising[!is.na(advertising$TV), ]


### set correct data types for columns
## factor() : ensure categorical inout variables are defined as factor using factor() function
# df$var <- factor(df$factor)

str(advertising) 


###########################################
### 3. EXPLORATORY DATA ANALYSIS (EDA)  ###
###########################################

### check for assumptions of multiple regression
#  multicollinearity - high correlations among input variables : use correlation matrix of VIF
#  assumed linear relationship between response and predictors - scatter plot between response and a preditor var or after model building, do a scatter plot of residual error vs. predictor variables/fitted values
#  normality: distribution of numerical variables (eg. in a histogram) should roughly follow a bell curve. If the data is skewed, a transformatoin using log, square or square root might sort this issue

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
# ggplot(data=advertising, aes(x=TV)) + geom_histogram()

## Radio ##
p2 <- ggplot(data=advertising, aes(x=radio))
## Geometric objects (type of plot) ##
p2 + geom_histogram()
# ggplot(data=advertising, aes(x=radio)) + geom_histogram()

## Newspaper ##
p3 <- ggplot(data=advertising, aes(x=newspaper))
## Geometric objects (type of plot) ##
p3 + geom_histogram()

## sales ##
p4 <- ggplot(data=advertising, aes(x=sales))  ## Aesthetic mappings (data columns to use in plotting) ##
p4 + geom_histogram()  ## Geometric objects (type of plot) ##
#ggplot(advertising,aes(x=sales)) + geom_histogram(bins=20,alpha=0.5,fill='blue') + theme_minimal()

#### scatter plots between reponse and predictor variables ####
# scatter plot bween response and predictor is assumed to be linear. 
# If it significantly deviates from linear, please consider transforming the predictor variable (eg. square, square root, log), eg. for a parabola, a squared predictor might better fit the data

##Scatter plot - sales vs TV ###
# Aesthetic mappings (data columns to use in plotting) ##
p5 <- ggplot(data=advertising, aes(x=TV, y=sales))
## Geometric objects (type of plot) ##
p5 + geom_point()

# ggplot(data=advertising, aes(x=TV, y=sales)) + geom_point()

##Scatter plot - sales vs radio ###
## Aesthetic mappings (data columns to use in plotting) ##
p6 <- ggplot(data=advertising, aes(x=radio, y=sales))
## Geometric objects (type of plot) ##
p6 + geom_point()

##Scatter plot - sales vs newspaper ###
## Aesthetic mappings (data columns to use in plotting) ##
p7 <- ggplot(data=advertising, aes(x=newspaper, y=sales))
## Geometric objects (type of plot) ##
p7 + geom_point()
# points too scattered without much of a clear pattern

#### Correlation matrix  ####

## get the numeric columns
numeric.cols <- sapply(advertising, is.numeric)
print(numeric.cols)

# get correlations on the numeric columns
numeric.data <- advertising[,numeric.cols] ## data of numeric columns

#correlation.data <- cor(advertising[,numeric.cols])


## calculate correlation matrix
# cor() funfunction calculates correlation matrix
correlation.data<-cor(numeric.data)
# print correlation matrix - check for predictor variables which are highly correlated
print(correlation.data)


## package to plot correlations
#install.packages('corrplot')
#install.packages('corrgram')
#library(corrgram)
library(corrplot)

# help(corrplot)
# plot correlations
corrplot(correlation.data,method='color')
#corrgram(correlation.data,order=TRUE, lower.panel=panel.shade, upper.panel=panel.pie, text.panel=panel.txt)




#######################
### 4. BUILD MODEL ####
#######################

###   - Split data into Train and Test Groups



###   - Train model on train group

#model <- lm(y ~ x1 + x2,data)
#model <- lm(y ~. , data) # Uses all features
model <- lm(sales ~ radio+newspaper+TV ,data=advertising)
#model <- lm(sales ~ .,data=advertising)

#model summary
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








