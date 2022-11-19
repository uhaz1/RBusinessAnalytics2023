#install.packages("tm")
#install.packages("wordcloud")
#install.packages("RColorBrewer")

# text mining package
library(tm)        
# wordcloud visualisation
library(wordcloud)  
library(RColorBrewer)


### import data

## Reuters data:  http://disi.unitn.it/moschitti/corpora.htm
# Reuters21578-Apte-115Cat

options(stringsAsFactors = FALSE)

# Trainig Data for Trade and MoneyFx categories

trade.directory <- "./data/Reuters21578-Apte-115Cat/training/trade"
moneyfx.directory <- "./data/Reuters21578-Apte-115Cat/training/money-fx"

?Corpus
### create corpus
# corpus <- Corpus(DirSource(directory = trade.directory, encoding = "ASCII"))
corpus <- VCorpus(DirSource(directory = moneyfx.directory, encoding = "ASCII"))

# text in elements in a vector
# corpus <- VCorpus(VectorSource(textVector))

class(corpus)

### inspect corpus
print(corpus)
inspect(corpus[1:2])
#meta(corpus[[2]],"id")
meta(corpus[[1]])

class(corpus[[1]])
corpus[[1]]
corpus[[1]][[1]]     # print document 1
trade.inspect(corpus[[1]]) # character rep of document 1 in tm

lapply(corpus[1:2],as.character)


#### TRANSFORMATIONS  ####

# done using tm_map()
# modify docs - 
# eg. stemming , 
#     stopwords removal
#     

corpus2 <- corpus
# remove extra whitespace
corpus <- tm_map(corpus,stripWhitespace)

# convert to lowercase
corpus <- tm_map(corpus,content_transformer(tolower))
inspect(corpus[[1]])

# remove stopwords
# stopwords - words that are frequent but provide little information./174
# Some common English stop words include "I", "she'll", "the"
corpus <- tm_map(corpus,removeWords, stopwords("english"))
inspect(corpus[[1]])

# Add "word1" and "word" to the list: new_stops
# new_stops <- c("word1", "word2", stopwords("english"))
# corpus <- tm_map(corpus,removeWords, new_stops)

# stemming
# stemming- reduce words to their word stem, base or root form
# eg. cats, catlike, and catty -> cat; fishing, fished, and fisher -> fish
corpus <- tm_map(corpus,stemDocument)
inspect(corpus[[1]])

install.packages('SnowballC')
library(SnowballC)

##### FILTERS #####


#### TERM DOCUMENT MATRIX  ####

#create term document matrix
dtm <- DocumentTermMatrix(corpus)
# inspect term document matrix - sample
inspect(dtm)

# full metrix in dense format
#as.matxix(dtm) 

#### OPERATIONS ON TERM DOCUMENT MATRIX  ####

# terms that occurs at least 5 times
findFreqTerms(dtm,5)

#  associations with at least 0.8 correlation with a word
findAssocs(dtm, "trade",0.4)

# remove sparse terms
# terms document matrices tend to get big. To reduce matrix size dramatically,
#   - remove sparse terms (terms occuring in a very few docs) 
inspect(removeSparseTerms(dtm,0.997))
inspect(dtm)
#new document term matrix with sparse terms removed
removedsparse <- removeSparseTerms(dtm,0.997)

# counts for terms : sum of columns of document term matrix 
freq_up = colSums(as.matrix(removedsparse))
print(freq_up) # named vector of term counts

#word cloud
bag = as.matrix(freq_up) # convert named vector of term counts to matrix
str(bag) 

bag = sort(rowSums(bag), decreasing = T) # sort in descending order of term count
bag.df = data.frame(word = names(bag), freq = bag) # convert o to dataframe


############################
#### WORD CLOUD ####
############################
set.seed(111)

#wordcloud(words = bag.df$word, freq = bag.df$freq, min.freq = 50,colors=brewer.pal(8, "Dark2"))
wordcloud(corpus, max.words = 50, random.order = FALSE, colors = brewer.pal(8,"Dark2"), scale = c(6, 0.5))
wordcloud(words = bag.df$word, freq = bag.df$freq, max.words = 50, random.order = FALSE, colors = brewer.pal(8,"Dark2"), scale = c(6, 0.5))

?wordcloud


############################
#### SENTIMENT ANALYSIS ####
############################

#install.packages("SentimentAnalysis")
library(SentimentAnalysis)

#analyse sentiment
#sentiment <- analyzeSentiment(text[1:100])  ## vector
sentiment <- analyzeSentiment(corpus) ## corpus

# Extract dictionary-based sentiment according to the QDAP dictionary
sentiment$SentimentQDAP

# View sentiment direction (i.e. positive, neutral and negative)
convertToDirection(sentiment$SentimentQDAP)

