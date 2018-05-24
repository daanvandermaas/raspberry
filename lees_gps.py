#! /usr/bin/python
# Written by Dan Mandle http://dan.mandle.me September 2012
# License: GPL 2.0
 
import os
from gps import *
from time import *
import time
import threading




gpsd = None #seting the global variable




class GpsPoller(threading.Thread):
  def __init__(self):
    threading.Thread.__init__(self)
    global gpsd #bring it in scope
    gpsd = gps(mode=WATCH_ENABLE) #starting the stream of info
    self.current_value = None
    self.running = True #setting the thread running to true

  def run(self):
    global gpsd
    while gpsp.running:
      gpsd.next() #this will continue to loop and grab EACH set of gpsd info to clear the buffer



  
def get_location():
  gpsp = GpsPoller() # create the thread
  
  gpsp.start() # start it up
  
  lat =  gpsd.fix.latitude
  lon =  gpsd.fix.longitude
  speed = gpsd.fix.speed
      
  
  gpsp.running = False
  gpsp.join() # wait for the thread to finish what it's doing
  
  return [lat,lon,speed]
