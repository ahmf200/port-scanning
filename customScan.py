# https://pypi.org/project/python-nmap/
# https://stackoverflow.com/questions/31104766/parsing-an-nmap-result

import nmap

host = '172.18.97.225'
# port = ''

whatHost = input('Enter the IP you want to scan: ')

scanner = nmap.PortScanner()
scanner.scan(hosts=whatHost, arguments='-v -sS -sV -sC -A -O')

for allHosts in scanner.all_hosts():
    print('---------------------')
    # print('Host: %s (%s)' % (whatHost, scanner[whatHost].hostname))
    print('Host: %s' % (whatHost))
    print('State %s' % scanner[whatHost].state())

for proto in scanner[whatHost].all_protocols():
    print('\nProtocol: %s' % proto)

print(scanner[whatHost].all_protocols())

foundPorts = scanner[whatHost]['tcp'].keys()

# for port in foundPorts:
#     print('Port: %s\tState: %s\tReason: %s\tName:  %s\tProduct: %s\t\tVersion: %s' 
#     % (port, scanner[whatHost][proto][port]['state'], scanner[whatHost][proto][port]['reason'], scanner[whatHost][proto][port]['name'], 
#     scanner[whatHost][proto][port]['product'], scanner[whatHost][proto][port]['version']))


# for port in foundPorts:
#     print('{:<20s} {:<25s} {:<25s} {:<25s} {:<35s} {:<35}'.format('Port: %s', 'State: %s', 'Reason: %s', 'Name: %s', 'Product: %s', 'Version: %s') 
#         % (port, scanner[whatHost][proto][port]['state'], scanner[whatHost][proto][port]['reason'], scanner[whatHost][proto][port]['name'], 
#             scanner[whatHost][proto][port]['product'], scanner[whatHost][proto][port]['version']))


for eachPort in foundPorts:
    print('{:<20s} {:<25s} {:<25s} {:<25s} {:<35s} {:<35}'.format('Port: %s', 'State: %s', 'Reason: %s', 'Name: %s', 'Product: %s', 'Version: %s') 
    % (str(eachPort), scanner[whatHost][proto][str(eachPort)]['state'], scanner[whatHost][proto][str(eachPort)]['reason'], scanner[whatHost][proto][str(eachPort)]['name'], 
        scanner[whatHost][proto][str(eachPort)]['product'], scanner[whatHost][proto][str(eachPort)]['version']))