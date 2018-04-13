# 0. setup
rm(list=ls())
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")

install.packages("tokenizers")
install.packages("quanteda")
install.packages("tm")
install.packages("dplyr")
install.packages("stringr")
library(tokenizers)
library(quanteda)
library(tm)
library(dplyr)
library(stringr)


##1.Loading data 
blogs<-readLines(con <- file("./en_US.blogs.txt"), encoding = "UTF-8", skipNul = TRUE )#, n=10000)
close(con)
twitter<-readLines(con <- file("./en_US.twitter.txt"), encoding = "UTF-8", skipNul = TRUE )#, n=10000 )
close(con)
news<-readLines(con <- file("./en_US.news.txt"), encoding = "UTF-8", skipNul = TRUE )#, n=1000)
close(con)
text <-c(blogs, twitter, news)
l<-length(text)
size<-0.25*length(text)
text<-sample(text, size, replace = FALSE, prob = NULL)
saveRDS(text, file = "text.rds")


####################################################################
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
text <- readRDS("./text.rds")


#library(tokenizers)
#library(quanteda)
#library(tm)
#library(dplyr)
library(stringr)


#2. Cleaning text
text <- removeNumbers(text)
text <- removePunctuation(text)
text <- stripWhitespace(text)
text <- tolower(text)
head(text)

#removing foreign language words (those that contain other characters than a-z)
text<-gsub(pattern = '[a-zA-Z0-9]+[^a-zA-Z0-9\\s]+[a-zA-Z0-9]+',
           x = text,
           replacement = "",
           ignore.case = TRUE,
           perl = TRUE)

#removing stopwords
stopwords=stopwords()
#stopwords = c("a", "the", "an")
for (i in 1:length(text) )
{
  x <- unlist(strsplit(text[i], " "))
  text[i]<-paste(x[!x %in% stopwords], collapse = " ")
}
head(text)

saveRDS(text, file = "text1.rds")


####################################################################
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
text <- readRDS("./text1.rds")
library(tokenizers)
library(quanteda)
library(tm)
library(dplyr)
library(stringr)


#3.Generating ngrams & splitting them into separate words
#NGram 1
tokens <- tokenize_ngrams(text,n=1,n_min = 1)
tokenTable <- table(unlist(tokens))
ngramOne <- data.frame(tokenTable)
ngramOne <- ngramOne[order(ngramOne$Freq,decreasing = TRUE),]
colnames(ngramOne) <-c("word1", "freq")
head(ngramOne)
dim(ngramOne)

##cutting unigrams that appear only one time
ngramOne <-subset(ngramOne, !( freq == "1" ))
saveRDS(ngramOne, file = "ngramOne.rds")


#NGram 2
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
text <- readRDS("./text1.rds")
library(tokenizers)
library(quanteda)
library(tm)
library(dplyr)
library(stringr)

#sampling (otherwise RStudio can't handle it)
l<-length(text)
size<-0.5*length(text)
text<-sample(text, size, replace = FALSE, prob = NULL)

tokens <- tokenize_ngrams(text,n=2,n_min = 2)
tokenTable <- table(unlist(tokens))
ngramTwo <- data.frame(tokenTable)
ngramTwo <- ngramTwo[order(ngramTwo$Freq,decreasing = TRUE),]
head(ngramTwo, n=10)

##split 2gram into 2 separate words 
bigram_split <- strsplit(as.character(ngramTwo$Var1),split=" ")
ngramTwo <- transform(ngramTwo,word1 = sapply(bigram_split,"[[",1),word2 = sapply(bigram_split,"[[",2), freq = ngramTwo$Freq)
head(ngramTwo)
ngramTwo <- ngramTwo[,3:5]
head(ngramTwo)
#colnames(ngramTwo)<-c("word1", "word2","freq")
ngramTwo <-subset(ngramTwo, !( freq == "1" ))

saveRDS(ngramTwo, file = "ngramTwo2.rds")


#NGram 3
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
text <- readRDS("./text1.rds")
library(tokenizers)
library(quanteda)
library(tm)
library(dplyr)
library(stringr)

#sampling (otherwise RStudio can't handle it)
l<-length(text)
size<-0.5*length(text)
text<-sample(text, size, replace = FALSE, prob = NULL)
tokens <- tokenize_ngrams(text,n=3,n_min = 3)
tokenTable <- table(unlist(tokens))
ngramThree <- data.frame(tokenTable)
ngramThree <- ngramThree[order(ngramThree$Freq,decreasing = TRUE),]
head(ngramThree, n=10)
tail(ngramThree, n=1000)
ngramThree <-subset(ngramThree, !( Freq == "1" ))
saveRDS(ngramThree, file = "ngramThree12.rds")

##split 3gram into 3 separate words
trigram_split <- strsplit(as.character(ngramThree$Var1),split=" ")
head(trigram_split)
ngramThree <- transform(ngramThree,word1 = sapply(trigram_split,"[[",1),word2 = sapply(trigram_split,"[[",2), word3=sapply(trigram_split,"[[",3), freq = ngramThree$Freq)
head(ngramThree)
ngramThree <- ngramThree[,3:6]
head(ngramThree)
tail(ngramThree)
saveRDS(ngramThree, file = "ngramThree2.rds")


#Ngram 4
tokens <- tokenize_ngrams(text,n=4,n_min = 4)
tokenTable <- table(unlist(tokens))
ngramFour <- data.frame(tokenTable)
ngramFour <- ngramFour[order(ngramFour$Freq,decreasing = TRUE),]
head(ngramFour, n=10)
tail(ngramFour, n=100)
ngramFour <-subset(ngramFour, !( Freq == "1" ))

saveRDS(ngramFour, file = "ngramFour12.rds")

##split 4gram into 4 separate words
fourgram_split <- strsplit(as.character(ngramFour$Var1),split=" ")
ngramFour <- transform(ngramFour,word1 = sapply(fourgram_split,"[[",1),word2 = sapply(fourgram_split,"[[",2), word3=sapply(fourgram_split,"[[",3),word4 = sapply(fourgram_split,"[[",4), freq = ngramFour$Freq)
head(ngramFour)
ngramFour <- ngramFour[,3:7]
colnames(ngramFour)[4]<-"word4"
head(ngramFour)
tail(ngramFour)
saveRDS(ngramFour, file = "ngramFour2.rds")

####################################################################
setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
ngramOne <- readRDS("./ngramOne.rds")
ngramTwo <- readRDS("./ngramTwo.rds")
ngramThree <- readRDS("./ngramThree_.rds")
ngramFour <- readRDS("./ngramFour.rds")
