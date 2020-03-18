from skidl import *

vcc, gnd = Net('VCC'), Net('GND')
vcc.drive = POWER
gnd.drive = POWER

@subcircuit
def make_resistor(value):
    return Part('Device', 'R', footprint='Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal', 
        value=value)

@subcircuit
def make_capacitor(value):
    return Part('Device', 'C', footprint='Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm',
        value=value)

@subcircuit
def make_electrolytic_capacitor(value):
    return Part('Device', 'CP1', footprint='Capacitor_THT:CP_Radial_D5.0mm_P2.50mm', value=value)

diode1 = Part('Diode', '1N4004', footprint='Diode_THT:D_DO-41_SOD81_P7.62mm_Horizontal')
diode2 = Part('Diode', '1N4004', footprint='Diode_THT:D_DO-41_SOD81_P7.62mm_Horizontal')

resistor1 = make_resistor('1k')
resistor2 = make_resistor('10k')

capacitor1 = make_capacitor('0.1uF')
capacitor2 = make_capacitor('0.022uF')

electrolytic_capacitor1 = make_electrolytic_capacitor('22uF')
electrolytic_capacitor2 = make_electrolytic_capacitor('22uF')

timer = Part('Timer', 'LM555', footprint='Package_DIP:DIP-8_W7.62mm_Socket_LongPads')

input = Part('Connector', 'Screw_Terminal_01x02', footprint='TerminalBlock:TerminalBlock_bornier-2_P5.08mm')
output = Part('Connector', 'Screw_Terminal_01x02', footprint='TerminalBlock:TerminalBlock_bornier-2_P5.08mm')

input[:] += vcc, gnd
timer['VCC, R'] += vcc
timer['GND'] += gnd
timer['TR, THR'] += capacitor2[1]
capacitor2[2] += gnd
timer['CV'] += capacitor1[1]
capacitor1[2] += gnd
timer['VCC'] += resistor1[1]
timer['DIS'] += resistor1[2], resistor2[1]
timer['THR'] += resistor2[2]
timer['Q'] +=  electrolytic_capacitor1[2]
electrolytic_capacitor1[1] += diode1['A'], diode2['K']
diode1['K'] += gnd
diode2['A'] += electrolytic_capacitor2[1], output[1]
electrolytic_capacitor2[2] += gnd
output[2] += gnd


def generate():
    from pathlib import Path
    file = Path(__file__).with_suffix('.net').name
    generate_netlist(file_=file)

def interact():
    import code
    code.InteractiveConsole(locals=globals()).interact()

if __name__ == '__main__':
    generate()
    interact()