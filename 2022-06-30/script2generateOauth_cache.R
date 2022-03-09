apikey <- "Br0gSgTNM2g2IlwhCBmZWRWbx" #API Key
apisecret <- "6psuOaCDU1Gl6q8cu6F5CYb19bs3oBtI0JuBasS44IpOqo5loo" #API Secret
token <- "382187895-58nmI0XrZiC2pxaDi4IJDAIasUCij8EE0wIXuxlw" #Access Token
tokensecret <- "CqLOlQBfwZkoN02aRmCFRL1v0JkEmUxjSmjIsBYqCebs4" #Access token secret



library(twitteR)
# grant interactive session
options(httr_oauth_cache=T) 
setup_twitter_oauth(apikey, apisecret, token, tokensecret)

local_cache <- get("oauth_token", twitteR:::oauth_cache) # saves the oauth token so we can reuse it
save(local_cache, file="data/oauth_cache.RData")

