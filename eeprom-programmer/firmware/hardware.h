/*
 * hardware.h
 *
 * Created: 7/19/2020 11:05:05 AM
 *  Author: olegk
 */ 

#ifndef HARDWARE_H_
#define HARDWARE_H_

void hardware_init();

unsigned char hardware_read_byte( unsigned short address );
void hardware_write_byte( unsigned short address, unsigned char byte );

#endif /* HARDWARE_H_ */