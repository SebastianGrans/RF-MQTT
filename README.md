# MQTT Controlled RF outlets

Control RF outlets with MQTT, a Raspberry Pi and a 433MHz transmitter.


## Prerequisites 
* wiringPi
* rc-switch
* mosquitto 
* a 433MHz transmitter 

## Installation 
1. Clone this repo. 
2. Clone the [rc-switch](https://github.com/sui77/rc-switch) repository and extract the folder (should be named rc-switch-master) into the folder of this repo. 
3. Read through `mqttexec.sh` and `send.cpp` and edit the parameters to fit your needs.
4. Run `make` 
5. Run the script `./mqttexec`



## Run on boot 
If you want the script to start on boot then follow these instructions
1. Place `mqttexec.service` in `/etc/systemd/system`
2. Reload SystemD `sudo systemctl daemon-reload`
3. Enable the service `sudo systemctl enable mqttexec.service`
4. Reboot or run `sudo systemctl start mqttexec.service`
5. Confirm that it is running with `sudo systemctl status mqttexec`
 
