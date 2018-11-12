library('rtweet')
library('tidyverse')

fortnite_tweets <- search_tweets(q = "#fortnite", n = 500)

#write_as_csv(fortnite_tweets, 'Fortnite_tweets_test2.csv')
fortnite_tweets <- read_csv('Fortnite_tweets_test2.csv')

View(fortnite_tweets)


by_platform <- fortnite_tweets %>% 
  group_by(source) %>% 
  summarise(total_tweet = n()) %>% 
  arrange(total_tweet)
View(by_platform)


by_platform_select <- fortnite_tweets %>% 
#  filter(source == contains('iPhone'), contains('Android'), contains('Web Client'), contains('iPad'), contains('PlayStation'), contains('Twitch')) %>% 
  group_by(source) %>% 
  summarise(total_tweet = n()) %>%
  filter(total_tweet > 10) %>% 
  arrange(total_tweet)

View(by_platform_select)



test_plot <- ggplot(by_platform, aes(x = reorder(source, total_tweet), y = total_tweet)) +
  geom_point(size = 5, colour = 'purple') +
  coord_flip() +
  labs(title = 'Number of tweets using #fortninte by platform',
       x = 'platform',
       y = 'tweet count') +
  scale_y_continuous(breaks = seq(0,250,20)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
test_plot
#ggsave('test_plot.png', test_plot)
