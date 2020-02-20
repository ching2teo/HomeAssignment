# C# Console DataHub
C# console application:
1. connect to mqtt and receive message sent from sensor
2. connect to MySql to keep message that sent from sensor.

How to setup:
1. Unzip MainDataHub.zip 
2. Open the source code in Visual Studio 2019
3. Right click solution and restore nuget package:
	 a. M2MqttDotnetCore
	 b. MySql.Data
	 c. Microsoft.VisiualStudio.Azure.Containers.Tools.Targets
4. Set MainDataHub Project as startup project.
5. Modify the App.config file:
	 a. MqttBroker and SQLServer value to your pc IP address
