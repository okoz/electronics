import argparse
import sys
import serial

baud_rate = 4800

def read(args):
    with open(args.out, 'wb') as output:
        serial_port = serial.Serial(args.serial_port, baud_rate)

        last_address = 2 ** 15 if args.length is None else args.length
        for address in range(last_address):
            sys.stdout.write('\r')
            sys.stdout.write('{0}/{1}'.format(address, last_address - 1))

            address_bytes = address.to_bytes(2, byteorder='big')
            serial_port.write(b'r')
            serial_port.write(address_bytes)
            data = serial_port.read(1)
            output.write(data)

def write(args):
    with open(args.input_file, 'rb') as input_file:
        content = input_file.read()
        serial_port = serial.Serial(args.serial_port, baud_rate)

        last_address = len(content)
        for address in range(last_address):
            sys.stdout.write('\r')
            sys.stdout.write('{0}/{1}'.format(address, last_address - 1))

            address_bytes = address.to_bytes(2, byteorder='big')
            serial_port.write(b'w')
            serial_port.write(address_bytes)
            serial_port.write(content[address].to_bytes(1, byteorder='big'))
            response = serial_port.read(1)
            if response != b'z':
                raise RuntimeError("Didn't get write acknowledgement for address {0}".format(address))

def verify(args):
    print('Verify')
    print(args)

def set_up_common_arguments(parser):
    parser.add_argument('--serial-port', required=True, help='Serial port where the programmer is connected')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(help='Possible EEPROM actions')

    parser_read = subparsers.add_parser('read', help='Read EEPROM contents into a file')
    parser_read.add_argument('--out', required=True, help='Destination where to write EEPROM contents')
    parser_read.add_argument('--length', type=int, help="Number of bytes to read (default: 32K)")
    set_up_common_arguments(parser_read)
    parser_read.set_defaults(func=read)

    parser_write = subparsers.add_parser('write', help='Write the contents of a file into an EEPROM')
    parser_write.add_argument('--in', required=True, dest='input_file', help='Source file from which to read the data')
    set_up_common_arguments(parser_write)
    parser_write.set_defaults(func=write)
    
    parser_verify = subparsers.add_parser('verify', help='Verify that an EEPROM contains the expected contents')
    parser_verify.add_argument('--in', required=True, help='File with reference EEPROM contents')
    set_up_common_arguments(parser_verify)
    parser_verify.set_defaults(func=verify)
    
    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)

    args = parser.parse_args()
    args.func(args)