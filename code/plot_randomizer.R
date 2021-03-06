################################################################################
# Import Libraries
################################################################################
library(ggplot2)
library(openair)
library(scales)
library(lubridate)
library(reshape2)


temperature_plot <- function(df) {
  subtract_month <- tail(df$ts, 1) %m-% months(1)
  df <- subset(df, ts > subtract_month)
  df$day <- factor(df$ts)
  t0 <- strptime(df$ts, "%Y-%m-%d %H:%M:%S")
  df$day <- format(t0, "%Y-%m-%d")
  df_agg <- aggregate(df$temp, by = list(df$day), function(x) {
    c(max = max(x), min = min(x)) })
  
  xdf <- NULL
  xdf$day <- df_agg$Group.1
  xdf$max <- df_agg$x[, 1]
  xdf$min <- df_agg$x[, 2]
  xdf$avg <- (xdf$max + xdf$min) / 2
  xdf <- data.frame(xdf)
  
  t <- ggplot(xdf, aes(x = day, y = avg, ymin = min, ymax = max)) +
    geom_line(aes(y = max), color = "steelblue", size = 1, group = 1) +
    geom_line(aes(y = min), color = "steelblue", size = 1, group = 1) +
    geom_pointrange(color = "black", size= 0.75) +
    geom_point(aes(y = max), color = "steelblue", size = 3.5) +
    geom_point(aes(y = min), color = "steelblue", size = 3.5) +
    theme_minimal() +
    ylab("Air Temperature") +
    theme(axis.title.x=element_blank())
  return(t)
}