#!/bin/sh
# Mengqing Wu <mengqing.wu@desy.de>
# 2019-05-01

echo "Upstream HV current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u105
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u106
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u107

echo "Downstream HV current:"
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u100
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u101
snmpget -v 2c -m +WIENER-CRATE-MIB -c guru 192.168.3.2 outputMeasurementCurrent.u102
