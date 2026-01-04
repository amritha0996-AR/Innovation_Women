library(dplyr)
library(tidytext)
library(tidyr)
library(tibble)
library(tidyverse)


# Unnest tokens and remove stop words
clean_tokens <- Tokens %>%
  unnest_tokens(word, Review) %>%        
  anti_join(stop_words, by = "word")  

#bing
bing_sentiment <- clean_tokens %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(sentiment, sort = TRUE)

# View results
print(bing_sentiment)

#nrc
nrc_sentiment <- clean_tokens %>%
  inner_join(get_sentiments("nrc"), by = "word") %>%
  count(sentiment, sort = TRUE)

# View results
print(nrc_sentiment)

#afinn
afinn_sentiment <- clean_tokens %>%
  inner_join(get_sentiments("afinn"), by = "word") %>%
  summarise(total_score = sum(value))

# View results
print(afinn_sentiment)


# --- 
word_count <- clean_tokens %>%
  count(word, sort = TRUE)

# View result
print(word_count)


write.csv(word_count, "word_count.csv", row.names = FALSE)



