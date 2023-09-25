#include "scene1.h"


#define BOX_W 6
#define BOX_H 8
#define BOX_TRUEW 8
#define BOX_TRUEH 8

#define GB_MAX_QUEUE_LENGTH 64
typedef struct {
    P2 m_queue[GB_MAX_QUEUE_LENGTH];
    U8 m_size;
} GbGameQueue;

B8 gbQueuePush( P2 xy, 
                GbGameQueue *pQueue)
{
    if (pQueue->m_size >= GB_MAX_QUEUE_LENGTH)
        return FALSE;

    pQueue->m_queue[pQueue->m_size++] = xy;
    return TRUE;
}

B8 gbQueuePop(  P2 *xy, 
                GbGameQueue *pQueue)
{
    if (pQueue->m_size == 0)
        return FALSE;

    *xy = pQueue->m_queue[--pQueue->m_size];
    return TRUE;
}

typedef struct {
    U8 m_map[BOX_TRUEW*BOX_TRUEH];
} Scene1_State;

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

void gbInitMap(Scene1_State *pState)
{    
    const U8 COCK_RING[] = 
    {
        1,1,0,0,0,0,0,0,
        1,1,1,1,0,0,0,0,
        1,1,1,1,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,1,1,0,0,0,
        0,0,0,1,1,0,0,0,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
    };
    
    memcpy(pState->m_map, COCK_RING, sizeof(COCK_RING));
    //U8 i = 0;
    //GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
    //    pState->m_map[i] = 'W';
    //));
}

void gbPrintMap(Scene1_State *pState)
{
    U8 i = 0;
    GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
        printf("%d ", pState->m_map[i]);
        if (END_OF_ROW(x))
            putchar('\n');
    ));
}


const U8 pkgLossFactor[5] = {205, 180, 154, 128, 64};

void gbFindChanceOfLostPkg(Scene1_State *pState)
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

// Check if point is within the bounds of the map
B8 gbPointInBounds(P2 xy)
{
    return (((xy & 7) < 6) && ((xy >> 3) < 8));
}

P2 gbSampleDirection(   P2 xy, 
                        GbPointDirection dir)
{
    P2 next_point = xy;
    switch (dir)
    {
        case GB_RIGHT:
            next_point =    xy + 1;
            next_point =    (xy & 0x38) | 
                            (next_point & 0x07);
            break;
        case GB_LEFT:
            next_point =    xy - 1;
            next_point =    (xy & 0x38) | 
                            (next_point & 0x07);
            break;
        case GB_UP:
            next_point =    xy + 8;
            next_point =    (xy & 0x07) | 
                            (next_point & 0x38);
            break;
        case GB_DOWN:
            next_point =    xy - 8;
            next_point =    (xy & 0x07) | 
                            (next_point & 0x38);
            break;
    }

    return next_point;
}

// I LEGITIMATELY HAVE NO CLUE HOW THE FUCK THIS CODE IS ACTUALLY FUNCTIONING
void gbMapSampleNeighbor(   P2 current_point, 
                            GbPointDirection dir,
                            U8 current_color, 
                            Scene1_State *pState,
                            GbGameQueue *pQueue)
{
    P2 next_point = gbSampleDirection(current_point, dir);
    B8 success = TRUE;

    if (!gbPointInBounds(next_point) || 
        pState->m_map[next_point] != current_color) // THIS IS A LOAD-BEARING COLOR CHECK. WITHOUT THIS, THE FUNCTION WILL FAIL.
        return;

    success = gbQueuePush(next_point, pQueue);
    if (success)
        return;
    
    // FAILURE
    for (int i = 0; i < pQueue->m_size; i++)
        printf("queue[%d]: <%d,%d>\n", 
            i, 
            pQueue->m_queue[i] & 7,
            pQueue->m_queue[i] >> 3
        );
    
    gbPrintMap(pState);
    printf("error: failed to push to queue!");
}

B8 gbFloodFill( P2 xy, 
                U8 color,
                Scene1_State *pState)
{
    GbGameQueue point_queue;
    P2  current_point;
    U8  current_color,
        start_color;

    // Initialize queues
    point_queue.m_size      = 0;
    
    // Check if out of bounds, or if the color is already set to the desired color
    if (!gbPointInBounds(xy) || 
        pState->m_map[xy] == color)
        return FALSE;

    // Sample the starting color
    start_color = pState->m_map[xy];

    // Push the current position to the back of the point and visitor queue
    gbQueuePush(xy, &point_queue);
    
    do
    {
        // Pop the last position off the head of the queue, get the color
        gbQueuePop(&current_point, &point_queue);
        current_color = pState->m_map[current_point];

        if (start_color != current_color)
            continue;

        // Set the new color here
        pState->m_map[current_point] = color;

        // Sample neighbors
        gbMapSampleNeighbor(current_point, GB_UP,      current_color, pState, &point_queue);
        gbMapSampleNeighbor(current_point, GB_DOWN,    current_color, pState, &point_queue);
        gbMapSampleNeighbor(current_point, GB_LEFT,    current_color, pState, &point_queue);
        gbMapSampleNeighbor(current_point, GB_RIGHT,   current_color, pState, &point_queue);
    }
    while (point_queue.m_size != 0);

    return TRUE;
}

// Scene1 global state
Scene1_State state;
// Global vars, SUPER ROUGH
U8  input       = 255,
    countdown   = 0,
    rng_val     = 0,
    max_time    = 20,
    start_time  = 0;

void scene1Start()
{
    // Init RNG, timing, map
    initrand(start_time);
    start_time = time(NULL);
    gbInitMap(&state);

    DISPLAY_ON;
    SHOW_BKG;
    
    set_bkg_data(
        0, 
        scene1_2_tileset_size, 
        scene1_2_tileset
    );
    set_bkg_tiles(
        0, 
        0, 
        scene1_2_tilemap_width, 
        scene1_2_tilemap_height, 
        scene1_2_tilemap
    );
    set_bkg_tile_xy(4, 3, scene1_2_tileset_size-2);

    //gbFindChanceOfLostPkg(&state);
    //gbFloodFill(
    //    GB_MAKE_POINT2(0, 0), 
    //    3, 
    //    &state
    //);
    //gbPrintMap(&state);
}

void scene1Update()
{
    while(1)
    {
        input = joypad();

        wait_vbl_done();
        //countdown = gbCountdownSeconds(max_time, start_time);
        //rng_val = rand();    
        //printf("%d\n", rng_val);
        //if (!((input & J_UP) > 0))
        //    continue;
    
        //cls();
        //gbPrintTiles();
    }
}