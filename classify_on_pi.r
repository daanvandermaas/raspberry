library(keras)
library(rPython)
library(jpeg)
library(RMySQL)
library(base64enc)

con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )

system('teamviewer')
system('sudo gpsd -n /dev/ttyS0 -F /var/run/gpsd.sock')


model = load_model_hdf5('model')

dir = '/media/pi/A894-0C66'

dir.create(file.path(dir, 'ja'))
dir.create(file.path(dir, 'nee'))

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
file_name_image = 'image.jpg'
command = paste0('raspistill -o ', file_name_image, ' -w 1024 -h 1024 --nopreview -t 2000')
system(command)
##

#get location
location = unlist(python.call('get_location'))
location_old = location
print(location)
##

im = readJPEG(file_name_image)[257:768,]
im = array(im, dim = c(1, dim(im)))
pred = model$predict(x = im)


if(pred[1] > 0.8){
  writeJPEG(file.path(dir, 'ja', paste0(i, '.jpg') ))
  write(location, file.path(dir, 'ja', paste0(i, '.txt') ) )
}else{
  writeJPEG(file.path(dir, 'nee', paste0(i, '.jpg') ))
  write(location, file.path(dir, 'nee', paste0(i, '.txt') ) )
}


#  id = paste(time, location[1], location[2], pred)
#  txt <- base64enc::base64encode(file_name_image)
  
#  q = paste0("INSERT INTO digitaalschouwen (id, time, prediction, location_x, location_y, location_old_x, location_old_y, photo) VALUES ('", id, "','", time, "',", pred, ",'", location[1], "','", location[2], "','" , location_old[1], "','", location_old[2], "', '", txt, "')")
#  dbSendQuery(con, q)
  
  



#if(i %% 5 == 0 ){
#  dbDisconnect(con)
#  con <- dbConnect(MySQL(), user="bf98019d0486fa", password="58973b37", dbname="ad_2de5416a43df6e8", host="us-cdbr-iron-east-01.cleardb.net" )
#}

#  if(i %% 10 == 0 ){
#    #select 9 most recent reocords
#  q = 'select id FROM digitaalschouwen LIMIT 9 '
#  z = dbSendQuery(con , q)
#  ids = fetch(z, n=-1)
#  ids = ids[,1]
  
  #build query te remove all records older than most recent 9
 # ids_last = ids[length(ids)]
#  ids = ids[-length(ids)]
#  ids = paste0('\'', ids, '\', ')
#  ids = paste(ids, collapse = ' ' )
#  ids = paste0(ids, ' \'', ids_last, '\'')
  
  #send query
#  q = paste0('DELETE FROM digitaalschouwen WHERE id NOT IN (', ids ,')' )
#  z = dbSendQuery(con , q)
#  }

#  Sys.sleep(10)
  
}


