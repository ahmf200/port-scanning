import nmap
import os


def nmapScan():
    scanner = nmap.PortScanner()

    print("Welcome, this is a simple nmap port automation tool.")
    print("<-------------------------------------------------->")

    ip_addr = input("\nPlease enter the IP address you want to scan: \n")
    print("The IP you entered was " + ip_addr)
    type(ip_addr)

    port_number = input("\nPlease enter the port number or range (e.g. 1-1024): \n")
    print("The port number you entered was " + port_number)
    type(port_number)

    scan_type = input(""" \nPlease enter the type of scan you wan to perform
                    1) SYNC ACK Scan
                    2) UDP Scan
                    3) Comprehensive Scan
                    4) Scan other addresses (ipv4, mac and other addresses)\n""")

    print("You have selected the scan type: " + scan_type)
    
    if scan_type == '1':
        print("\nNmap Version: ", scanner.nmap_version())
        scanner.scan(hosts=ip_addr, ports=port_number, arguments='-v -sS', sudo=True)
        print(scanner.scaninfo())
        print("IP Status: ", scanner[ip_addr].state())
        print(scanner[ip_addr].all_protocols())
        print("Open Ports: ", scanner[ip_addr]['tcp'].keys())
        print(scanner.csv())
    elif scan_type == '2':
        print("\nNmap Version: ", scanner.nmap_version())
        scanner.scan(hosts=ip_addr, ports=port_number, arguments='-v -sU', sudo=True)
        print(scanner.scaninfo())
        print("IP Status: ", scanner[ip_addr].state())
        print(scanner[ip_addr].all_protocols())
        print("Open Ports: ", scanner[ip_addr]['udp'].keys())
    elif scan_type == '3':
        print("\nNmap Version: ", scanner.nmap_version())
        # scanner.scan(hosts=ip_addr, ports=port_number, arguments='-v -sS -sV -sC -A -O', sudo=True)
        scanner.scan(hosts=ip_addr, ports=port_number, arguments='-v -sS', sudo=True)
        print(scanner.scaninfo())
        print("IP Status: ", scanner[ip_addr].state())
        print(scanner[ip_addr].all_protocols())
        print("Open Ports: ", scanner[ip_addr]['udp'].keys())
        # print("Open Ports: ", scanner[ip_addr])
    elif scan_type == '4':
        specific_port = input("\nPlease enter a specific port number: \n")
        r = scanner.scan(hosts=ip_addr, arguments='-sS -p T:'+specific_port, sudo=True)
        print (r['scan'][ip_addr]['addresses'])
        print(scanner.scaninfo())
        print("IP Status: ", scanner[ip_addr].state())
        print(scanner[ip_addr].all_protocols())
        print("Open Ports: ", scanner[ip_addr]['tcp'].keys())
    elif scan_type >= '5':
        os.system('clear')
        print("Please enter a valid option")
        nmapScan()


nmapScan()