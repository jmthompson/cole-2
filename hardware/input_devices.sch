EESchema Schematic File Version 4
LIBS:cole-2-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 8
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Microchip_ATmega:ATmega328P-PU U?
U 1 1 5E0D073A
P 2600 2800
F 0 "U?" H 1956 2846 50  0000 R CNN
F 1 "ATmega328P-PU" H 1956 2755 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 2600 2800 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 2600 2800 50  0001 C CNN
	1    2600 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2200 3450 2200
Text GLabel 3450 2200 2    39   Input ~ 0
RESET
Wire Wire Line
	3200 2300 3450 2300
Text GLabel 3450 2300 2    39   Input ~ 0
~RESET
$EndSCHEMATC
