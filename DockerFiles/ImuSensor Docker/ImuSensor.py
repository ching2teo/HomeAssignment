import paho.mqtt.client as mqtt
import time
import datetime
import ImuSensorData

sensorId = "IMU20200001"
Broker = "localhost"
Topic = "HomeAssignment/DataHub"
Port = 1883
Message = ""
Count = 0
SensorData = "-0.997497|0.127171|-0.613392|111.146580|1.700186|-4.025391"

# This is the Publisher
client = mqtt.Client()
client.connect(Broker, Port, 60)

while True:
    Count = 0
    Message = ""
    CurrentTimeStamp = datetime.datetime.now()
    while Count < 100:
        #CurrentTimeStamp = datetime.datetime.now()

        Message = Message + "imu|" + sensorId + "|" + str(CurrentTimeStamp) + "|" + str(
            ImuSensorData.GetAccelerometerX()) + "|" + str(ImuSensorData.GetAccelerometerY()) + "|" + str(
            ImuSensorData.GetAccelerometerZ()) + "|" + str(ImuSensorData.GetGyroX()) + "|" + str(
            ImuSensorData.GetGyroY()) + "|" + str(ImuSensorData.GetGyroZ()) + ";"
        Count = Count + 1
    print(Message)
    client.publish(Topic, Message)
    time.sleep(1)
client.disconnect()
# while True:
#    client.connect(Broker, Port, 60)
#   CurrentTimeStamp = datetime.datetime.now()
#  Message = "imu|" + sensorId + "|" + str(CurrentTimeStamp) + "|" + SensorData
# client.publish(Topic, Message)
# print(Message)
# client.disconnect()
# time.sleep(1)
