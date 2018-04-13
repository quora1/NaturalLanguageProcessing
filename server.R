library(shiny)
library(tm)
library(stringr)
library(stylo)

source("FINAL3.R")

shinyServer(function(input, output) {
  output$html1 <- renderUI({
    inputText <- input$text1
    inputText <- cleanInput(inputText)
    prediction <- NextWord(inputText)
    prediction <- as.character(prediction)
    
    
    str1 <- "Predicted word(s): "
    
    str2 <- ""
    
    for(i in 1:length(prediction))
    {
      if(!is.na(prediction[i]))
      {
        
        if(prediction[i] == "Enter something")
        {
          str2 <-paste(str2, "<span style= color:green>",h4("Appliaction is ready to process. Input something", align = "left"), "</span>")
          str1 <- ""
        }
        else if(prediction[i] == "Sorry, this word cannot be predicted. Try another one."){
          str2 <-paste(str2, "<span style= color:red>",h4(prediction[i],align = "left"), "</span>")
          str1 <- ""
        }
        else{
          prediction[i] <- paste(i,". ", prediction[i])
          str2 <- paste(str2, h4(prediction[i], align = "left"), "</span>")
        }
      }
    }
    str1 <- h4(str1, align = "left")
    HTML(paste(str1, str2))
  })
  
  
  
  
})