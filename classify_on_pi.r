library(keras)
library(rPython)
library(jpeg)
library(RMySQL)


con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

system('teamviewer')
system('sudo gpsd -n /dev/ttyS0 -F /var/run/gpsd.sock')


#model = load_model_hdf5('model')


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
command = paste0('raspistill -o ', file_name_image, ' -w 512 -h 512 --nopreview -t 2000')
system(command)
##

#get location
location = unlist(python.call('get_location'))
print(location)
##


#classify image
im = readJPEG(file_name_image)
#pred = model$predict_classes(im)
command = paste('rm', file_name_image)
system(command)
##

####JUST FOR TESTING
#location = c(52.123213, 3.342234, 6.43)
pred = 1
#####


#sent data
#if gps fix
if(length(location)>2 & length(location_old)>2){
#if sighting sent the following message
if(pred == 1){
id = paste(time, location[1], location[2], pred)
q = paste0("INSERT INTO digitaalschouwen (id, time, prediction, location_x, location_y, location_old_x, location_old_y) VALUES ('", id, "','", time, "',", pred, ",'", location[1], "','", location[2], "','" , location_old[1], "','", location_old[2],"')")
dbSendQuery(con , q)
#sent photo as well
}}
location_old = location


if(i %% 20 == 0 ){
  dbDisconnect(con)
  con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
}

if(i %% 3000 == 0 ){
  q = "TRUNCATE TABLE digitaalschouwen"
  dbSendQuery(con , q)
  }

}


