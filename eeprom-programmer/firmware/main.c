/*
 * EEPROMProgrammer.c
 *
 * Created: 2/5/2020 12:23:16 AM
 * Author : olegk
 */ 

#define F_CPU 8000000UL

#include <avr/io.h>
#include <util/delay.h>

#define USART_BAUDRATE 4800
#define UBRR_VALUE ( ( ( F_CPU / ( USART_BAUDRATE * 16UL ) ) ) - 1 )

void serial_init()
{
	UBRRL = UBRR_VALUE & 255;
	UBRRH = UBRR_VALUE >> 8;
	UCSRB = ( 1 << TXEN ) | ( 1 << RXEN );
	UCSRC = ( 1 << UCSZ1 ) | ( 1 << UCSZ0 );
}

void serial_send( unsigned char data )
{
	while( !( UCSRA & ( 1 << UDRE ) ) );
	UDR = data;
}

unsigned char serial_receive()
{
	while( !( UCSRA & ( 1 << RXC ) ) );
	return UDR;
}

void serial_break()
{
	serial_send( 10 );
	serial_send( 13 );
}

void serial_message( const char* message )
{
	while( message && *message )
	{
		serial_send( *( unsigned char* )message );
		message++;
	}
}

static const unsigned char hex_characters[] = { '0', '1', '2', '3', '4', '5', '6',
	'7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

void serial_hex( unsigned char byte )
{
	serial_send( hex_characters[ byte >> 4 ] );
	serial_send( hex_characters[ byte & 0xF ] );	
}

int is_hex( char character )
{
	return ( character >= '0' && character <= '9' )
		|| ( character >= 'A' && character <= 'F' )
		|| ( character >= 'a' && character <= 'f' );
}

char parse_nibble( char character )
{
	if ( character >= '0' && character <= '9' )
		return character - '0';
	else if ( character >= 'A' && character <= 'F' )
		return 10 + ( character - 'A' );
	else if ( character >= 'a' && character <= 'f' )
		return 10 + ( character - 'a' );
		
	return -1;
}

void write_to_data_bus( unsigned char data )
{
	DDRB = 0xFF;
	PORTB = data;
}

unsigned char read_from_data_bus()
{
	DDRB = 0x00;
	PORTB = 0x00;
	return PINB;
}

#define EEPROM_WRITE_ENABLE ( 1 << PD5 )
#define EEPROM_OUTPUT_ENABLE ( 1 << PD4 )
#define ADDRESS_REGISTER_CLOCK ( 1 << PD6 )
#define ADDRESS_SHIFT_REGISTER_CLOCK ( 1 << PD3 )
#define ADDRESS_OUTPUT_BIT ( 1 << PD2 )

static volatile unsigned char control_register;

void init_control_register()
{
	control_register = EEPROM_WRITE_ENABLE | EEPROM_OUTPUT_ENABLE;
	
	DDRD = 0xFF;
	PORTD = control_register;
}

void set_bus_options( int output_enable, int write_enable )
{
	if ( output_enable )
		control_register &= ~EEPROM_OUTPUT_ENABLE;
	else
		control_register |= EEPROM_OUTPUT_ENABLE;
		
	if ( write_enable )
		control_register &= ~EEPROM_WRITE_ENABLE;
	else
		control_register |= EEPROM_WRITE_ENABLE;
		
	PORTD = control_register;
}

void tick_shift_register_clock()
{
	control_register |= ADDRESS_SHIFT_REGISTER_CLOCK;
	PORTD = control_register;
	
	control_register &= ~ADDRESS_SHIFT_REGISTER_CLOCK;
	PORTD = control_register;
}

void tick_register_clock()
{
	control_register |= ADDRESS_REGISTER_CLOCK;
	PORTD = control_register;
	
	control_register &= ~ADDRESS_REGISTER_CLOCK;
	PORTD = control_register;
}

void set_output_bit( unsigned char bit )
{
	if ( bit )
	{
		control_register |= ADDRESS_OUTPUT_BIT;
		PORTD = control_register;
	}
	else
	{	
		control_register &= ~ADDRESS_OUTPUT_BIT;
		PORTD = control_register;
	}
}

void set_address( unsigned short address )
{
	for ( int i = 0; i < 16; i++ )
	{
		set_output_bit( ( address >> ( 15 - i ) ) & 1 );
		tick_shift_register_clock();
	}
	
	tick_register_clock();
}

unsigned char reverse_bits( unsigned char byte )
{
	return ( ( byte & 1 ) << 7 )
		| ( ( byte & 2 ) << 5 )
		| ( ( byte & 4 ) << 3 )
		| ( ( byte & 8 ) << 1 )
		| ( ( byte & 16 ) >> 1 )
		| ( ( byte & 32 ) >> 3 )
		| ( ( byte & 64 ) >> 5 )
		| ( ( byte & 128 ) >> 7 );
}

unsigned char read_byte( unsigned short address )
{
	set_address( address );
	_delay_us( 1.0 );
	set_bus_options( 1, 0 );
	_delay_us( 1.0 );
	unsigned char data = reverse_bits( read_from_data_bus() );
	set_bus_options( 0, 0 );
	_delay_us( 1.0 );
	return data;
}

void write_byte( unsigned short address, unsigned char data )
{
	set_address( address );
	_delay_us( 1.0 );
	set_bus_options( 0, 1 );
	_delay_us( 1.0 );
	write_to_data_bus( reverse_bits( data ) );
	_delay_us( 1.0 );
	set_bus_options( 0, 0 );
	_delay_us( 1.0 );
}

int main(void)
{
	init_control_register();
	serial_init();
	
	unsigned short address = 0;
	
	serial_message( "Hello" );
	serial_break();
	
	while (1)
    {
		unsigned char data = serial_receive();
		
		switch( data )
		{
			case 'n':
			{
				address++;
				serial_hex( address >> 8 );
				serial_hex( address & 0xFF );
				serial_message( ": " );
				data = read_byte( address );
				serial_hex( data );
				serial_break();
			}
			break;
			
			case 'p':
			{
				address--;
				serial_hex( address >> 8 );
				serial_hex( address & 0xFF );
				serial_message( ": " );
				data = read_byte( address );
				serial_hex( data );
				serial_break();
			}
			break;
			
			case 'd':
			{
				serial_hex( address >> 8 );
				serial_hex( address & 0xFF );
				serial_message( ": " );
				data = read_byte( address );
				serial_hex( data );
				serial_break();
			}
			break;
			
			case 's':
			{
				unsigned char high_byte = serial_receive();
				if ( !is_hex( high_byte ) )
				{
					serial_message( "Expected 0-9, A-Z, a-z." );
					serial_break();
				}
				else
				{
					unsigned char low_byte = serial_receive();
					if ( !is_hex( low_byte ) )
					{
						serial_message( "Expected 0-9, A-Z, a-z." );
						serial_break();
					}
					else
					{
						unsigned char byte = ( parse_nibble( high_byte ) << 4 )
							| ( parse_nibble( low_byte ) & 0xF );
							
						write_byte( address, byte );
						
						serial_message( "Wrote " );
						serial_hex( byte );
						serial_message( " to " );
						serial_hex( address >> 8 );
						serial_hex( address & 0xFF );
						serial_break();
					}
				}
				
			}
			break;
			
			case 'r':
			{
				write_byte( address, 0xFF );
			}
			break;
		}
    }
}

