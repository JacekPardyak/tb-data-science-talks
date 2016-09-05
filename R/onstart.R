.onLoad <- function(libname, pkgname){
  cachedToken <- new.env()
  dataFile <- system.file("data/oauth_cache.RData", package="communicator")
  load(dataFile, cachedToken)
  assign("oauth_token", cachedToken$local_cache, envir=twitteR:::oauth_cache)
  rm(cachedToken)
}
