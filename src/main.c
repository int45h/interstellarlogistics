#define REENTRANT
#include <gb/gb.h>
#include <gbdk/console.h>

#include <stdio.h>
#include <rand.h>
#include <time.h>

#include "scene1.h"

void main()
{
    scene1Start();
    scene1Update();
}