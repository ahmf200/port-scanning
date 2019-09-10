#!/bin/bash

read -p "Enter the IP you want to scan: " ipAddress

read -p "Which scan type would you like to use? " scanType

if [ $scanType == 1 ]
then
    printf "\n --- SYNC ACK scan selected --- \n"
    sudo nmap -sS $ipAddress > scanResult.txt
elif [ $scanType == 2 ]
then
    printf "\n --- UDP scan selected --- \n"
    sudo nmap -sU $ipAddress > scanResult.txt
elif [ $scanType == 3 ]
then
    printf "\n --- Comprehensive scan selected --- \n"
    sudo nmap -v -sS -sV -sC -A -O $ipAddress > scanResult.txt
else
    printf "\nYou need to select a scan type."
fi