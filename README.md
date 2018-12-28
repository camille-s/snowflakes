# Snowflakes!

This is code for making DataHaven's 2018-2019 holiday card. It's a weird snowflake chart of daily snowfall data for different weather stations in Connecticut.

Making snowflakes:

* The Rmd file has code experiments for downloading snowfall data from NOAA GHCND. The function `rnoaa::ncdc`, which I used here, pulls data from NOAA's API. As of 12/28/2018, this is unavailable because of the government shutdown :angry:. As an alternative, `rnoaa::ghcnd` gets data from NOAA's FTP servers, which are still up for the time being.
* As of now, the data is output in `snowfall.csv` a little strangely: dates are downsampled to weeks, values are the mean daily snowfall for each week, and then dates are scaled to the number of days since 01/01/2012 in order to make plotting in Processing easier.
* Use the script `prep_json_for_processing.R` to make JSON files nested by weather station that can be read in the Processing app.
* The Processing app (`snowflakes_processing/snowflakes.pde`) will save the image generated into a PDF file titled with the names of weather stations included in its data.
