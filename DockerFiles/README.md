# Create Image from DockerFile
1.	Create image for TemperatureSensor.py
    a.	Open Window PowerShell as administrator
    b.	Change director to python script folder
    c.	Run this command: docker build -t tempsensor .
    d.	tempsensor image created.
2.	Create image for GpsSensor.py
    a.	Open Window PowerShell as administrator
    b.	Change director to python script folder
    c.	Run this command: docker build -t gpssensor .
    d.	gpssensor image created.
3.	Create image for ImuSensor.py
    a.	Open Window PowerShell as administrator
    b.	Change director to python script folder
    c.	Run this command: docker build -t imusensor .
    d.	imusensor image created.
