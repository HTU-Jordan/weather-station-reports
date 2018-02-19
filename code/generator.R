library(rmarkdown)
f = paste0("C://Users//yanal.kashou//Projects//weather-station-reports//analyses//weather_report_", Sys.Date(), ".html")

if (!file.exists(f)) {
  rmarkdown::render(input = "code/report_template.Rmd", output_format = "html_document", output_file = f)
}

