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

d<-c("Joe Biden", "Cory Booker", "Pete Buttigieg", "Julián Castro", "Kamala Harris", 
     "Amy Klobuchar","Beto O’Rourke","Bernie Sanders", "Elizabeth Warren","Andrew Yang",
     "Biden", "Booker", "Buttigieg", "Castro", "Harris", "Klobuchar", "O'Rourke", "Sanders", "Warren", "Yang",
     "@SenSanders","@ewarren", "@BetoORourke","@AndrewYang", "@JulianCastro",
     "@CoryBooker", "@SenKamalaHarris", "@amyklobuchar", "@JoeBiden", "@PeteButtigieg" ,"@kamalaHarris",
     "@BernieSanders","@SenWarren",
     "Joe", "Cory", "Pete", "Julián", "Julian", "Kamala", "Amy", "Beto", "Bernie", "Elizabeth", "Andrew")  

##Scrape tweets about candidtes
##PRE DEBATE

pre<-Map(
  "search_tweets",q,
  n = 1000
)

ds <- do_call_rbind(pre)
##DUring Debate

tweets_about_candidates<-stream_tweets("@SenSanders")
