library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  
  titlePanel("Word Predictor" ),
             h5("by Wiktoria Urantowka"),
  
  #navbarpage
  navbarPage("",
             tabPanel("Application",
                      
                      sidebarLayout(
                        sidebarPanel(
                          textInput(inputId="text1", label = "Please enter your text here: ", value =""),
                          h4("How it works:", style = "color:red"),
                          p("1. Wait for the readiness of the application. "),
                          p("2. Type any combination of words in the window above."),
      
                          p("3. Based on your input the algorithm predicts the next word"),
                          p("4. You can choose one of the words from the list and keep on predicting the following words."),

                          h4("Enjoy !", style = "color:red")#,
                        ),
                        
                        
                        
                        mainPanel(
                          h5("NOTE : Please, give it few seconds to warm up if you run it for a first time. Wait for the indication below that the aplication is ready to process",style ="color:black"),
                          h1( " "),
                          h1( " "),
                          h1( " "),
                          h1( " "),
                          h1( " "),
                          htmlOutput("html1")
                        )
                      )
             ),
             tabPanel("Disclaimer"
               ,
                    mainPanel(
                      h3("The predicted vocabulary may contain profanity. The choice of leaving it was conscious 
                        as it is part of everyday's language for many people.
                        If you think you may feel ofended, please don't input sentences that lead to a generation of profanities. 
                         You know what these sentences are. If you don't use them you will be fine.")

                      ) 
             ) 
  )
))