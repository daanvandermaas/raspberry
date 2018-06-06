library(data.table)

location_files = list.files('db/pi_safari', pattern = '.rds', full.names = TRUE)

locations = lapply(location_files, function(file){
  x =readRDS(file)
 data.frame('x' = x[1], 'y' = x[2])
})

locations = rbindlist(locations)

View(locations)