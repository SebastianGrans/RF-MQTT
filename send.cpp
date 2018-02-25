// vim: tabstop=2 expandtab

#include "rc-switch-master/RCSwitch.h"
#include <stdio.h> // printf, fgets
#include <stdlib.h> // exit

RCSwitch trans;
        
int main(int argc, char *argv[]) {
  if(argc < 2) {
    printf("No command specified.\n");
    exit(EXIT_FAILURE);
  }

  /* Different RF outlets have different protocols.
   * You can determine it using this program: 
   * https://github.com/Martin-Laclaustra/rc-switch/tree/protocollessreceiver/examples/ProtocolAnalyzeDemo
   * With that you can also sniff the decimal codes that you should 
   * fill into mqttexec.sh 
   */ 
  int TRANS_PIN = 2;
  int PROTOCOL = 4;
  int PULSE_LENGTH = 380;

  /* Setup wiringPi */
  if(wiringPiSetup() == -1) {
    printf("wiringPi failed. Exiting...\n");
    exit(EXIT_FAILURE);
  }
 
  trans = RCSwitch();
  trans.enableTransmit(TRANS_PIN);
  trans.setProtocol(PROTOCOL);
  trans.setPulseLength(PULSE_LENGTH);
 
  trans.send(atoi(argv[1]), 24);
  
  exit(EXIT_SUCCESS);
}

