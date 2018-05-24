library(keras)
library(rPython)
library(jpeg)


python.load('gps_thread.py')
python.load('lees_gps.py')


location = python.call('get_location')
