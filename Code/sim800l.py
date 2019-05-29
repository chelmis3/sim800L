#!/usr/bin/env python3

import serial
import time

ser = serial.Serial(
    "/dev/ttyS0",
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    bytesize=serial.EIGHTBITS,
    timeout = 1)

if ser.isOpen():
    print(ser.name + ' is open....!!!!')
    ser.write(b'AT\r')
    time.sleep(1)
    
    print(ser.name + ' is calling...')
    ser.write(b'ATD +254*********;\r')
    time.sleep(10)
    
    
    print(ser.name + ' is hanging up...')
    ser.write(b'ATH\r')
    time.sleep(1)
        
    print(ser.name + ' is sending SMS...')
    ser.write(b'AT+CMGF=1\r')
    time.sleep(1)
    ser.write(b'AT+CMGS="+254*********"\r')
    time.sleep(2)
    ser.write(b"Python message0\r")
    time.sleep(2)
    ser.write(b'\x1a\r\n') #CTRL+Z
    time.sleep(3)
    
    ser.write(b'AT\r')
    time.sleep(1)
    
    print(ser.name + ' is setting up GPRS connection...')
    ser.write(b'AT+SAPBR=3,1,"Contype","GPRS"\r')
    time.sleep(3)
    ser.write(b'AT+SAPBR=3,1,"APN","CMNET"\r')
    time.sleep(3)
    ser.write(b'AT+SAPBR=1,1\r')
    time.sleep(3)
    ser.write(b'AT+SAPBR=2,1\r')
    time.sleep(3)
    print(ser.name + ' is getting webpage...')
    ser.write(b'AT+HTTPINIT\r')
    time.sleep(3)
    ser.write(b'AT+HTTPSSL=1\r')
    time.sleep(3)
    ser.write(b'AT+HTTPPARA="CID",1\r')
    time.sleep(3)
    ser.write(b'AT+HTTPPARA="URL","api.thingspeak.com/update?api_key=****************&field1=708&field2=300"\r')
    time.sleep(3)
    ser.write(b'AT+HTTPACTION=0\r')
    time.sleep(7)
    ser.write(b'AT+HTTPREAD\r')
    time.sleep(3)
    ser.write(b'AT+HTTPTERM\r')
    time.sleep(5)

    print("Disconnecting...")
    ser.close()
    


       
    
