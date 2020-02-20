import paho.mqtt.client as mqtt
import time
import datetime
import random
import decimal

SensorId = "TEMPERATURE20200001"
Broker = "192.168.1.106"
Topic = "HomeAssignment/DataHub"
Port = 1883
Message = ""
# This is the Publisher

client = mqtt.Client()

# generate random temperature every minutes
# publish temperature data with timestamp
while True:
    temperature = decimal.Decimal(random.randrange(3610, 4000)) / 100
    client.connect(Broker, Port, 60)
    Message = "temp|" + SensorId + "|" + str(datetime.datetime.now()) + "|" + str(temperature) + ";"
    client.publish(Topic, Message)
    print(Message)
    client.disconnect()
    time.sleep(60)
