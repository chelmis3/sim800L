#!/bin/bash
send AT
expect "OK"
sleep 2s

send ATD +2547********;
expect "OK"
sleep 20s

send ATH	
expect "OK"
sleep 2s

send AT+CMGF=1	
expect "OK"
sleep 3s

send AT+CMGS=\"+2547********\"	
expect ">"	
send "This is a message"	
send "^z"	
expect "OK"
sleep 2s

send AT
expect "OK"
sleep 2s

send ATDL	
expect "OK"
sleep 2s
