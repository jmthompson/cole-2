EESchema Schematic File Version 4
LIBS:cole-2-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 6
Title "CPU and System Controller"
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
P 2550 2900
F 0 "U?" H 2750 4300 60  0000 C CNN
F 1 "WD65C816S" H 2850 1500 39  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket" H 2050 2000 60  0001 C CNN
F 3 "" H 2050 2000 60  0000 C CNN
	1    2550 2900
	1    0    0    -1  
$EndComp
Text GLabel 3400 1700 2    39   Output ~ 0
A0
Wire Wire Line
	3400 1700 3150 1700
Text GLabel 3400 1800 2    39   Output ~ 0
A1
Wire Wire Line
	3400 1800 3150 1800
Text GLabel 3400 1900 2    39   Output ~ 0
A2
Wire Wire Line
	3400 1900 3150 1900
Text GLabel 3400 2000 2    39   Output ~ 0
A3
Wire Wire Line
	3400 2000 3150 2000
Text GLabel 3400 2100 2    39   Output ~ 0
A4
Wire Wire Line
	3400 2100 3150 2100
Text GLabel 3400 2200 2    39   Output ~ 0
A5
Wire Wire Line
	3400 2200 3150 2200
Text GLabel 3400 2300 2    39   Output ~ 0
A6
Wire Wire Line
	3400 2300 3150 2300
Text GLabel 3400 2400 2    39   Output ~ 0
A7
Wire Wire Line
	3400 2400 3150 2400
Text GLabel 3400 2500 2    39   Output ~ 0
A8
Wire Wire Line
	3400 2500 3150 2500
Text GLabel 3400 2600 2    39   Output ~ 0
A9
Wire Wire Line
	3400 2600 3150 2600
Text GLabel 3400 2700 2    39   Output ~ 0
A10
Wire Wire Line
	3400 2700 3150 2700
Text GLabel 3400 2800 2    39   Output ~ 0
A11
Wire Wire Line
	3400 2800 3150 2800
Text GLabel 3400 2900 2    39   Output ~ 0
A12
Wire Wire Line
	3400 2900 3150 2900
Text GLabel 3400 3000 2    39   Output ~ 0
A13
Wire Wire Line
	3400 3000 3150 3000
Text GLabel 3400 3100 2    39   Output ~ 0
A14
Wire Wire Line
	3400 3100 3150 3100
Text GLabel 3400 3200 2    39   Output ~ 0
A15
Wire Wire Line
	3400 3200 3150 3200
Text GLabel 1700 2000 0    39   Input ~ 0
ϕ2
Wire Wire Line
	1950 2000 1700 2000
Text GLabel 1700 2500 0    39   Input ~ 0
~IRQ
Wire Wire Line
	1950 2500 1700 2500
Text GLabel 1700 2600 0    39   Input ~ 0
~NMI
Wire Wire Line
	1950 2600 1700 2600
Text GLabel 1700 2900 0    39   Output ~ 0
R~W
Wire Wire Line
	1950 2900 1700 2900
NoConn ~ 1950 3700
Text GLabel 1700 3500 0    39   Output ~ 0
VDA
Wire Wire Line
	1950 3500 1700 3500
NoConn ~ 1950 3800
NoConn ~ 1950 4000
Text GLabel 3400 3400 2    39   BiDi ~ 0
D0
Text GLabel 3400 3500 2    39   BiDi ~ 0
D1
Text GLabel 3400 3600 2    39   BiDi ~ 0
D2
Text GLabel 3400 3700 2    39   BiDi ~ 0
D3
Text GLabel 3400 3800 2    39   BiDi ~ 0
D4
Text GLabel 3400 3900 2    39   BiDi ~ 0
D5
Text GLabel 3400 4000 2    39   BiDi ~ 0
D6
Text GLabel 3400 4100 2    39   BiDi ~ 0
D7
Text GLabel 1700 3300 0    39   Input ~ 0
BE
Wire Wire Line
	1950 3300 1700 3300
Text GLabel 1700 1700 0    39   Input ~ 0
~RESET
Wire Wire Line
	1950 1700 1700 1700
Text GLabel 1700 3200 0    39   BiDi ~ 0
RDY
Wire Wire Line
	1700 3200 1950 3200
Text GLabel 1700 2400 0    39   Input ~ 0
~ABORT
Wire Wire Line
	1700 2400 1950 2400
NoConn ~ 1950 4100
Wire Wire Line
	9150 1850 9150 2000
Wire Wire Line
	9400 2000 9150 2000
Text GLabel 10050 1700 2    39   BiDi ~ 0
RDY
Wire Wire Line
	9800 1700 10050 1700
Text GLabel 10050 1800 2    39   Output ~ 0
~ABORT
Wire Wire Line
	9800 1800 10050 1800
Text GLabel 10050 2000 2    39   Output ~ 0
BE
Wire Wire Line
	9800 2000 10050 2000
Text GLabel 5700 3250 0    39   Input ~ 0
A11
Wire Wire Line
	5700 3250 5950 3250
Text GLabel 5700 3650 0    39   Input ~ 0
A15
Wire Wire Line
	5700 3350 5950 3350
Text GLabel 5700 3750 0    39   Output ~ 0
A16
Wire Wire Line
	5700 3450 5950 3450
Text GLabel 5700 3850 0    39   Output ~ 0
A17
Wire Wire Line
	5700 3550 5950 3550
Text GLabel 5700 3950 0    39   Output ~ 0
A18
Wire Wire Line
	5700 3650 5950 3650
Wire Wire Line
	5700 3750 5950 3750
Wire Wire Line
	5700 3850 5950 3850
Text GLabel 5700 3350 0    39   Input ~ 0
A12
Wire Wire Line
	5700 3950 5950 3950
Text GLabel 5700 3450 0    39   Input ~ 0
A13
Text GLabel 5700 3550 0    39   Input ~ 0
A14
Text GLabel 7400 3150 2    39   Input ~ 0
ϕ2
Wire Wire Line
	7400 3150 7150 3150
Text GLabel 7400 3050 2    39   Input ~ 0
VDA
Wire Wire Line
	7400 3050 7150 3050
Text GLabel 7400 3250 2    39   Input ~ 0
R~W
Wire Wire Line
	7400 3250 7150 3250
Text GLabel 7400 2500 2    39   Output ~ 0
~ROMCS
Wire Wire Line
	7150 2500 7400 2500
Text GLabel 7400 2600 2    39   Output ~ 0
~RAM1CS
Wire Wire Line
	7150 2600 7400 2600
Text GLabel 7400 2700 2    39   Output ~ 0
~RAM2CS
Wire Wire Line
	7150 2700 7400 2700
Text GLabel 7400 1850 2    39   Output ~ 0
~RD
Wire Wire Line
	7150 1850 7400 1850
Text GLabel 7400 1950 2    39   Output ~ 0
~WR
Wire Wire Line
	7150 1950 7400 1950
Text GLabel 1700 3400 0    39   Output ~ 0
VPA
Wire Wire Line
	1950 3400 1700 3400
$Comp
L Device:R_Network06_US RN?
U 1 1 5BAB6B12
P 9600 1700
F 0 "RN?" V 9900 1700 50  0000 C CNN
F 1 "4607X-101-332LF" V 9150 1650 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP7" V 9975 1700 50  0001 C CNN
F 3 "https://www.mouser.com/datasheet/2/54/4600x-776645.pdf" H 9600 1700 50  0001 C CNN
	1    9600 1700
	0    -1   -1   0   
$EndComp
Text GLabel 10050 1500 2    39   Output ~ 0
~INTR3
Wire Wire Line
	9800 1500 10050 1500
$Comp
L power:GND #PWR?
U 1 1 5C149A7F
P 1750 6850
F 0 "#PWR?" H 1750 6600 50  0001 C CNN
F 1 "GND" H 1755 6677 50  0000 C CNN
F 2 "" H 1750 6850 50  0001 C CNN
F 3 "" H 1750 6850 50  0001 C CNN
	1    1750 6850
	1    0    0    -1  
$EndComp
Text GLabel 5700 2950 0    39   Input ~ 0
A5
Wire Wire Line
	5700 2950 5950 2950
Wire Wire Line
	5700 3050 5950 3050
Wire Wire Line
	5700 3150 5950 3150
Text GLabel 5700 3050 0    39   Input ~ 0
A6
Text GLabel 5700 3150 0    39   Input ~ 0
A7
Text GLabel 3950 5850 2    39   Input ~ 0
~IRQ
Wire Wire Line
	3950 5850 3700 5850
Text GLabel 2850 5700 0    39   Input ~ 0
~INTR1
Wire Wire Line
	3100 5700 2850 5700
Text GLabel 2850 5800 0    39   Input ~ 0
~INTR2
Wire Wire Line
	3100 5800 2850 5800
Text GLabel 2850 5900 0    39   Input ~ 0
~INTR3
Wire Wire Line
	3100 5900 2850 5900
Text GLabel 2850 6000 0    39   Input ~ 0
~INTR4
Wire Wire Line
	3100 6000 2850 6000
$Comp
L power:+3V3 #PWR?
U 1 1 5D46E61B
P 2550 950
F 0 "#PWR?" H 2550 800 50  0001 C CNN
F 1 "+3V3" H 2565 1123 50  0000 C CNN
F 2 "" H 2550 950 50  0001 C CNN
F 3 "" H 2550 950 50  0001 C CNN
	1    2550 950 
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5D481D84
P 9150 1850
F 0 "#PWR?" H 9150 1700 50  0001 C CNN
F 1 "+3V3" H 9165 2023 50  0000 C CNN
F 2 "" H 9150 1850 50  0001 C CNN
F 3 "" H 9150 1850 50  0001 C CNN
	1    9150 1850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U?
U 1 1 5DF4CB6F
P 3400 5850
F 0 "U?" H 3400 6225 50  0000 C CNN
F 1 "SN74HC21N" H 3400 6134 50  0000 C CNN
F 2 "" H 3400 5850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 3400 5850 50  0001 C CNN
	1    3400 5850
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U?
U 2 1 5DF659F8
P 3400 6600
F 0 "U?" H 3400 6975 50  0000 C CNN
F 1 "SN74HC21N" H 3400 6884 50  0000 C CNN
F 2 "" H 3400 6600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 3400 6600 50  0001 C CNN
	2    3400 6600
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 U?
U 3 1 5DF6663D
P 1750 6350
F 0 "U?" H 1980 6396 50  0000 L CNN
F 1 "SN74HC21N" H 1980 6305 50  0000 L CNN
F 2 "" H 1750 6350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 1750 6350 50  0001 C CNN
	3    1750 6350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5DF83F9F
P 1750 5600
F 0 "#PWR?" H 1750 5450 50  0001 C CNN
F 1 "+3V3" H 1765 5773 50  0000 C CNN
F 2 "" H 1750 5600 50  0001 C CNN
F 3 "" H 1750 5600 50  0001 C CNN
	1    1750 5600
	1    0    0    -1  
$EndComp
NoConn ~ 3700 6600
$Comp
L power:GND #PWR?
U 1 1 5DFD48B5
P 2900 6850
F 0 "#PWR?" H 2900 6600 50  0001 C CNN
F 1 "GND" H 2905 6677 50  0000 C CNN
F 2 "" H 2900 6850 50  0001 C CNN
F 3 "" H 2900 6850 50  0001 C CNN
	1    2900 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 6450 2900 6450
Wire Wire Line
	2900 6450 2900 6550
Wire Wire Line
	3100 6550 2900 6550
Connection ~ 2900 6550
Wire Wire Line
	2900 6550 2900 6650
Wire Wire Line
	3100 6650 2900 6650
Connection ~ 2900 6650
Wire Wire Line
	2900 6650 2900 6750
Wire Wire Line
	3100 6750 2900 6750
Connection ~ 2900 6750
Wire Wire Line
	2900 6750 2900 6850
Wire Wire Line
	3150 3400 3400 3400
Wire Wire Line
	3150 3500 3400 3500
Wire Wire Line
	3150 3600 3400 3600
Wire Wire Line
	3150 3700 3400 3700
Wire Wire Line
	3150 3800 3400 3800
Wire Wire Line
	3150 3900 3400 3900
Wire Wire Line
	3150 4000 3400 4000
Wire Wire Line
	3150 4100 3400 4100
Wire Wire Line
	9800 1900 10050 1900
Text GLabel 10050 1900 2    39   Output ~ 0
~NMI
Wire Wire Line
	9800 1600 10050 1600
Text GLabel 10050 1600 2    39   Output ~ 0
~RESET
$Comp
L power:+3V3 #PWR?
U 1 1 5DF82880
P 6550 950
F 0 "#PWR?" H 6550 800 50  0001 C CNN
F 1 "+3V3" H 6565 1123 50  0000 C CNN
F 2 "" H 6550 950 50  0001 C CNN
F 3 "" H 6550 950 50  0001 C CNN
	1    6550 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 950  6550 1050
Wire Wire Line
	6400 1600 6400 1400
Wire Wire Line
	6400 1250 6550 1250
Connection ~ 6550 1250
Wire Wire Line
	6550 1250 6550 1600
Wire Wire Line
	6550 1250 6700 1250
$Comp
L Device:C_Small C?
U 1 1 5DF91781
P 6100 1050
F 0 "C?" V 6000 1050 50  0000 C CNN
F 1 "0.1uf" V 6200 1050 50  0000 C CNN
F 2 "" H 6100 1050 50  0001 C CNN
F 3 "~" H 6100 1050 50  0001 C CNN
	1    6100 1050
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5DF9B14E
P 6100 1400
F 0 "C?" V 6000 1400 50  0000 C CNN
F 1 "0.1uf" V 6200 1400 50  0000 C CNN
F 2 "" H 6100 1400 50  0001 C CNN
F 3 "~" H 6100 1400 50  0001 C CNN
	1    6100 1400
	0    1    1    0   
$EndComp
Wire Wire Line
	6200 1400 6400 1400
Connection ~ 6400 1400
Wire Wire Line
	6400 1400 6400 1250
Wire Wire Line
	6200 1050 6550 1050
Connection ~ 6550 1050
Wire Wire Line
	6550 1050 6550 1250
$Comp
L power:GND #PWR?
U 1 1 5DFB219F
P 5700 1500
F 0 "#PWR?" H 5700 1250 50  0001 C CNN
F 1 "GND" H 5705 1327 50  0000 C CNN
F 2 "" H 5700 1500 50  0001 C CNN
F 3 "" H 5700 1500 50  0001 C CNN
	1    5700 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DFB2934
P 7400 1500
F 0 "#PWR?" H 7400 1250 50  0001 C CNN
F 1 "GND" H 7405 1327 50  0000 C CNN
F 2 "" H 7400 1500 50  0001 C CNN
F 3 "" H 7400 1500 50  0001 C CNN
	1    7400 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 1500 5700 1400
Wire Wire Line
	5700 1050 6000 1050
Wire Wire Line
	6000 1400 5700 1400
Connection ~ 5700 1400
Wire Wire Line
	5700 1400 5700 1050
Text GLabel 5700 1850 0    39   BiDi ~ 0
D0
Wire Wire Line
	5700 1850 5950 1850
Text GLabel 5700 1950 0    39   BiDi ~ 0
D1
Wire Wire Line
	5700 1950 5950 1950
Text GLabel 5700 2050 0    39   BiDi ~ 0
D2
Wire Wire Line
	5700 2050 5950 2050
Text GLabel 5700 2150 0    39   BiDi ~ 0
D3
Wire Wire Line
	5700 2150 5950 2150
Text GLabel 5700 2250 0    39   BiDi ~ 0
D4
Wire Wire Line
	5700 2250 5950 2250
Text GLabel 5700 2350 0    39   BiDi ~ 0
D5
Wire Wire Line
	5700 2350 5950 2350
Text GLabel 5700 2450 0    39   BiDi ~ 0
D6
Wire Wire Line
	5700 2450 5950 2450
Text GLabel 5700 2550 0    39   BiDi ~ 0
D7
Wire Wire Line
	5700 2550 5950 2550
Text GLabel 5700 2750 0    39   Input ~ 0
A0
Wire Wire Line
	5700 2750 5950 2750
Wire Wire Line
	5700 2850 5950 2850
Text GLabel 5700 2850 0    39   Input ~ 0
A1
$Comp
L power:GND #PWR?
U 1 1 5E009129
P 6550 4550
F 0 "#PWR?" H 6550 4300 50  0001 C CNN
F 1 "GND" H 6555 4377 50  0000 C CNN
F 2 "" H 6550 4550 50  0001 C CNN
F 3 "" H 6550 4550 50  0001 C CNN
	1    6550 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 4200 6550 4350
Wire Wire Line
	6400 4200 6400 4350
Wire Wire Line
	6400 4350 6550 4350
Wire Wire Line
	6700 4350 6700 4200
Connection ~ 6550 4350
Wire Wire Line
	6550 4350 6550 4550
Wire Wire Line
	6550 4350 6700 4350
Wire Wire Line
	2550 4450 2550 4550
$Comp
L power:GND #PWR0106
U 1 1 5B8020B3
P 2550 4550
F 0 "#PWR0106" H 2550 4300 50  0001 C CNN
F 1 "GND" H 2555 4377 50  0000 C CNN
F 2 "" H 2550 4550 50  0001 C CNN
F 3 "" H 2550 4550 50  0001 C CNN
	1    2550 4550
	1    0    0    -1  
$EndComp
Connection ~ 6700 1400
Wire Wire Line
	6700 1400 6700 1600
Wire Wire Line
	6700 1250 6700 1400
Wire Wire Line
	2550 950  2550 1350
Wire Wire Line
	7400 1400 7400 1500
Wire Wire Line
	7100 1400 7400 1400
Wire Wire Line
	6700 1400 6900 1400
$Comp
L Device:C_Small C?
U 1 1 5DF9EB81
P 7000 1400
F 0 "C?" V 6900 1400 50  0000 C CNN
F 1 "0.1uf" V 7100 1400 50  0000 C CNN
F 2 "" H 7000 1400 50  0001 C CNN
F 3 "~" H 7000 1400 50  0001 C CNN
	1    7000 1400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E05DC06
P 3250 1250
F 0 "#PWR?" H 3250 1000 50  0001 C CNN
F 1 "GND" H 3255 1077 50  0000 C CNN
F 2 "" H 3250 1250 50  0001 C CNN
F 3 "" H 3250 1250 50  0001 C CNN
	1    3250 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3250 1150 3250 1250
Wire Wire Line
	2950 1150 3250 1150
Wire Wire Line
	2550 1150 2750 1150
$Comp
L Device:C_Small C?
U 1 1 5E05DC0F
P 2850 1150
F 0 "C?" V 2750 1150 50  0000 C CNN
F 1 "0.1uf" V 2950 1150 50  0000 C CNN
F 2 "" H 2850 1150 50  0001 C CNN
F 3 "~" H 2850 1150 50  0001 C CNN
	1    2850 1150
	0    1    1    0   
$EndComp
Text GLabel 7400 2950 2    39   Input ~ 0
~RESET
Wire Wire Line
	7400 2950 7150 2950
Wire Wire Line
	7150 2350 7400 2350
Text GLabel 7400 2350 2    39   Output ~ 0
~IOSEL4
Wire Wire Line
	7150 2250 7400 2250
Text GLabel 7400 2250 2    39   Output ~ 0
~IOSEL3
Wire Wire Line
	7150 2150 7400 2150
Text GLabel 7400 2150 2    39   Output ~ 0
~IOSEL2
Wire Wire Line
	7150 2050 7400 2050
Text GLabel 7400 2050 2    39   Output ~ 0
~IOSEL1
Wire Wire Line
	1750 5600 1750 5700
$Comp
L power:GND #PWR?
U 1 1 5E1220B2
P 950 5800
F 0 "#PWR?" H 950 5550 50  0001 C CNN
F 1 "GND" H 955 5627 50  0000 C CNN
F 2 "" H 950 5800 50  0001 C CNN
F 3 "" H 950 5800 50  0001 C CNN
	1    950  5800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	950  5700 950  5800
Wire Wire Line
	1250 5700 950  5700
$Comp
L Device:C_Small C?
U 1 1 5E1220BA
P 1350 5700
F 0 "C?" V 1250 5700 50  0000 C CNN
F 1 "0.1uf" V 1450 5700 50  0000 C CNN
F 2 "" H 1350 5700 50  0001 C CNN
F 3 "~" H 1350 5700 50  0001 C CNN
	1    1350 5700
	0    -1   1    0   
$EndComp
Wire Wire Line
	1450 5700 1750 5700
Connection ~ 1750 5700
Wire Wire Line
	1750 5700 1750 5850
Text GLabel 7400 3950 2    39   Output ~ 0
SPI65_TDI
Wire Wire Line
	7400 3950 7150 3950
$Comp
L Connector:Conn_ARM_JTAG_SWD_10 J?
U 1 1 5E19AC48
P 9600 3550
F 0 "J?" H 9900 4100 50  0000 R CNN
F 1 "JTAG" H 9450 4100 50  0000 R CNN
F 2 "Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical" H 9600 3550 50  0001 C CNN
F 3 "http://infocenter.arm.com/help/topic/com.arm.doc.ddi0314h/DDI0314H_coresight_components_trm.pdf" V 9250 2300 50  0001 C CNN
	1    9600 3550
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E19C76D
P 9600 4350
F 0 "#PWR?" H 9600 4100 50  0001 C CNN
F 1 "GND" H 9605 4177 50  0000 C CNN
F 2 "" H 9600 4350 50  0001 C CNN
F 3 "" H 9600 4350 50  0001 C CNN
	1    9600 4350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9600 4150 9600 4250
Wire Wire Line
	9700 4150 9700 4250
Wire Wire Line
	9700 4250 9600 4250
Connection ~ 9600 4250
Wire Wire Line
	9600 4250 9600 4350
Wire Wire Line
	9600 2800 9600 2950
$Comp
L power:+3V3 #PWR?
U 1 1 5E1A9B5B
P 9600 2800
F 0 "#PWR?" H 9600 2650 50  0001 C CNN
F 1 "+3V3" H 9615 2973 50  0000 C CNN
F 2 "" H 9600 2800 50  0001 C CNN
F 3 "" H 9600 2800 50  0001 C CNN
	1    9600 2800
	-1   0    0    -1  
$EndComp
NoConn ~ 9100 3250
Wire Wire Line
	7400 3850 7150 3850
Text GLabel 7400 3850 2    39   Input ~ 0
TCK
Wire Wire Line
	7400 3750 7150 3750
Text GLabel 7400 3750 2    39   Input ~ 0
TMS
Wire Wire Line
	7400 3650 7150 3650
Text GLabel 7400 3650 2    39   Input ~ 0
TDI
Wire Wire Line
	8850 3450 9100 3450
Text GLabel 8850 3450 0    39   Output ~ 0
TCK
Wire Wire Line
	8850 3550 9100 3550
Text GLabel 8850 3550 0    39   Output ~ 0
TMS
Wire Wire Line
	8850 3750 9100 3750
Text GLabel 8850 3750 0    39   Output ~ 0
TDI
Wire Wire Line
	8850 3650 9100 3650
Text GLabel 8850 3650 0    39   Input ~ 0
TDO
$Comp
L custom_chips:CSC U?
U 1 1 5E4F0787
P 6550 2900
F 0 "U?" H 6550 4381 50  0000 C CNN
F 1 "CSC" H 6550 4290 50  0000 C CNN
F 2 "Package_QFP:TQFP-44_10x10mm_P0.8mm" H 6550 2850 50  0001 C CNN
F 3 "https://www.xilinx.com/support/documentation/data_sheets/ds057.pdf" H 6550 2850 50  0001 C CNN
	1    6550 2900
	1    0    0    -1  
$EndComp
$EndSCHEMATC
