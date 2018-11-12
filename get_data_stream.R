library('rtweet')
library('tidyverse')

#set up variables-----------------------------------------------------------------------------------------------------------------------
#set query
query <- 'fortnite, fortniteBR, FORTNITE, Fortnite, FortniteBattleRoyale'

#set stream time
#streamtime in seconds
#streamtime <- 3 * 60 #3min
#streamtime <- 3 * 60 * 60 #3h
streamtime <- 12 * 60 * 60 #12h
#streamtime <- 60L * 60L * 24L * 7L * 2L #two weeks

#set file name
#filename <- 'data/fortnite.json'

#rate_limits <- rate_limit()
#----------------------------------------------------------------------------------------------------------------------------------------

#stream data to file---------------------------------------------------------------------------------------------------------------------
stream_tweets2(
  q = query,
  parse = FALSE,
  timeout = streamtime,
  dir = "data/fortnite"
)


#MOVE TO DIFFERENT SCRIPT!!!
### Parse from json file-----------------------------------------------------------------------------------------------------------------
rt <- parse_stream('data/fortnite.json')
View(rt)

ts_plot(rt, by = 'mins')

# rt %>%
#   dplyr::group_by(country) %>%
#   ts_plot() +
#   ggplot2::labs(
#     title = "Tweets about Fortnite",
#     subtitle = "Tweets collected, parsed, and plotted using `rtweet`"
#   )


#rm(rt)

# by_country <- rt %>% 
#   filter(country != is.na(country)) %>% 
#   group_by(country) %>% 
#   summarise(total_tweet = n()) %>%
# #  filter(total_tweet > 10) %>% 
#   arrange(total_tweet)
# 
# test_plot <- ggplot(by_country, aes(x = reorder(country, total_tweet), y = total_tweet)) +
#   geom_point(size = 5, colour = 'purple') +
#   coord_flip() +
#   labs(title = 'Number of tweets about Fortninte by country',
#        x = 'country',
#        y = 'tweet count') +
# #  scale_y_continuous(breaks = seq(0,250,20)) +
#   theme_bw() +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))
# test_plot

