#! /usr/bin/python
# Written by Dan Mandle http://dan.mandle.me September 2012
# License: GPL 2.0
 
import gps_thread


  
def get_location():
  gpsp = gps_thread.GpsPoller() # create the thread
  
  gpsp.start() # start it up
  
  lat =  gpsd.fix.latitude
  lon =  gpsd.fix.longitude
  speed = gpsd.fix.speed
      
  
  gpsp.running = False
  gpsp.join() # wait for the thread to finish what it's doing
  
  return [lat,lon,speed]
