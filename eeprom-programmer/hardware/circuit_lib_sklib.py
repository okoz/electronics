from skidl import Pin, Part, Alias, SchLib, SKIDL, TEMPLATE

SKIDL_lib_version = '0.0.1'

circuit_lib = SchLib(tool=SKIDL).add_parts(*[
        Part(**{ 'name':'Conn_02x03_Odd_Even', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'J', 'F1':'Conn_02x03_Odd_Even', 'datasheet':'~', 'description':'Generic connector, double row, 02x03, odd/even pin numbering scheme (row 1 odd numbers, row 2 even numbers), script generated (kicad-library-utils/schlib/autogen/connector/)', 'F3':'', 'F2':'', 'keywords':'connector', 'ref_prefix':'J', 'num_units':1, 'fplist':['Connector*:*_2x??_*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical', 'pins':[
            Pin(num='1',name='Pin_1',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='Pin_2',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='3',name='Pin_3',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='4',name='Pin_4',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='5',name='Pin_5',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='6',name='Pin_6',func=Pin.types.PASSIVE,do_erc=True)] }),
        Part(**{ 'name':'Screw_Terminal_01x02', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'J', 'F1':'Screw_Terminal_01x02', 'datasheet':'~', 'description':'Generic screw terminal, single row, 01x02, script generated (kicad-library-utils/schlib/autogen/connector/)', 'F3':'', 'F2':'', 'keywords':'screw terminal', 'ref_prefix':'J', 'num_units':1, 'fplist':['TerminalBlock*:*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'TerminalBlock:TerminalBlock_bornier-2_P5.08mm', 'pins':[
            Pin(num='1',name='Pin_1',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='Pin_2',func=Pin.types.PASSIVE,do_erc=True)] }),
        Part(**{ 'name':'28C256', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'U', 'F1':'28C256', 'datasheet':'http://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf', 'description':'Paged Parallel EEPROM 256Kb (32K x 8), DIP-28/SOIC-28', 'F3':'', 'F2':'', 'keywords':'Parallel EEPROM 256Kb', 'ref_prefix':'U', 'num_units':1, 'fplist':['DIP*W15.24mm*', 'SOIC*7.5x17.9mm*P1.27mm*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'Socket:DIP_Socket-28_W11.9_W12.7_W15.24_W17.78_W18.5_3M_228-1277-00-0602J', 'pins':[
            Pin(num='1',name='A14',func=Pin.types.INPUT,do_erc=True),
            Pin(num='10',name='A0',func=Pin.types.INPUT,do_erc=True),
            Pin(num='11',name='D0',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='12',name='D1',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='13',name='D2',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='14',name='GND',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='15',name='D3',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='16',name='D4',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='17',name='D5',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='18',name='D6',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='19',name='D7',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='2',name='A12',func=Pin.types.INPUT,do_erc=True),
            Pin(num='20',name='~CS',func=Pin.types.INPUT,do_erc=True),
            Pin(num='21',name='A10',func=Pin.types.INPUT,do_erc=True),
            Pin(num='22',name='~OE',func=Pin.types.INPUT,do_erc=True),
            Pin(num='23',name='A11',func=Pin.types.INPUT,do_erc=True),
            Pin(num='24',name='A9',func=Pin.types.INPUT,do_erc=True),
            Pin(num='25',name='A8',func=Pin.types.INPUT,do_erc=True),
            Pin(num='26',name='A13',func=Pin.types.INPUT,do_erc=True),
            Pin(num='27',name='~WE',func=Pin.types.INPUT,do_erc=True),
            Pin(num='28',name='VCC',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='3',name='A7',func=Pin.types.INPUT,do_erc=True),
            Pin(num='4',name='A6',func=Pin.types.INPUT,do_erc=True),
            Pin(num='5',name='A5',func=Pin.types.INPUT,do_erc=True),
            Pin(num='6',name='A4',func=Pin.types.INPUT,do_erc=True),
            Pin(num='7',name='A3',func=Pin.types.INPUT,do_erc=True),
            Pin(num='8',name='A2',func=Pin.types.INPUT,do_erc=True),
            Pin(num='9',name='A1',func=Pin.types.INPUT,do_erc=True)] }),
        Part(**{ 'name':'ATtiny2313V-10PU', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'U', 'F1':'ATtiny2313V-10PU', '_aliases':Alias({'ATtiny2313-20PU', 'ATtiny4313-PU', 'ATtiny2313A-PU'}), 'datasheet':'http://ww1.microchip.com/downloads/en/DeviceDoc/doc8246.pdf', 'description':'20MHz, 4kB Flash, 256B SRAM, 256B EEPROM, DIP-20', 'F3':'', 'F2':'Package_DIP:DIP-20_W7.62mm', 'keywords':'AVR 8bit Microcontroller tinyAVR', 'ref_prefix':'U', 'num_units':1, 'fplist':['DIP*W7.62mm*'], 'do_erc':True, 'aliases':Alias({'ATtiny2313-20PU', 'ATtiny4313-PU', 'ATtiny2313A-PU'}), 'pin':None, 'footprint':'Package_DIP:DIP-20_W7.62mm_Socket_LongPads', 'pins':[
            Pin(num='1',name='PA2/~RESET',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='10',name='GND',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='11',name='PD6',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='12',name='PB0',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='13',name='PB1',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='14',name='PB2',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='15',name='PB3',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='16',name='PB4',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='17',name='PB5',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='18',name='PB6',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='19',name='PB7',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='2',name='PD0',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='20',name='VCC',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='3',name='PD1',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='4',name='PA1/XTAL2',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='5',name='PA0/XTAL1',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='6',name='PD2',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='7',name='PD3',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='8',name='PD4',func=Pin.types.BIDIR,do_erc=True),
            Pin(num='9',name='PD5',func=Pin.types.BIDIR,do_erc=True)] }),
        Part(**{ 'name':'74HC595', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'U', 'F1':'74HC595', '_aliases':Alias({'74AHC595', '74AHCT595', '74HCT595', '74LS595'}), 'datasheet':'http://www.ti.com/lit/gpn/sn74ls595', 'description':'8-bit serial in/out Shift Register 3-State Outputs', 'F3':'', 'F2':'', 'keywords':'TTL SR 3State', 'ref_prefix':'U', 'num_units':1, 'fplist':['DIP*W7.62mm*', 'SOIC*3.9x9.9mm*P1.27mm*', 'TSSOP*4.4x5mm*P0.65mm*', 'SOIC*5.3x10.2mm*P1.27mm*', 'SOIC*7.5x10.3mm*P1.27mm*'], 'do_erc':True, 'aliases':Alias({'74AHC595', '74AHCT595', '74HCT595', '74LS595'}), 'pin':None, 'footprint':'Package_DIP:DIP-16_W7.62mm_Socket_LongPads', 'pins':[
            Pin(num='1',name='QB',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='10',name='~SRCLR',func=Pin.types.INPUT,do_erc=True),
            Pin(num='11',name='SRCLK',func=Pin.types.INPUT,do_erc=True),
            Pin(num='12',name='RCLK',func=Pin.types.INPUT,do_erc=True),
            Pin(num='13',name='~OE',func=Pin.types.INPUT,do_erc=True),
            Pin(num='14',name='SER',func=Pin.types.INPUT,do_erc=True),
            Pin(num='15',name='QA',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='16',name='VCC',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='2',name='QC',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='3',name='QD',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='4',name='QE',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='5',name='QF',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='6',name='QG',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='7',name='QH',func=Pin.types.TRISTATE,do_erc=True),
            Pin(num='8',name='GND',func=Pin.types.PWRIN,do_erc=True),
            Pin(num='9',name="QH'",func=Pin.types.OUTPUT,do_erc=True)] }),
        Part(**{ 'name':'Conn_01x06', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'J', 'F1':'Conn_01x06', 'datasheet':'~', 'description':'Generic connector, single row, 01x06, script generated (kicad-library-utils/schlib/autogen/connector/)', 'F3':'', 'F2':'', 'keywords':'connector', 'ref_prefix':'J', 'num_units':1, 'fplist':['Connector*:*_1x??_*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical', 'pins':[
            Pin(num='1',name='Pin_1',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='Pin_2',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='3',name='Pin_3',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='4',name='Pin_4',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='5',name='Pin_5',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='6',name='Pin_6',func=Pin.types.PASSIVE,do_erc=True)] }),
        Part(**{ 'name':'R', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'R', 'F1':'R', 'datasheet':'~', 'description':'Resistor', 'F3':'', 'F2':'', 'keywords':'R res resistor', 'ref_prefix':'R', 'num_units':1, 'fplist':['R_*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal', 'pins':[
            Pin(num='1',name='~',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='~',func=Pin.types.PASSIVE,do_erc=True)] }),
        Part(**{ 'name':'C', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'C', 'F1':'C', 'datasheet':'~', 'description':'Unpolarized capacitor', 'F3':'', 'F2':'', 'keywords':'cap capacitor', 'ref_prefix':'C', 'num_units':1, 'fplist':['C_*'], 'do_erc':True, 'aliases':Alias(), 'pin':None, 'footprint':'Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm', 'pins':[
            Pin(num='1',name='~',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='~',func=Pin.types.PASSIVE,do_erc=True)] }),
        Part(**{ 'name':'1N4001', 'dest':TEMPLATE, 'tool':SKIDL, 'F0':'D', 'F1':'1N4001', '_aliases':Alias({'1N4005', '1N4004', '1N4007', '1N4006', '1N4002', '1N4003', 'BA158', 'BA157', 'BA159'}), 'datasheet':'http://diotec.com/tl_files/diotec/files/pdf/datasheets/ba157', 'description':'1000V 1A Fast recovery Rectifier Diode, DO-41', 'F3':'', 'F2':'Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal', 'keywords':'diode', 'ref_prefix':'D', 'num_units':1, 'fplist':['D*DO?41*'], 'do_erc':True, 'aliases':Alias({'1N4005', '1N4004', '1N4007', '1N4006', '1N4002', '1N4003', 'BA158', 'BA157', 'BA159'}), 'pin':None, 'footprint':'Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal', 'pins':[
            Pin(num='1',name='K',func=Pin.types.PASSIVE,do_erc=True),
            Pin(num='2',name='A',func=Pin.types.PASSIVE,do_erc=True)] })])