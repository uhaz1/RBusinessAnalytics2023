
### R Dataframes ###
#used to store data tables. each column to be of one data type. columns of different data types can be in a data frame.

#Creating Data Frames
#Importing and Exporting Data
#Getting Information about Data Frame
#Referencing Cells
#Referencing Rows
#Referencing Columns
#Adding Rows
#Adding Columns
#Setting Column Names
#Selecting Multiple Rows
#Selecting Multiple Columns
#Dealing with Missing Data

#list of available built-in data frames
data()

mtcars
class(mtcars)

women
class(women)


## create a data frame form column vectors: data.frame() ##
#create vectors
day <- c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
new.accounts <- c(1000,1200,1150,1500,1600,1400,800)
closed.accounts <- c(40,45,40,70,100,110,30)

#create dataframe from vectors : data.frame()
accounts <- data.frame(day,new.accounts,closed.accounts)
print(accounts)

#structure of accounts data frame
str(accounts)

#summary statistics of columns of the data frame
summary(accounts)

### Import data from a file###

#Import data from csv files to a data frame
#sep=";"
bank.marketing <- read.csv('./data/Advertising.csv')
print(bank.marketing)
head(bank.marketing) # print top rows

#import from an excel file
#install.packages('readxl')
library(readxl)
df1 <- read_excel('file1.xlsx',sheet='Sheet1')

#Export dataframe to csv
write.csv(bank.marketing,file='./data/test_export.csv')

### getting information about a dataframe ###

#structure of accounts data frame - column names and their data types
str(bank.marketing)
#summary statistics of columns of the data frame
summary(bank.marketing)
#number of rows
nrow(bank.marketing)
#number of columns
ncol(bank.marketing)
#Column names
colnames(bank.marketing)
#row names
rownames(bank.marketing)

### data frames - selection and indexing ###

head(bank.marketing)

#referencing cells
bank.marketing[1,2]
#get multiple calles in a data frame
df <- bank.marketing[1:2,1:2]
print(df)
class(df)

#referencing rows
df2 <- bank.marketing[2,]
print(df2)
#head() returns the first few rows
head(bank.marketing)
head(bank.marketing,n=10)
#tails returns the last few rows
tail(bank.marketing)
tail(bank.marketing,n=10)

# referencing columns #
bank.marketing$sales      #returns a vector
col<- bank.marketing$sales #returns a vector
class(col)  #return the class of the elements of the vector

bank.marketing[1,'sales']   #returns a vector
col2 <- bank.marketing[,'sales']  #returns a vector
class(col2)  #return the class of the elements of the vector

bank.marketing[['job']]
col3 <- bank.marketing[['job']]
class(col3)
col3 

bank.marketing[,c('sales','radio','newspaper')]   #returns a vector
col4 <- bank.marketing[,c('sales','radio','newspaper')]  #returns a vector
class(col4)  #return the class of the elements of the vector

#refer columns by column number
bank.marketing[,c(1,2,3)]  
col5 <- bank.marketing[,c(1,2,3)]
class(col5)

# exclude columns
bank.marketing[,-1]  
bank.marketing[,c(-1,-2,-3)]  
bank.marketing[,-c(1,2,3)]  

# adding rows : rbind(df1,df2)

#adding columns
#df[,'new_col'] <- df$col  #copy a column
#df$new_col <- df$col  #copy a column
bank.marketing$sales2 <- bank.marketing$sales *2
bank.marketing[,'sales3'] <- bank.marketing$sales *2  #create new_age = age*2
bank.marketing[,'new_col1'] <- 'test'  #create new_age = age*2
bank.marketing$new_col2 <- 'test'  #create new_age = age*2

#setting column names
#rename column  using colnames()
colnames(bank.marketing)[1] <- 'TV2'
colnames(bank.marketing)[1] <- 'TV'

#rename all columns at once: colnames(df) <- c(....)

#select multiple rows: df[1:n,]
#exclude row: df[-n,]

#conditinal row selection - filter
v1 <- bank.marketing[bank.marketing$sales >10 & bank.marketing$sales < 20, ]
head(v1,n=20)
bank.marketing[bank.marketing$sales == 9.3, ]
bank.marketing[bank.marketing$sales != 9.3, ]
bank.marketing[bank.marketing$sales >10 & bank.marketing$TV <50, ]

#head

#tail


### Dealing with missing data ###
# detect any missing data in df
is.na(bank.marketing)
any(is.na(bank.marketing)) 
# anywhere in col
any(is.na(bank.marketing$sales)) 
# delete selected missing data rows - df <- df[!is.na(df$col), ]
bank.marketing <- bank.marketing[!is.na(bank.marketing$sales), ]


# replace NAs with something else
#df[is.na(df)] <- 0 # works on whole df
#df$col[is.na(df$col)] <- 999 # For a selected column













