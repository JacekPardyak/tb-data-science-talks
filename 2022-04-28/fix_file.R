library(tidyverse)
# get rawdata
dat <- readLines("2022-04-28/RestoReviewRawdata.csv")
dat[11]

Encoding(dat) <- 'UTF-8'
#dat <- gsub('b"', "", dat, fixed = TRUE)
dat <- gsub("b'", "", dat, fixed = TRUE)
dat <- gsub("\\xc3\\xa9", "é", dat, fixed = TRUE)

dat[11]
writeLines(dat, "2022-04-28/RestoReviewRawdataClean.csv", useBytes = TRUE)

dat <- read_csv("2022-04-28/RestoReviewRawdataClean.csv")
dat[10, 'reviewText']

write_csv(dat, "2022-04-28/RestoReviewRawdataClean.csv.gz")
