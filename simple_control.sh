#!/bin/bash

'''
*Author:  Mengqing Wu <mengqing.wu@desy.de>
*Date:    2019-01-08
*Project: Lycoris
*Description:
  This is a naive script to control the *Wiener MPOD* power supplier.
Manual see: http://file.wiener-d.com/documentation/MPOD/WIENER_MPOD_Manual_3.0.pdf
MIB file used: 
  file.wiener-d.com/software/net-snmp/WIENER-CRATE-MIB-4169.zip 

*Checkpoints before use this:

1) did you configure the Wiener to listen to which port via USB?
   -- Here we set it to be 192.168.3.2
   -- Web Monitor go to your Browser, type 192.168.3.2
2) did you correspondingly connect / configure the port on the PC correctly?
   -- So you have to set your PC Addr to be 192.168.3.1
3) If so, then go ahead:
'''

# Check all Channels:
snmpwalk -v 2c -m +WIENER-CRATE-MIB -c public 192.168.3.2 crate | grep outputSwitch
'''
Then you will see output as below:
-----
WIENER-CRATE-MIB::outputSwitch.u0 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u1 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u2 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u3 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u4 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u5 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u6 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u7 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u200 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u201 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u202 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u203 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u204 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u205 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u206 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u207 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u208 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u209 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u210 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u211 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u212 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u213 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u214 = INTEGER: off(0)
WIENER-CRATE-MIB::outputSwitch.u215 = INTEGER: off(0)
'''

# Turn ON:
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u200 i 1

# Turn OFF:
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u200 i 0

# Check status:
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u200
'''
Output:
----------
WIENER-CRATE-MIB::outputSwitch.u200 = INTEGER: off(0)
'''

# Control Voltage:
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputVoltage.u1 F 6

snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputVoltage.u1
'''
Output:
----------
WIENER-CRATE-MIB::outputVoltage.u1 = Opaque: Float: 6.000000 V
'''

# Control Current:
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputCurrent.u1 F 5

snmpget -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputCurrent.u1

# maybe important, you do not like the loud Wiener? Here you can change the fan speed:
# 1. check 
snmpwalk -v 2c -m +WIENER-CRATE-MIB -c public 192.168.3.2 crate | grep fan
# 2. set
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 fanNominalSpeed.0 i 800
# 3. you can re-check or not.

