library(keras)
library(rPython)
library(jpeg)
library(RMySQL)

dir = '/media/pi/A894-OC66'

con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

system('teamviewer')
system('sudo gpsd -n /dev/ttyS0 -F /var/run/gpsd.sock')



python.load('lees_gps.py')

i=0

location_old = c()


while(0<1){
  
  print(i)
  i = i+1
  
  #get time
  time = Sys.time()
  time = gsub(time , replacement =  '_', pattern = ' ')
  ##
  
  #take photo
  file_name_image = paste0(i, '_', time ,'.jpg')
  command = paste0('raspistill -o ', file.path(dir ,file_name_image), ' -w 512 -h 512 --nopreview -t 2000')
  system(command)
  ##
  
  #get location
  location = unlist(python.call('get_location'))
  file_name_gps = paste0(i, '_', time ,'.rds')
  saveRDS(location, file.path(dir ,file_name_gps))
  print(location)
 
  
  
}


