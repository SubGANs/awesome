#!/usr/bin/python2
#coding: utf-8

import urllib2
import json
import sys, os
from six.moves import configparser


config = configparser.ConfigParser()
config.read(os.getenv("HOME") + '/.config/awesome/scripts/scripts.conf')
key = config.get('WEATHER', 'KEY')
city = config.get('WEATHER', 'CITY')
#http://api.openweathermap.org/data/2.5/find?q=Irkutsk&units=metric&lang=ru&appid=your_key
result_file= os.getenv("HOME") + '/.config/awesome/scripts/weather.txt'

try:
    URL = 'http://api.openweathermap.org/data/2.5/find?q=%s&units=metric&lang=ru&appid=%s' % (city, key)
    HEADERS = {"Content-Type": "html/json"}
    request = urllib2.Request(URL, headers = HEADERS)
    response = urllib2.urlopen(request)
    json_string = response.read()
    parsed_string = json.loads(json_string)
#    cod = parsed_string['cod']
    temp = parsed_string['list'][0]['main']['temp']
    icon = parsed_string['list'][0]['weather'][0]['icon']
    temp = int(round(temp))
    print ('%s°C' % (temp))
    file = open(result_file, 'w')
    file.write('%s°C' % (temp))
    file.close()
except:
    file = open(result_file, 'r')
    data = file.read()
    if data[-1:] == "!":
        file.close()
    else:
        ('!')
        file = open(result_file, 'a')
        file.write('!')
        file.close()