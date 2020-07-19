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

static volatile unsigned char control_register;

void hardware_init()
{
	control_register = EEPROM_WRITE_ENABLE | EEPROM_OUTPUT_ENABLE;
	
	DDRD = 0xFF;
	PORTD = control_register;
}

static void set_bus_options( int output_enable, int write_enable )
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

static void tick_shift_register_clock()
{
	control_register |= ADDRESS_SHIFT_REGISTER_CLOCK;
	PORTD = control_register;
	
	control_register &= ~ADDRESS_SHIFT_REGISTER_CLOCK;
	PORTD = control_register;
}

static void tick_register_clock()
{
	control_register |= ADDRESS_REGISTER_CLOCK;
	PORTD = control_register;
	
	control_register &= ~ADDRESS_REGISTER_CLOCK;
	PORTD = control_register;
}

static void set_output_bit( unsigned char bit )
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