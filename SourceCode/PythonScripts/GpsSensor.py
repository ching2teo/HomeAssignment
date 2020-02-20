import paho.mqtt.client as mqtt
import time
import datetime
import random
import decimal

SensorId = "GPS20200001"
Broker = "localhost"
Topic = "HomeAssignment/DataHub"
Port = 1883
Message = ""
latitude = 3.07
longitude = 101.51
# This is the Publisher

client = mqtt.Client()

# generate random coordinate every 2 seconds
while True:
    dec_lat = random.random() / 100
    dec_lon = random.random() / 100
    client.connect(Broker, Port, 60)
    Message = "gps|"+ SensorId + "|" + str(datetime.datetime.now())+"|"+str(longitude + dec_lon) + "|" + str(latitude + dec_lat) + ";"
    client.publish(Topic, Message)
    print(Message)
    client.disconnect()
    time.sleep(2)


