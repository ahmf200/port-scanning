#!/bin/bash

read -p "Enter the IP you want to scan: " ipAddress

printf "Scan types:\n
        1. TCP SYN (-sS)
        2. TCP connect (-sT)
        3. UDP (-sU)
        4. Comprehensive (-v[verbose] -sS[TCP SYN] -sV[Service version detection] -sC -O[Operating system detection])
        5. Aggressive (-A) - INTRUSIVE, BE WARNED 
        9. More information on each scan type\n\n"

read -p "Which scan type would you like to use? (Type the number) " scanType

saveToOutputQuestion() {
    read -p "\nDo you want the output to be saved to a file? (yes/no or y/n)\n
    Your file name will be in the following format -> scanResult-<scanType>-$ipAddress\n" outputDecision
}

pingQuestion() {
    read -p "\nDo you wish to not ping the target?\n" pingDecision
}

if [ $scanType == 1 ]
then
    printf "\n --- TCP SYN scan selected --- \n"
    pingQuestion
    if [ $pingDecision == 'yes' ] || [ $pingDecision == 'y']
    then
        saveToOutputQuestion
        if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
        then
            nmap -sS -Pn $ipAddress > scanResult-tcpSyn-$ipAddress.txt
        elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
        then
            nmap -sS -Pn $ipAddress
        fi
    elif [ $pingDecision == 'no' ] || [ $pingDecision == 'n' ]
    then
        saveToOutputQuestion
        if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
        then
            nmap -sS $ipAddress > scanResult-tcpSyn-$ipAddress.txt
        elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
        then
            nmap -sS $ipAddress
        fi
    fi
    # saveToOutputQuestion
    # if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
    # then
    #     nmap -sS $ipAddress > scanResult-tcpSyn-$ipAddress.txt
    # elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
    # then
    #     nmap -sS $ipAddress
    # fi
elif [ $scanType == 2 ]
then
    printf "\n --- TCP connect scan selected --- \n"
    saveToOutputQuestion
    if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
    then
        nmap -sT $ipAddress > scanResult-tcpCon-$ipAddress.txt
    elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
    then
        nmap -sT $ipAddress
    fi
elif [ $scanType == 3 ]
then
    printf "\n --- UDP scan selected --- \n"
    saveToOutputQuestion
    if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
    then
        nmap -sU $ipAddress > scanResult-udp-$ipAddress.txt
    elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
    then
        nmap -sU $ipAddress
    fi
elif [ $scanType == 4 ]
then
    printf "\n --- Comprehensive scan selected --- \n"
    saveToOutputQuestion
    if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
    then
        nmap -v -sS -sV -sC -O $ipAddress > scanResult-comp-$ipAddress.txt
    elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
    then
        nmap -v -sS -sV -sC -O $ipAddress
    fi
elif [ $scanType == 5 ]
then
    printf "\n --- Aggressive scan selected --- \n"
    saveToOutputQuestion
    if [ $outputDecision == 'yes' ] || [ $outputDecision == 'y' ]
    then
        nmap -v -A $ipAddress > scanResult-comp-$ipAddress.txt
    elif [ $outputDecision == 'no' ] || [ $outputDecision == 'n' ]
    then
        nmap -v -A $ipAddress
    fi
elif [ $scanType == 9 ]
then
    printf "\n --- Scan type information --- \n"
    printf "\n\n -sS"
    printf "\t    SYN scan is the default and most popular scan option for good reasons. 
            It can be performed quickly, scanning thousands of ports per second on a fast network not hampered by restrictive firewalls. 
            It is also relatively unobtrusive and stealthy since it never completes TCP connections."
    printf "\n\n -sT"
    printf "\t    TCP connect scan is the default TCP scan type when SYN scan is not an option. This is the case when a user does not have raw packet privileges. 
            Instead of writing raw packets as most other scan types do, Nmap asks the underlying operating system to establish a connection with the target machine and port by issuing the connect system call. 
            This is the same high-level system call that web browsers, P2P clients, and most other network-enabled applications use to establish a connection. 
            It is part of a programming interface known as the Berkeley Sockets API. 
            Rather than read raw packet responses off the wire, Nmap uses this API to obtain status information on each connection attempt.
            When SYN scan is available, it is usually a better choice. Nmap has less control over the high level connect call than with raw packets, making it less efficient"
    printf "\n\n -sU"
    printf "\t    While most popular services on the Internet run over the TCP protocol, UDP services are widely deployed. DNS, SNMP, and DHCP (registered ports 53, 161/162, and 67/68) are three of the most common. 
            Because UDP scanning is generally slower and more difficult than TCP, some security auditors ignore these ports. 
            This is a mistake, as exploitable UDP services are quite common and attackers certainly don't ignore the whole protocol. 
            Fortunately, Nmap can help inventory UDP ports.
            UDP scan is activated with the -sU option. It can be combined with a TCP scan type such as SYN scan (-sS) to check both protocols during the same run.
            UDP scan works by sending a UDP packet to every targeted port"
elif [ -z $scanType ]
then
    printf "Nothing entered."
    exit 1
elif ! [[ $scanType =~ ^[0-9]+$ ]]
then
    printf "Numbers only."
    exit 1
else
    printf "\nYou need to select a scan type."
    exit 1
fi
