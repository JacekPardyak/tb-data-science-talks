library(tidyverse)
reviews <- read_csv("./2022-06-09/reviews.csv.gz")
reviews %>% head()
reviews %>%
  filter(str_detect(address , 'Den Haag')) %>% 
  group_by(restoName) %>%
  summarise(n = n()) %>% arrange(desc(n)) -> tmp
reviews %>% names()
