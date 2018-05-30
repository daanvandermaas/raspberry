library(keras)
library(rPython)
library(jpeg)

system('sudo gpsd -n /dev/ttyS0 -F /var/run/gpsd.sock')

model = load_model_hdf5('model')


python.load('lees_gps.py')

Sys.sleep(100)
i=0

location_old = c(NA,NA,NA)


while(0<1){

  print(i)
  i = i+1
  
#get time
time = Sys.time()
time = gsub(time , replacement =  '_', pattern = ' ')
##

#take photo
file_name = paste0(i, '_', time ,'.jpg')
command = paste0('raspistill -o ', file_name, ' -w 512 -h 512 --nopreview -t 10000')
system(command)
##

#get location
location = unlist(python.call('get_location'))
##

#classify image
im = readJPEG(file_name)
pred = model$predict_classes(im)
file.remove(file_name)
##

#sent data
#if sighting
c(location, location_old, pred , time)
#sent photo as well
##

location_old = location

}