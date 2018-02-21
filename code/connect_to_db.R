################################################################################
# Import Libraries
################################################################################
library(RODBC)
library(stringr)


################################################################################
# Database Connection Functions
################################################################################

# Create Connection to Database
connect_to_db <- function() {
  con <- odbcDriverConnect(connection=
                              'dsn=weather-ODBC;
                            driver={SQL Server Native Client 11.0};
                            trusted_connection=yes')
  return(con)
}

# Close Connection to Database
disconnect_from_db <- function(con) {
 close(con) 
}


################################################################################
# Database Query Functions
################################################################################

# Get data with interval 15 Seconds
fetch_15sec_data <- function(number_of_rows) {
  # Open connection to database
  con <- connect_to_db()
  q <- str_c("select top ", number_of_rows, " * from perFIFTEENSEC order by rec desc") 
  data <- sqlQuery(con,
                   q,
                   stringsAsFactors = FALSE,
                   as.is = c(T, F))
  # Close connection to database
  disconnect_from_db(con)
  data_DT <- as.POSIXct(data$ts, format="%Y-%m-%d %H:%M:%S", tz="EET")
  data[-2] <- data.frame(sapply(data[-2], as.numeric))
  data$ts <- data_DT
  data <- data[order(data$ts),]
  return(data)
}


# Get data with interval 1 Minute
fetch_1min_data <- function(number_of_rows) {
  # Open connection to database
  con <- connect_to_db()
  q <- str_c("select top ", number_of_rows, " * from perMINUTE order by rec desc") 
  data <- sqlQuery(con,
                   q,
                   stringsAsFactors = FALSE,
                   as.is = c(T, F))
  # Close connection to database
  disconnect_from_db(con)
  data_DT <- as.POSIXct(data$ts, format="%Y-%m-%d %H:%M:%S", tz="EET")
  data[-2] <- data.frame(sapply(data[-2], as.numeric))
  data$ts <- data_DT
  data <- data[order(data$ts),]
  return(data)  
}

# Get data with interval 1 Hour
fetch_1hour_data <- function(number_of_rows) {
  # Open connection to database
  con <- connect_to_db()
  q <- str_c("select top ", number_of_rows, " * from perHOUR order by rec desc") 
  data <- sqlQuery(con,
                   q,
                   stringsAsFactors = FALSE,
                   as.is = c(T, F))
  # Close connection to database
  disconnect_from_db(con)
  data_DT <- as.POSIXct(data$ts, format="%Y-%m-%d %H:%M:%S", tz="EET")
  data[-2] <- data.frame(sapply(data[-2], as.numeric))
  data$ts <- data_DT
  data <- data[order(data$ts),]
  return(data) 
}






