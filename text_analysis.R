library('tidyverse')
library('tidytext')

data <- read_csv('Fortnite_tweets_test.csv')
View(data)
tweets_df <- as.data.frame(data$text) %>% 
  rename(text = `data$text`)
tweets_txt <- data$text
View(tweets_txt)
words <- tweets %>% 
  unnest_tokens(word, text)
