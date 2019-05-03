#!/bin/bash
###
#
# *Author:  Mengqing Wu <mengqing.wu@desy.de>
# *Date:    2019-04-30
# *Project: Lycoris
# *Description: 
#   - Master AVDD @ LV channel 6 (3.0V);
#   - Master DVDD @ LV channel 7 (3.0V);
# 
####

## Global Variable, please check:
WienerAddr=192.168.3.2
HV=70.00
HI=0.004 # 100uA
checkI=0

#--- Check voltage setting ---#
arr_res0=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u100 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))
arr_res1=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u101 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))
arr_res2=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u102 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))

echo  "[info] Check HV_0 @ Chn100 ?= ${HV}V..."
if [[ ${arr_res0[1]} == *${HV}* ]];
then
    echo -e "\t HV_0 Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u100 F ${HV}
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u0
fi

echo  "[info] Check HV_1 @ Chn101 ?= ${HV}V..."
if [[ ${arr_res1[1]} == *${HV}* ]];
then
    echo -e "\t HV_1 Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u101 F ${HV}
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u1
fi

echo  "[info] Check HV_2 @ Chn102 ?= ${HV}V..."
if [[ ${arr_res2[1]} == *${HV}* ]];
then
    echo -e "\t HV_2 Verified." # String Partially Match
else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u102 F ${HV}
    #snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputVoltage.u1
fi


#--- Check current setting ---#

if [ $checkI==1 ];
then
    echo "Check Current!"
    
    arr_hi0=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u100 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))
    arr_hi1=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u101 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))
    arr_hi1=($( snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u102 | grep -Eo '[+-]?[0-9]+([.][0-9]+)?'))
    
    
    echo  "[info] Check I_bias_0 limit ?= 1 uA..." # 0.000001 A
    if [[ ${arr_hi0[1]} == *${HI}* ]];
    then    
	echo -e "\t I_bias_0 Verified." # String Partially Match
    else
	echo "No Match"
	snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u100 F ${HI}
    fi
    
    echo  "[info] Check I_bias_0 limit ?= 1 uA..." # 0.000001 A
    if [[ ${arr_hi1[1]} == *${HI}* ]];
    then    
	echo -e "\t I_bias_0 Verified." # String Partially Match
    else
	echo "No Match"
	snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u101 F ${HI}
    fi
    
    echo  "[info] Check I_bias_0 limit ?= 1 uA..." # 0.000001 A
    if [[ ${arr_hi2[1]} == *${HI}* ]];
    then    
	echo -e "\t I_bias_0 Verified." # String Partially Match
    else
    echo "No Match"
    snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputCurrent.u102 F ${HI}
    fi

fi # prepare 

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
elif [[ "$SWITCH" == *"off"* ]]; then
    echo "swtich off"
    switch=0
else
    echo "not equal! abort..."
    exit
fi

snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u100 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u101 i $switch
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  $WienerAddr outputSwitch.u102 i $switch
