/*
 * serial.h
 *
 * Created: 7/19/2020 10:54:15 AM
 *  Author: olegk
 */ 


#ifndef SERIAL_H_
#define SERIAL_H_

void serial_init();
void serial_send( unsigned char data );
unsigned char serial_receive();
void serial_line_break();
void serial_message( const char* message );
void serial_hex_byte( unsigned char byte );
void serial_hex_word( unsigned short word );

int is_hex( char character );
char parse_nybble( char character );

#endif /* SERIAL_H_ */