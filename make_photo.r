
i=0
while(0<1){
  print(i)
  i = i+1
#get time
time = Sys.time()
time = gsub(time , replacement =  '_', pattern = ' ')
#take photo
command = paste0('raspistill -o /media/pi/6DA3F120567E843D/pi/', i, '_', time ,'.jpg -w 512 -h 512 --nopreview -t 500')
system(command)
#get location

}