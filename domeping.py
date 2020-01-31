#!/usr/bin/python
import sys
from scapy.all import *

conf.verb = 0
arg = sys.argv[1]

print "Hosts vivos"
for ip in range(1, 255):
	iprange = "%s.%s" %(arg,ip)
	pIP = IP(dst=iprange)
	pacote = pIP/ICMP()
	resp, noresp = sr(pacote,timeout=1)
	print resp[0][1][IP].ttl
#	print resp[0][1].show()
#	for resposta in resp:
#		print resposta[1][IP].src
