/*
 * main.c
 *
 * Created: 2/5/2020 12:23:16 AM
 * Author : olegk
 */ 

#include "common.h"
#include "serial.h"
#include "hardware.h"

static void print_address_and_value( unsigned short address )
{
	unsigned short data = hardware_read_byte( address );

	serial_hex_word( address );
	serial_message( ": " );
	serial_hex_byte( data );
	serial_line_break();
}

int main(void)
{	
	hardware_init();
	serial_init();
	
	unsigned short address = 0;
	
	serial_message( "Hello" );
	serial_line_break();
	
	while (1)
    {
		unsigned char data = serial_receive();
		
		switch( data )
		{
			case 'n':
			{
				address++;
				print_address_and_value( address );
			}
			break;
			
			case 'p':
			{
				address--;
				print_address_and_value( address );
			}
			break;
			
			case 'd':
			{
				print_address_and_value( address );
			}
			break;
			
			case 's':
			{
				unsigned char high_byte = serial_receive();
				if ( !is_hex( high_byte ) )
				{
					serial_message( "Expected 0-9, A-Z, a-z." );
					serial_line_break();
				}
				else
				{
					unsigned char low_byte = serial_receive();
					if ( !is_hex( low_byte ) )
					{
						serial_message( "Expected 0-9, A-Z, a-z." );
						serial_line_break();
					}
					else
					{
						unsigned char byte = ( parse_nybble( high_byte ) << 4 )
							| ( parse_nybble( low_byte ) & 0xF );
							
						hardware_write_byte( address, byte );
						
						serial_message( "Wrote " );
						serial_hex_byte( byte );
						serial_message( " to " );
						serial_hex_byte( address >> 8 );
						serial_hex_byte( address & 0xFF );
						serial_line_break();
					}
				}
				
			}
			break;
			
			case 'c':
			{
				hardware_write_byte( address, 0xFF );
			}
			break;
			
			case 'w':
			{
				unsigned char high_byte = serial_receive();
				unsigned char low_byte = serial_receive();
				unsigned char byte = serial_receive();
				unsigned short address = ( ( unsigned short )high_byte ) << 8 | low_byte;
				hardware_write_byte( address, byte );
				serial_send( 'z' );
			}
			break;
			
			case 'r':
			{
				unsigned char high_byte = serial_receive();
				unsigned char low_byte = serial_receive();
				unsigned short address = ( ( unsigned short )high_byte ) << 8 | low_byte;
				unsigned char byte = hardware_read_byte( address );
				serial_send( byte );
			}
			break;
		}
    }
}

