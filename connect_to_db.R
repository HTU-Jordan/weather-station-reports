library(RODBC)
library(stringr)

connect_to_db <- function() {
  con <<- odbcDriverConnect(connection=
                              'dsn=weather-ODBC;
                            driver={SQL Server Native Client 11.0};
                            trusted_connection=yes')
  return(con)
}

disconnect_from_db <- function(con) {
 close(con) 
}

fetch_15sec <- function(number_of_rows) {
  q <- str_c("select top ", number_of_rows, " from perFIFTEENSEC") 
  
  
}


con <- connect_to_db()
data <- sqlQuery(con,
                          "select top 15840 * from perMINUTE",
                          stringsAsFactors = FALSE,
                          as.is = c(T, F))
odbcCloseAll()
reactive_data_DT <- as.POSIXct(reactive_data$ts, format="%Y-%m-%d %H:%M:%S", tz="EET")
reactive_data[-2] <- data.frame(sapply(reactive_data[-2], as.numeric))
reactive_data$ts <- reactive_data_DT
reactive_data <- reactive_data[order(reactive_data$ts),]
return(reactive_data)