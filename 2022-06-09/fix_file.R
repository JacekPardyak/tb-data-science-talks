library(tidyverse)
# get rawdata
data <- readLines("2022-06-09/RestoReviewRawdata.csv")
data[11]

Encoding(data) <- 'UTF-8'

 
data <- gsub("\u0080 ", "", data, fixed = TRUE)
data <- gsub("â\u0082¬ ", "", data, fixed = TRUE)

 
data <- gsub("\"b\"\"", "\"", data, fixed = TRUE)
data <- gsub("\"\"\"", "\"", data, fixed = TRUE)
data <- gsub("\"b'", "\"", data, fixed = TRUE)
data <- gsub("'\"", "\"", data, fixed = TRUE)


data <- gsub("\\xc2\\xb4", "'", data, fixed = TRUE)
data <- gsub("\\xc3\\x8c", "'", data, fixed = TRUE)

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
data <- gsub("\\xe2\\x80\\x94", "–", data, fixed = TRUE)

data <- gsub("Ã©", "é", data, fixed = TRUE)


unwanted = c("\\xe2\\x99\\x82",
             "\\xe2\\x80\\xbc",
             "\\xe2\\x80\\x8d",
             "\\xe2\\x80\\x98",
             "\\xe2\\x80\\x99",
             "\\xe2\\x80\\x9a",
             "\\xe2\\x80\\x9c",
             "\\xe2\\x80\\x9d",
             "\\xe2\\x80\\x9e",
             "\\xe2\\x80\\xa2",
             "\\xe2\\x80\\xa6",
             "\\xe2\\x84\\xa2",
             "\\xe2\\xad\\x90",
             "\\xef\\xb8\\x8f",
             "\\xe2\\x9c\\x85",
             "\\xe2\\x9d\\xa4",
             "\\xe2\\x98\\xba",
             "\\xe2\\x98\\xba",
             "\\xe2\\x9c\\x94",
             "\\xe2\\x95\\x91",
             "\\xe2\\x98\\x85",
             "\\xe2\\x80\\x8b",
             "\\xe2\\x9d\\xa3",
             "\\xe2\\x99\\xa1",
             "\\xe2\\x89\\xa4",
             "\\xe2\\x9d\\x97",
             "\\xe2\\x98\\x95",
             "\\xe2\\x80\\xa8",
             "\\xe2\\x98\\x80",
             "\\xe2\\x80\\xaa",
             "\\xe2\\x80\\xac",
             "\\xe2\\x9c\\xa8",
             "\\xe2\\x98\\x9d",
             "\\xe2\\x98\\xb9",
             "\\xe2\\x99\\xa5",
             "\\xe2\\x9c\\x8b",
             "\\xe2\\x9c\\x8c",
             "\\xe2\\x9d\\x93",
             "\\xe2\\x9a\\xa0",
             "\\xe2\\x9b\\xb7",
             "\\xe2\\x98\\x83",
             "\\xef\\xbc\\x8c",
             "\\xe9\\x9d\\x9e",
             "\\xe5\\xb8\\xb8",
             "\\xe5\\xa5\\xbd",
             "\\xe3\\x80\\x82",
             "\\xce\\xb6\\xce",
             "\\xb5\\xcf\\x83",
             "\\xcf\\x84",
             "\\xcf\\x8c",
             "\\n")
for(x in unwanted){
  data <- gsub(x, " ", data, fixed = TRUE)
}



writeLines(data, "2022-06-09/RestoReviewRawdataClean.csv", useBytes = TRUE)

data <- read_csv("2022-06-09/RestoReviewRawdataClean.csv") %>%
  distinct(reviewText, restoId, reviewerId, .keep_all= TRUE)  %>%
  filter(!is.na(reviewText)) %>%
  filter((!reviewText == '- Recensie is momenteel in behandeling -')) %>%
  mutate(reviewDate = gsub("mrt", "mar", reviewDate)) %>%
  mutate(reviewDate = gsub("mei", "may.", reviewDate)) %>%
  mutate(reviewDate = gsub("okt", "oct", reviewDate)) %>%
  mutate(reviewDate = strptime(reviewDate, "%d %b. %Y")) %>% 
  mutate(reviewDate = as.POSIXct(reviewDate)) 
summary(data)

data %>% select('reviewText') %>% 
  filter(stringr::str_detect(reviewText, fixed("\\x8c"))) %>% first()

library(tidytext)
tmp <- data %>% select(restoId, review_id, reviewText) %>% 
  unnest_tokens(word, reviewText) %>%  group_by(restoId, review_id) %>% 
  summarize(reviewText = str_c(word, collapse = " ")) %>%
  ungroup()
data <- data %>% select(-reviewText)%>% left_join(tmp) %>% 
  filter(!is.na(reviewText))

write_csv(data, "2022-06-09/reviews.csv.gz")

