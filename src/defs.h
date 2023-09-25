#ifndef DEFS_H
#define DEFS_H

#include <gb/gb.h>

#define GB_TRUE     1
#define GB_FALSE    0

typedef uint8_t     U8;
typedef uint8_t     B8;
typedef uint16_t    U16;
typedef uint32_t    U32;

typedef uint8_t     P2;
typedef enum {
    GB_UP,
    GB_DOWN,
    GB_LEFT,
    GB_RIGHT,
} GbPointDirection;

#define GB_MAKE_POINT2(x,y) (((y&7)<<3)|(x&7))
#define GB_ADD_POINT2(a,b)  ((((a&56)+(b&56))&56) | (((a&7)+(b&7))&7))
#define GB_SUB_POINT2(a,b)  ((((a&56)-(b&56))&56) | (((a&7)-(b&7))&7))

typedef struct {
    U8 input;
} GbGlobalState;

#endif