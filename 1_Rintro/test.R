
#install.packages("ISLR2")
#install.packages("MASS")
library(ISLR2)
library(ISLR)
library(MASS)
test <- Credit
library(dplyr)

test <- read.csv('./data/Advertising.csv')

test$sales <- as.numeric(test$sales)
summary(test$sales)
summarise(test$sales)

test2 <- summarise(test, total.balance=sum(Balance)) 

cr <- Credit
cr2 <- filter(cr, Limit>8000,Student=='Yes')
class(cr2)

cr3 <- cr %>% group_by(Student) %>% summarise(total.balance=sum(Balance))
