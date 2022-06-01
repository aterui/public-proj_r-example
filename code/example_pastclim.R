
# setup -------------------------------------------------------------------
## install pastclim package from GitHub
## install pastclimData for easy data download
devtools::install_github("EvolEcolGroup/pastclim")
devtools::install_github("EvolEcolGroup/pastclimData", ref="master")

## load libraries
## pacman::p_load() allows you to load multiple libraries at once.
pacman::p_load(pastclim,
               pastclimData,
               tidyverse)

## download Beyer2020 data
## this will take ~ 15 mins to complete
download_dataset(dataset="Beyer2020",
                 bio_variables = c("bio01","bio05"))


# pastclim example data ---------------------------------------------------

## file path to the example file
### path to example
path_to_example_nc <- system.file("/extdata/",
                                  package = "pastclim")

### path to beyer2020
path_to_beyer2020 <- system.file("/extdata/",
                                 package = "pastclimData")

## get a summary of downloaded data
get_downloaded_datasets(path_to_nc = path_to_example_nc)
get_downloaded_datasets(path_to_nc = path_to_beyer2020)


# data extraction ---------------------------------------------------------

## make a list of lat lon & time_bp
locations <- data.frame(longitude = c(0, 90, -120, -7),
                        latitude = c(20, 45, 60, 37),
                        time_bp = c(0, -10000, -20000, -10000))

## climate data for a specific location & time

### `x` for lat lon
### `time_bp` for time

### example data
climate_for_locations(x = locations[,c("longitude", "latitude")],
                      time_bp = locations$time_bp,
                      bio_variables = c("bio01","bio12"),
                      dataset = "Example",
                      nn_interpol = FALSE,
                      path_to_nc = path_to_example_nc)

### Beyer 2020 data
climate_for_locations(x = locations[,c("longitude", "latitude")],
                      time_bp = locations$time_bp,
                      bio_variables = c("bio01","bio12"),
                      dataset = "Beyer2020",
                      nn_interpol = FALSE,
                      path_to_nc = path_to_beyer2020)

## time-series climate data for a specific location

### example data
locations_ts <- time_series_for_locations(x = locations[1, c("longitude", "latitude")],
                                          bio_variables=c("bio01","bio12"),
                                          dataset = "Example",
                                          path_to_nc = path_to_example_nc)

## get a raster layer for a specific time slice

### example data
climate_20k <- climate_for_time_slice(time_bp = -20000,
                                      c("bio01","bio10","bio12"),
                                      dataset = "Example",
                                      path_to_nc = path_to_example_nc)


# tidyverse example -------------------------------------------------------

iris %>% 
  as_tibble() %>% 
  filter(Species == "setosa",
         Sepal.Length > 5)
