# C++ Class Library
C++ Class generate random Inertial Motion Sensor

1. Open the source code in Visual Studio 2017
2. Open the source code in Visual Studio 2017
	 a. Right click ImuSensorData project and choose properties:
	    i. Configuration Manager> General> Configuration Type : Dynamic Library (.dll)
			ii. Configuration Manager>VC++ Directories>Include Directories: C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\include
			iii. Configuration Manager>VC++ Directories>Library Directories: C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\libs
			iv. Configuration Manager>C/C++>General>Additional Include Directories: C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\include
			v. Configuration Manager>Linker>General>Additional Library Directories: C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\libs
3. Build ImuSensorData project with platform set as x64, [ImuSensorData.dll] will be generated in folder /x64/Release. 
4. Rename ImuSensorData.dll to ImuSensorData.pyd
5. Copy ImuSensorData.pyd to python dlls folder (eg: C:\Program Files (x86)\Microsoft Visual Studio\Shared\Python36_64\DLLs)
6. This c++ dll can load to python script now.

