#variables
x <- 1
y <- 'happy'
# Logical(TRUE/FALSE)/ Boolean
z <- TRUE
# logical need to be all uppercase
z2 <- True 
#Vector
v <- c(1,412,14,2)       #create numeric vector
v2 <- c('S','T','A','D') #create character vector
#to get an element of a vector using bracket notation
v[1]  # 
v[3]
v2[2]
v3 <- 1:8
v3[2]
## 2d data - matrix
mat1 <- matrix(v3,nrow=2, byrow=TRUE) # assign elements row wise : byrow=TRUE
?matrix
print(mat1)
dim(mat1)  #dimensions - row & column count
## 2d - data frame
df <- read.csv('./data/Advertising.csv')
head(df, n=10)
write.csv(df,file='./data/test_data.csv')
str(df)     # structure
summary(df) #summary
dim(df)    #dimensions - row & column count
nrow(df)   # row count
ncol(df)   # column count
colnames(df) # column names
col <- colnames(df) # column names of data frame assigned to vector col
print(col)  # print object
  
class(df)  # class of object df : data frame
class(mat1) # class of object : matrix
class(col)  # class(vector) prints the data type of the elemets of the vector

head(df)   #print top rows of data frame- default = 6
tail(df, n=9) #print top n rows of data frame

#referencing cells of data frames
df[1,2]  #df[i,j] - row i, column j : row 1, column 2
df[2:4,] # rows 2 to 4, all columns
df[2:4,c(3,4)]  # rows 2 to 4, columns 3 & 4
df[2:4,c('newspaper','sales')] # rows 2 to 4, columns 'newspaper' and 'sales'
df[2:4,c(-3,-4)] # rows 2 to 4, exclude columns 3 & 4

df$sales           # vector output: sales column of data frame df.
sales1 <- df$sales # sales1 is a vector of values in sales column of data frame df.
write.csv(sales1,'test.csv') # write sales1 to a csv file

## aggregate numeric elements of a vector or column of a data frame
# use na.rm = TRUE if there are NA or missing values in the column
sum(df$sales)   #sum of all elements of df$sales
?sum
sum(sales1) 
min(df$sales)  #min of all elements of df$sales
?min
max(df$sales) #max of all elements of df$sales
sd(df$radio)  #standard deviation of df$radio

length(df$radio) #number of elements in df$radio
head(df)

df1 <- df[df$radio>40,] # rows with df$radio>40, select all columns
head(df1)
sum(df1$sales)

max(df$radio)
# rows with df$radio>40  & df$radio<=45, select columns sales & radio
df2<- df[df$radio>40 & df$radio<=45,c('sales','radio')] 
head(df2)
sum(df2$sales)

#install.packages('dplyr'). This package has useful data manipulation functions
library(dplyr)

#install.packages('ISLR'). This package has datasets form the ISLR book.
library(ISLR)
head(Credit)  #view top rows of data in the Credit dataset
str(Credit)   # dtructure of Credit dataset : row & column count, column names and their data types
cr <- Credit  # assign data in Credit data frame to cr data frame variable
head(cr)  # top rows of cr

cr$Gender <- factor(cr$Gender) # convert cr$Gender to a factor.Categorical variables are to be defined as factors

select(cr,ID,Balance) #dplyr: select columns ID, Balance fromt he cr data frame

head(cr)
## Comparison operators: == , > , >=, <=, &, |
filter(cr,Limit>8000,Student=='Yes')   #dplyr: filter rows of cr - select rows with Limit>8000 & Student=='Yes'
filter(cr,Limit>8000 & Student=='Yes') #dplyr: filter rows of cr - select rows with Limit>8000 & Student=='Yes'
filter(cr,Limit>8000 | Student=='Yes') #dplyr: filter rows of cr - select rows with Limit>8000 OR Student=='Yes'
#dplyr: filter rows of cr - select rows with (Limit>8000 OR Student=='Yes') and Cards==2
filter(cr,Limit>8000 | Student=='Yes',Cards==2) 
#aggregate functions: sum, mean, max, min, sd, median, n, n_distinct
summarise(cr,total.balance=sum(Balance)) #sum of Balance. assign sum to total.balance variable name
summarise(cr,total.balance=sum(Balance), avg.balance=mean(Balance)) #sum of Balance, average Balance

#pipe operator : %>%
cr %>% filter(Limit>8000,Student=='Yes')  #dplyr: filter rows of cr - select rows with Limit>8000 & Student=='Yes'
#dplyr pipe: 1. filter rows of cr - select rows with Limit>8000 & Student=='Yes' 2. Then, sum of Balance of the filtered data formt he previous step
cr %>% filter(Limit>8000,Student=='Yes') %>% summarise(total.balance=sum(Balance))
#dplyr pipe : 1. filter rows of cr - select rows with Limit>8000 & Student=='Yes' 2. Then, sum of Balance and average of Balance of the filtered data in the previous step
cr %>% filter(Limit>8000,Student=='Yes') %>% summarise(total.balance=sum(Balance), avg.balance=mean(Balance))

#group_by 
#dplyr pipe: 1. group observations by value of Student variable(Yes/No) 2. sum Balance for each group of Student (Yes, No)
cr %>% group_by(Student) %>% summarise(total.balance=sum(Balance))
#dplyr pipe: 1. group observations by value of Student variable(Yes/No) and then by Married (Yes, No) 2. sum Balance for each group of Student (Yes, No) and Married (Yes, No) combinations
cr %>% group_by(Student, Married) %>% summarise(total.balance=sum(Balance))
#dplyr pipe: 1. group observations by value of Student variable(Yes/No) and then by Married (Yes, No) 2. sum Balance & average Balnce for each group of Student (Yes, No) and Married (Yes, No) combinations
cr %>% group_by(Student, Married) %>% summarise(total.balance=sum(Balance), avg.balance=mean(Balance))

#dplyr pipe: 1. group observations by value of Student variable(Yes/No) and then by Married (Yes, No) 2. sum Balance & average Balnce for each group of Student (Yes, No) and Married (Yes, No) combinations
# assign the results of the pipe operations on cr data frame to result variable
result <- cr %>% group_by(Student, Married) %>% summarise(total.balance=sum(Balance), avg.balance=mean(Balance))
print(result) # print result
