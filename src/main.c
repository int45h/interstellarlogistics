#define REENTRANT
#include <gb/gb.h>
#include <gbdk/console.h>

#include <stdio.h>
#include <rand.h>
#include <time.h>

#define GB_TRUE     1
#define GB_FALSE    0

typedef uint8_t     U8;
typedef uint8_t     B8;
typedef uint16_t    U16;
typedef uint32_t    U32;

#define BOX_W 6
#define BOX_H 8
#define BOX_TRUEW 8
#define BOX_TRUEH 8


typedef struct {
    U8 m_map[BOX_TRUEW*BOX_TRUEH];
} GbGameState;

#define GB_ITERATE_MAP(idx, body) \
    U8  x = 0,\
        y = 0;\
    for (idx = 0; idx < BOX_TRUEW*BOX_TRUEH; idx++)\
    {\
        x = idx  & 7;\
        y = idx >> 3;\
        if (x >= BOX_W || y >= BOX_H )\
            continue;\
            body\
    }

#define GB_FUNCTION_BODY(...) __VA_ARGS__

void gbInitTiles(GbGameState *pState)
{    
    U8 i = 0;
    GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
        pState->m_map[i] = 'W';
    ));
}

void gbPrintTiles(GbGameState *pState)
{
    U8 i = 0;
    GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
        printf("%c ", pState->m_map[i]);
        if (((x+1) % BOX_W) == 0)
            putchar('\n');
    ));
}

U8 gbCountdownSeconds(U8 max_time, U8 start_time)
{
    return max_time - ((time(NULL)-start_time) % (max_time+1));
}

void main()
{
    DISPLAY_ON;
    U8  input       = 255,
        countdown   = 0,
        rng_val     = 0,
        max_time    = 20,
        start_time  = time(NULL);

    GbGameState state;

    initrand(start_time);

    gbInitTiles(&state);
    printf("%d\n", countdown);
    gbPrintTiles(&state);

    while(1)
    {
        input = joypad();
        //countdown = gbCountdownSeconds(max_time, start_time);
        rng_val = rand();    
        printf("%d\n", rng_val);
        //if (!((input & J_UP) > 0))
        //    continue;
    
        //cls();
        //gbPrintTiles();
    }
}