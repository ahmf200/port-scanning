# https://pypi.org/project/python-nmap/
# https://stackoverflow.com/questions/31104766/parsing-an-nmap-result

import nmap

host = '172.18.97.225'
port = ''

scanner = nmap.PortScanner()
scanner.scan(hosts=host, arguments='-v -sS -sV -sC -A -O')



for allHosts in scanner.all_hosts():
    print('---------------------')
    # print('Host: %s (%s)' % (host, scanner[host].hostname))
    print('Host: %s' % (host))
    print('State %s' % scanner[host].state())

for proto in scanner[host].all_protocols():
    print('\nProtocol: %s' % proto)


eachPort = scanner[host][proto].keys()

for port in eachPort:
    print('Port: %s\tState: %s\tReason: %s\tName:  %s\tProduct: %s\t\tVersion: %s' 
    % (port, scanner[host][proto][port]['state'], scanner[host][proto][port]['reason'], scanner[host][proto][port]['name'], 
    scanner[host][proto][port]['product'], scanner[host][proto][port]['version']))

scanner.csv
