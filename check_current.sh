#!/bin/sh
# Mengqing Wu <mengqing.wu@desy.de>
# 2019-05-01
# updated: 2019-07-15

echo "DAQ board current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u303

echo "1 Cassette AVDD current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u0
echo "1 Cassette DVDD current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u1

echo "1 Cassette HV current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u100
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u101
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u102

echo "2 Cassetted HV current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u105
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u106
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u107
