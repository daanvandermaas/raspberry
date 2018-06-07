library(keras)
library(rPython)
library(jpeg)

system('sudo gpsd -n /dev/ttyS0 -F /var/run/gpsd.sock')
#dir = '/media/pi/2B94B18C738EFD89'
dir = "/home/pi/raspberry"
#model = load_model_hdf5('model')


python.load('lees_gps.py')

#Sys.sleep(100)
i=0

location_old = c()


for(n in 0:500){

  print(i)
  i = i+1
  
#get time
time = Sys.time()
time = gsub(time , replacement =  '_', pattern = ' ')
##

#take photo
file_name = paste0(i, '_', time ,'.jpg')
command = paste0('raspistill -o ', file.path(dir ,file_name), ' -w 512 -h 512 --nopreview -t 2000')
system(command)
##

#get location
location = unlist(python.call('get_location'))
file_name = paste0(i, '_', time ,'.rds')
saveRDS(location, file.path(dir ,file_name))
print(location)
##

#classify image
#im = readJPEG(file_name)
#pred = model$predict_classes(im)
#file.remove(file_name)
##

#sent data
#if gps fix
#if(length(location)>2 & length(location_old)>2){}
#if sighting sent the following message
#c(location, location_old, pred , time)
#sent photo as well
##

location_old = location

}