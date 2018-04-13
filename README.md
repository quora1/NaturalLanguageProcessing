# NaturalLanguageProcessing

##Overview:##

Capstone Project finalizes 9-course Data Science Specialization and it's purpose is to built a Shiny application predicting words based on the last n-number of words input by the user.

–> The tool is available here: https://quora1.shinyapps.io/WordPredictor_Final/  
–> The data used to train the algorith is available here: https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip  
–> Website to the Capstone course providing more background to the project is here: https://www.coursera.org/learn/data-science-project/home/welcome  
–> The following section provides overview of steps undertaken

##Building of the word-predicting-tool consisted of the following steps:##  
  
1.Loading and dompiling the data  
2.Pre-processing the data  
3.Computation of n-grams  
4.Setting up a function that uses n-grams to predict next word  
5.Building Shiny application that consumes n-grams (3.) and the "NextWordPredictor" function (4.)  
  
##Reference to the files in this repository:##  
  
–> Ngrams_generator - takes care of steps 1,2 and 3  
–> FINAL3 - uses output from Ngrams_generator and based on it builds prediction function - step 4.  
–> ui.R and server.R - take care of step 5 (and screen_shot_of_shiny_application illustrates it)  
  
########################################################################################################
########################################################################################################
  


1. and 2. Detail on preprocessing 
#########################

1.Creation of a sample corpus from 3 data sources: Blogs, News and Twitter
2.Transforming it by:
-Removing all characters not standard in English language
-Removing punctuations
-Removing numbers
-Removing stopwords limited number of stopwords (“a” and “the”)
-Removing additional interword space
-Converting words to lower case
-Stemming words ( Grouping words of the same meaning together ex “run”, “ran”, “running”)
3.Tokenizing the corpus (defining that words are separate units of the text)

3.Creating n-grams 
#########################

N-grams are series of the most frequent combinations of 2, 3 and 4 words.
Example of the most frequent 4grams in the tokenized data:

  word1 word2 word3 word4 freq
1    is going    to    be  554
2  when    it comes    to  505
3    to    be  able    to  456
4  cant  wait    to   see  414
5    if   you  want    to  391
6     i  dont  want    to  332


4. Setting up a function that uses n-grams to predict next word 
#############################################################

Elements necessary for prediction:

1. Input provided by the user that gets fed into a function that preprocesses it and subsets the last 3 words from the sentence (in case the input is longet than 3 words)
2. The n-gram files ordered in descending order according to their frequency of occurance in corpora.

Prediction Procedure:

The prediction function grams the words input by the user and matches it with the most frequent ngrams: If the input contains 3 words, they are matched with 4 grams, if 2 words with 3 grams, if 1 word with 2 grams The procedure is always started by the highest possible order of ngrams and if no match is found, it tries to find a match within a lower ngram order. In case there is more than one match, the one with the highest frequency is applied

5.Building Shiny application
#############################

Web based application that takes users input, calls function that calls n-grams and spits out prediction. 
I uploaded a screen shot of the interface in this repository 






