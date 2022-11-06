#### DATA MANIPULATION ####

# install.packages('ISLR') # data: Credit dataset
# install.packages("dplyr")
library(ISLR)
library(dplyr)

head(Credit)
dim(Credit)
str(Credit)

# comparision operators : ==, != , <, <=, >, >=, %in%, is.na , !is.na, &, |,boolean operators

### SUBSET OPERATIONS ###

### filter ###

# dplyr
# Student=='Yes' AND Married=='Yes' AND Limit>5000
filter(Credit,Student=='Yes', Married=='Yes', Limit>5000)
# (Student=='Yes' OR Married=='Yes') AND Limit>5000
filter(Credit, Student=='Yes' | Married=='Yes', Limit>5000)

# dataframe : Student=='Yes' AND Married=='Yes' AND Limit>5000
Credit[Credit$Student=='Yes' & Credit$Married=='Yes' & Credit$Limit>5000,]

# (Student=='Yes' OR Married=='Yes') AND Limit>5000
# subset() : part of R base
subset(Credit,(Student=='Yes' | Married=='Yes') & Limit>5000)

### slice : select rows by position ###

# dplyr : slice 
slice(Credit,10:15)
# dataframe : slice 
Credit[10:15,]

head(Credit)

### select columns by name ###

# dplyr : select columns
head(select(Credit,ID,Rating ))

# dataframe : select columns
head(Credit[,c(1,4)])
head(Credit[,c('ID','Rating')])

### distinct : remove duplicate rows ###
# dplyr : distinct
distinct(select(Credit,Cards,Gender))
# duplicate rows
select(Credit,Cards,Gender) 


### RESHAPING DATA ###
head(Credit)
### dplyr : order rows by values of a column : Low to high
arrange(Credit, Limit)
df <- arrange(Credit, Limit)
head(arrange(Credit, Limit))
head(arrange(Credit, Limit,Rating), n=10)

### dplyr : order rows by values of a column : High to Low
head(arrange(Credit, desc(Limit)))
head(arrange(Credit, desc(Limit)), n=10)

df <- Credit
head(df)

### R Base : rename columns - r base ###
colnames(df)[2] <- 'Income2'
head(df)

### dplyr : rename columns  ###
head(rename(df,Limit2=Limit)) ## not in in-place function. you need to reassign the renamed data structure to a new variable
a<- rename(df,Limit2=Limit)

df <- Credit
head(df)

### CREATE NEW VARIABLES ###

## dplyr: create new variables
head(mutate(df,Available=Limit-Balance))

df2 <- mutate(df,Available=Limit-Balance)
head(df2)

head(df)

min(df2$Available)

## R base - create new variables
df$Available2 <- df$Limit- df$Balance
head(df)

head(Credit)

### SUMMARISE DATA ###

## Summarise data into single rows

#dplyr : summarise - min, max, mean, median, var, sd, n, first , last, sum

summarise(Credit,avg.balance= mean(Balance))
summarise(Credit,min.balance= min(Balance))
summarise(Credit,max.balance= max(Balance))              
summarise(Credit,sum.balance= sum(Balance))          
summarise(Credit,sd.balance= sd(Balance))            ## std dev
summarise(Credit,median.balance= median(Balance))    ## median
summarise(Credit,count.balance= n())                ## rows
summarise(Credit,count.balance= n_distinct(Cards))  ## distinct values


# R base : min, max, mean, median, var, sd, n
sum(Credit$Balance)
min(Credit$Balance)
max(Credit$Balance)
mean(Credit$Balance)
sd(Credit$Balance)
median(Credit$Balance)
length(Credit$Balance)


### PIPE OPERATOR ###
# Chain operators - perform multiple opearations in sequence

Credit %>% select(Student,Cards) %>% distinct() 

distinct(select(Credit,Student,Cards))

## COMPUTE SUMMARY FOR EACH GROUP ##
# GROUP BY #
# group data into rows with the same value of selected column

# sum of balance by Student type
Credit %>% group_by(Student) %>% summarise(sum.balance=sum(Balance))

head(Credit)
# sum of balance by Cards 
Credit %>% group_by(Cards) %>% summarise(sum.balance=sum(Balance))

df.cards.balance <- Credit %>% group_by(Cards) %>% summarise(sum.balance=sum(Balance))
head(df.cards.balance)
  
# sum of balance by Cards in descending order of balance
Credit %>% group_by(Cards) %>% summarise(sum.balance=sum(Balance)) %>% arrange(desc(sum.balance))

head(Credit)

# sum of balance for Married flag
Credit %>% group_by(Married) %>% summarise(sum.balance=sum(Balance), count=n())

# sum of balance for Married flags and Age>30
Credit %>% filter(Age>30) %>% group_by(Married) %>% summarise(sum.balance=sum(Balance), count=n())

# sum of balance by Student flag and Married
Credit %>% group_by(Student,Married) %>% summarise(sum.balance=sum(Balance))

# sum of balance by Student FLAG and Married FLAG. Order in decending order of balance
Credit %>% group_by(Student,Married) %>% summarise(sum.balance=sum(Balance))  %>% arrange(desc(sum.balance))



