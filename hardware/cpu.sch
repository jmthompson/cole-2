EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 8
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
P 3900 3200
F 0 "U?" H 4100 4600 60  0000 C CNN
F 1 "WD65C816S" H 4200 1800 39  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket" H 3400 2300 60  0001 C CNN
F 3 "" H 3400 2300 60  0000 C CNN
	1    3900 3200
	1    0    0    -1  
$EndComp
Text GLabel 4750 2000 2    39   Output ~ 0
A0
Wire Wire Line
	4750 2000 4500 2000
Text GLabel 4750 2100 2    39   Output ~ 0
A1
Wire Wire Line
	4750 2100 4500 2100
Text GLabel 4750 2200 2    39   Output ~ 0
A2
Wire Wire Line
	4750 2200 4500 2200
Text GLabel 4750 2300 2    39   Output ~ 0
A3
Wire Wire Line
	4750 2300 4500 2300
Text GLabel 4750 2400 2    39   Output ~ 0
A4
Wire Wire Line
	4750 2400 4500 2400
Text GLabel 4750 2500 2    39   Output ~ 0
A5
Wire Wire Line
	4750 2500 4500 2500
Text GLabel 4750 2600 2    39   Output ~ 0
A6
Wire Wire Line
	4750 2600 4500 2600
Text GLabel 4750 2700 2    39   Output ~ 0
A7
Wire Wire Line
	4750 2700 4500 2700
Text GLabel 4750 2800 2    39   Output ~ 0
A8
Wire Wire Line
	4750 2800 4500 2800
Text GLabel 4750 2900 2    39   Output ~ 0
A9
Wire Wire Line
	4750 2900 4500 2900
Text GLabel 4750 3000 2    39   Output ~ 0
A10
Wire Wire Line
	4750 3000 4500 3000
Text GLabel 4750 3100 2    39   Output ~ 0
A11
Wire Wire Line
	4750 3100 4500 3100
Text GLabel 4750 3200 2    39   Output ~ 0
A12
Wire Wire Line
	4750 3200 4500 3200
Text GLabel 4750 3300 2    39   Output ~ 0
A13
Wire Wire Line
	4750 3300 4500 3300
Text GLabel 4750 3400 2    39   Output ~ 0
A14
Wire Wire Line
	4750 3400 4500 3400
Text GLabel 4750 3500 2    39   Output ~ 0
A15
Wire Wire Line
	4750 3500 4500 3500
Text GLabel 3050 2300 0    39   Input ~ 0
ϕ2
Wire Wire Line
	3300 2300 3050 2300
Text GLabel 3050 2800 0    39   Input ~ 0
~IRQ
Wire Wire Line
	3300 2800 3050 2800
Text GLabel 3050 2900 0    39   Input ~ 0
~NMI
Wire Wire Line
	3300 2900 3050 2900
Text GLabel 3050 3200 0    39   Output ~ 0
R~W
Wire Wire Line
	3300 3200 3050 3200
NoConn ~ 3300 4000
Text GLabel 3050 3800 0    39   Output ~ 0
VDA
Wire Wire Line
	3300 3800 3050 3800
NoConn ~ 3300 4100
NoConn ~ 3300 4300
Text GLabel 4750 3700 2    39   BiDi ~ 0
D0
Text GLabel 4750 3800 2    39   BiDi ~ 0
D1
Text GLabel 4750 3900 2    39   BiDi ~ 0
D2
Text GLabel 4750 4000 2    39   BiDi ~ 0
D3
Text GLabel 4750 4100 2    39   BiDi ~ 0
D4
Text GLabel 4750 4200 2    39   BiDi ~ 0
D5
Text GLabel 4750 4300 2    39   BiDi ~ 0
D6
Text GLabel 4750 4400 2    39   BiDi ~ 0
D7
Text GLabel 3050 3600 0    39   Input ~ 0
BE
Wire Wire Line
	3300 3600 3050 3600
Text GLabel 3050 2000 0    39   Input ~ 0
~RESET
Wire Wire Line
	3300 2000 3050 2000
Text GLabel 3050 3500 0    39   BiDi ~ 0
RDY
Wire Wire Line
	3050 3500 3300 3500
Text GLabel 3050 2700 0    39   Input ~ 0
~ABORT
Wire Wire Line
	3050 2700 3300 2700
NoConn ~ 3300 4400
Wire Wire Line
	5150 6400 5150 6550
Wire Wire Line
	5400 6550 5150 6550
Text GLabel 6050 6250 2    39   BiDi ~ 0
RDY
Wire Wire Line
	5800 6250 6050 6250
Text GLabel 6050 6350 2    39   Output ~ 0
~ABORT
Wire Wire Line
	5800 6350 6050 6350
Text GLabel 6050 6550 2    39   Output ~ 0
BE
Wire Wire Line
	5800 6550 6050 6550
Text GLabel 7050 3550 0    39   Input ~ 0
A11
Wire Wire Line
	7050 3550 7300 3550
Text GLabel 7050 3950 0    39   Input ~ 0
A15
Wire Wire Line
	7050 3650 7300 3650
Text GLabel 7050 4050 0    39   Output ~ 0
A16
Wire Wire Line
	7050 3750 7300 3750
Text GLabel 7050 4150 0    39   Output ~ 0
A17
Wire Wire Line
	7050 3850 7300 3850
Text GLabel 7050 4250 0    39   Output ~ 0
A18
Wire Wire Line
	7050 3950 7300 3950
Wire Wire Line
	7050 4050 7300 4050
Wire Wire Line
	7050 4150 7300 4150
Text GLabel 7050 3650 0    39   Input ~ 0
A12
Wire Wire Line
	7050 4250 7300 4250
Text GLabel 7050 3750 0    39   Input ~ 0
A13
Text GLabel 7050 3850 0    39   Input ~ 0
A14
Text GLabel 8750 3650 2    39   Output ~ 0
ϕ2
Wire Wire Line
	8750 3650 8500 3650
Text GLabel 8750 3550 2    39   Input ~ 0
VDA
Wire Wire Line
	8750 3550 8500 3550
Text GLabel 8750 3750 2    39   Input ~ 0
R~W
Wire Wire Line
	8750 3750 8500 3750
Text GLabel 8750 2800 2    39   Output ~ 0
~ROMCS
Wire Wire Line
	8500 2800 8750 2800
Text GLabel 8750 2900 2    39   Output ~ 0
~RAM1CS
Wire Wire Line
	8500 2900 8750 2900
Text GLabel 8750 3000 2    39   Output ~ 0
~RAM2CS
Wire Wire Line
	8500 3000 8750 3000
Text GLabel 8750 2150 2    39   Output ~ 0
~RD
Wire Wire Line
	8500 2150 8750 2150
Text GLabel 8750 2250 2    39   Output ~ 0
~WR
Wire Wire Line
	8500 2250 8750 2250
Text GLabel 3050 3700 0    39   Output ~ 0
VPA
Wire Wire Line
	3300 3700 3050 3700
$Comp
L Device:R_Network07_US RN?
U 1 1 5BAB6B12
P 5600 6250
F 0 "RN?" V 5900 6250 50  0000 C CNN
F 1 "4608X-101-332LF" V 5150 6200 50  0000 C CNN
F 2 "Resistor_THT:R_Array_SIP8" V 5975 6250 50  0001 C CNN
F 3 "https://www.mouser.com/datasheet/2/54/4600x-776645.pdf" H 5600 6250 50  0001 C CNN
	1    5600 6250
	0    -1   -1   0   
$EndComp
Text GLabel 6050 5950 2    39   Output ~ 0
~INTR3
Wire Wire Line
	5800 5950 6050 5950
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
Text GLabel 7050 3250 0    39   Input ~ 0
A5
Wire Wire Line
	7050 3250 7300 3250
Wire Wire Line
	7050 3350 7300 3350
Text GLabel 7050 3350 0    39   Input ~ 0
A6
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
P 3900 1250
F 0 "#PWR?" H 3900 1100 50  0001 C CNN
F 1 "+3V3" H 3915 1423 50  0000 C CNN
F 2 "" H 3900 1250 50  0001 C CNN
F 3 "" H 3900 1250 50  0001 C CNN
	1    3900 1250
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5D481D84
P 5150 6400
F 0 "#PWR?" H 5150 6250 50  0001 C CNN
F 1 "+3V3" H 5165 6573 50  0000 C CNN
F 2 "" H 5150 6400 50  0001 C CNN
F 3 "" H 5150 6400 50  0001 C CNN
	1    5150 6400
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
	4500 3700 4750 3700
Wire Wire Line
	4500 3800 4750 3800
Wire Wire Line
	4500 3900 4750 3900
Wire Wire Line
	4500 4000 4750 4000
Wire Wire Line
	4500 4100 4750 4100
Wire Wire Line
	4500 4200 4750 4200
Wire Wire Line
	4500 4300 4750 4300
Wire Wire Line
	4500 4400 4750 4400
Wire Wire Line
	5800 6450 6050 6450
Text GLabel 6050 6450 2    39   Output ~ 0
~NMI
Wire Wire Line
	5800 6150 6050 6150
Text GLabel 6050 6150 2    39   Output ~ 0
~RESET
$Comp
L power:+3V3 #PWR?
U 1 1 5DF82880
P 7900 1250
F 0 "#PWR?" H 7900 1100 50  0001 C CNN
F 1 "+3V3" H 7915 1423 50  0000 C CNN
F 2 "" H 7900 1250 50  0001 C CNN
F 3 "" H 7900 1250 50  0001 C CNN
	1    7900 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 1250 7900 1350
Wire Wire Line
	7750 1900 7750 1700
Wire Wire Line
	7750 1550 7900 1550
Connection ~ 7900 1550
Wire Wire Line
	7900 1550 7900 1900
Wire Wire Line
	7900 1550 8050 1550
$Comp
L Device:C_Small C?
U 1 1 5DF91781
P 7450 1350
F 0 "C?" V 7350 1350 50  0000 C CNN
F 1 "0.1uf" V 7550 1350 50  0000 C CNN
F 2 "" H 7450 1350 50  0001 C CNN
F 3 "~" H 7450 1350 50  0001 C CNN
	1    7450 1350
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5DF9B14E
P 7450 1700
F 0 "C?" V 7350 1700 50  0000 C CNN
F 1 "0.1uf" V 7550 1700 50  0000 C CNN
F 2 "" H 7450 1700 50  0001 C CNN
F 3 "~" H 7450 1700 50  0001 C CNN
	1    7450 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	7550 1700 7750 1700
Connection ~ 7750 1700
Wire Wire Line
	7750 1700 7750 1550
Wire Wire Line
	7550 1350 7900 1350
Connection ~ 7900 1350
Wire Wire Line
	7900 1350 7900 1550
$Comp
L power:GND #PWR?
U 1 1 5DFB219F
P 7050 1800
F 0 "#PWR?" H 7050 1550 50  0001 C CNN
F 1 "GND" H 7055 1627 50  0000 C CNN
F 2 "" H 7050 1800 50  0001 C CNN
F 3 "" H 7050 1800 50  0001 C CNN
	1    7050 1800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DFB2934
P 8750 1800
F 0 "#PWR?" H 8750 1550 50  0001 C CNN
F 1 "GND" H 8755 1627 50  0000 C CNN
F 2 "" H 8750 1800 50  0001 C CNN
F 3 "" H 8750 1800 50  0001 C CNN
	1    8750 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1800 7050 1700
Wire Wire Line
	7050 1350 7350 1350
Wire Wire Line
	7350 1700 7050 1700
Connection ~ 7050 1700
Wire Wire Line
	7050 1700 7050 1350
Text GLabel 7050 2150 0    39   BiDi ~ 0
D0
Wire Wire Line
	7050 2150 7300 2150
Text GLabel 7050 2250 0    39   BiDi ~ 0
D1
Wire Wire Line
	7050 2250 7300 2250
Text GLabel 7050 2350 0    39   BiDi ~ 0
D2
Wire Wire Line
	7050 2350 7300 2350
Text GLabel 7050 2450 0    39   BiDi ~ 0
D3
Wire Wire Line
	7050 2450 7300 2450
Text GLabel 7050 2550 0    39   BiDi ~ 0
D4
Wire Wire Line
	7050 2550 7300 2550
Text GLabel 7050 2650 0    39   BiDi ~ 0
D5
Wire Wire Line
	7050 2650 7300 2650
Text GLabel 7050 2750 0    39   BiDi ~ 0
D6
Wire Wire Line
	7050 2750 7300 2750
Text GLabel 7050 2850 0    39   BiDi ~ 0
D7
Wire Wire Line
	7050 2850 7300 2850
$Comp
L power:GND #PWR?
U 1 1 5E009129
P 7900 4850
F 0 "#PWR?" H 7900 4600 50  0001 C CNN
F 1 "GND" H 7905 4677 50  0000 C CNN
F 2 "" H 7900 4850 50  0001 C CNN
F 3 "" H 7900 4850 50  0001 C CNN
	1    7900 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 4500 7900 4650
Wire Wire Line
	7750 4500 7750 4650
Wire Wire Line
	7750 4650 7900 4650
Wire Wire Line
	8050 4650 8050 4500
Connection ~ 7900 4650
Wire Wire Line
	7900 4650 7900 4850
Wire Wire Line
	7900 4650 8050 4650
Wire Wire Line
	3900 4750 3900 4850
$Comp
L power:GND #PWR0106
U 1 1 5B8020B3
P 3900 4850
F 0 "#PWR0106" H 3900 4600 50  0001 C CNN
F 1 "GND" H 3905 4677 50  0000 C CNN
F 2 "" H 3900 4850 50  0001 C CNN
F 3 "" H 3900 4850 50  0001 C CNN
	1    3900 4850
	1    0    0    -1  
$EndComp
Connection ~ 8050 1700
Wire Wire Line
	8050 1700 8050 1900
Wire Wire Line
	8050 1550 8050 1700
Wire Wire Line
	3900 1250 3900 1450
Wire Wire Line
	8750 1700 8750 1800
Wire Wire Line
	8450 1700 8750 1700
Wire Wire Line
	8050 1700 8250 1700
$Comp
L Device:C_Small C?
U 1 1 5DF9EB81
P 8350 1700
F 0 "C?" V 8250 1700 50  0000 C CNN
F 1 "0.1uf" V 8450 1700 50  0000 C CNN
F 2 "" H 8350 1700 50  0001 C CNN
F 3 "~" H 8350 1700 50  0001 C CNN
	1    8350 1700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E05DC06
P 4600 1550
F 0 "#PWR?" H 4600 1300 50  0001 C CNN
F 1 "GND" H 4605 1377 50  0000 C CNN
F 2 "" H 4600 1550 50  0001 C CNN
F 3 "" H 4600 1550 50  0001 C CNN
	1    4600 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1450 4600 1550
Wire Wire Line
	4300 1450 4600 1450
Wire Wire Line
	3900 1450 4100 1450
$Comp
L Device:C_Small C?
U 1 1 5E05DC0F
P 4200 1450
F 0 "C?" V 4100 1450 50  0000 C CNN
F 1 "0.1uf" V 4300 1450 50  0000 C CNN
F 2 "" H 4200 1450 50  0001 C CNN
F 3 "~" H 4200 1450 50  0001 C CNN
	1    4200 1450
	0    1    1    0   
$EndComp
Text GLabel 8750 3450 2    39   Output ~ 0
~RESET
Wire Wire Line
	8750 3450 8500 3450
Wire Wire Line
	8500 2650 8750 2650
Text GLabel 8750 2650 2    39   Output ~ 0
~IOSEL4
Wire Wire Line
	8500 2550 8750 2550
Text GLabel 8750 2550 2    39   Output ~ 0
~IOSEL3
Wire Wire Line
	8500 2450 8750 2450
Text GLabel 8750 2450 2    39   Output ~ 0
~IOSEL2
Wire Wire Line
	8500 2350 8750 2350
Text GLabel 8750 2350 2    39   Output ~ 0
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
Text GLabel 8750 4250 2    39   Output ~ 0
SPI65_TDI
Wire Wire Line
	8750 4250 8500 4250
Wire Wire Line
	8750 4150 8500 4150
Text GLabel 8750 4150 2    39   Input ~ 0
TCK
Wire Wire Line
	8750 4050 8500 4050
Text GLabel 8750 4050 2    39   Input ~ 0
TMS
Wire Wire Line
	8750 3950 8500 3950
Text GLabel 8750 3950 2    39   Input ~ 0
TDI
$Comp
L custom_chips:CSC U?
U 1 1 5E4F0787
P 7900 3200
F 0 "U?" H 7900 4681 50  0000 C CNN
F 1 "CSC" H 7900 4590 50  0000 C CNN
F 2 "Package_QFP:TQFP-44_10x10mm_P0.8mm" H 7900 3150 50  0001 C CNN
F 3 "https://www.xilinx.com/support/documentation/data_sheets/ds057.pdf" H 7900 3150 50  0001 C CNN
	1    7900 3200
	1    0    0    -1  
$EndComp
Connection ~ 3900 1450
Wire Wire Line
	3900 1450 3900 1650
Wire Wire Line
	5800 6050 6050 6050
Text GLabel 6050 6050 2    39   Output ~ 0
RESET
Text GLabel 8750 3300 2    39   Input ~ 0
RESET
Wire Wire Line
	8750 3300 8500 3300
Text GLabel 8750 3200 2    39   Input ~ 0
SYSCLK
Wire Wire Line
	8750 3200 8500 3200
$EndSCHEMATC
