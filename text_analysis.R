library('tidyverse')
library('tidytext')
library('wordcloud')

#get data
data <- read_csv('Fortnite_tweets_test.csv')
View(data)
emoji_dict <- read_delim('emDict.csv', ';')


#select tweet text only
tweets_df <- data %>%
  select(text) %>% 
  mutate(tweet_index = rownames(.))
View(tweets_df)

#reshape text into words
words <- tweets_df %>% 
  unnest_tokens(word, text, token = 'tweets')
View(words)

#remove stop words and count
tweet_words <- words %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE) %>% 
  arrange(desc(n))
View(tweet_words)

#remove emoji
cleaned_words <- tweet_words %>% 
  filter(!grepl('1|2|3|4|5|6|7|8|9|0', word)) %>% 
  arrange(desc(n))

View(cleaned_words)
#save in csv to use in app
write_csv(cleaned_words, 'Fortnite_clean_words_test.csv')

#plot
ggplot(subset(cleaned_words, n > 10), aes(reorder(word, n), n)) +
  geom_point(size = 5, colour = 'purple') +
#  geom_col() +
  xlab(NULL) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  coord_flip()


### group word freq by platform #####
by_platform <- data %>% 
  select(text, source) %>% 
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>%
  group_by(source, word) %>% 
  count() %>% 
  filter(!grepl('1|2|3|4|5|6|7|8|9|0', word)) %>% 
  arrange(desc(n))

View(by_platform)
#save in csv to use in app
write_csv(by_platform, 'Fortnite_words_by_plat_test.csv')


#plot
ggplot(subset(by_platform, n > 12), aes(reorder(word, n), n)) +
  geom_point(size = 5, colour = 'purple') +
  facet_wrap(~ source, scales = 'free') +
  #  geom_col() +
  xlab(NULL) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  coord_flip()

#wordcloud example
wordcloud(words= cleaned_words$word, freq= cleaned_words$n, #scale = c(3, 0.5), 
          random.order= FALSE, min.freq= 3, colors= brewer.pal(8, "Set1"))
