#define REENTRANT
#include <gb/gb.h>
#include <gbdk/console.h>

#include <stdio.h>
#include <rand.h>
#include <time.h>

#include "scene1.h"

U8 gbCountdownSeconds(U8 max_time, U8 start_time)
{
    return max_time - ((time(NULL)-start_time) % (max_time+1));
}

void main()
{
    scene1Start();
    scene1Update();
}