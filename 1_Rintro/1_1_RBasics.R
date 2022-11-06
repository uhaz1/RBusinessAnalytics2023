

##### INTRODUCTION TO R - Summary #####

### R PROGRAMMING BASICS ###

### 1.1 Arithmetic with R ###
# addition
1 + 2
# subtraction
4-3
# multiplication
5*4
# Division
5/2
# Exponents
2^3
#Modulo
5 %% 2


### 1.2 Comparison Operators ###
# Greater than
3 > 4

# Greater than or equal to
4 >= 3

# Less than
3 < 4

# Less than or equal to
4 <= 3

v1 <- 4
v2 <- 5
v1 < v2

#Equal
3 == 3
3 == 2
#Not Equal
3 != 2

#Order of operations - PEMDAS - Parentheses, Exponents, Multiplication and Division (from left to right), Addition and Subtraction (from left to right).
#http://www.math.wm.edu/~leemis/Rsamples/4-5.pdf
(100 * 2) + (50 / 2)

# Use hashtags for comments

# 2. FUNCTION- A function is a set of statements organized together to perform a specific task. 
# https://www.tutorialspoint.com/r/r_functions.htm

# 2.1 USER DEFINED FUNCTION
# a function to add two numbers and print the sum to console
add_two_numbners <- function(x,y) {
  print(x+y)
}

# calling a function: function_name(arg1 = val1, arg2 = val2, ...)
add_two_numbners(1,2)

# 2.2 R has a large number of in-built functions and the user can create their own functions.
# Reference to useful functions that comes with R: https://cran.r-project.org/doc/contrib/Short-refcard.pdf
# calling a function: function_name(arg1 = val1, arg2 = val2, ...)

# 2.3. PACKAGE: Extension to R. Can contains functions and data to provide additional functionality. 
# Can be installed by the the user usually via a centralised software repository such as CRAN
# to be loaded on top of the script
# dplyr package has functions to easily manipulate data tables
# ggplot package has functions to plot data 



### 2. STORING DATA IN R OBJECTS / VARIABLES ###
# a placeholder in the computer memory here a value or set of values can be stored. variable names are case sensitive
# object_name <- value, 
# variable_name <- value

## 2.1 STORING PRIMITIVE VALUES IN VARIABLES (eg. a number or character) ##
# variable x stores a value 1 of numeric data type.  
# x is assigned a value of 1 using the assignment operator <-. = can also be used as an assignment operator
x <- 1 
# Object/variable names must start with a letter, and can only contain letters, numbers, _ and .
x_1 <- 2
sales.year1 <- 200000

# variable y stores a value 'happy' of character data type. character values are enclosed in quotes
y <- 'happy'
# variable z stores a Boolean or Logical value of TRUE. TRUE or FALSE are possible boolean values. All uppercase letters
z <- TRUE
# logical need to be all uppercase. True or False is not boolean as all letters are not uppercase
z2 <- True 


## 2.2 VECTORS: STORING SETS OF VALUES ##

# A vector is a simple data structure - 1 dimensional array that can hold character, numberic or logical data elements
# a vector is created using the function c()

# a numeric vector which has a set of four numeric values
vec1 <- c(3,4,15,16)
print(vec1)
class(vec1)
#a character vector which has a set of four character values enclosed in quotes
vec2 <- c('A','B','S')
print(vec2)
class(vec2)
#logical
vec3 <- c(TRUE,FALSE)
print(vec3)
class(vec3)

#you cannot mix data types. if you try, all elements will be forced to a single data type
vec4 <- c(4,'APPLE')
print(vec4)
class(vec4)

#names can be assigned to each element of a vector
vec5 <- c(3,4,15,16)
names(vec5) <- c('Jan','Feb','Mar','Apr')
print(vec5)

### Vector Indexing and Slicing ###
vec1 <- c(3,4,15,16)
vec2 <- c('A','B','S')

#to get an element of a vector using bracket notation
print(vec1[1])
print(vec1[3])
print(vec2[1])
print(vec2[3])

# to get multiple elements of a vector - multiple indexing 
# pass a vector of index positions
print(vec1[c(1,3)])

#slicing- vector[startIndex:stopIndex]
print(vec1[1:3])

#indexing with names
vec5 <- c(3,4,15,16)
names(vec5) <- c('Jan','Feb','Mar','Apr')
print(vec5)
vec5['Jan']
vec5[c('Jan','Mar')]

vec5 > 4

#Compare and select
print(vec5[vec5>4])
vec5 > 4

# assign names to filters
filter <- vec5 > 4
print(filter)
print(vec5[filter])


### Vector Operations ###
#elementwise
vec5 <- c(3,4,15,16)
vec6 <- c(2,3,5,1)

#add elementwise
print(vec5 + vec6)
#subtract elementwise
print(vec5 - vec6)
#multiply elementwise
print(vec5*vec6)
#divide elementwise
print(vec5/vec6)

#using built-in functions on vectors
#sum() - add all elements
sum(vec6)  
#standard deviation
sd(vec6)
#variance
var(vec6)
#maximum element
max(vec6)
#minimum element
min(vec6)
#product of elements
prod(vec6)

#combine vectors
client1 <- c(3,4,15,16)
client2 <- c(2,3,5,1)

vec7 <- c(client1,client2)
print(vec7)



###  Getting help with R ###
# google search, stackoverflow
# R documentation
# Need help with vectors, try help()
# https://www.r-project.org/other-docs.html
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html

help(vector)
?vector
help.search('vector')

### Print formatting ###
# print()
print("hi there!")
print(vec6)
print(iris) # measurement samples for 3 flower species /datasets

# paste() : paste (..., sep = " ") - add a default space separator
print(paste("hi","there","uh"))
print(paste("hi","there",sep=":"))
paste("hi","there",sep="")
print(paste("hi","there",sep="-"))
# paste0(...) is equivalent to paste(...,sep="") 
print(paste0("hi","there", "."))



## 2.3 MATRIX: STORE TWO Dimensional data can be stored in a matrix
# a matrix can store two dimensional data

#v <- c(1,2)
v <- 1:10 #short notation to create a vector with sequence of numbers
print(v)
help(matrix) #help on matrix function

matrix.numbers <- matrix(v,nrow=2)
print(matrix.numbers)

matrix.numbers2 <- matrix(v,byrow=TRUE,nrow=2)
print(matrix.numbers2)

v2 <- 1:8
print(v2)
matrix.sales <- matrix(v2,byrow=TRUE,nrow=2)
print(matrix.sales)

#naming matrices
months <- c('Jan','Feb','Mar','Apr')
client.names <- c('Client1', 'Client2')

colnames(matrix.sales) <- months       #name columns using the colnames() function
rownames(matrix.sales) <- client.names #name rows using the rownames() function

print(matrix.sales)

mat1 <- matrix(v3,nrow=2, byrow=TRUE) # assign elements row wise : byrow=TRUE
?matrix
print(mat1)
dim(mat1)  #dimensions - row & column count



## 2.4 DATAFRAME: STORE TWO Dimensional table data in a dataframe

# import a data table from a csv file into a dataframe variable named df using the  r base function read.csv()
df <- read.csv('./data/Advertising.csv')
# view the first ten rows in the dataframe called df
head(df, n=10)
#write the data in dataframe df into a csv file called test_data.csv using the r base function write.csv()
write.csv(df,file='./data/test_data.csv')
# structure() : get the structure of dataframe df using the r base function str()- which tells the variable or column names, their data types and sample values
str(df)   
#summary() : r base function to get summary statistics of the columns of the dataframe df
summary(df) 
#dim() : r base function to get dimensions of dataframe df - row & column counts
dim(df)    
# nrow() : r base function to get row count of a dataframe
nrow(df)   
# ncol() : r base function to get column count of a dataframe
ncol(df)   
# colnames() : r base function to get names of columns in a dataframe
colnames(df) 
# column names of dataframe df assigned to a vector named as col
col <- colnames(df) 
# print the value of variable or object named col
print(col)  
# class() : r base function to get class of object df : data frame
class(df)  
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

# one column of a dataframe is a vector of a set of values in the column
df$sales           # vector output: sales column of data frame df.
sales1 <- df$sales # sales1 is a vector of values in sales column of data frame df.
write.csv(sales1,'test.csv') # write sales1 to a csv file


## aggregate numeric elements of a vector or column of a data frame
# use na.rm = TRUE if there are NA or missing values in the column
sum(df$sales)   #sum of all elements of df$sales
sum(df$sales, na.rm=TRUE) # ignore NA or missing value. if na.rm=TRUE is not used, the sum will not result in a sum value if the column/vector has NA values
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


