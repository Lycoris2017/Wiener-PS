#!/bin/bash

echo " power OFF the DAQ board"
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u303 i 0
sleep 10

echo " power ON the DAQ board"
snmpset -v 2c -m +WIENER-CRATE-MIB -c guru  192.168.3.2 outputSwitch.u303 i 1
