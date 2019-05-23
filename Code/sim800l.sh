#!/bin/bash
send AT
expect "OK"
sleep 2s

send ATD +2547********;	#call given number
expect "OK"
sleep 20s

send ATH	
expect "OK"
sleep 2s

send AT+CMGF=1	
expect "OK"
sleep 3s

send AT+CMGS=\"+2547********\"	#send message to given number
expect ">"	
send "This is a message"	
send "^z"	
expect "OK"
sleep 2s

send AT
expect "OK"
sleep 2s

send ATDL	#redial previously dialed number
expect "OK"
sleep 2s

#SETTING UP GPRS CONNECTION
#--------------------------------------------
#Set the connection type to GPRS
send AT+SAPBR=3\,1\,\"Contype\"\,\"GPRS\"
expect "OK"
sleep 2s

#Set the APN to to "www" since i am using a Vodafone SIM card, It might be different for you, and depends on the network
send AT+SAPBR=3\,1\,\"APN\"\,\"CMNET\"
expect "OK"
sleep 2s

#Enable the GPRS
send AT+SAPBR =1\,1
expect "OK"
sleep 3s

#Query if the connection is setup properly, if we get back a IP address then we can proceed
send AT+SAPBR=2\,1
expect "OK"
sleep 3s

#GETTING THE CONTENTS OF A WEBPAGE FROM THE SERVER
#--------------------------------------------------------
#initialiase HTTP service
send AT+HTTPINIT
expect "OK"
sleep 2s

#initialise HTTPS service, ONLY IF URL is HTTPS or SSL enabled: Also Remove the http:// part in the HTTPPARA="URL",xxxx command
#send AT+HTTPSSL=1
#expect "OK"
#sleep 2s

#Start by setting up the HTTP bearer profile identifier
send AT+HTTPPARA=\"CID\"\,1
expect "OK"
sleep 2s

#Set the url  to the address of the webpage you want to access
send AT+HTTPPARA=\"URL\"\,\"http://ptsv2.com/t/******/post?key=25&value=2019\"
expect "OK"
sleep 2s

#Start the HTTP GET session, by giving this command
send AT+HTTPACTION=0
expect "OK"
sleep 2s

#The below command tells the module that we want to read the received data
send AT+HTTPREAD
expect "OK"
sleep 2s

#terminate HTTP service
send AT+HTTPTERM
expect "OK"
sleep 5s
