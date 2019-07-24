##Twitter Data Script

##Load Libraries
library(rtweet)
library(readr)

##Load Candidate Data
CandidateTwitterHandles <- read_csv("CandidateTwitterHandles.csv")
handles<-factor(CandidateTwitterHandles$`Twitter Handle`)
handles<-paste0("@",as.character(CandidateTwitterHandles$`Twitter Handle`))

##Scrape Candidate Tweets
##THIS TAKES A LONG TIME AND YOU CAN NOT LET YOUR SCREEN GO DARK
  
cantweets<-get_timelines(hand, n = 2000, retryonratelimit = TRUE)##Type some rediculous number here to get all tweets
tweets<-subset(cantweets, select =c("created_at", "screen_name","text"))
write.csv(tweets, "testtweets.csv")
