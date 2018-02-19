#!/bin/sh
cd C:/Users/yanal.kashou/Projects/weather-station-reports
git checkout dev
git add .
git commit -m "automatic update"
git remote add origin remote repository https://github.com/HTU-Jordan/weather-station-reports.git
git remote -v
git push origin master
echo Press Enter...
read
