EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L Connector:DB9_Female J2
U 1 1 5F052F1B
P 9200 4350
F 0 "J2" H 9380 4396 50  0000 L CNN
F 1 "DB9_Female" H 9380 4305 50  0000 L CNN
F 2 "Connector_Dsub:DSUB-9_Female_Horizontal_P2.77x2.84mm_EdgePinOffset9.90mm_Housed_MountingHolesOffset11.32mm" H 9200 4350 50  0001 C CNN
F 3 " ~" H 9200 4350 50  0001 C CNN
	1    9200 4350
	1    0    0    -1  
$EndComp
$Comp
L Interface_UART:MAX232 U1
U 1 1 5F053A2C
P 6650 3650
F 0 "U1" H 7000 4900 50  0000 C CNN
F 1 "MAX232" H 7000 4800 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 6700 2600 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/max232.pdf" H 6650 3750 50  0001 C CNN
	1    6650 3650
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C1
U 1 1 5F054820
P 5450 2900
F 0 "C1" H 5565 2946 50  0000 L CNN
F 1 "1uF" H 5565 2855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 5450 2900 50  0001 C CNN
F 3 "~" H 5450 2900 50  0001 C CNN
	1    5450 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C2
U 1 1 5F054BE0
P 7800 2900
F 0 "C2" H 7915 2946 50  0000 L CNN
F 1 "1uF" H 7915 2855 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 7800 2900 50  0001 C CNN
F 3 "~" H 7800 2900 50  0001 C CNN
	1    7800 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C4
U 1 1 5F054F63
P 7950 3550
F 0 "C4" V 7750 3350 50  0000 C CNN
F 1 "1uF" V 7850 3350 50  0000 C CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 7950 3550 50  0001 C CNN
F 3 "~" H 7950 3550 50  0001 C CNN
	1    7950 3550
	0    1    1    0   
$EndComp
$Comp
L Device:CP1 C3
U 1 1 5F0551CC
P 7950 3250
F 0 "C3" V 8150 3100 50  0000 C CNN
F 1 "1uF" V 8050 3100 50  0000 C CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 7950 3250 50  0001 C CNN
F 3 "~" H 7950 3250 50  0001 C CNN
	1    7950 3250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7800 2750 7450 2750
Wire Wire Line
	7450 3050 7800 3050
Wire Wire Line
	5850 2750 5450 2750
Wire Wire Line
	5450 3050 5850 3050
Wire Wire Line
	7450 3250 7800 3250
Wire Wire Line
	7450 3550 7800 3550
Wire Wire Line
	8250 3550 8100 3550
$Comp
L power:GND #PWR05
U 1 1 5F0643FB
P 8250 3250
F 0 "#PWR05" H 8250 3000 50  0001 C CNN
F 1 "GND" V 8255 3122 50  0000 R CNN
F 2 "" H 8250 3250 50  0001 C CNN
F 3 "" H 8250 3250 50  0001 C CNN
	1    8250 3250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8250 3250 8100 3250
$Comp
L power:GND #PWR06
U 1 1 5F066307
P 8250 3550
F 0 "#PWR06" H 8250 3300 50  0001 C CNN
F 1 "GND" V 8255 3422 50  0000 R CNN
F 2 "" H 8250 3550 50  0001 C CNN
F 3 "" H 8250 3550 50  0001 C CNN
	1    8250 3550
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5F066A7E
P 6650 5100
F 0 "#PWR04" H 6650 4850 50  0001 C CNN
F 1 "GND" H 6655 4927 50  0000 C CNN
F 2 "" H 6650 5100 50  0001 C CNN
F 3 "" H 6650 5100 50  0001 C CNN
	1    6650 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 5100 6650 4850
$Comp
L power:VCC #PWR03
U 1 1 5F0672C2
P 6650 2250
F 0 "#PWR03" H 6650 2100 50  0001 C CNN
F 1 "VCC" H 6665 2423 50  0000 C CNN
F 2 "" H 6650 2250 50  0001 C CNN
F 3 "" H 6650 2250 50  0001 C CNN
	1    6650 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 2250 6650 2450
Wire Wire Line
	7800 4150 7800 3750
Wire Wire Line
	7800 3750 7450 3750
Wire Wire Line
	7450 4150 7700 4150
Wire Wire Line
	7700 4150 7700 4350
$Comp
L power:GND #PWR07
U 1 1 5F06A457
P 8900 4950
F 0 "#PWR07" H 8900 4700 50  0001 C CNN
F 1 "GND" H 8905 4777 50  0000 C CNN
F 2 "" H 8900 4950 50  0001 C CNN
F 3 "" H 8900 4950 50  0001 C CNN
	1    8900 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8900 4750 8900 4950
Wire Wire Line
	7450 3950 7750 3950
Wire Wire Line
	7750 3950 7750 4250
Wire Wire Line
	7450 4350 7650 4350
Wire Wire Line
	7650 4350 7650 4450
$Comp
L Connector:Conn_01x06_Female J1
U 1 1 5F06E41C
P 4650 4100
F 0 "J1" H 4542 3575 50  0000 C CNN
F 1 "Conn_01x06_Female" H 4542 3666 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical" H 4650 4100 50  0001 C CNN
F 3 "~" H 4650 4100 50  0001 C CNN
	1    4650 4100
	-1   0    0    1   
$EndComp
$Comp
L power:VCC #PWR01
U 1 1 5F06F14A
P 5250 3550
F 0 "#PWR01" H 5250 3400 50  0001 C CNN
F 1 "VCC" H 5265 3723 50  0000 C CNN
F 2 "" H 5250 3550 50  0001 C CNN
F 3 "" H 5250 3550 50  0001 C CNN
	1    5250 3550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5F06F492
P 5250 4500
F 0 "#PWR02" H 5250 4250 50  0001 C CNN
F 1 "GND" H 5255 4327 50  0000 C CNN
F 2 "" H 5250 4500 50  0001 C CNN
F 3 "" H 5250 4500 50  0001 C CNN
	1    5250 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 4300 5250 4300
Wire Wire Line
	5250 4300 5250 4500
Wire Wire Line
	4850 3800 5250 3800
Wire Wire Line
	5250 3800 5250 3550
Wire Wire Line
	5850 3750 5300 3750
Wire Wire Line
	5300 3750 5300 3900
Wire Wire Line
	5300 3900 4850 3900
Wire Wire Line
	4850 4000 5350 4000
Wire Wire Line
	5350 4000 5350 3950
Wire Wire Line
	5350 3950 5850 3950
Wire Wire Line
	5850 4150 5350 4150
Wire Wire Line
	5350 4150 5350 4100
Wire Wire Line
	5350 4100 4850 4100
Wire Wire Line
	5850 4350 5300 4350
Wire Wire Line
	5300 4350 5300 4200
Wire Wire Line
	5300 4200 4850 4200
Wire Wire Line
	8900 3950 8800 3950
Wire Wire Line
	8800 4550 8900 4550
Wire Wire Line
	8900 4050 8800 4050
Wire Wire Line
	8800 3950 8800 4050
Wire Wire Line
	8800 4050 8800 4550
Connection ~ 8800 4050
Wire Wire Line
	7800 4150 8900 4150
Wire Wire Line
	7700 4350 8900 4350
$Comp
L Device:Jumper JP1
U 1 1 5F07ECFE
P 8150 4250
F 0 "JP1" H 8150 4514 50  0000 C CNN
F 1 "Jumper" H 8150 4423 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 8150 4250 50  0001 C CNN
F 3 "~" H 8150 4250 50  0001 C CNN
	1    8150 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:Jumper JP2
U 1 1 5F07F26B
P 8150 4450
F 0 "JP2" H 8150 4714 50  0000 C CNN
F 1 "Jumper" H 8150 4623 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 8150 4450 50  0001 C CNN
F 3 "~" H 8150 4450 50  0001 C CNN
	1    8150 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 4450 8900 4450
Wire Wire Line
	8450 4250 8900 4250
Wire Wire Line
	7750 4250 7850 4250
Wire Wire Line
	7850 4450 7650 4450
$Comp
L Device:CP1 C5
U 1 1 5F082D3E
P 8200 2400
F 0 "C5" H 8315 2446 50  0000 L CNN
F 1 "1uF" H 8315 2355 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 8200 2400 50  0001 C CNN
F 3 "~" H 8200 2400 50  0001 C CNN
	1    8200 2400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR08
U 1 1 5F0833F8
P 8200 2200
F 0 "#PWR08" H 8200 2050 50  0001 C CNN
F 1 "VCC" H 8215 2373 50  0000 C CNN
F 2 "" H 8200 2200 50  0001 C CNN
F 3 "" H 8200 2200 50  0001 C CNN
	1    8200 2200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5F083802
P 8200 2600
F 0 "#PWR09" H 8200 2350 50  0001 C CNN
F 1 "GND" H 8205 2427 50  0000 C CNN
F 2 "" H 8200 2600 50  0001 C CNN
F 3 "" H 8200 2600 50  0001 C CNN
	1    8200 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 2600 8200 2550
Wire Wire Line
	8200 2250 8200 2200
$EndSCHEMATC