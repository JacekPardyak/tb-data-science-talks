library(tidyverse)
# get rawdata
data <- readLines("2022-04-28/RestoReviewRawdata.csv")
data[11]

Encoding(data) <- 'UTF-8'
data <- gsub("\"b\"\"", "\"", data, fixed = TRUE)
data <- gsub("\"\"\"", "\"", data, fixed = TRUE)
data <- gsub("\"b'", "\"", data, fixed = TRUE)
data <- gsub("'\"", "\"", data, fixed = TRUE)


data <- gsub("\\xc3\\xa0", "à", data, fixed = TRUE)
data <- gsub("\\xc3\\xa1", "á", data, fixed = TRUE)
data <- gsub("\\xc3\\xa2", "â", data, fixed = TRUE)
data <- gsub("\\xc3\\xa3", "ã", data, fixed = TRUE)
data <- gsub("\\xc3\\xa4", "ä", data, fixed = TRUE)
data <- gsub("\\xc3\\xa5", "å", data, fixed = TRUE)



data <- gsub("\\xc3\\xa7", "ç", data, fixed = TRUE)
data <- gsub("\\xc3\\xa8", "è", data, fixed = TRUE)

data <- gsub("\\xc3\\xa9", "é", data, fixed = TRUE)
data <- gsub("\\xc3\\xaa", "ê", data, fixed = TRUE)
data <- gsub("\\xc3\\xab", "ë", data, fixed = TRUE)
data <- gsub("\\xc3\\xac", "ì", data, fixed = TRUE)
data <- gsub("\\xc3\\xad", "í", data, fixed = TRUE)
data <- gsub("\\xc3\\xae", "î", data, fixed = TRUE)
data <- gsub("\\xc3\\xaf", "ï", data, fixed = TRUE)


data <- gsub("\\xe2\\x82\\xac", "€", data, fixed = TRUE)
data <- gsub("\\xe2\\x80\\x93", "–", data, fixed = TRUE)



data <- gsub("\\xe2\\x80\\x98", "", data, fixed = TRUE)
data <- gsub("\\xe2\\x80\\x99", "'", data, fixed = TRUE)

data <- gsub("\\xe2\\x80\\x9c", "", data, fixed = TRUE)
data <- gsub("\\xe2\\x80\\x9d", "", data, fixed = TRUE)
data <- gsub("\\xe2\\x80\\xa6", "", data, fixed = TRUE)

data <- gsub("\\xe2\\x80\\xa6", "", data, fixed = TRUE)

writeLines(data, "2022-04-28/RestoReviewRawdataClean.csv", useBytes = TRUE)

data <- read_csv("2022-04-28/RestoReviewRawdataClean.csv") %>%
  distinct(reviewText, restoId, reviewerId, .keep_all= TRUE)  %>%
  filter(!is.na(reviewText)) %>% 
  mutate(avgPrice = gsub("\u0080 ", "", avgPrice, fixed = TRUE))

data %>% select('reviewText') %>% 
  filter(stringr::str_detect(reviewText, fixed("\\xe2"))) %>% first()

write_csv(data, "2022-04-28/RestoReviewRawdataClean.csv.gz")

