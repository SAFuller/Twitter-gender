##Twitter Data Script

##Load Libraries
library(rtweet)
library(readr)

##query terms
q<-c("Joe Biden", "Cory Booker", "Pete Buttigieg", "Julián Castro", "Kamala Harris", 
     "Amy Klobuchar","Beto O’Rourke","Bernie Sanders", "Elizabeth Warren","Andrew Yang",
     "Biden", "Booker", "Buttigieg", "Castro", "Harris", "Klobuchar", "O'Rourke", "Sanders", "Warren", "Yang",
     "@SenSanders","@ewarren", "@BetoORourke","@AndrewYang", "@JulianCastro",
     "@CoryBooker", "@SenKamalaHarris", "@amyklobuchar", "@JoeBiden", "@PeteButtigieg" ,"@kamalaHarris",
     "@BernieSanders","@SenWarren")



##Scrape tweets about candidtes
##PRE DEBATE: Ran at 3:00 pm on 9/11/2019

pre<-Map(
  "search_tweets",q,
  n = 30000, retryonratelimit = TRUE)

pre_debate <- do_call_rbind(pre)

#Clean Pre Debate Data
preorig<-subset(pre_debate, pre_debate$is_retweet==0)
preorig2<-subset(preorig, select=c("text","favorite_count", "retweet_count","created_at"))
preorig2$day<-NA
preorig2$day<-substr(preorig2$created_at, 9, 10)
preorig2$day<-as.numeric(preorig2$day)
preorig2$dcenteredday<-NA
preorig2$dcenteredday<-(preorig2$day-12)

preorig3<-subset(preorig2, select =c("text","favorite_count","retweet_count","day","dcenteredday"))

preorig3$Biden<-NA
preorig3$Biden<-as.numeric(grepl("Biden", preorig3$text))

preorig3$Booker<-NA
preorig3$Booker<-as.numeric(grepl("Booker", preorig3$text))

preorig3$Buttigieg<-NA
preorig3$Buttigieg<-as.numeric(grepl("Buttigieg", preorig3$text))

preorig3$Castro<-NA
preorig3$Castro<-as.numeric(grepl("Castro", preorig3$text))

preorig3$Harris<-NA
preorig3$Harris<-as.numeric(grepl("Harris", preorig3$text))

preorig3$Klobuchar<-NA
preorig3$Klobuchar<-as.numeric(grepl("Klobuchar", preorig3$text))

preorig3$ORourke<-NA
preorig3$ORourke<-as.numeric(grepl("O'Rourke", preorig3$text))

preorig3$Sanders<-NA
preorig3$Sanders<-as.numeric(grepl("Sanders", preorig3$text))

preorig3$Warren<-NA
preorig3$Warren<-as.numeric(grepl("Warren", preorig3$text))

preorig3$Yang<-NA
preorig3$Yang<-as.numeric(grepl("Yang", preorig3$text))

preorig3$text <- gsub("http.*","",preorig3$text)
preorig3$text <- gsub("https.*","",preorig3$text)
preorig3$text <- gsub("#.*","",preorig3$text)
preorig3$text <- gsub("@.*","",preorig3$text)
preorig3$text <- sapply(preorig3$text,function(row) iconv(row, "latin1", "ASCII", sub=""))

pre_debate<-as.data.frame(preorig3)
write.csv(pre_debate,"pre_debate.csv")

##DUring Debate Start at 6:50 pm

during<-Map(
  "search_tweets",q,
  n = 500000, since_id= 1172298849878073345 , max_id = 	1172344149183328259,
  retryonratelimit = TRUE, include_rts = FALSE, type = "recent" )


during_debate <- do_call_rbind(during)

during_debate2<- subset(during_debate, 1172298849878073345 < during_debate$status_id & 
                          during_debate$status_id < 1172344149183328259)

during2<-subset(during_debate2, select=c("text","favorite_count", "retweet_count","created_at"))
during2$day<-NA
during2$dcenteredday<-NA
during2$dcenteredday<-0

during3<-subset(during2, select =c("text","favorite_count","retweet_count","day","dcenteredday"))

during3$Biden<-NA
during3$Biden<-as.numeric(grepl("Biden", during3$text))

during3$Booker<-NA
during3$Booker<-as.numeric(grepl("Booker", during3$text))

during3$Buttigieg<-NA
during3$Buttigieg<-as.numeric(grepl("Buttigieg", during3$text))

during3$Castro<-NA
during3$Castro<-as.numeric(grepl("Castro", during3$text))

during3$Harris<-NA
during3$Harris<-as.numeric(grepl("Harris", during3$text))

during3$Klobuchar<-NA
during3$Klobuchar<-as.numeric(grepl("Klobuchar", during3$text))

during3$ORourke<-NA
during3$ORourke<-as.numeric(grepl("O'Rourke", during3$text))

during3$Sanders<-NA
during3$Sanders<-as.numeric(grepl("Sanders", during3$text))

during3$Warren<-NA
during3$Warren<-as.numeric(grepl("Warren", during3$text))

during3$Yang<-NA
during3$Yang<-as.numeric(grepl("Yang", during3$text))

during3$text <- gsub("http.*","",during3$text)
during3$text <- gsub("https.*","",during3$text)
during3$text <- gsub("#.*","",during3$text)
during3$text <- gsub("@.*","",during3$text)
during3$text <- sapply(during3$text,function(row) iconv(row, "latin1", "ASCII", sub=""))

durdebate<-as.data.frame(during3)
write.csv(durdebate,"during_debate.csv")
