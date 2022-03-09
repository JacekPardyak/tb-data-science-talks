#jacek_pardyak #O-1
#jacekpardyak

# person you want to send direct message has to follow you
# your app has to set up permissions:
# Read, Write and Access direct messages

library(twitteR)

dmSend(paste(Sys.time(), "test", sep = " "), "jacekpardyak")



msg <- function(){# function to send a message
  user <- readline(prompt="Enter a username: ")
  text <- readline(prompt="Enter a text: ")
  dmSend(text, user)
  cat("Message sent")}

?dmSend


dmsg <- function(){
  dmDestroy(
    receMessages[[1]]$getId()
    )
  }

received <- dmGet()
sent     <- dmSent()
messages <- c(received, sent)
messages <- lapply(messages, function(x){cbind(x$id,
                                               x$senderSN,
                                               x$recipientSN,
                                               x$text)})
messages <- data.frame(matrix(unlist(messages),
                              nrow = length(messages), byrow=T)) 
names(messages) <- c("id", "sender", "recipient", "text")

messages <- messages[order(messages[,"id"]),]

i = 2
message <- messages[i,]

cat(paste(paste(message[,2], "said:", sep = " "), message[,4], sep = " "))

# delete a message

dmDestroy(received[[1]])

print("la")
or(i in 1:length(messages)){
message <- messages[[i]]
row <- cbind(id = message$id,
             sender = message$senderSN,
             recipient = message$recipientSN,
             text = message$text)
res <- rbind(row,res)
}



yy <- data.frame(tt)



00
chat[[1]]$`.->text`
chat[[1]]$text

message$id


toDataFrame(chat[[1]])
  sender
  recipient
  text
summary(chat)

chat$getSender()

chat[[1]]
class(chat)

chat@text

chat$toDataFrame()
as.data.frame(chat)
chat$t