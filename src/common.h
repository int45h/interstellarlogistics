#ifndef COMMON_H
#define COMMON_H

#include <gb/gb.h>

// Taken from https://alfaexploit.com/en/posts/gameboy_dev06/
void gbFadeIn()
{
    BGP_REG = 0xFF;    
    delay(100);
    BGP_REG = 0xFE;
    delay(100);
    BGP_REG = 0xF9;
    delay(100);
    BGP_REG = 0xE4;
    delay(100);
}

void gbFadeOut()
{
    BGP_REG = 0xE4;    
    delay(100);
    BGP_REG = 0xF9;
    delay(100);
    BGP_REG = 0xFE;
    delay(100);
    BGP_REG = 0xFF;
    delay(100);
}

#endif