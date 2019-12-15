EESchema Schematic File Version 4
LIBS:cole-2-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 7
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
P 6150 3000
F 0 "U?" H 6450 4050 60  0000 C CNN
F 1 "WD65C22S" H 6450 1700 39  0000 C CNN
F 2 "Package_DIP:DIP-40_W25.4mm_Socket" H 5650 3300 60  0001 C CNN
F 3 "" H 5650 3300 60  0000 C CNN
	1    6150 3000
	1    0    0    -1  
$EndComp
Text GLabel 5300 3400 0    39   BiDi ~ 0
D0
Wire Wire Line
	5550 3400 5300 3400
Text GLabel 5300 3500 0    39   BiDi ~ 0
D1
Wire Wire Line
	5550 3500 5300 3500
Text GLabel 5300 3600 0    39   BiDi ~ 0
D2
Wire Wire Line
	5550 3600 5300 3600
Text GLabel 5300 3700 0    39   BiDi ~ 0
D3
Wire Wire Line
	5550 3700 5300 3700
Text GLabel 5300 3800 0    39   BiDi ~ 0
D4
Wire Wire Line
	5550 3800 5300 3800
Text GLabel 5300 3900 0    39   BiDi ~ 0
D5
Wire Wire Line
	5550 3900 5300 3900
Text GLabel 5300 4000 0    39   BiDi ~ 0
D6
Wire Wire Line
	5550 4000 5300 4000
Text GLabel 5300 4100 0    39   BiDi ~ 0
D7
Wire Wire Line
	5550 4100 5300 4100
Text GLabel 5300 2500 0    39   Input ~ 0
~IO1SEL
Wire Wire Line
	5550 2500 5300 2500
Text GLabel 5300 2000 0    39   Input ~ 0
ϕ2
Wire Wire Line
	5550 2000 5300 2000
Text GLabel 5300 3200 0    39   Input ~ 0
R~W
Wire Wire Line
	5550 3200 5300 3200
Text GLabel 5300 1900 0    39   Input ~ 0
~RESET
Wire Wire Line
	5550 1900 5300 1900
Text GLabel 5300 2200 0    39   Output ~ 0
~INTR1
Wire Wire Line
	5550 2200 5300 2200
Text GLabel 5300 2700 0    39   Input ~ 0
A0
Wire Wire Line
	5550 2700 5300 2700
Text GLabel 5300 2800 0    39   Input ~ 0
A1
Wire Wire Line
	5550 2800 5300 2800
Text GLabel 5300 2900 0    39   Input ~ 0
A2
Wire Wire Line
	5550 2900 5300 2900
Text GLabel 5300 3000 0    39   Input ~ 0
A3
Wire Wire Line
	5550 3000 5300 3000
$Comp
L power:GND #PWR?
U 1 1 5B936194
P 6150 4600
F 0 "#PWR?" H 6150 4350 50  0001 C CNN
F 1 "GND" H 6155 4427 50  0000 C CNN
F 2 "" H 6150 4600 50  0001 C CNN
F 3 "" H 6150 4600 50  0001 C CNN
	1    6150 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4450 6150 4600
Wire Wire Line
	5550 2400 4750 2400
Wire Wire Line
	4750 2400 4750 2300
Text GLabel 7000 1900 2    39   BiDi ~ 0
PA0
Wire Wire Line
	7000 1900 6750 1900
Text GLabel 7000 2000 2    39   BiDi ~ 0
PA1
Wire Wire Line
	7000 2000 6750 2000
Text GLabel 7000 2100 2    39   BiDi ~ 0
PA2
Wire Wire Line
	7000 2100 6750 2100
Text GLabel 7000 2200 2    39   BiDi ~ 0
PA3
Wire Wire Line
	7000 2200 6750 2200
Text GLabel 7000 2300 2    39   BiDi ~ 0
PA4
Wire Wire Line
	7000 2300 6750 2300
Text GLabel 7000 2400 2    39   BiDi ~ 0
PA5
Wire Wire Line
	7000 2400 6750 2400
Text GLabel 7000 2500 2    39   BiDi ~ 0
PA6
Wire Wire Line
	7000 2500 6750 2500
Text GLabel 7000 2600 2    39   BiDi ~ 0
PA7
Wire Wire Line
	7000 2600 6750 2600
Text GLabel 7000 3100 2    39   BiDi ~ 0
PB0
Wire Wire Line
	7000 3100 6750 3100
Text GLabel 7000 3200 2    39   BiDi ~ 0
PB1
Wire Wire Line
	7000 3200 6750 3200
Text GLabel 7000 3300 2    39   BiDi ~ 0
PB2
Wire Wire Line
	7000 3300 6750 3300
Text GLabel 7000 3400 2    39   BiDi ~ 0
PB3
Wire Wire Line
	7000 3400 6750 3400
Text GLabel 7000 3500 2    39   BiDi ~ 0
PB4
Wire Wire Line
	7000 3500 6750 3500
Text GLabel 7000 3600 2    39   BiDi ~ 0
PB5
Wire Wire Line
	7000 3600 6750 3600
Text GLabel 7000 3700 2    39   BiDi ~ 0
PB6
Wire Wire Line
	7000 3700 6750 3700
Text GLabel 7000 3800 2    39   BiDi ~ 0
PB7
Wire Wire Line
	7000 3800 6750 3800
Text GLabel 7000 4000 2    39   BiDi ~ 0
CB1
Wire Wire Line
	7000 4000 6750 4000
Text GLabel 7000 4100 2    39   BiDi ~ 0
CB2
Wire Wire Line
	7000 4100 6750 4100
Text GLabel 7000 2800 2    39   BiDi ~ 0
CA1
Wire Wire Line
	7000 2800 6750 2800
Text GLabel 7000 2900 2    39   BiDi ~ 0
CA2
Wire Wire Line
	7000 2900 6750 2900
$Comp
L power:+3V3 #PWR?
U 1 1 5D495A6A
P 6150 1150
F 0 "#PWR?" H 6150 1000 50  0001 C CNN
F 1 "+3V3" H 6165 1323 50  0000 C CNN
F 2 "" H 6150 1150 50  0001 C CNN
F 3 "" H 6150 1150 50  0001 C CNN
	1    6150 1150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5D5787D3
P 4750 2300
F 0 "#PWR?" H 4750 2150 50  0001 C CNN
F 1 "+3V3" H 4765 2473 50  0000 C CNN
F 2 "" H 4750 2300 50  0001 C CNN
F 3 "" H 4750 2300 50  0001 C CNN
	1    4750 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1150 6150 1300
$Comp
L Device:C_Small C?
U 1 1 5E39E5FA
P 5650 1300
AR Path="/5B877537/5E39E5FA" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5E39E5FA" Ref="C?"  Part="1" 
F 0 "C?" V 5550 1300 50  0000 C CNN
F 1 "0.1uf" V 5750 1300 50  0000 C CNN
F 2 "" H 5650 1300 50  0001 C CNN
F 3 "~" H 5650 1300 50  0001 C CNN
	1    5650 1300
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 1300 6150 1300
$Comp
L power:GND #PWR?
U 1 1 5E39E601
P 5350 1400
AR Path="/5B877537/5E39E601" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5E39E601" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 5350 1150 50  0001 C CNN
F 1 "GND" H 5355 1227 50  0000 C CNN
F 2 "" H 5350 1400 50  0001 C CNN
F 3 "" H 5350 1400 50  0001 C CNN
	1    5350 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 1300 5350 1300
Wire Wire Line
	5350 1300 5350 1400
Connection ~ 6150 1300
Wire Wire Line
	6150 1300 6150 1550
$Comp
L custom_chips:SPI65B U?
U 1 1 5E4D9D0C
P 9100 3050
F 0 "U?" H 9450 4300 50  0000 C CNN
F 1 "SPI65B" H 9100 3050 50  0000 C CNN
F 2 "Package_QFP:TQFP-44_10x10mm_P0.8mm" H 9150 4500 50  0001 C CNN
F 3 "https://www.xilinx.com/support/documentation/data_sheets/ds057.pdf" H 9100 3000 50  0001 C CNN
	1    9100 3050
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5E4F5F46
P 9100 1100
AR Path="/5B7D0B8D/5E4F5F46" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5E4F5F46" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 9100 950 50  0001 C CNN
F 1 "+3V3" H 9115 1273 50  0000 C CNN
F 2 "" H 9100 1100 50  0001 C CNN
F 3 "" H 9100 1100 50  0001 C CNN
	1    9100 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 1100 9100 1200
Wire Wire Line
	8950 1750 8950 1550
Wire Wire Line
	8950 1400 9100 1400
Connection ~ 9100 1400
Wire Wire Line
	9100 1400 9100 1750
Wire Wire Line
	9100 1400 9250 1400
$Comp
L Device:C_Small C?
U 1 1 5E4F5F52
P 8650 1200
AR Path="/5B7D0B8D/5E4F5F52" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5E4F5F52" Ref="C?"  Part="1" 
F 0 "C?" V 8550 1200 50  0000 C CNN
F 1 "0.1uf" V 8750 1200 50  0000 C CNN
F 2 "" H 8650 1200 50  0001 C CNN
F 3 "~" H 8650 1200 50  0001 C CNN
	1    8650 1200
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5E4F5F58
P 8650 1550
AR Path="/5B7D0B8D/5E4F5F58" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5E4F5F58" Ref="C?"  Part="1" 
F 0 "C?" V 8550 1550 50  0000 C CNN
F 1 "0.1uf" V 8750 1550 50  0000 C CNN
F 2 "" H 8650 1550 50  0001 C CNN
F 3 "~" H 8650 1550 50  0001 C CNN
	1    8650 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	8750 1550 8950 1550
Connection ~ 8950 1550
Wire Wire Line
	8950 1550 8950 1400
Wire Wire Line
	8750 1200 9100 1200
Connection ~ 9100 1200
Wire Wire Line
	9100 1200 9100 1400
$Comp
L power:GND #PWR?
U 1 1 5E4F5F64
P 8250 1650
AR Path="/5B7D0B8D/5E4F5F64" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5E4F5F64" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 8250 1400 50  0001 C CNN
F 1 "GND" H 8255 1477 50  0000 C CNN
F 2 "" H 8250 1650 50  0001 C CNN
F 3 "" H 8250 1650 50  0001 C CNN
	1    8250 1650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E4F5F6A
P 9950 1650
AR Path="/5B7D0B8D/5E4F5F6A" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5E4F5F6A" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 9950 1400 50  0001 C CNN
F 1 "GND" H 9955 1477 50  0000 C CNN
F 2 "" H 9950 1650 50  0001 C CNN
F 3 "" H 9950 1650 50  0001 C CNN
	1    9950 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 1650 8250 1550
Wire Wire Line
	8250 1200 8550 1200
Wire Wire Line
	8550 1550 8250 1550
Connection ~ 8250 1550
Wire Wire Line
	8250 1550 8250 1200
Connection ~ 9250 1550
Wire Wire Line
	9250 1550 9250 1750
Wire Wire Line
	9250 1400 9250 1550
Wire Wire Line
	9950 1550 9950 1650
Wire Wire Line
	9650 1550 9950 1550
Wire Wire Line
	9250 1550 9450 1550
$Comp
L Device:C_Small C?
U 1 1 5E4F5F7B
P 9550 1550
AR Path="/5B7D0B8D/5E4F5F7B" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5E4F5F7B" Ref="C?"  Part="1" 
F 0 "C?" V 9450 1550 50  0000 C CNN
F 1 "0.1uf" V 9650 1550 50  0000 C CNN
F 2 "" H 9550 1550 50  0001 C CNN
F 3 "~" H 9550 1550 50  0001 C CNN
	1    9550 1550
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E4FE01E
P 9100 4700
AR Path="/5B7D0B8D/5E4FE01E" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5E4FE01E" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 9100 4450 50  0001 C CNN
F 1 "GND" H 9105 4527 50  0000 C CNN
F 2 "" H 9100 4700 50  0001 C CNN
F 3 "" H 9100 4700 50  0001 C CNN
	1    9100 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 4350 9100 4500
Wire Wire Line
	8950 4350 8950 4500
Wire Wire Line
	8950 4500 9100 4500
Wire Wire Line
	9250 4500 9250 4350
Connection ~ 9100 4500
Wire Wire Line
	9100 4500 9100 4700
Wire Wire Line
	9100 4500 9250 4500
Text GLabel 9950 4100 2    39   Output ~ 0
TDO
Wire Wire Line
	9950 4100 9700 4100
Wire Wire Line
	9950 4000 9700 4000
Text GLabel 9950 4000 2    39   Input ~ 0
TCK
Wire Wire Line
	9950 3900 9700 3900
Text GLabel 9950 3900 2    39   Input ~ 0
TMS
Wire Wire Line
	9950 3800 9700 3800
Text GLabel 9950 3800 2    39   Input ~ 0
SPI65_TDI
Text GLabel 8250 2000 0    39   BiDi ~ 0
D0
Wire Wire Line
	8250 2000 8500 2000
Text GLabel 8250 2100 0    39   BiDi ~ 0
D1
Wire Wire Line
	8250 2100 8500 2100
Text GLabel 8250 2200 0    39   BiDi ~ 0
D2
Wire Wire Line
	8250 2200 8500 2200
Text GLabel 8250 2300 0    39   BiDi ~ 0
D3
Wire Wire Line
	8250 2300 8500 2300
Text GLabel 8250 2400 0    39   BiDi ~ 0
D4
Wire Wire Line
	8250 2400 8500 2400
Text GLabel 8250 2500 0    39   BiDi ~ 0
D5
Wire Wire Line
	8250 2500 8500 2500
Text GLabel 8250 2600 0    39   BiDi ~ 0
D6
Wire Wire Line
	8250 2600 8500 2600
Text GLabel 8250 2700 0    39   BiDi ~ 0
D7
Wire Wire Line
	8250 2700 8500 2700
Text GLabel 8250 3250 0    39   Input ~ 0
A0
Wire Wire Line
	8250 3250 8500 3250
Wire Wire Line
	8250 3350 8500 3350
Text GLabel 8250 3350 0    39   Input ~ 0
A1
Text GLabel 8250 2900 0    39   Input ~ 0
ϕ2
Wire Wire Line
	8500 2900 8250 2900
Text GLabel 8250 3850 0    39   Input ~ 0
~RESET
Wire Wire Line
	8500 3850 8250 3850
Text GLabel 8250 3750 0    39   Output ~ 0
~INTR2
Wire Wire Line
	8500 3750 8250 3750
Text GLabel 8250 3550 0    39   Input ~ 0
~IO2SEL
Wire Wire Line
	8500 3550 8250 3550
Wire Wire Line
	8500 3450 7700 3450
Wire Wire Line
	7700 3450 7700 3350
$Comp
L power:+3V3 #PWR?
U 1 1 5E54EB56
P 7700 3350
F 0 "#PWR?" H 7700 3200 50  0001 C CNN
F 1 "+3V3" H 7715 3523 50  0000 C CNN
F 2 "" H 7700 3350 50  0001 C CNN
F 3 "" H 7700 3350 50  0001 C CNN
	1    7700 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 2000 9700 2000
Text GLabel 9950 2000 2    39   Input ~ 0
SERCLK
Text GLabel 8250 3150 0    39   Input ~ 0
R~W
Wire Wire Line
	8500 3150 8250 3150
Wire Wire Line
	9950 2200 9700 2200
Text GLabel 9950 2200 2    39   Input ~ 0
SPI_INT0
Wire Wire Line
	9950 2300 9700 2300
Text GLabel 9950 2300 2    39   Input ~ 0
SPI_INT1
Wire Wire Line
	9950 2400 9700 2400
Text GLabel 9950 2400 2    39   Input ~ 0
SPI_INT2
Wire Wire Line
	9950 2500 9700 2500
Text GLabel 9950 2500 2    39   Input ~ 0
SPI_INT3
Wire Wire Line
	9950 2750 9700 2750
Text GLabel 9950 2750 2    39   Input ~ 0
SPI_MISO
Wire Wire Line
	9950 2850 9700 2850
Text GLabel 9950 2850 2    39   Output ~ 0
SPI_MOSI
Wire Wire Line
	9950 2950 9700 2950
Text GLabel 9950 2950 2    39   Output ~ 0
SPI_SCLK
Wire Wire Line
	9950 3100 9700 3100
Text GLabel 9950 3100 2    39   Output ~ 0
SPI_SS0
Wire Wire Line
	9950 3200 9700 3200
Text GLabel 9950 3200 2    39   Output ~ 0
SPI_SS1
Wire Wire Line
	9950 3300 9700 3300
Text GLabel 9950 3300 2    39   Output ~ 0
SPI_SS2
Wire Wire Line
	9950 3400 9700 3400
Text GLabel 9950 3400 2    39   Output ~ 0
SPI_SS3
$Comp
L SC28L92:SC28L92 U?
U 1 1 5DFC88C0
P 2300 3000
AR Path="/5B9337AE/5DFC88C0" Ref="U?"  Part="1" 
AR Path="/5D58F4B4/5DFC88C0" Ref="U?"  Part="1" 
F 0 "U?" H 2550 4300 59  0000 C CNN
F 1 "SC28L92" V 2300 2950 39  0000 C CNN
F 2 "Package_LCC:PLCC-44_THT-Socket" H 3300 4550 39  0001 C CNN
F 3 "" H 2300 3000 39  0001 C CNN
	1    2300 3000
	1    0    0    -1  
$EndComp
Text GLabel 1400 1850 0    39   Input ~ 0
A0
Wire Wire Line
	1400 1850 1650 1850
Text GLabel 1400 1950 0    39   Input ~ 0
A1
Wire Wire Line
	1400 1950 1650 1950
Text GLabel 1400 2050 0    39   Input ~ 0
A2
Wire Wire Line
	1400 2050 1650 2050
Text GLabel 1400 2150 0    39   Input ~ 0
A3
Wire Wire Line
	1400 2150 1650 2150
Text GLabel 1400 2350 0    39   BiDi ~ 0
D0
Wire Wire Line
	1400 2350 1650 2350
Text GLabel 1400 2450 0    39   BiDi ~ 0
D1
Wire Wire Line
	1400 2450 1650 2450
Text GLabel 1400 2550 0    39   BiDi ~ 0
D2
Wire Wire Line
	1400 2550 1650 2550
Text GLabel 1400 2650 0    39   BiDi ~ 0
D3
Wire Wire Line
	1400 2650 1650 2650
Text GLabel 1400 2750 0    39   BiDi ~ 0
D4
Wire Wire Line
	1400 2750 1650 2750
Text GLabel 1400 2850 0    39   BiDi ~ 0
D5
Wire Wire Line
	1400 2850 1650 2850
Text GLabel 1400 2950 0    39   BiDi ~ 0
D6
Wire Wire Line
	1400 2950 1650 2950
Text GLabel 1400 3050 0    39   BiDi ~ 0
D7
Wire Wire Line
	1400 3050 1650 3050
Text GLabel 1400 3250 0    39   Input ~ 0
~IO3SEL
Wire Wire Line
	1400 3250 1650 3250
Text GLabel 1400 3350 0    39   Input ~ 0
~RD
Wire Wire Line
	1400 3350 1650 3350
Text GLabel 1400 3450 0    39   Input ~ 0
~WR
Wire Wire Line
	1400 3450 1650 3450
Text GLabel 1400 3650 0    39   Input ~ 0
~INTR3
Wire Wire Line
	1400 3650 1650 3650
Text GLabel 1400 3550 0    39   Input ~ 0
RESET
Wire Wire Line
	1400 3550 1650 3550
NoConn ~ 1650 4100
Text GLabel 3200 1850 2    39   Input ~ 0
RxDA
Wire Wire Line
	2950 1850 3200 1850
Text GLabel 3200 2150 2    39   Input ~ 0
RxDB
Wire Wire Line
	2950 2150 3200 2150
Text GLabel 3200 1950 2    39   Output ~ 0
TxDA
Wire Wire Line
	2950 1950 3200 1950
Text GLabel 3200 2250 2    39   Output ~ 0
TxDB
Wire Wire Line
	2950 2250 3200 2250
Text GLabel 3200 3500 2    39   Input ~ 0
CTSA
Wire Wire Line
	2950 3500 3200 3500
Text GLabel 3200 3600 2    39   Input ~ 0
CTSB
Wire Wire Line
	2950 3600 3200 3600
Text GLabel 3200 2550 2    39   Output ~ 0
RTSA
Wire Wire Line
	2950 2550 3200 2550
Text GLabel 3200 2650 2    39   Output ~ 0
RTSB
Wire Wire Line
	2950 2650 3200 2650
Text GLabel 3200 3700 2    39   Input ~ 0
DCDA
Wire Wire Line
	2950 3700 3200 3700
Text GLabel 3200 3800 2    39   Input ~ 0
DCDB
Wire Wire Line
	2950 3800 3200 3800
Text GLabel 3200 4000 2    39   Input ~ 0
DSRA
Wire Wire Line
	2950 4000 3200 4000
Text GLabel 3200 4100 2    39   Input ~ 0
DSRB
Wire Wire Line
	2950 4100 3200 4100
Text GLabel 3200 2750 2    39   Output ~ 0
DTRA
Wire Wire Line
	2950 2750 3200 2750
Text GLabel 3200 2850 2    39   Output ~ 0
DTRB
Wire Wire Line
	2950 2850 3200 2850
NoConn ~ 2950 2950
NoConn ~ 2950 3050
NoConn ~ 2950 3150
NoConn ~ 1650 3950
NoConn ~ 2950 3900
$Comp
L osc:Osc_8pin U?
U 1 1 5DFC890A
P 2300 6150
AR Path="/5B9337AE/5DFC890A" Ref="U?"  Part="1" 
AR Path="/5D58F4B4/5DFC890A" Ref="U?"  Part="1" 
F 0 "U?" H 2072 6150 60  0000 R CNN
F 1 "ASFL1-3.6864MHZ-EK-T" H 1500 5750 60  0000 C CNN
F 2 "" H 2300 6150 60  0001 C CNN
F 3 "" H 2300 6150 60  0001 C CNN
	1    2300 6150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DFC8910
P 2300 6650
AR Path="/5B7D0B8D/5DFC8910" Ref="#PWR?"  Part="1" 
AR Path="/5C1871C9/5DFC8910" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC8910" Ref="#PWR?"  Part="1" 
AR Path="/5D58F4B4/5DFC8910" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2300 6400 50  0001 C CNN
F 1 "GND" H 2305 6477 50  0000 C CNN
F 2 "" H 2300 6650 50  0001 C CNN
F 3 "" H 2300 6650 50  0001 C CNN
	1    2300 6650
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5DFC8916
P 2300 5450
AR Path="/5D58F4B4/5DFC8916" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC8916" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2300 5300 50  0001 C CNN
F 1 "+3V3" H 2315 5623 50  0000 C CNN
F 2 "" H 2300 5450 50  0001 C CNN
F 3 "" H 2300 5450 50  0001 C CNN
	1    2300 5450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DFC891C
P 2300 4500
AR Path="/5D58F4B4/5DFC891C" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC891C" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2300 4250 50  0001 C CNN
F 1 "GND" H 2305 4327 50  0000 C CNN
F 2 "" H 2300 4500 50  0001 C CNN
F 3 "" H 2300 4500 50  0001 C CNN
	1    2300 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 3850 1350 3850
Wire Wire Line
	1350 3850 1350 5150
Wire Wire Line
	1350 5150 3200 5150
Wire Wire Line
	3200 5150 3200 6150
Wire Wire Line
	3200 6150 2700 6150
NoConn ~ 2950 3250
$Comp
L power:+3V3 #PWR?
U 1 1 5DFC8928
P 2300 1050
AR Path="/5D58F4B4/5DFC8928" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC8928" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2300 900 50  0001 C CNN
F 1 "+3V3" H 2315 1223 50  0000 C CNN
F 2 "" H 2300 1050 50  0001 C CNN
F 3 "" H 2300 1050 50  0001 C CNN
	1    2300 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 1050 2300 1200
$Comp
L Device:C_Small C?
U 1 1 5DFC892F
P 1800 1200
AR Path="/5B877537/5DFC892F" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5DFC892F" Ref="C?"  Part="1" 
AR Path="/5D58F4B4/5DFC892F" Ref="C?"  Part="1" 
F 0 "C?" V 1700 1200 50  0000 C CNN
F 1 "0.1uf" V 1900 1200 50  0000 C CNN
F 2 "" H 1800 1200 50  0001 C CNN
F 3 "~" H 1800 1200 50  0001 C CNN
	1    1800 1200
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 1200 2300 1200
$Comp
L power:GND #PWR?
U 1 1 5DFC8936
P 1500 1300
AR Path="/5B877537/5DFC8936" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC8936" Ref="#PWR?"  Part="1" 
AR Path="/5D58F4B4/5DFC8936" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 1500 1050 50  0001 C CNN
F 1 "GND" H 1505 1127 50  0000 C CNN
F 2 "" H 1500 1300 50  0001 C CNN
F 3 "" H 1500 1300 50  0001 C CNN
	1    1500 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1200 1500 1200
Wire Wire Line
	1500 1200 1500 1300
Connection ~ 2300 1200
Wire Wire Line
	2300 1200 2300 1450
Text GLabel 3450 6150 2    39   Output ~ 0
SERCLK
Wire Wire Line
	3200 6150 3450 6150
Connection ~ 3200 6150
Wire Wire Line
	2300 5450 2300 5600
$Comp
L Device:C_Small C?
U 1 1 5DFC8944
P 1800 5600
AR Path="/5B877537/5DFC8944" Ref="C?"  Part="1" 
AR Path="/5B9337AE/5DFC8944" Ref="C?"  Part="1" 
AR Path="/5D58F4B4/5DFC8944" Ref="C?"  Part="1" 
F 0 "C?" V 1700 5600 50  0000 C CNN
F 1 "0.1uf" V 1900 5600 50  0000 C CNN
F 2 "" H 1800 5600 50  0001 C CNN
F 3 "~" H 1800 5600 50  0001 C CNN
	1    1800 5600
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 5600 2300 5600
$Comp
L power:GND #PWR?
U 1 1 5DFC894B
P 1500 5700
AR Path="/5B877537/5DFC894B" Ref="#PWR?"  Part="1" 
AR Path="/5B9337AE/5DFC894B" Ref="#PWR?"  Part="1" 
AR Path="/5D58F4B4/5DFC894B" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 1500 5450 50  0001 C CNN
F 1 "GND" H 1505 5527 50  0000 C CNN
F 2 "" H 1500 5700 50  0001 C CNN
F 3 "" H 1500 5700 50  0001 C CNN
	1    1500 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 5600 1500 5600
Wire Wire Line
	1500 5600 1500 5700
Connection ~ 2300 5600
Wire Wire Line
	2300 5600 2300 5650
$EndSCHEMATC
