#!/bin/bash
###
#
# *Author:  Mengqing Wu <mengqing.wu@desy.de>
# *Date:    2019-04-09
# *Project: Lycoris
# *Description: 
#   - DAQ board @ LV Channel 4 (12V);
#   - KPiX AVDD @ LV channel 0 (3.0V);
#   - KPiX DVDD @ LV channel 1 (3.0V);
# 
####

## Global Variable, please check:
WienerAddr=192.168.3.2

#--- Check voltage setting ---#
res0=$( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u0 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
res1=$( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u1 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
res4=$( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u4 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?')

echo  "[info] Check AVDD_Master input @ Chn0 ?= 3V..."
if [[ $res0 == *3.00* ]];
then
    echo -e "\tAVDD Master Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u0 F 3
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u0
fi

echo  "[info] Check DVDD_Master input @ Chn1 ?= 3V..."
if [[ $res1 == *3.00* ]];
then
    echo -e "\tDVDD Master Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u1 F 3
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u1
fi

echo  "[info] Check DAQ board power @ Chn4 ?= 12V..."
if [[ $res4 == *12.00* ]];
then
    echo -e "\tDAQ Voltage Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u4 F 12
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u4
fi

#--- Turn it on ---#

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

snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u0 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u1 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u4 i $switch

