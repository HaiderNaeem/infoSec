#!/bin/python3

import sys
import socket
from datetime import datetime

if len(sys.argv) == 2:
        target = socket.gethostbyname(sys.argv[1]) #translate hostname tp IPv4
else:
        print("Invalid amount of Argument")
        print("Syntax: python3 scanner.py <ip>")
        sys.exit()
print("_"*50)
print("Scanning target: "+ target)
print("Time Started: " + str(datetime.now()))
print("_"*50)

try:
        for port in range(50,85): #checking for open port 53 or 80 for now
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                socket.setdefaulttimeout(1)
                result = s.connect_ex((target,port))
                print("Checking port {}".format(port))
                if result == 0:
                        print("port {} is open".format(port))
                s.close()

except KeyboardInterrupt:
        print("\nExiting program.") #hitting ctrl-c
        sys.exit()
except socket.gaierror:
        print("Hostname could not be resolved.")
        sys.exit()
except socket.error:
        print("Could not connect to server.")
        sys.exit()
