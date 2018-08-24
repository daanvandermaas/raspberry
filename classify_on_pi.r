library(keras)
library(rPython)
library(jpeg)
library(RMySQL)
library(base64enc)

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
#file_name_image = paste0(i, '_', time ,'.jpg')
#command = paste0('raspistill -o ', file_name_image, ' -w 512 -h 512 --nopreview -t 2000')
#system(command)
##

#get location
#location = unlist(python.call('get_location'))
#print(location)
##


#classify image
#im = readJPEG(file_name_image)
#pred = model$predict_classes(im)


####JUST FOR TESTING
time = Sys.time()
time = gsub(time , replacement =  '_', pattern = ' ')
location = c(52.123213, 3.342234, 6.43)
location_old = location
pred = 1


im = readJPEG('db/z.jpg')


id = paste(time, location[1], location[2], pred)

im = serialize(im, NULL)
im = base64enc::base64encode(im)


con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
q = paste0("INSERT INTO digitaalschouwen (id, time, prediction, location_x, location_y, location_old_x, location_old_y, photo) VALUES ('", id, "','", time, "',", pred, ",'", location[1], "','", location[2], "','" , location_old[1], "','", location_old[2], "', '", im, "')")
dbSendQuery(con , q)
dbDisconnect(con)
#####


#sent data
#if gps fix
# if(length(location)>2 & length(location_old)>2){
# #if sighting sent the following message
# if(pred == 1){
# id = paste(time, location[1], location[2], pred)
# 
im_string <- base64enc::base64encode(file_name_image)
dbSendQuery(con, paste0("INSERT INTO `ad_2de5416a43df6e8`.`digitaalschouwen`(`photo`) VALUES('",txt,"')"))

# 
 q = paste0("INSERT INTO digitaalschouwen (id, time, prediction, location_x, location_y, location_old_x, location_old_y, photo) VALUES ('", id, "','", time, "',", pred, ",'", location[1], "','", location[2], "','" , location_old[1], "','", location_old[2], "', '", im_string, "')")
# dbSendQuery(con , q)
# }}
# location_old = location


#remove image
# command = paste('rm', file_name_image)
# system(command)
##

if(i %% 20 == 0 ){
  dbDisconnect(con)
  con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
}

if(i %% 3000 == 0 ){
  q = "TRUNCATE TABLE digitaalschouwen"
  dbSendQuery(con , q)
  }

}


