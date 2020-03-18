from skidl import *

vcc, gnd = Net('VCC'), Net('GND')
vcc.drive = POWER
gnd.drive = POWER

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