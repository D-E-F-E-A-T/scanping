#!/usr/bin/python
import socket,sys,re

if (len(sys.argv) != 2):
	print "Modo de uso: python %s 192.168.0.1\r\n" %sys.argv[0]
	sys.exit(0)

file = open("usuarios.txt")
for linha in file:
	tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	tcp.connect((sys.argv[1],25))
	banner = tcp.recv(1024)
	tcp.send("VRFY "+linha)
	user = tcp.recv(1024)
	if re.search("252", user):
		print "Usuario encontrado: "+user.strip("252 2.0.0 ")


#if ( len(sys.argv) != 3 ):
#	print "Modo de uso: python %s IP nome" %sys.argv[0]
#	sys.exit(0)

#tcp = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#tcp.connect((sys.argv[1],25))
#banner = tcp.recv(1024)
#print banner

#tcp.send("VRFY %s\r\n" %sys.argv[2])
#user = tcp.recv(1024)
#print user
