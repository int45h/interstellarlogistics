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
#define END_OF_ROW(x) (((x+1) % BOX_W) == 0)
#define NOT_END_OF_ROW(x) (((x+1) % BOX_W) != 0)

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
        if (END_OF_ROW(x))
            putchar('\n');
    ));
}

U8 gbCountdownSeconds(U8 max_time, U8 start_time)
{
    return max_time - ((time(NULL)-start_time) % (max_time+1));
}

const U8 pkgLossFactor[5] = {205, 180, 154, 128, 64};

void gbFindChanceOfLostPkg(GbGameState *pState)
{
    U8  chance          = 64,
        modifier        = 0,
        lossIdx         = 0,
        idx             = 0;

    GB_ITERATE_MAP(idx, GB_FUNCTION_BODY(
        // Go through each row starting from the front
        // If there are any packages, set the factor
        // to 7*
        if (NOT_END_OF_ROW(x))
        {
            if (y < 5)
                modifier += pState->m_map[(7-y)*BOX_TRUEW + x] != 0;
        }
        else
        {
            if (modifier == 0)
                continue;

            lossIdx = (y < 5) ? y : 4;
            modifier = rand()%(modifier<<2);

            // chance of loss = ((7-y)+1)*255/10 + mod(rand(), pkgs_in_row*4)
            chance = pkgLossFactor[lossIdx] + modifier;
            modifier = 0;

            // Exit early
            break;
        }
    ));

    printf("Package loss%%: %d%%\n", (chance*100) / 255);
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

    gbFindChanceOfLostPkg(&state);

    while(1)
    {
        input = joypad();
        //countdown = gbCountdownSeconds(max_time, start_time);
        //rng_val = rand();    
        //printf("%d\n", rng_val);
        //if (!((input & J_UP) > 0))
        //    continue;
    
        //cls();
        //gbPrintTiles();
    }
}