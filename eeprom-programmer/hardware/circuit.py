from skidl import *

vcc, gnd = Net('VCC'), Net('GND')
vcc.drive = POWER
gnd.drive = POWER

address_shift_register_clock = Net('ADDR_SRCLK')
address_register_clock = Net('ADDR_RCLK')
microcontroller_address_output = Net('ADDR_OUTPUT')
eeprom_write_enable = Net('~EEPROM_WE')
eeprom_output_enable = Net('~EEPROM_OE')

address_bus = Bus('ADDRESS_BUS', 15)
data_bus = Bus('DATA_BUS', 8)

isp_connector = Part("Connector_Generic", "Conn_02x03_Odd_Even", footprint='Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical')
power_connector = Part('Connector', 'Screw_Terminal_01x02', footprint='TerminalBlock:TerminalBlock_bornier-2_P5.08mm')
eeprom = Part("Memory_EEPROM", "28C256", footprint='Socket:DIP_Socket-28_W11.9_W12.7_W15.24_W17.78_W18.5_3M_228-1277-00-0602J')

microcontroller = Part("MCU_Microchip_ATtiny", "ATtiny2313-20PU", footprint='Package_DIP:DIP-20_W7.62mm_Socket_LongPads')
high_byte, low_byte = 2 * Part("74xx", "74HC595", TEMPLATE, footprint='Package_DIP:DIP-16_W7.62mm_Socket_LongPads')

power_connector[1] += vcc
power_connector[2] += gnd

@subcircuit
def make_communications_interface(vcc, gnd, rx, tx):
    '''Communications interface through external max232 adapter.
    Pinout:
    1 - GND
    2 - RTS
    3 - RX
    4 - CTS
    5 - TX
    6 - VCC'''
    interface = Part("Connector_Generic", "Conn_01x06", footprint='Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical')
    interface[1] += gnd
    interface[2] += NC
    interface[3] += rx
    interface[4] += NC
    interface[5] += tx
    interface[6] += vcc

make_communications_interface(vcc, gnd, microcontroller['PD0'], microcontroller['PD1'])

# Address shift registers.
low_byte['QA, QB, QC, QD, QE, QF, QG, QH'] += address_bus[0:7]
high_byte['QA, QB, QC, QD, QE, QF, QG'] += address_bus[8:14]
high_byte["QH, QH'"] += NC
low_byte['SER'] += microcontroller_address_output
high_byte['SER'] += low_byte["QH'"]

for shift_register in [high_byte, low_byte]:
    shift_register['SRCLK'] += address_shift_register_clock
    shift_register['RCLK'] += address_register_clock
    # No need to clear, we'll just shift in the whole address every time.
    shift_register['~SRCLR'] += vcc 
    shift_register['~OE'] += gnd
    shift_register['VCC, GND'] += vcc, gnd


# EEPROM connections.
eeprom['VCC, GND'] += vcc, gnd
eeprom['A14, A13, A12, A11, A10, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0'] += address_bus[14:0]
eeprom['D7, D6, D5, D4, D3, D2, D1, D0'] += data_bus[7:0]
eeprom['CS'] += gnd
eeprom['~OE'] += eeprom_output_enable
eeprom['~WE'] += eeprom_write_enable

@subcircuit
def reset_circuit(reset, vcc, gnd):
    # TODO okoz: Double check the capacitor and resistor footprints. Maybe we can
    # disable the reset pin to gain an I/O.
    pullup = Part("Device", "R", value='10k', footprint='Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal')
    capacitor = Part("Device", "C", value='10u', footprint='Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm')
    diode = Part("Diode", "1N4004", footprint='Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal')

    vcc += pullup[1], diode['K']
    microcontroller['~RESET'] += pullup[2], capacitor[1], diode['A']
    gnd += capacitor[2]

# Microcontroller connections.
microcontroller['VCC, GND'] += vcc, gnd
reset_circuit(microcontroller['~RESET'], vcc, gnd)
microcontroller['PD2'] += microcontroller_address_output
microcontroller['PD3'] += address_shift_register_clock
microcontroller['PD6'] += address_register_clock
microcontroller['PB7, PB6, PB5, PB4, PB3, PB2, PB1, PB0'] += data_bus[0:7]
microcontroller['PD4'] += eeprom_output_enable
microcontroller['PD5'] += eeprom_write_enable
microcontroller['PA0, PA1'] += NC

# ISP connector.
# 1 MISO,  2 +VCC
# 3 SCK,   4 MOSI
# 5 RESET, 6 GND
microcontroller['PB6'] += isp_connector[1]
microcontroller['VCC'] += isp_connector[2]
microcontroller['PB7'] += isp_connector[3]
microcontroller['PB5'] += isp_connector[4]
microcontroller['~RESET'] += isp_connector[5]
microcontroller['GND'] += isp_connector[6]

generate_netlist(file_='eeprom_programmer.net')

def interact():
    import code
    code.InteractiveConsole(locals=globals()).interact()

interact()