#!/bin/bash
# vim: expandtab tabstop=4

# Set the topic to subscribe to. 
SUB_TOPIC="cmnd/switches/+"

# MQTT credentials 
USER="<replace me>"
PW="<replace me>"


# Declare the commands here. 
# If we recieve 'cmnd/switches/A ON' the script executes './send 11840172' 
# The code was sniffed from the remote using 'ProtocolAnalyzeDemo' from this
# fork of rc-switch: https://github.com/Martin-Laclaustra/rc-switch/tree/protocollessreceiver
declare -A COMMANDS
COMMANDS["A ON"]=11840172
COMMANDS["A OFF"]=12552332
COMMANDS["B ON"]=11949797
COMMANDS["B OFF"]=11639189
COMMANDS["C ON"]=12284094
COMMANDS["C OFF"]=12502382
COMMANDS["D ON"]=11639191
COMMANDS["D OFF"]=12379911

# Just some pretty output. 
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[93m'
DEFAULT='\e[39m'

while read MSG;
do
    # SWITCH=$(sed -e 's/.*\/\([A-B]\).*/\1/' <<< $MSG)
    # COMMAND=$(sed -e 's/.* \(\w*$\).*/\1/' <<< $MSG)
    
    # Extract everything after the last slash in the MQTT command. 
    COMMAND=$(sed -e 's/.*\/\(.*\)/\1/' <<< $MSG) 
    echo -en $YELLOW$(date)':' $DEFAULT$MSG;
    
    # If the received command was valid, execute ./send with the approriate 
    # decimal command. 
    if [[ ${COMMANDS[$COMMAND]} ]]; then     
        echo -e $GREEN' ✔︎' $DEFAULT
        ./send ${COMMANDS[$COMMAND]}
    else 
        echo -e $RED' ✘ No such command' $DEFAULT
    fi

# Setup the subscription using mosquitto_sub
done < <(mosquitto_sub -u ${USER} -P ${PW} -t ${SUB_TOPIC} -q 1 -v)
