library(keras)
library(rPython)
library(jpeg)

model = load_model_hdf5('model')


python.load('gps_thread.py')
python.load('lees_gps')

Sys.sleep(100)
i=0



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
location = python.call('get_location')
##

#classify image
im = readJPEG(file_name)
pred = model$predict_classes(im)
file.remove(file_name)
##

#sent data

##
}