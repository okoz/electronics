/*
 * hardware.c
 *
 * Created: 7/19/2020 11:06:26 AM
 *  Author: olegk
 */

#include "common.h"
#include "hardware.h"

static void write_to_data_bus( unsigned char data )
{
	DDRB = 0xFF;
	PORTB = data;
}

static unsigned char read_from_data_bus()
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

#define CONTROL_REGISTER PORTD

void hardware_init()
{
	DDRD = 0xFF;
	CONTROL_REGISTER = EEPROM_WRITE_ENABLE | EEPROM_OUTPUT_ENABLE;
}

static void set_bus_options( int output_enable, int write_enable )
{
	if ( output_enable )
		CONTROL_REGISTER &= ~EEPROM_OUTPUT_ENABLE;
	else
		CONTROL_REGISTER |= EEPROM_OUTPUT_ENABLE;
	
	if ( write_enable )
		CONTROL_REGISTER &= ~EEPROM_WRITE_ENABLE;
	else
		CONTROL_REGISTER |= EEPROM_WRITE_ENABLE;
}

static void tick_shift_register_clock()
{
	CONTROL_REGISTER |= ADDRESS_SHIFT_REGISTER_CLOCK;
	CONTROL_REGISTER &= ~ADDRESS_SHIFT_REGISTER_CLOCK;
}

static void tick_register_clock()
{
	CONTROL_REGISTER |= ADDRESS_REGISTER_CLOCK;
	CONTROL_REGISTER &= ~ADDRESS_REGISTER_CLOCK;
}

static void set_output_bit( unsigned char bit )
{
	if ( bit )
		CONTROL_REGISTER |= ADDRESS_OUTPUT_BIT;
	else
		CONTROL_REGISTER &= ~ADDRESS_OUTPUT_BIT;
}

static void set_address( unsigned short address )
{
	for ( int i = 0; i < 16; i++ )
	{
		set_output_bit( ( address >> ( 15 - i ) ) & 1 );
		tick_shift_register_clock();
	}
	
	tick_register_clock();
}

static unsigned char reverse_bits( unsigned char byte )
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

unsigned char hardware_read_byte( unsigned short address )
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

void hardware_write_byte( unsigned short address, unsigned char data )
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