apikey <- "JB6lZJeKJ78RD3QvUtXFwD9xy" #API Key
apisecret <- "23UOMmZIzoYI4Pi6TX8h4DEirywbLaIgmW4P9dz5VNoqregouY" #API Secret
token <- "382187895-iWUQji4HmpKeZ0Wi8LTqQPEXPQluQX5iD0z7Iq9r" #Access Token
tokensecret <- "A6lX7xXE5rc7PZD2QVEv6Z3shJpVz3BhaIHg3UMgsSw2o" #Access token secret


library(twitteR)
# grant interactive session
options(httr_oauth_cache=T) 
setup_twitter_oauth(apikey, apisecret, token, tokensecret)

local_cache <- get("oauth_token", twitteR:::oauth_cache) # saves the oauth token so we can reuse it
save(local_cache, file="data/oauth_cache.RData")

tweet("kk45s is a 4test") # make sure you can see a tweet
#tweet("@Jacek_Pardyak this is a test") # check that you see notifications, change @username to your own username
