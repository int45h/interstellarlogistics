#ifndef UTILS_H
#define UTILS_H

#define REENTRANT
#include <gb/gb.h>
#include <stdio.h>

static void* memcpy(void *dest, const void *source, uint16_t size)
{
    printf("size: %d\n", size);

    uint8_t*        dest_u8 = dest;
    const uint8_t*  src_u8  = source;
    
    while (size)
    {
        dest_u8[size-1] = src_u8[size-1];
        --size;
    }

    return dest;
}

#endif