EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 5
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
L 65xx:W65C816SxP U?
U 1 1 5B7D0BC7
P 2450 2450
F 0 "U?" H 2650 3500 60  0000 C CNN
F 1 "WD65C816S" V 2450 2450 39  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket" H 1950 1550 60  0001 C CNN
F 3 "" H 1950 1550 60  0000 C CNN
	1    2450 2450
	1    0    0    -1  
$EndComp
Text GLabel 3300 1250 2    39   Output ~ 0
A0
Wire Wire Line
	3300 1250 3050 1250
Text GLabel 3300 1350 2    39   Output ~ 0
A1
Wire Wire Line
	3300 1350 3050 1350
Text GLabel 3300 1450 2    39   Output ~ 0
A2
Wire Wire Line
	3300 1450 3050 1450
Text GLabel 3300 1550 2    39   Output ~ 0
A3
Wire Wire Line
	3300 1550 3050 1550
Text GLabel 3300 1650 2    39   Output ~ 0
A4
Wire Wire Line
	3300 1650 3050 1650
Text GLabel 3300 1750 2    39   Output ~ 0
A5
Wire Wire Line
	3300 1750 3050 1750
Text GLabel 3300 1850 2    39   Output ~ 0
A6
Wire Wire Line
	3300 1850 3050 1850
Text GLabel 3300 1950 2    39   Output ~ 0
A7
Wire Wire Line
	3300 1950 3050 1950
Text GLabel 3300 2050 2    39   Output ~ 0
A8
Wire Wire Line
	3300 2050 3050 2050
Text GLabel 3300 2150 2    39   Output ~ 0
A9
Wire Wire Line
	3300 2150 3050 2150
Text GLabel 3300 2250 2    39   Output ~ 0
A10
Wire Wire Line
	3300 2250 3050 2250
Text GLabel 3300 2350 2    39   Output ~ 0
A11
Wire Wire Line
	3300 2350 3050 2350
Text GLabel 3300 2450 2    39   Output ~ 0
A12
Wire Wire Line
	3300 2450 3050 2450
Text GLabel 3300 2550 2    39   Output ~ 0
A13
Wire Wire Line
	3300 2550 3050 2550
Text GLabel 3300 2650 2    39   Output ~ 0
A14
Wire Wire Line
	3300 2650 3050 2650
Text GLabel 3300 2750 2    39   Output ~ 0
A15
Wire Wire Line
	3300 2750 3050 2750
$Comp
L 74xx:74HC245 U?
U 1 1 5B7E0296
P 5850 3450
F 0 "U?" H 5700 4100 50  0000 C CNN
F 1 "74HCT245" V 5850 3650 39  0000 C CNN
F 2 "" H 5850 3450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC245" H 5850 3450 50  0001 C CNN
	1    5850 3450
	-1   0    0    -1  
$EndComp
$Comp
L 74xx:74LS573 U?
U 1 1 5B7E0AC5
P 5850 5800
F 0 "U?" H 6000 6450 50  0000 C CNN
F 1 "74AC573" V 5850 5800 39  0000 C CNN
F 2 "" H 5850 5800 50  0001 C CNN
F 3 "74xx/74hc573.pdf" H 5850 5800 50  0001 C CNN
	1    5850 5800
	1    0    0    -1  
$EndComp
Text GLabel 1600 1550 0    39   Input ~ 0
PHI2
Wire Wire Line
	1850 1550 1600 1550
Text GLabel 1600 2050 0    39   Input ~ 0
IRQB
Wire Wire Line
	1850 2050 1600 2050
Text GLabel 1600 2150 0    39   Input ~ 0
NMI
Wire Wire Line
	1850 2150 1600 2150
Text GLabel 1600 2450 0    39   Output ~ 0
RWB
Wire Wire Line
	1850 2450 1600 2450
NoConn ~ 1850 3250
Text GLabel 1600 3050 0    39   Output ~ 0
VDA
Wire Wire Line
	1850 3050 1600 3050
NoConn ~ 1850 3350
NoConn ~ 1850 3550
Text GLabel 6600 2950 2    39   BiDi ~ 0
D0
Wire Wire Line
	6350 2950 6600 2950
Text GLabel 6600 3050 2    39   BiDi ~ 0
D1
Wire Wire Line
	6350 3050 6600 3050
Text GLabel 6600 3150 2    39   BiDi ~ 0
D2
Wire Wire Line
	6350 3150 6600 3150
Text GLabel 6600 3250 2    39   BiDi ~ 0
D3
Wire Wire Line
	6350 3250 6600 3250
Text GLabel 6600 3350 2    39   BiDi ~ 0
D4
Wire Wire Line
	6350 3350 6600 3350
Text GLabel 6600 3450 2    39   BiDi ~ 0
D5
Wire Wire Line
	6350 3450 6600 3450
Text GLabel 6600 3550 2    39   BiDi ~ 0
D6
Wire Wire Line
	6350 3550 6600 3550
Text GLabel 6600 3650 2    39   BiDi ~ 0
D7
Wire Wire Line
	6350 3650 6600 3650
Text GLabel 6600 3850 2    39   Input ~ 0
RWB
Wire Wire Line
	6350 3850 6600 3850
Text GLabel 6600 3950 2    39   Input ~ 0
PHI1
Wire Wire Line
	6350 3950 6600 3950
Text GLabel 5100 6200 0    39   Input ~ 0
PHI1
Wire Wire Line
	5100 6200 5350 6200
$Comp
L power:GND #PWR0101
U 1 1 5B7EA7A8
P 5850 6850
F 0 "#PWR0101" H 5850 6600 50  0001 C CNN
F 1 "GND" H 5855 6677 50  0000 C CNN
F 2 "" H 5850 6850 50  0001 C CNN
F 3 "" H 5850 6850 50  0001 C CNN
	1    5850 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 6600 5850 6700
Wire Wire Line
	5850 6700 5250 6700
Wire Wire Line
	5250 6700 5250 6300
Wire Wire Line
	5250 6300 5350 6300
Connection ~ 5850 6700
Wire Wire Line
	5850 6700 5850 6850
Text GLabel 6600 5300 2    39   Output ~ 0
A16
Wire Wire Line
	6350 5300 6600 5300
Text GLabel 6600 5400 2    39   Output ~ 0
A17
Wire Wire Line
	6350 5400 6600 5400
Text GLabel 6600 5500 2    39   Output ~ 0
A18
Wire Wire Line
	6350 5500 6600 5500
Text GLabel 6600 5600 2    39   Output ~ 0
A19
Wire Wire Line
	6350 5600 6600 5600
Text GLabel 6600 5700 2    39   Output ~ 0
A20
Wire Wire Line
	6350 5700 6600 5700
Text GLabel 6600 5800 2    39   Output ~ 0
A21
Wire Wire Line
	6350 5800 6600 5800
Text GLabel 6600 5900 2    39   Output ~ 0
A22
Wire Wire Line
	6350 5900 6600 5900
Text GLabel 6600 6000 2    39   Output ~ 0
A23
Wire Wire Line
	6350 6000 6600 6000
$Comp
L power:+5V #PWR0102
U 1 1 5B7EFC32
P 5850 2550
F 0 "#PWR0102" H 5850 2400 50  0001 C CNN
F 1 "+5V" H 5865 2723 50  0000 C CNN
F 2 "" H 5850 2550 50  0001 C CNN
F 3 "" H 5850 2550 50  0001 C CNN
	1    5850 2550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 5B7F0B65
P 5850 4900
F 0 "#PWR0103" H 5850 4750 50  0001 C CNN
F 1 "+5V" H 5865 5073 50  0000 C CNN
F 2 "" H 5850 4900 50  0001 C CNN
F 3 "" H 5850 4900 50  0001 C CNN
	1    5850 4900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 5B7F1A82
P 2450 750
F 0 "#PWR0104" H 2450 600 50  0001 C CNN
F 1 "+5V" H 2465 923 50  0000 C CNN
F 2 "" H 2450 750 50  0001 C CNN
F 3 "" H 2450 750 50  0001 C CNN
	1    2450 750 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 750  2450 900 
$Comp
L power:GND #PWR0105
U 1 1 5B7F3A53
P 5850 4350
F 0 "#PWR0105" H 5850 4100 50  0001 C CNN
F 1 "GND" H 5855 4177 50  0000 C CNN
F 2 "" H 5850 4350 50  0001 C CNN
F 3 "" H 5850 4350 50  0001 C CNN
	1    5850 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5850 4250 5850 4350
Wire Wire Line
	5850 4900 5850 5000
Wire Wire Line
	5850 2550 5850 2650
$Comp
L power:GND #PWR0106
U 1 1 5B8020B3
P 2450 4100
F 0 "#PWR0106" H 2450 3850 50  0001 C CNN
F 1 "GND" H 2455 3927 50  0000 C CNN
F 2 "" H 2450 4100 50  0001 C CNN
F 3 "" H 2450 4100 50  0001 C CNN
	1    2450 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 4000 2450 4100
Text GLabel 1600 2850 0    39   Input ~ 0
BE
Wire Wire Line
	1850 2850 1600 2850
Text GLabel 1600 1250 0    39   Input ~ 0
RESB
Wire Wire Line
	1850 1250 1600 1250
Text GLabel 1600 2750 0    39   BiDi ~ 0
RDY
Wire Wire Line
	1600 2750 1850 2750
Text GLabel 1600 1950 0    39   Input ~ 0
ABORT
Wire Wire Line
	1600 1950 1850 1950
NoConn ~ 1850 3650
$Comp
L power:+5V #PWR0107
U 1 1 5B8182CE
P 5300 1400
F 0 "#PWR0107" H 5300 1250 50  0001 C CNN
F 1 "+5V" H 5315 1573 50  0000 C CNN
F 2 "" H 5300 1400 50  0001 C CNN
F 3 "" H 5300 1400 50  0001 C CNN
	1    5300 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 1400 5300 1550
Wire Wire Line
	5550 1550 5300 1550
Text GLabel 6200 1250 2    39   BiDi ~ 0
RDY
Wire Wire Line
	5950 1250 6200 1250
Text GLabel 6200 1350 2    39   Output ~ 0
ABORT
Wire Wire Line
	5950 1350 6200 1350
Text GLabel 6200 1450 2    39   Output ~ 0
NMI
Wire Wire Line
	5950 1450 6200 1450
Text GLabel 6200 1550 2    39   Output ~ 0
BE
Wire Wire Line
	5950 1550 6200 1550
Text GLabel 6200 1150 2    39   Output ~ 0
RESET
Wire Wire Line
	5950 1150 6200 1150
Wire Wire Line
	5350 6000 3950 6000
Wire Wire Line
	5350 5900 4050 5900
Wire Wire Line
	5350 5800 4150 5800
Wire Wire Line
	5350 5700 4250 5700
Wire Wire Line
	5350 5600 4350 5600
Wire Wire Line
	5350 5500 4450 5500
Wire Wire Line
	5350 5400 4550 5400
Wire Wire Line
	5350 5300 4650 5300
$Comp
L custom_chips:CAD U?
U 1 1 5B8A0547
P 9450 1950
F 0 "U?" H 9700 2850 60  0000 C CNN
F 1 "CAD2" V 9450 1950 39  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm_Socket" H 9450 1300 60  0001 C CNN
F 3 "" H 9450 1300 60  0000 C CNN
	1    9450 1950
	1    0    0    -1  
$EndComp
Text GLabel 8550 1600 0    39   Input ~ 0
A11
Wire Wire Line
	8550 1600 8800 1600
Text GLabel 8550 2000 0    39   Input ~ 0
A15
Wire Wire Line
	8550 1700 8800 1700
Text GLabel 8550 2100 0    39   Input ~ 0
A16
Wire Wire Line
	8550 1800 8800 1800
Text GLabel 8550 2200 0    39   Input ~ 0
A17
Wire Wire Line
	8550 1900 8800 1900
Text GLabel 8550 2300 0    39   Input ~ 0
A18
Wire Wire Line
	8550 2000 8800 2000
Text GLabel 8550 2400 0    39   Input ~ 0
A19
Wire Wire Line
	8550 2100 8800 2100
Text GLabel 8550 2500 0    39   Input ~ 0
A20
Wire Wire Line
	8550 2200 8800 2200
Text GLabel 8550 1700 0    39   Input ~ 0
A12
Wire Wire Line
	8550 2300 8800 2300
Text GLabel 8550 1800 0    39   Input ~ 0
A13
Wire Wire Line
	8550 2400 8800 2400
Text GLabel 8550 1900 0    39   Input ~ 0
A14
Wire Wire Line
	8550 2500 8800 2500
Text GLabel 8350 4550 0    39   Input ~ 0
PHI2
Wire Wire Line
	8350 4550 8600 4550
Text GLabel 8550 2650 0    39   Input ~ 0
VDA
Wire Wire Line
	8550 2650 8800 2650
Text GLabel 8350 4650 0    39   Input ~ 0
RWB
Wire Wire Line
	8350 4650 8600 4650
Text GLabel 8350 4750 0    39   Input ~ 0
ROMPROT
Text GLabel 10350 1400 2    39   Output ~ 0
ROMCSB
Wire Wire Line
	10100 1400 10350 1400
Text GLabel 10350 1500 2    39   Output ~ 0
RAM1CSB
Wire Wire Line
	10100 1500 10350 1500
Text GLabel 10350 1600 2    39   Output ~ 0
RAM2CSB
Wire Wire Line
	10100 1600 10350 1600
Text GLabel 10300 2250 2    39   Output ~ 0
IO1SELB
Wire Wire Line
	10100 2250 10300 2250
Text GLabel 10300 2350 2    39   Output ~ 0
IO2SELB
Wire Wire Line
	10100 2350 10300 2350
Text GLabel 10550 4300 2    39   Output ~ 0
RDB
Wire Wire Line
	10300 4300 10550 4300
Text GLabel 10550 4400 2    39   Output ~ 0
WRB
Wire Wire Line
	10300 4400 10550 4400
$Comp
L power:+5V #PWR?
U 1 1 5B8F80D4
P 9450 800
F 0 "#PWR?" H 9450 650 50  0001 C CNN
F 1 "+5V" H 9465 973 50  0000 C CNN
F 2 "" H 9450 800 50  0001 C CNN
F 3 "" H 9450 800 50  0001 C CNN
	1    9450 800 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5B912ADB
P 9450 3100
F 0 "#PWR?" H 9450 2850 50  0001 C CNN
F 1 "GND" H 9455 2927 50  0000 C CNN
F 2 "" H 9450 3100 50  0001 C CNN
F 3 "" H 9450 3100 50  0001 C CNN
	1    9450 3100
	1    0    0    -1  
$EndComp
Text GLabel 1600 2950 0    39   Output ~ 0
VPA
Wire Wire Line
	1850 2950 1600 2950
$Comp
L Device:R_Network06_US RN?
U 1 1 5BAB6B12
P 5750 1250
F 0 "RN?" V 6167 1250 50  0000 C CNN
F 1 "R_Network06_US" V 6076 1250 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP7" V 6125 1250 50  0001 C CNN
F 3 "http://www.vishay.com/docs/31509/csc.pdf" H 5750 1250 50  0001 C CNN
	1    5750 1250
	0    -1   -1   0   
$EndComp
Text GLabel 6200 1050 2    39   Output ~ 0
INTR2B
Wire Wire Line
	5950 1050 6200 1050
Wire Wire Line
	8350 4750 8600 4750
Wire Wire Line
	4650 2950 5350 2950
Wire Wire Line
	3050 2950 4650 2950
Connection ~ 4650 2950
Wire Wire Line
	4650 5300 4650 2950
Wire Wire Line
	4550 3050 5350 3050
Wire Wire Line
	3050 3050 4550 3050
Connection ~ 4550 3050
Wire Wire Line
	4550 5400 4550 3050
Wire Wire Line
	4450 3150 5350 3150
Wire Wire Line
	3050 3150 4450 3150
Connection ~ 4450 3150
Wire Wire Line
	4450 5500 4450 3150
Wire Wire Line
	4350 3250 5350 3250
Wire Wire Line
	3050 3250 4350 3250
Connection ~ 4350 3250
Wire Wire Line
	4350 5600 4350 3250
Wire Wire Line
	4250 3350 5350 3350
Wire Wire Line
	3050 3350 4250 3350
Connection ~ 4250 3350
Wire Wire Line
	4250 5700 4250 3350
Wire Wire Line
	4150 3450 5350 3450
Wire Wire Line
	3050 3450 4150 3450
Connection ~ 4150 3450
Wire Wire Line
	4150 5800 4150 3450
Wire Wire Line
	4050 3550 5350 3550
Wire Wire Line
	3050 3550 4050 3550
Connection ~ 4050 3550
Wire Wire Line
	4050 5900 4050 3550
Wire Wire Line
	3950 3650 5350 3650
Wire Wire Line
	3050 3650 3950 3650
Connection ~ 3950 3650
Wire Wire Line
	3950 6000 3950 3650
Text GLabel 10550 4500 2    39   Output ~ 0
ROMWRB
Wire Wire Line
	10300 4500 10550 4500
$Comp
L custom_chips:CBD U?
U 1 1 5C106687
P 9450 4700
F 0 "U?" H 9850 5100 60  0000 C CNN
F 1 "CID" V 9450 4700 39  0000 C CNN
F 2 "Package_DIP:DIP-24_W7.62mm_Socket" H 9450 4050 60  0001 C CNN
F 3 "" H 9450 4050 60  0000 C CNN
	1    9450 4700
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5C13132B
P 9450 3850
F 0 "#PWR?" H 9450 3700 50  0001 C CNN
F 1 "+5V" H 9465 4023 50  0000 C CNN
F 2 "" H 9450 3850 50  0001 C CNN
F 3 "" H 9450 3850 50  0001 C CNN
	1    9450 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5C149A7F
P 9450 5550
F 0 "#PWR?" H 9450 5300 50  0001 C CNN
F 1 "GND" H 9455 5377 50  0000 C CNN
F 2 "" H 9450 5550 50  0001 C CNN
F 3 "" H 9450 5550 50  0001 C CNN
	1    9450 5550
	1    0    0    -1  
$EndComp
Text GLabel 8550 1300 0    39   Input ~ 0
A4
Wire Wire Line
	8550 1300 8800 1300
Wire Wire Line
	8550 1400 8800 1400
Wire Wire Line
	8550 1500 8800 1500
Text GLabel 8550 1400 0    39   Input ~ 0
A5
Text GLabel 8550 1500 0    39   Input ~ 0
A6
Text GLabel 10300 2450 2    39   Output ~ 0
IO3SELB
Wire Wire Line
	10100 2450 10300 2450
Text GLabel 10300 2550 2    39   Output ~ 0
IO4SELB
Wire Wire Line
	10100 2550 10300 2550
Text GLabel 8550 2750 0    39   Input ~ 0
VPA
Wire Wire Line
	8550 2750 8800 2750
Text GLabel 8350 4850 0    39   Input ~ 0
IRQ
Wire Wire Line
	8350 4850 8600 4850
Text GLabel 10500 4850 2    39   Input ~ 0
INTR1B
Wire Wire Line
	10250 4850 10500 4850
Text GLabel 10500 4950 2    39   Input ~ 0
INTR2B
Wire Wire Line
	10250 4950 10500 4950
Text GLabel 10500 5050 2    39   Input ~ 0
INTR3B
Wire Wire Line
	10250 5050 10500 5050
Text GLabel 10500 5150 2    39   Input ~ 0
INTR4B
Wire Wire Line
	10250 5150 10500 5150
$EndSCHEMATC
