
#Variables
x <- 1 
y <- 'happy'
#logial
z <- TRUE

#Vectors
v <- c(23,43, 14,12)
v2 <- c('S','T','A','D')
v2[1]

v3 <- 1:8

# 2-dimensions - Matrix
mat1 <- matrix(v3,nrow=2, byrow=TRUE)
print(mat1)

# 2d data- Data frame
#read data from a csv file
df <- read.csv('./data/Advertising.csv')

head(df, n=10)
#write data to a csv file
write.csv(df, file = './data/test_data.csv')

#structure of a dataframe
str(df)
#summary statistics
summary(df)

dim(df)  # dimensions- row and column counts
nrow(df) # row count
ncol(df) # column count

col <- colnames(df) # column names of a dataframe
print(col) #print object

class(x) #data type
class(v)
class(df)

df[1,2]  #df[i,j] row i , column j
v4 <- df[1,]

df[2:4,]
df[2:4,c(3,4)] #rows 2 to 4, columns 3 and 4
df[2:4,c('newspaper','sales')]  #rows 2 to 4, columns 3 and 4

df[2:4,c(-3,-4)] # rows 2 to 4, exclude columns 3 and 4

vec5 <- df$sales #vector of - sales column
write.csv(vec5,'./data/test_data2.csv')

#aggregate numeric elements of vectors and dataframes

# use na.rm=TRUE if there are missing values
sum(df$sales)
sum(vec5)
?sum

min(df$sales)  # min value
max(df$sales)  # max value
sd(df$sales)   #std deviation

length(df$radio) # number of elements in a vector
nrow(df) # row in a dataframe

df1 <- df[df$radio>40,] #rows with df$radio>40, select all columns
head(df1)
sum(df1$sales) 

max(df$radio)

#rows with radio>40 and radio<45, select sales and radio columns
df2 <- df[df$radio>40 & df$radio<45,c('sales','radio')]
head(df2)
sum(df2$sales)

## dplyr package has useful function to manipulate data
#install.packages('dplyr')
library(dplyr)

# this package has datasets from the ISLR textbook
#install.packages('ISLR')
library(ISLR)

head(Credit) # view top rows in the Credit data frame
str(Credit)   # structure of the data frame

cr <- Credit  # assign data in the Credit data frame to cr
head(cr)
cr$Gender <- factor(cr$Gender) #convert Gender to a factor. Categorical variables are defined as factor.

df3 <- select(cr, ID, Balance) #dplyr - select ID, Balance from cr data frame

### Comparison operators: ==, >, >=, <=, &, |
filter(cr,Limit>8000,Student=='Yes') #dplyr - filter for rows in cr for Limit > 8000 and Student==Yes
filter(cr,Limit>8000 & Student=='Yes')  #dplyr - filter for rows in cr for Limit > 8000 and Student==Yes
filter(cr, Limit > 8000 | Student =='Yes') #dplyr - filter for rows in cr data frame for Limit > 8000 or Student=Yes

# dplyr - filter the cr data frame- select rows with (Limit > 8000 or Student=Yes) and Cards==2
filter(cr, Limit > 8000 | Student=='Yes', Cards==2)

## aggregate functions: sum, mean, max, sd, median, n, n_distinct
summarise(cr, total.balance=sum(Balance)) # dplyr: total.balance has the sum of balance 
#sum(cr$Balance, na.rm=TRUE)
# dplyr - total.balance has sum of balance, avg.balance have mean of balance
summarise(cr,total.balance=sum(Balance), avg.balance=mean(Balance))

#pipe operator : %>%
#dplr: in cr data frame filter for rows with Limit>8000 and Student=Yes
cr %>% filter(Limit>8000,Student=='Yes') 

# dplyr pipe- filter cr dataframe for Limit>8000 and Student=Yes. Then sum the balance of the filtered data
cr %>% filter(Limit>8000, Student=='Yes') %>% summarise(total.balance=sum(Balance)) 

# dplyr pipe- filter cr dataframe for Limit>8000 and Student=Yes. Then calculate the sum of the balance of the filtered data and average of the Balance
cr %>% filter(Limit>8000, Student=='Yes') %>% summarise(total.balance=sum(Balance), avg.balance=mean(Balance)) 

#group_by
#sum of Balance by Student
cr %>% group_by(Student) %>% summarise(total.balance=sum(Balance))
# Sum of Balance by Student and Married
cr %>% group_by(Student,Married) %>% summarise(total.balance=sum(Balance))
