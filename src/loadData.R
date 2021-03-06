library(RSQLite)
library(purrr)
source("./src/makeWordCloud.R")


getData <- function() {
  db <- dbConnect(dbDriver("SQLite"), "./input/database.sqlite")
  
  reviews <- dbGetQuery(db, "
                        SELECT Score,Text
                        FROM Reviews WHERE Score != 3
                        LIMIT 500")
  
  divideSet <- function(data) {
    result <- ""
    if(data < 3)
        result <- "negative"
    else 
        result <- "positive"
    return(result)
  }
  
  reviews$Score = map(reviews$Score, divideSet)
  #dbDisconnect(db)
  #return(list("train"=train,"test"=test))
  unlist(reviews, use.names=FALSE)
  
  return(reviews)
}

divide <- function(item) {
  result = ""
  if(item < 0) 
    result = "positive"
  else 
    result = "negative"
  return(result)
}

