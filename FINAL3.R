setwd("/Users/quora1/Desktop/DataScience/10_Capstone/final/en_US")
ngramTwo <- readRDS("./ngramTwo.rds")
ngramThree <- readRDS("./ngramThree.rds")
ngramFour <- readRDS("./ngramFour.rds")


library(stringr)
library(dplyr)
library(tm)
library(stylo)

NextWord <- function(input)
{
  wordInput <- cleanInput(input)
  wordCount <- length(wordInput)
  prediction <- c()
  
  #Trimming input 
  if(wordCount>3)
  {
    wordInput <- wordInput[(wordCount-2):wordCount]
    prediction <- matchinFourGranm(wordInput[1],wordInput[2],wordInput[3])
  }
  
  #4 Gram Match
  if(wordCount ==3)
  {
    prediction <- matchinFourGranm(wordInput[1],wordInput[2],wordInput[3])
  }
  
  #3 Gram Match
  if(wordCount ==2)
  {
    prediction <- matchThreeGram(wordInput[1],wordInput[2])
  }
  #2 gram match
  if(wordCount ==1)
  {
    prediction <- matchTwoGram(wordInput[1])
  }
  
  #nothing entered
  if(wordCount == 0)
  {
    prediction <- "Enter something"
  }
  
  #Unknown words
  if(length(prediction)==0)
  {
    prediction <- "Sorry, this word cannot be predicted. Try another one."
  }
  
  #Returning outcome
  if(length(prediction) < 5)
  {
    prediction
  }
  else
  {
    prediction[1:5]
  }
}

#Preparing input
cleanInput <- function(text){
  textInput <- tolower(text)
  textInput <- stripWhitespace(textInput)
  textInput <- removeNumbers(textInput)
  textInput <- removePunctuation(textInput)
  textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
  textInput <- txt.to.words.ext(textInput, language="English.all", preserve.case = TRUE)
  return(textInput)
}


#Matching string in 4 Gram and getting predicted word
matchinFourGranm <- function (inputWord1,inputWord2,inputWord3)
  
{
  predWord <- filter(ngramFour,(word1 == inputWord1 & word2 == inputWord2 & word3 == inputWord3))$word4
  if(length(predWord) == 0)
  {
    predWord <- filter(ngramFour,( word2 == inputWord2 & word3 == inputWord3))$word4
    if(length(predWord) == 0)
    {
      predWord <- filter(ngramFour,( word1 == inputWord2 & word2 == inputWord3))$word3
      if(length(predWord) ==0)
      {
        predWord <- matchThreeGram(inputWord2,inputWord3)
      }
    }
  }
  predWord
}

#Matching string in 3 Gram and getting predicted word
matchThreeGram <- function(inputWord1,inputWord2)
{
  predWord <- filter(ngramThree,( word1 == inputWord1 & word2 == inputWord2))$word3
  if(length(predWord)==0)
  {
    predWord <- filter(ngramThree,(word2 == inputWord2))$word3 
    
    if(length(predWord)== 0)
    {
      predWord <- filter(ngramThree,(word1 == inputWord2))$word2 
      
      if(length(predWord) ==0 )
      {
        predWord <- matchTwoGram(inputWord2)
      }
    }
  }
  predWord
}

#Matching string in 2 Gram and getting predicted word
matchTwoGram <- function(inputWord1)
{
  predWord <- filter(ngramTwo,( word1 == inputWord1 ))$word2
  predWord
}

as.character(NextWord("could anyone help"))