EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 5
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
L 65xx:W65C22SxP U?
U 1 1 5B9338F9
P 4150 2600
F 0 "U?" H 4450 3650 60  0000 C CNN
F 1 "WD65C22S" V 4150 2600 39  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket" H 3650 2900 60  0001 C CNN
F 3 "" H 3650 2900 60  0000 C CNN
	1    4150 2600
	1    0    0    -1  
$EndComp
Text GLabel 3300 3000 0    39   BiDi ~ 0
D0
Wire Wire Line
	3550 3000 3300 3000
Text GLabel 3300 3100 0    39   BiDi ~ 0
D1
Wire Wire Line
	3550 3100 3300 3100
Text GLabel 3300 3200 0    39   BiDi ~ 0
D2
Wire Wire Line
	3550 3200 3300 3200
Text GLabel 3300 3300 0    39   BiDi ~ 0
D3
Wire Wire Line
	3550 3300 3300 3300
Text GLabel 3300 3400 0    39   BiDi ~ 0
D4
Wire Wire Line
	3550 3400 3300 3400
Text GLabel 3300 3500 0    39   BiDi ~ 0
D5
Wire Wire Line
	3550 3500 3300 3500
Text GLabel 3300 3600 0    39   BiDi ~ 0
D6
Wire Wire Line
	3550 3600 3300 3600
Text GLabel 3300 3700 0    39   BiDi ~ 0
D7
Wire Wire Line
	3550 3700 3300 3700
Text GLabel 3300 2100 0    39   Input ~ 0
IO1SELB
Wire Wire Line
	3550 2100 3300 2100
$Comp
L power:+5V #PWR?
U 1 1 5B933B09
P 2750 1900
F 0 "#PWR?" H 2750 1750 50  0001 C CNN
F 1 "+5V" H 2765 2073 50  0000 C CNN
F 2 "" H 2750 1900 50  0001 C CNN
F 3 "" H 2750 1900 50  0001 C CNN
	1    2750 1900
	-1   0    0    -1  
$EndComp
Text GLabel 3300 1600 0    39   Input ~ 0
PHI2
Wire Wire Line
	3550 1600 3300 1600
Text GLabel 3300 2800 0    39   Input ~ 0
RWB
Wire Wire Line
	3550 2800 3300 2800
Text GLabel 3300 1500 0    39   Input ~ 0
RESB
Wire Wire Line
	3550 1500 3300 1500
Text GLabel 3300 1800 0    39   Output ~ 0
INTR1B
Wire Wire Line
	3550 1800 3300 1800
Text GLabel 3300 2300 0    39   Input ~ 0
A0
Wire Wire Line
	3550 2300 3300 2300
Text GLabel 3300 2400 0    39   Input ~ 0
A1
Wire Wire Line
	3550 2400 3300 2400
Text GLabel 3300 2500 0    39   Input ~ 0
A2
Wire Wire Line
	3550 2500 3300 2500
Text GLabel 3300 2600 0    39   Input ~ 0
A3
Wire Wire Line
	3550 2600 3300 2600
$Comp
L power:+5V #PWR?
U 1 1 5B935BF1
P 4150 1050
F 0 "#PWR?" H 4150 900 50  0001 C CNN
F 1 "+5V" H 4165 1223 50  0000 C CNN
F 2 "" H 4150 1050 50  0001 C CNN
F 3 "" H 4150 1050 50  0001 C CNN
	1    4150 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 1050 4150 1150
$Comp
L power:GND #PWR?
U 1 1 5B936194
P 4150 4200
F 0 "#PWR?" H 4150 3950 50  0001 C CNN
F 1 "GND" H 4155 4027 50  0000 C CNN
F 2 "" H 4150 4200 50  0001 C CNN
F 3 "" H 4150 4200 50  0001 C CNN
	1    4150 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 4050 4150 4200
Wire Wire Line
	3550 2000 2750 2000
Wire Wire Line
	2750 2000 2750 1900
Text GLabel 5000 1500 2    39   BiDi ~ 0
PA0
Wire Wire Line
	5000 1500 4750 1500
Text GLabel 5000 1600 2    39   BiDi ~ 0
PA1
Wire Wire Line
	5000 1600 4750 1600
Text GLabel 5000 1700 2    39   BiDi ~ 0
PA2
Wire Wire Line
	5000 1700 4750 1700
Text GLabel 5000 1800 2    39   BiDi ~ 0
PA3
Wire Wire Line
	5000 1800 4750 1800
Text GLabel 5000 1900 2    39   BiDi ~ 0
PA4
Wire Wire Line
	5000 1900 4750 1900
Text GLabel 5000 2000 2    39   BiDi ~ 0
PA5
Wire Wire Line
	5000 2000 4750 2000
Text GLabel 5000 2100 2    39   BiDi ~ 0
PA6
Wire Wire Line
	5000 2100 4750 2100
Text GLabel 5000 2200 2    39   BiDi ~ 0
PA7
Wire Wire Line
	5000 2200 4750 2200
Text GLabel 5000 2700 2    39   BiDi ~ 0
PB0
Wire Wire Line
	5000 2700 4750 2700
Text GLabel 5000 2800 2    39   BiDi ~ 0
PB1
Wire Wire Line
	5000 2800 4750 2800
Text GLabel 5000 2900 2    39   BiDi ~ 0
PB2
Wire Wire Line
	5000 2900 4750 2900
Text GLabel 5000 3000 2    39   BiDi ~ 0
PB3
Wire Wire Line
	5000 3000 4750 3000
Text GLabel 5000 3100 2    39   BiDi ~ 0
PB4
Wire Wire Line
	5000 3100 4750 3100
Text GLabel 5000 3200 2    39   BiDi ~ 0
PB5
Wire Wire Line
	5000 3200 4750 3200
Text GLabel 5000 3300 2    39   BiDi ~ 0
PB6
Wire Wire Line
	5000 3300 4750 3300
Text GLabel 5000 3400 2    39   BiDi ~ 0
PB7
Wire Wire Line
	5000 3400 4750 3400
Text GLabel 5000 3600 2    39   BiDi ~ 0
CB1
Wire Wire Line
	5000 3600 4750 3600
Text GLabel 5000 3700 2    39   BiDi ~ 0
CB2
Wire Wire Line
	5000 3700 4750 3700
Text GLabel 5000 2400 2    39   BiDi ~ 0
CA1
Wire Wire Line
	5000 2400 4750 2400
Text GLabel 5000 2500 2    39   BiDi ~ 0
CA2
Wire Wire Line
	5000 2500 4750 2500
Text GLabel 1000 1700 0    39   BiDi ~ 0
PA0
Wire Wire Line
	1000 1700 1250 1700
Text GLabel 1000 1800 0    39   BiDi ~ 0
PA1
Wire Wire Line
	1000 1800 1250 1800
Text GLabel 1000 1900 0    39   BiDi ~ 0
PA2
Wire Wire Line
	1000 1900 1250 1900
Text GLabel 1000 2000 0    39   BiDi ~ 0
PA3
Wire Wire Line
	1000 2000 1250 2000
Text GLabel 1000 2100 0    39   BiDi ~ 0
PA4
Wire Wire Line
	1000 2100 1250 2100
Text GLabel 2000 1800 2    39   BiDi ~ 0
PA5
Wire Wire Line
	1750 1800 2000 1800
Text GLabel 2000 1900 2    39   BiDi ~ 0
PA6
Wire Wire Line
	1750 1900 2000 1900
Text GLabel 2000 2000 2    39   BiDi ~ 0
PA7
Wire Wire Line
	1750 2000 2000 2000
Text GLabel 2000 2100 2    39   BiDi ~ 0
CA1
Wire Wire Line
	1750 2100 2000 2100
Text GLabel 2000 2200 2    39   BiDi ~ 0
CA2
Wire Wire Line
	1750 2200 2000 2200
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J?
U 1 1 5B94626A
P 1450 1900
F 0 "J?" H 1500 2317 50  0000 C CNN
F 1 "USER PORT A" H 1500 2226 50  0000 C CNN
F 2 "" H 1450 1900 50  0001 C CNN
F 3 "~" H 1450 1900 50  0001 C CNN
	1    1450 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5B948822
P 2000 1600
F 0 "#PWR?" H 2000 1450 50  0001 C CNN
F 1 "+5V" H 2015 1773 50  0000 C CNN
F 2 "" H 2000 1600 50  0001 C CNN
F 3 "" H 2000 1600 50  0001 C CNN
	1    2000 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 1700 2000 1600
Wire Wire Line
	1750 1700 2000 1700
$Comp
L power:GND #PWR?
U 1 1 5B94F9E3
P 1000 2300
F 0 "#PWR?" H 1000 2050 50  0001 C CNN
F 1 "GND" H 1005 2127 50  0000 C CNN
F 2 "" H 1000 2300 50  0001 C CNN
F 3 "" H 1000 2300 50  0001 C CNN
	1    1000 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 2200 1000 2200
Wire Wire Line
	1000 2200 1000 2300
Text GLabel 1000 2950 0    39   BiDi ~ 0
PB0
Wire Wire Line
	1000 2950 1250 2950
Text GLabel 1000 3050 0    39   BiDi ~ 0
PB1
Wire Wire Line
	1000 3050 1250 3050
Text GLabel 1000 3150 0    39   BiDi ~ 0
PB2
Wire Wire Line
	1000 3150 1250 3150
Text GLabel 1000 3250 0    39   BiDi ~ 0
PB3
Wire Wire Line
	1000 3250 1250 3250
Text GLabel 1000 3350 0    39   BiDi ~ 0
PB4
Wire Wire Line
	1000 3350 1250 3350
Text GLabel 2000 3050 2    39   BiDi ~ 0
PB5
Wire Wire Line
	1750 3050 2000 3050
Text GLabel 2000 3150 2    39   BiDi ~ 0
PB6
Wire Wire Line
	1750 3150 2000 3150
Text GLabel 2000 3250 2    39   BiDi ~ 0
PB7
Wire Wire Line
	1750 3250 2000 3250
Text GLabel 2000 3350 2    39   BiDi ~ 0
CB1
Wire Wire Line
	1750 3350 2000 3350
Text GLabel 2000 3450 2    39   BiDi ~ 0
CB2
Wire Wire Line
	1750 3450 2000 3450
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J?
U 1 1 5B95216E
P 1450 3150
F 0 "J?" H 1500 3567 50  0000 C CNN
F 1 "USER PORT B" H 1500 3476 50  0000 C CNN
F 2 "" H 1450 3150 50  0001 C CNN
F 3 "~" H 1450 3150 50  0001 C CNN
	1    1450 3150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5B952175
P 2000 2850
F 0 "#PWR?" H 2000 2700 50  0001 C CNN
F 1 "+5V" H 2015 3023 50  0000 C CNN
F 2 "" H 2000 2850 50  0001 C CNN
F 3 "" H 2000 2850 50  0001 C CNN
	1    2000 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2950 2000 2850
Wire Wire Line
	1750 2950 2000 2950
$Comp
L power:GND #PWR?
U 1 1 5B95217D
P 1000 3550
F 0 "#PWR?" H 1000 3300 50  0001 C CNN
F 1 "GND" H 1005 3377 50  0000 C CNN
F 2 "" H 1000 3550 50  0001 C CNN
F 3 "" H 1000 3550 50  0001 C CNN
	1    1000 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3450 1000 3450
Wire Wire Line
	1000 3450 1000 3550
Text GLabel 9100 1100 0    39   Input ~ 0
A0
Wire Wire Line
	9100 1100 9350 1100
Text GLabel 9100 1200 0    39   Input ~ 0
A1
Wire Wire Line
	9100 1200 9350 1200
Text GLabel 9100 1300 0    39   Input ~ 0
A2
Wire Wire Line
	9100 1300 9350 1300
Text GLabel 9100 1400 0    39   Input ~ 0
A3
Wire Wire Line
	9100 1400 9350 1400
Text GLabel 9100 1500 0    39   Input ~ 0
A4
Wire Wire Line
	9100 1500 9350 1500
Text GLabel 9100 1600 0    39   Input ~ 0
A5
Wire Wire Line
	9100 1600 9350 1600
Text GLabel 9100 1700 0    39   Input ~ 0
A6
Wire Wire Line
	9100 1700 9350 1700
Text GLabel 9100 1800 0    39   Input ~ 0
A7
Wire Wire Line
	9100 1800 9350 1800
Text GLabel 9100 1900 0    39   Input ~ 0
A8
Wire Wire Line
	9100 1900 9350 1900
Text GLabel 9100 2000 0    39   Input ~ 0
A9
Wire Wire Line
	9100 2000 9350 2000
Text GLabel 9100 2100 0    39   Input ~ 0
A10
Wire Wire Line
	9100 2100 9350 2100
Text GLabel 9100 2200 0    39   Input ~ 0
A11
Wire Wire Line
	9100 2200 9350 2200
Text GLabel 9100 2300 0    39   Input ~ 0
A12
Wire Wire Line
	9100 2300 9350 2300
Text GLabel 9100 2400 0    39   Input ~ 0
A13
Wire Wire Line
	9100 2400 9350 2400
Text GLabel 9100 2500 0    39   Input ~ 0
A14
Wire Wire Line
	9100 2500 9350 2500
Text GLabel 9100 2600 0    39   Input ~ 0
A15
Wire Wire Line
	9100 2600 9350 2600
Text GLabel 10100 1100 2    39   Input ~ 0
A16
Wire Wire Line
	9850 1100 10100 1100
Text GLabel 10100 1200 2    39   Input ~ 0
A17
Wire Wire Line
	9850 1200 10100 1200
Text GLabel 10100 1300 2    39   Input ~ 0
A18
Wire Wire Line
	9850 1300 10100 1300
Text GLabel 10100 1400 2    39   Input ~ 0
A19
Wire Wire Line
	9850 1400 10100 1400
Text GLabel 10100 1500 2    39   Input ~ 0
A20
Wire Wire Line
	9850 1500 10100 1500
Text GLabel 10100 1600 2    39   Input ~ 0
A21
Wire Wire Line
	9850 1600 10100 1600
Text GLabel 10100 1700 2    39   Input ~ 0
A22
Wire Wire Line
	9850 1700 10100 1700
Text GLabel 10100 1800 2    39   Input ~ 0
A23
Wire Wire Line
	9850 1800 10100 1800
Text GLabel 10100 1900 2    39   BiDi ~ 0
D0
Wire Wire Line
	9850 1900 10100 1900
Text GLabel 10100 2000 2    39   BiDi ~ 0
D1
Wire Wire Line
	9850 2000 10100 2000
Text GLabel 10100 2100 2    39   BiDi ~ 0
D2
Wire Wire Line
	9850 2100 10100 2100
Text GLabel 10100 2200 2    39   BiDi ~ 0
D3
Wire Wire Line
	9850 2200 10100 2200
Text GLabel 10100 2300 2    39   BiDi ~ 0
D4
Wire Wire Line
	9850 2300 10100 2300
Text GLabel 10100 2400 2    39   BiDi ~ 0
D5
Wire Wire Line
	9850 2400 10100 2400
Text GLabel 10100 2500 2    39   BiDi ~ 0
D6
Wire Wire Line
	9850 2500 10100 2500
Text GLabel 10100 2600 2    39   BiDi ~ 0
D7
Wire Wire Line
	9850 2600 10100 2600
Text GLabel 9100 2700 0    39   Input ~ 0
EXPIRQ
Wire Wire Line
	9100 2700 9350 2700
Text GLabel 9100 2800 0    39   Input ~ 0
NMI
Wire Wire Line
	9100 2800 9350 2800
Text GLabel 10100 2700 2    39   BiDi ~ 0
RDY
Wire Wire Line
	9850 2700 10100 2700
Text GLabel 10100 2900 2    39   Output ~ 0
BE
Wire Wire Line
	9850 2900 10100 2900
Text GLabel 10100 3200 2    39   Input ~ 0
PHI2
Wire Wire Line
	9850 3200 10100 3200
Text GLabel 9100 2900 0    39   Input ~ 0
VDA
Wire Wire Line
	9100 2900 9350 2900
Text GLabel 9100 3000 0    39   Input ~ 0
VPA
Wire Wire Line
	9100 3000 9350 3000
$Comp
L Connector_Generic:Conn_02x24_Odd_Even J?
U 1 1 5B9AF363
P 9550 2200
F 0 "J?" H 9600 3517 50  0000 C CNN
F 1 "EXPANSION" H 9600 3426 50  0000 C CNN
F 2 "" H 9550 2200 50  0001 C CNN
F 3 "~" H 9550 2200 50  0001 C CNN
	1    9550 2200
	1    0    0    -1  
$EndComp
Text GLabel 10100 3000 2    39   BiDi ~ 0
RESET
Wire Wire Line
	9850 3000 10100 3000
Text GLabel 10100 2800 2    39   Output ~ 0
ABORT
Wire Wire Line
	9850 2800 10100 2800
$Comp
L power:+5V #PWR?
U 1 1 5B9ED112
P 10650 3150
F 0 "#PWR?" H 10650 3000 50  0001 C CNN
F 1 "+5V" H 10665 3323 50  0000 C CNN
F 2 "" H 10650 3150 50  0001 C CNN
F 3 "" H 10650 3150 50  0001 C CNN
	1    10650 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 3150 10650 3300
Wire Wire Line
	10650 3400 9850 3400
Wire Wire Line
	9850 3300 10650 3300
Connection ~ 10650 3300
Wire Wire Line
	10650 3300 10650 3400
$Comp
L power:GND #PWR?
U 1 1 5B9F76DA
P 8850 3550
F 0 "#PWR?" H 8850 3300 50  0001 C CNN
F 1 "GND" H 8855 3377 50  0000 C CNN
F 2 "" H 8850 3550 50  0001 C CNN
F 3 "" H 8850 3550 50  0001 C CNN
	1    8850 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 3550 8850 3400
Wire Wire Line
	8850 3300 9350 3300
Wire Wire Line
	9350 3400 8850 3400
Connection ~ 8850 3400
Wire Wire Line
	8850 3400 8850 3300
Text GLabel 9100 3100 0    39   Input ~ 0
RD
Wire Wire Line
	9100 3100 9350 3100
Text GLabel 9100 3200 0    39   Input ~ 0
WR
Wire Wire Line
	9100 3200 9350 3200
NoConn ~ 9850 3100
$Comp
L SC28L92:SC28L92 U?
U 1 1 5BA26CE8
P 2450 5850
F 0 "U?" H 2700 7150 59  0000 C CNN
F 1 "SC28L92" V 2450 5800 39  0000 C CNN
F 2 "Package_LCC:PLCC-44_THT-Socket" H 3450 7400 39  0001 C CNN
F 3 "" H 2450 5850 39  0001 C CNN
	1    2450 5850
	1    0    0    -1  
$EndComp
Text GLabel 1550 4700 0    39   Input ~ 0
A0
Wire Wire Line
	1550 4700 1800 4700
Text GLabel 1550 4800 0    39   Input ~ 0
A1
Wire Wire Line
	1550 4800 1800 4800
Text GLabel 1550 4900 0    39   Input ~ 0
A2
Wire Wire Line
	1550 4900 1800 4900
Text GLabel 1550 5000 0    39   Input ~ 0
A3
Wire Wire Line
	1550 5000 1800 5000
Text GLabel 1550 5200 0    39   BiDi ~ 0
D0
Wire Wire Line
	1550 5200 1800 5200
Text GLabel 1550 5300 0    39   BiDi ~ 0
D1
Wire Wire Line
	1550 5300 1800 5300
Text GLabel 1550 5400 0    39   BiDi ~ 0
D2
Wire Wire Line
	1550 5400 1800 5400
Text GLabel 1550 5500 0    39   BiDi ~ 0
D3
Wire Wire Line
	1550 5500 1800 5500
Text GLabel 1550 5600 0    39   BiDi ~ 0
D4
Wire Wire Line
	1550 5600 1800 5600
Text GLabel 1550 5700 0    39   BiDi ~ 0
D5
Wire Wire Line
	1550 5700 1800 5700
Text GLabel 1550 5800 0    39   BiDi ~ 0
D6
Wire Wire Line
	1550 5800 1800 5800
Text GLabel 1550 5900 0    39   BiDi ~ 0
D7
Wire Wire Line
	1550 5900 1800 5900
Text GLabel 1550 6100 0    39   Input ~ 0
IOSEL2B
Wire Wire Line
	1550 6100 1800 6100
Text GLabel 1550 6200 0    39   Input ~ 0
RD
Wire Wire Line
	1550 6200 1800 6200
Text GLabel 1550 6300 0    39   Input ~ 0
WR
Wire Wire Line
	1550 6300 1800 6300
Text GLabel 1550 6500 0    39   Input ~ 0
INTR2B
Wire Wire Line
	1550 6500 1800 6500
Text GLabel 1550 6400 0    39   Input ~ 0
RES
Wire Wire Line
	1550 6400 1800 6400
NoConn ~ 1800 6950
$Comp
L power:GND #PWR?
U 1 1 5BAF28DD
P 2450 7550
F 0 "#PWR?" H 2450 7300 50  0001 C CNN
F 1 "GND" H 2455 7377 50  0000 C CNN
F 2 "" H 2450 7550 50  0001 C CNN
F 3 "" H 2450 7550 50  0001 C CNN
	1    2450 7550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 7350 2450 7500
$Comp
L power:+5V #PWR?
U 1 1 5BAFB20D
P 2450 4150
F 0 "#PWR?" H 2450 4000 50  0001 C CNN
F 1 "+5V" H 2465 4323 50  0000 C CNN
F 2 "" H 2450 4150 50  0001 C CNN
F 3 "" H 2450 4150 50  0001 C CNN
	1    2450 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 4150 2450 4300
Text GLabel 3350 4700 2    39   Input ~ 0
RxDA
Wire Wire Line
	3100 4700 3350 4700
Text GLabel 3350 5000 2    39   Input ~ 0
RxDB
Wire Wire Line
	3100 5000 3350 5000
Text GLabel 3350 4800 2    39   Output ~ 0
TxDA
Wire Wire Line
	3100 4800 3350 4800
Text GLabel 3350 5100 2    39   Output ~ 0
TxDB
Wire Wire Line
	3100 5100 3350 5100
Text GLabel 3350 6350 2    39   Input ~ 0
CTSA
Wire Wire Line
	3100 6350 3350 6350
Text GLabel 3350 6450 2    39   Input ~ 0
CTSB
Wire Wire Line
	3100 6450 3350 6450
Text GLabel 3350 5400 2    39   Output ~ 0
RTSA
Wire Wire Line
	3100 5400 3350 5400
Text GLabel 3350 5500 2    39   Output ~ 0
RTSB
Wire Wire Line
	3100 5500 3350 5500
Text GLabel 3350 6550 2    39   Input ~ 0
DCDA
Wire Wire Line
	3100 6550 3350 6550
Text GLabel 3350 6650 2    39   Input ~ 0
DCDB
Wire Wire Line
	3100 6650 3350 6650
Text GLabel 3350 6850 2    39   Input ~ 0
DSRA
Wire Wire Line
	3100 6850 3350 6850
Text GLabel 3350 6950 2    39   Input ~ 0
DSRB
Wire Wire Line
	3100 6950 3350 6950
Text GLabel 3350 5600 2    39   Output ~ 0
DTRA
Wire Wire Line
	3100 5600 3350 5600
Text GLabel 3350 5700 2    39   Output ~ 0
DTRB
Wire Wire Line
	3100 5700 3350 5700
NoConn ~ 3100 5800
NoConn ~ 3100 5900
NoConn ~ 3100 6000
$Comp
L Connector:DB9_Male J?
U 1 1 5BBB6647
P 7700 5150
F 0 "J?" H 7650 4450 50  0000 L CNN
F 1 "SERIAL A" H 7550 4550 50  0000 L CNN
F 2 "" H 7700 5150 50  0001 C CNN
F 3 " ~" H 7700 5150 50  0001 C CNN
	1    7700 5150
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5BC1A6E4
P 7200 5700
F 0 "#PWR?" H 7200 5450 50  0001 C CNN
F 1 "GND" H 7205 5527 50  0000 C CNN
F 2 "" H 7200 5700 50  0001 C CNN
F 3 "" H 7200 5700 50  0001 C CNN
	1    7200 5700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7400 5550 7200 5550
Wire Wire Line
	7200 5550 7200 5700
NoConn ~ 7400 5450
$Comp
L Connector:DB9_Male J?
U 1 1 5BC6CB29
P 9450 5150
F 0 "J?" H 9400 4450 50  0000 C CNN
F 1 "SERIAL B" H 9450 4550 50  0000 C CNN
F 2 "" H 9450 5150 50  0001 C CNN
F 3 " ~" H 9450 5150 50  0001 C CNN
	1    9450 5150
	1    0    0    1   
$EndComp
Wire Wire Line
	8900 4750 9150 4750
Wire Wire Line
	8900 4950 9150 4950
Wire Wire Line
	8900 5150 9150 5150
Wire Wire Line
	8900 5350 9150 5350
$Comp
L power:GND #PWR?
U 1 1 5BC6CB38
P 8950 5700
F 0 "#PWR?" H 8950 5450 50  0001 C CNN
F 1 "GND" H 8955 5527 50  0000 C CNN
F 2 "" H 8950 5700 50  0001 C CNN
F 3 "" H 8950 5700 50  0001 C CNN
	1    8950 5700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9150 5550 8950 5550
Wire Wire Line
	8950 5550 8950 5700
NoConn ~ 9150 5450
Wire Wire Line
	8900 5250 9150 5250
Wire Wire Line
	8900 5050 9150 5050
Wire Wire Line
	8900 4850 9150 4850
NoConn ~ 1800 6800
Text GLabel 1550 6700 0    39   Input ~ 0
SER_CLK
Wire Wire Line
	1800 6700 1550 6700
Text GLabel 3350 6100 2    39   Output ~ 0
ROMPROT
Wire Wire Line
	3100 6100 3350 6100
NoConn ~ 3100 6750
$EndSCHEMATC
