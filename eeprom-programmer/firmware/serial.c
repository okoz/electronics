/*
 * serial.c
 *
 * Created: 7/19/2020 10:58:46 AM
 *  Author: olegk
 */

#include "common.h"
#include "serial.h"

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

void serial_line_break()
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

void serial_hex_byte( unsigned char byte )
{
	serial_send( hex_characters[ byte >> 4 ] );
	serial_send( hex_characters[ byte & 0xF ] );
}

void serial_hex_word( unsigned short word )
{
	serial_hex_byte( word >> 8 );
	serial_hex_byte( word & 0xFF );
}

int is_hex( char character )
{
	return ( character >= '0' && character <= '9' )
	|| ( character >= 'A' && character <= 'F' )
	|| ( character >= 'a' && character <= 'f' );
}

char parse_nybble( char character )
{
	if ( character >= '0' && character <= '9' )
	return character - '0';
	else if ( character >= 'A' && character <= 'F' )
	return 10 + ( character - 'A' );
	else if ( character >= 'a' && character <= 'f' )
	return 10 + ( character - 'a' );
	
	return -1;
}
