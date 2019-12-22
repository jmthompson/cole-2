EESchema Schematic File Version 4
LIBS:cole-2-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 8
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
L Connector:Conn_ARM_JTAG_SWD_10 J?
U 1 1 5E0A8B14
P 2400 2150
AR Path="/5B7D0B8D/5E0A8B14" Ref="J?"  Part="1" 
AR Path="/5E07E1E4/5E0A8B14" Ref="J?"  Part="1" 
F 0 "J?" H 2700 2700 50  0000 R CNN
F 1 "JTAG" H 2250 2700 50  0000 R CNN
F 2 "Connector_IDC:IDC-Header_2x05_P2.54mm_Vertical" H 2400 2150 50  0001 C CNN
F 3 "http://infocenter.arm.com/help/topic/com.arm.doc.ddi0314h/DDI0314H_coresight_components_trm.pdf" V 2050 900 50  0001 C CNN
	1    2400 2150
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E0A8B1A
P 2400 2950
AR Path="/5B7D0B8D/5E0A8B1A" Ref="#PWR?"  Part="1" 
AR Path="/5E07E1E4/5E0A8B1A" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2400 2700 50  0001 C CNN
F 1 "GND" H 2405 2777 50  0000 C CNN
F 2 "" H 2400 2950 50  0001 C CNN
F 3 "" H 2400 2950 50  0001 C CNN
	1    2400 2950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2400 2750 2400 2850
Wire Wire Line
	2500 2750 2500 2850
Wire Wire Line
	2500 2850 2400 2850
Connection ~ 2400 2850
Wire Wire Line
	2400 2850 2400 2950
Wire Wire Line
	2400 1400 2400 1550
$Comp
L power:+3V3 #PWR?
U 1 1 5E0A8B26
P 2400 1400
AR Path="/5B7D0B8D/5E0A8B26" Ref="#PWR?"  Part="1" 
AR Path="/5E07E1E4/5E0A8B26" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 2400 1250 50  0001 C CNN
F 1 "+3V3" H 2415 1573 50  0000 C CNN
F 2 "" H 2400 1400 50  0001 C CNN
F 3 "" H 2400 1400 50  0001 C CNN
	1    2400 1400
	-1   0    0    -1  
$EndComp
NoConn ~ 1900 1850
Wire Wire Line
	1650 2050 1900 2050
Text GLabel 1650 2050 0    39   Output ~ 0
TCK
Wire Wire Line
	1650 2150 1900 2150
Text GLabel 1650 2150 0    39   Output ~ 0
TMS
Wire Wire Line
	1650 2350 1900 2350
Text GLabel 1650 2350 0    39   Output ~ 0
TDI
Wire Wire Line
	1650 2250 1900 2250
Text GLabel 1650 2250 0    39   Input ~ 0
TDO
Text GLabel 1900 4400 0    39   BiDi ~ 0
PA0
Wire Wire Line
	1900 4400 2150 4400
Text GLabel 1900 4500 0    39   BiDi ~ 0
PA1
Wire Wire Line
	1900 4500 2150 4500
Text GLabel 1900 4600 0    39   BiDi ~ 0
PA2
Wire Wire Line
	1900 4600 2150 4600
Text GLabel 1900 4700 0    39   BiDi ~ 0
PA3
Wire Wire Line
	1900 4700 2150 4700
Text GLabel 1900 4800 0    39   BiDi ~ 0
PA4
Wire Wire Line
	1900 4800 2150 4800
Wire Wire Line
	1900 4300 1900 4200
Wire Wire Line
	1900 4300 2150 4300
$Comp
L power:GND #PWR?
U 1 1 5E0B7BEA
P 1900 5500
F 0 "#PWR?" H 1900 5250 50  0001 C CNN
F 1 "GND" H 1905 5327 50  0000 C CNN
F 2 "" H 1900 5500 50  0001 C CNN
F 3 "" H 1900 5500 50  0001 C CNN
	1    1900 5500
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x13_Odd_Even J?
U 1 1 5E0B7BF0
P 2350 4900
AR Path="/5B9337AE/5E0B7BF0" Ref="J?"  Part="1" 
AR Path="/5E07E1E4/5E0B7BF0" Ref="J?"  Part="1" 
F 0 "J?" H 2400 5600 50  0000 C CNN
F 1 "70246-2604" H 2400 4200 50  0000 C CNN
F 2 "Connector_IDC:IDC-Header_2x13_P2.54mm_Vertical" H 2350 4900 50  0001 C CNN
F 3 "https://www.mouser.com/datasheet/2/276/0702462604_PCB_HEADERS-172439.pdf" H 2350 4900 50  0001 C CNN
	1    2350 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 5500 1900 5500
Wire Wire Line
	2650 5300 2900 5300
Text GLabel 2900 5300 2    39   BiDi ~ 0
CB2
Wire Wire Line
	2650 5200 2900 5200
Text GLabel 2900 5200 2    39   BiDi ~ 0
CB1
Wire Wire Line
	2650 5100 2900 5100
Text GLabel 2900 5100 2    39   BiDi ~ 0
PB7
Wire Wire Line
	2650 5000 2900 5000
Text GLabel 2900 5000 2    39   BiDi ~ 0
PB6
Wire Wire Line
	2650 4900 2900 4900
Text GLabel 2900 4900 2    39   BiDi ~ 0
PB5
Text GLabel 1900 4900 0    39   BiDi ~ 0
PA5
Wire Wire Line
	1900 4900 2150 4900
Text GLabel 1900 5000 0    39   BiDi ~ 0
PA6
Wire Wire Line
	1900 5000 2150 5000
Text GLabel 1900 5100 0    39   BiDi ~ 0
PA7
Wire Wire Line
	1900 5100 2150 5100
Text GLabel 1900 5200 0    39   BiDi ~ 0
CA1
Wire Wire Line
	1900 5200 2150 5200
$Comp
L power:GND #PWR?
U 1 1 5E0B7C09
P 3350 4350
F 0 "#PWR?" H 3350 4100 50  0001 C CNN
F 1 "GND" H 3355 4177 50  0000 C CNN
F 2 "" H 3350 4350 50  0001 C CNN
F 3 "" H 3350 4350 50  0001 C CNN
	1    3350 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4300 3350 4300
Wire Wire Line
	3350 4300 3350 4350
Wire Wire Line
	2650 5500 3350 5500
Wire Wire Line
	2650 4800 2900 4800
Text GLabel 2900 4800 2    39   BiDi ~ 0
PB4
Wire Wire Line
	2650 4700 2900 4700
Text GLabel 2900 4700 2    39   BiDi ~ 0
PB3
Wire Wire Line
	2650 4600 2900 4600
Text GLabel 2900 4600 2    39   BiDi ~ 0
PB2
Wire Wire Line
	2650 4500 2900 4500
Text GLabel 2900 4500 2    39   BiDi ~ 0
PB1
Wire Wire Line
	2650 4400 2900 4400
Text GLabel 2900 4400 2    39   BiDi ~ 0
PB0
$Comp
L power:+3V3 #PWR?
U 1 1 5E0B7C1C
P 1900 4200
F 0 "#PWR?" H 1900 4050 50  0001 C CNN
F 1 "+3V3" H 1915 4373 50  0000 C CNN
F 2 "" H 1900 4200 50  0001 C CNN
F 3 "" H 1900 4200 50  0001 C CNN
	1    1900 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 5400 3350 5500
$Comp
L power:+3V3 #PWR?
U 1 1 5E0B7C23
P 3350 5400
F 0 "#PWR?" H 3350 5250 50  0001 C CNN
F 1 "+3V3" H 3365 5573 50  0000 C CNN
F 2 "" H 3350 5400 50  0001 C CNN
F 3 "" H 3350 5400 50  0001 C CNN
	1    3350 5400
	1    0    0    -1  
$EndComp
Text GLabel 1900 5300 0    39   BiDi ~ 0
CA1
Wire Wire Line
	1900 5300 2150 5300
Wire Wire Line
	2650 5400 2900 5400
Text GLabel 2900 5400 2    39   BiDi ~ 0
SR
NoConn ~ 2150 5400
Text Notes 2050 3450 0    98   ~ 0
JTAG Port\n
Text Notes 2050 5900 0    98   ~ 0
User Port
$EndSCHEMATC
