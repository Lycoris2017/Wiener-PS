#!/bin/bash
###
#
# *Author:  Mengqing Wu <mengqing.wu@desy.de>
# *Date:    2019-02-04
# *Project: Lycoris
# *Description: 
#   - DAQ board @ LV Channel 0 (12V);
#   - KPiX AVDD @ LV channel 1 (2.5V);
#   - KPiX DVDD @ LV channel 2 (2.5V);
# 
####

# Turn it on

if [ "$#" -ne 1 ]; then
    echo "-- Wrong number of parameters!"
    echo "-- Example to use:"
    echo "   ./power_kpix.sh on [or 'off']"
    exit
fi

for i; do SWITCH=" $i"; done

echo $SWITCH

# very bug here: the parser may contain some unnecessary empty space:
if [[ "$SWITCH" == *"on"* ]]; then
    echo "switch on!"
    switch=1
else
    echo "not equal!"
    switch=0
fi

snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u0 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u1 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u2 i $switch

