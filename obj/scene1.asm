;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (Linux)
;--------------------------------------------------------
	.module scene1
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _scene1End
	.globl _scene1UpdateCursor
	.globl _scene1UpdatePlayerActions
	.globl _scene1UpdateCountdown
	.globl _scene1InitCounter
	.globl _scene1InitBG
	.globl _scene1InitMap
	.globl _scene1PrintMap
	.globl _gbFloodFill
	.globl _gbMapSampleNeighbor
	.globl _gbSampleDirection
	.globl _gbPointInBounds
	.globl _gbFindChanceOfLostPkg
	.globl _gbQueuePop
	.globl _gbQueuePush
	.globl _gbFadeOut
	.globl _gbFadeIn
	.globl _gbCountdownSeconds
	.globl _printf
	.globl _putchar
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _delay
	.globl _time
	.globl _rand
	.globl _initrand
	.globl _start_time
	.globl _max_time
	.globl _rng_val
	.globl _countdown
	.globl _input
	.globl _state
	.globl _pkgLossFactor
	.globl _number_start_index
	.globl _scene1Start
	.globl _scene1Update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_state::
	.ds 64
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_input::
	.ds 1
_countdown::
	.ds 1
_rng_val::
	.ds 1
_max_time::
	.ds 1
_start_time::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/utils.h:8: static void copy_U8_array(uint8_t *dest, const uint8_t* source, uint8_t size)
;	---------------------------------
; Function copy_U8_array
; ---------------------------------
_copy_U8_array:
	add	sp, #-5
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	inc	sp
	inc	sp
	push	bc
;src/utils.h:10: while (size != 0)
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
00101$:
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;src/utils.h:12: dest[size-1] = source[size-1];
	ld	a, (hl-)
	ld	c, a
	ld	b, #0x00
	dec	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, bc
	ld	e, l
	ld	d, h
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	(de), a
;src/utils.h:13: --size;
	ldhl	sp,	#4
	dec	(hl)
	jr	00101$
00104$:
;src/utils.h:15: }
	add	sp, #5
	pop	hl
	inc	sp
	jp	(hl)
;src/utils.h:17: static void* memcpy(void *dest, const void *source, uint16_t size)
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy:
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
;src/utils.h:19: uint8_t*        dest_u8 = dest;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
;src/utils.h:20: const uint8_t*  src_u8  = source;
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils.h:22: while (size)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00101$:
	ld	a, b
	or	a, c
	jr	Z, 00103$
;src/utils.h:24: dest_u8[size-1] = src_u8[size-1];
	ld	e, c
	ld	d, b
	dec	de
	push	de
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#4
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src/utils.h:25: --size;
	dec	bc
	jr	00101$
00103$:
;src/utils.h:28: return dest;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/utils.h:29: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;src/common.h:8: U8 gbCountdownSeconds(U8 max_time, U8 start_time)
;	---------------------------------
; Function gbCountdownSeconds
; ---------------------------------
_gbCountdownSeconds::
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/common.h:10: return max_time - ((time(NULL)-start_time) % (max_time+1));
	push	hl
	push	de
	ld	de, #0x0000
	call	_time
	pop	de
	pop	hl
	ld	a, c
	ld	d, #0x00
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	d, a
	ld	c, l
	ld	b, #0x00
	inc	bc
	push	hl
	call	__moduint
	pop	hl
	ld	a, l
	sub	a, c
;src/common.h:11: }
	ret
_number_start_index:
	.db #0x64	; 100	'd'
;src/common.h:15: void gbFadeIn()
;	---------------------------------
; Function gbFadeIn
; ---------------------------------
_gbFadeIn::
;src/common.h:17: BGP_REG = 0xFF;    
	ld	a, #0xff
	ldh	(_BGP_REG + 0), a
;src/common.h:18: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:19: BGP_REG = 0xFE;
	ld	a, #0xfe
	ldh	(_BGP_REG + 0), a
;src/common.h:20: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:21: BGP_REG = 0xF9;
	ld	a, #0xf9
	ldh	(_BGP_REG + 0), a
;src/common.h:22: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:23: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/common.h:24: delay(100);
	ld	de, #0x0064
;src/common.h:25: }
	jp	_delay
;src/common.h:27: void gbFadeOut()
;	---------------------------------
; Function gbFadeOut
; ---------------------------------
_gbFadeOut::
;src/common.h:29: BGP_REG = 0xE4;    
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/common.h:30: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:31: BGP_REG = 0xF9;
	ld	a, #0xf9
	ldh	(_BGP_REG + 0), a
;src/common.h:32: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:33: BGP_REG = 0xFE;
	ld	a, #0xfe
	ldh	(_BGP_REG + 0), a
;src/common.h:34: delay(100);
	ld	de, #0x0064
	call	_delay
;src/common.h:35: BGP_REG = 0xFF;
	ld	a, #0xff
	ldh	(_BGP_REG + 0), a
;src/common.h:36: delay(100);
	ld	de, #0x0064
;src/common.h:37: }
	jp	_delay
;src/scene1.c:16: B8 gbQueuePush( P2 xy, 
;	---------------------------------
; Function gbQueuePush
; ---------------------------------
_gbQueuePush::
	ld	c, a
;src/scene1.c:19: if (pQueue->m_size >= GB_MAX_QUEUE_LENGTH)
	ld	hl, #0x0040
	add	hl, de
	ld	a, (hl)
	cp	a, #0x40
	jr	C, 00102$
;src/scene1.c:20: return FALSE;
	xor	a, a
	ret
00102$:
;src/scene1.c:22: pQueue->m_queue[pQueue->m_size++] = xy;
	ld	b, a
	inc	b
	ld	(hl), b
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/scene1.c:23: return TRUE;
	ld	a, #0x01
;src/scene1.c:24: }
	ret
;src/scene1.c:26: B8 gbQueuePop(  P2 *xy, 
;	---------------------------------
; Function gbQueuePop
; ---------------------------------
_gbQueuePop::
	push	de
;src/scene1.c:29: if (pQueue->m_size == 0)
	ld	hl, #0x0040
	add	hl, bc
	ld	a, (hl)
;src/scene1.c:30: return FALSE;
	or	a,a
	jr	Z, 00103$
;src/scene1.c:32: *xy = pQueue->m_queue[--pQueue->m_size];
	dec	a
	ld	(hl), a
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, (hl)
	pop	hl
	push	hl
	ld	(hl), c
;src/scene1.c:33: return TRUE;
	ld	a, #0x01
00103$:
;src/scene1.c:34: }
	inc	sp
	inc	sp
	ret
;src/scene1.c:59: void gbFindChanceOfLostPkg(Scene1_State *pState)
;	---------------------------------
; Function gbFindChanceOfLostPkg
; ---------------------------------
_gbFindChanceOfLostPkg::
	add	sp, #-6
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/scene1.c:61: U8  chance          = 64,
	ldhl	sp,	#0
;src/scene1.c:62: modifier        = 0,
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x00
;src/scene1.c:66: GB_ITERATE_MAP(idx, GB_FUNCTION_BODY(
	ldhl	sp,	#5
	ld	(hl), #0x00
00113$:
	ldhl	sp,	#5
	ld	a, (hl)
	and	a, #0x07
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#5
	ld	e, (hl)
	srl	e
	srl	e
	srl	e
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x06
	jr	NC, 00111$
	ld	a, e
	sub	a, #0x08
	jr	NC, 00111$
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	d, b
	push	de
	ld	bc, #0x0006
	ld	e, l
	call	__modsint
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	a, e
	sub	a, #0x05
	ld	a, #0x00
	rla
	ld	c, a
	ld	a, b
	or	a, l
	jr	Z, 00109$
	ld	a, c
	or	a, a
	jr	Z, 00111$
	ld	a, #0x07
	sub	a, e
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	add	a, c
	ld	e, a
	ld	d, #0x00
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	sub	a,#0x01
	ld	a, #0x00
	rla
	xor	a, #0x01
	ldhl	sp,	#1
	ld	c, (hl)
	add	a, c
	ld	(hl), a
	jr	00111$
00109$:
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	ld	a, c
	or	a, a
	jr	NZ, 00117$
	ld	de, #0x0004
00117$:
	ldhl	sp,	#5
	ld	(hl), e
	call	_rand
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	d, #0x00
	ld	c, l
	ld	b, h
	call	__modsint
	ld	de, #_pkgLossFactor
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ldhl	sp,	#0
	ld	(hl), a
	jr	00112$
00111$:
	ldhl	sp,	#5
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x40
	jp	C, 00113$
00112$:
;src/scene1.c:92: printf("Package loss%%: %d%%\n", (chance*100) / 255);
	ldhl	sp,	#0
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	bc, #0x00ff
	ld	e, l
	ld	d, h
	call	__divsint
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
;src/scene1.c:93: }
	add	sp, #10
	ret
_pkgLossFactor:
	.db #0xcd	; 205
	.db #0xb4	; 180
	.db #0x9a	; 154
	.db #0x80	; 128
	.db #0x40	; 64
___str_0:
	.ascii "Package loss%%: %d%%"
	.db 0x0a
	.db 0x00
;src/scene1.c:96: B8 gbPointInBounds(P2 xy)
;	---------------------------------
; Function gbPointInBounds
; ---------------------------------
_gbPointInBounds::
;src/scene1.c:98: return (((xy & 7) < 6) && ((xy >> 3) < 8));
	ld	c, a
	and	a, #0x07
	sub	a, #0x06
	jr	NC, 00103$
	ld	a, c
	swap	a
	rlca
	and	a, #0x1f
	sub	a, #0x08
	jr	C, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/scene1.c:99: }
	ret
;src/scene1.c:101: P2 gbSampleDirection(   P2 xy, 
;	---------------------------------
; Function gbSampleDirection
; ---------------------------------
_gbSampleDirection::
	dec	sp
	dec	sp
	ld	c, a
	ld	a, e
;src/scene1.c:104: P2 next_point = xy;
	ld	e, c
;src/scene1.c:108: next_point =    xy + 1;
	ldhl	sp,	#0
	ld	(hl), c
;src/scene1.c:119: next_point =    (xy & 0x07) | 
	inc	hl
	push	af
	ld	a, c
	and	a, #0x07
	ld	(hl), a
	pop	af
;src/scene1.c:105: switch (dir)
	or	a, a
	jr	Z, 00103$
	cp	a, #0x01
	jr	Z, 00104$
;src/scene1.c:109: next_point =    (xy & 0x38) | 
	push	af
	ld	a, c
	and	a, #0x38
	ld	c, a
	pop	af
;src/scene1.c:105: switch (dir)
	cp	a, #0x02
	jr	Z, 00102$
	sub	a, #0x03
	jr	NZ, 00105$
;src/scene1.c:108: next_point =    xy + 1;
	dec	hl
	ld	a, (hl)
	inc	a
;src/scene1.c:110: (next_point & 0x07);
	and	a, #0x07
	or	a, c
	ld	e, a
;src/scene1.c:111: break;
	jr	00105$
;src/scene1.c:112: case GB_LEFT:
00102$:
;src/scene1.c:113: next_point =    xy - 1;
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
;src/scene1.c:115: (next_point & 0x07);
	and	a, #0x07
	or	a, c
	ld	e, a
;src/scene1.c:116: break;
	jr	00105$
;src/scene1.c:117: case GB_UP:
00103$:
;src/scene1.c:118: next_point =    xy + 8;
	ldhl	sp,	#0
;src/scene1.c:120: (next_point & 0x38);
	ld	a, (hl+)
	add	a, #0x08
	and	a, #0x38
	or	a, (hl)
	ld	e, a
;src/scene1.c:121: break;
	jr	00105$
;src/scene1.c:122: case GB_DOWN:
00104$:
;src/scene1.c:123: next_point =    xy - 8;
	ldhl	sp,	#0
;src/scene1.c:125: (next_point & 0x38);
	ld	a, (hl+)
	add	a, #0xf8
	and	a, #0x38
	or	a, (hl)
	ld	e, a
;src/scene1.c:127: }
00105$:
;src/scene1.c:129: return next_point;
	ld	a, e
;src/scene1.c:130: }
	inc	sp
	inc	sp
	ret
;src/scene1.c:133: void gbMapSampleNeighbor(   P2 current_point, 
;	---------------------------------
; Function gbMapSampleNeighbor
; ---------------------------------
_gbMapSampleNeighbor::
	add	sp, #-6
;src/scene1.c:139: P2 next_point = gbSampleDirection(current_point, dir);
	call	_gbSampleDirection
	ld	c, a
;src/scene1.c:142: if (!gbPointInBounds(next_point) || 
	push	bc
	ld	a, c
	call	_gbPointInBounds
	pop	bc
	or	a, a
	jp	Z,00110$
;src/scene1.c:143: pState->m_map[next_point] != current_color) // THIS IS A LOAD-BEARING COLOR CHECK. WITHOUT THIS, THE FUNCTION WILL FAIL.
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, b
;src/scene1.c:144: return;
	jp	NZ,00110$
;src/scene1.c:146: success = gbQueuePush(next_point, pQueue);
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_gbQueuePush
;src/scene1.c:147: if (success)
	or	a, a
;src/scene1.c:148: return;
;src/scene1.c:151: for (int i = 0; i < pQueue->m_size; i++)
	jr	NZ, 00110$
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0040
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	xor	a, a
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), a
00108$:
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00142$
	bit	7, d
	jr	NZ, 00143$
	cp	a, a
	jr	00143$
00142$:
	bit	7, d
	jr	Z, 00143$
	scf
00143$:
	jr	NC, 00106$
;src/scene1.c:155: pQueue->m_queue[i] >> 3
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	af
	swap	a
	rlca
	and	a, #0x1f
	ld	e, a
	pop	af
	ld	d, #0x00
;src/scene1.c:154: pQueue->m_queue[i] & 7,
;	spillPairReg hl
;	spillPairReg hl
	and	a, #0x07
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
;src/scene1.c:152: printf("queue[%d]: <%d,%d>\n", 
	push	bc
	push	de
	push	hl
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #8
	pop	bc
;src/scene1.c:151: for (int i = 0; i < pQueue->m_size; i++)
	ldhl	sp,	#4
	inc	(hl)
	jr	NZ, 00108$
	inc	hl
	inc	(hl)
	jr	00108$
00106$:
;src/scene1.c:159: printf("error: failed to push to queue!");
	ld	de, #___str_2
	push	de
	call	_printf
	pop	hl
00110$:
;src/scene1.c:160: }
	add	sp, #6
	pop	hl
	add	sp, #5
	jp	(hl)
___str_1:
	.ascii "queue[%d]: <%d,%d>"
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "error: failed to push to queue!"
	.db 0x00
;src/scene1.c:162: B8 gbFloodFill( P2 xy, 
;	---------------------------------
; Function gbFloodFill
; ---------------------------------
_gbFloodFill::
	add	sp, #-74
	ldhl	sp,	#73
	ld	(hl-), a
	ld	(hl), e
;src/scene1.c:172: point_queue.m_size      = 0;
	ldhl	sp,	#64
	ld	(hl), #0x00
;src/scene1.c:175: if (!gbPointInBounds(xy) || 
	ldhl	sp,	#73
	ld	a, (hl)
	call	_gbPointInBounds
	ldhl	sp,#71
	ld	(hl), a
	or	a, a
	jr	Z, 00101$
;src/scene1.c:176: pState->m_map[xy] == color)
	ldhl	sp,	#76
	ld	a, (hl)
	ldhl	sp,	#66
	ld	(hl), a
	ldhl	sp,	#77
	ld	a, (hl)
	ldhl	sp,	#67
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#73
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#71
	ld	(hl+), a
	ld	a, (hl-)
	sub	a, (hl)
	jr	NZ, 00102$
00101$:
;src/scene1.c:177: return FALSE;
	xor	a, a
	jp	00109$
00102$:
;src/scene1.c:180: start_color = pState->m_map[xy];
	ldhl	sp,	#71
	ld	a, (hl)
	ldhl	sp,	#68
	ld	(hl), a
;src/scene1.c:183: gbQueuePush(xy, &point_queue);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	ldhl	sp,	#73
	ld	a, (hl)
	call	_gbQueuePush
;src/scene1.c:185: do
00106$:
;src/scene1.c:188: gbQueuePop(&current_point, &point_queue);
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#65
	ld	e, l
	ld	d, h
	call	_gbQueuePop
;src/scene1.c:189: current_color = pState->m_map[current_point];
	ldhl	sp,	#65
	ld	a, (hl+)
	ld	e, a
	ld	d, #0x00
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#71
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#70
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/scene1.c:191: if (start_color != current_color)
	ldhl	sp,	#68
	ld	a, (hl)
	ldhl	sp,	#71
	sub	a, (hl)
	jr	NZ, 00107$
;src/scene1.c:195: pState->m_map[current_point] = color;
	ldhl	sp,#69
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/scene1.c:198: gbMapSampleNeighbor(current_point, GB_UP,      current_color, pState, &point_queue);
	ld	hl, #0
	add	hl, sp
	push	hl
	ldhl	sp,	#68
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#75
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x00
	ldhl	sp,	#70
	ld	a, (hl)
	call	_gbMapSampleNeighbor
;src/scene1.c:199: gbMapSampleNeighbor(current_point, GB_DOWN,    current_color, pState, &point_queue);
	ld	hl, #0
	add	hl, sp
	push	hl
	ldhl	sp,	#68
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#75
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x01
	ldhl	sp,	#70
	ld	a, (hl)
	call	_gbMapSampleNeighbor
;src/scene1.c:200: gbMapSampleNeighbor(current_point, GB_LEFT,    current_color, pState, &point_queue);
	ld	hl, #0
	add	hl, sp
	push	hl
	ldhl	sp,	#68
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#75
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x02
	ldhl	sp,	#70
	ld	a, (hl)
	call	_gbMapSampleNeighbor
;src/scene1.c:201: gbMapSampleNeighbor(current_point, GB_RIGHT,   current_color, pState, &point_queue);
	ld	hl, #0
	add	hl, sp
	push	hl
	ldhl	sp,	#68
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#75
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #0x03
	ldhl	sp,	#70
	ld	a, (hl)
	call	_gbMapSampleNeighbor
00107$:
;src/scene1.c:203: while (point_queue.m_size != 0);
	ldhl	sp,	#64
	ld	a, (hl)
	or	a, a
	jp	NZ, 00106$
;src/scene1.c:205: return TRUE;
	ld	a, #0x01
00109$:
;src/scene1.c:206: }
	add	sp, #74
	pop	hl
	pop	bc
	jp	(hl)
;src/scene1.c:220: void scene1PrintMap(Scene1_State *pState)
;	---------------------------------
; Function scene1PrintMap
; ---------------------------------
_scene1PrintMap::
	dec	sp
	dec	sp
;src/scene1.c:223: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
	ldhl	sp,	#1
	ld	(hl), #0x00
00108$:
	ldhl	sp,	#1
	ld	a, (hl-)
	and	a, #0x07
	ld	(hl+), a
	ld	a, (hl-)
	ld	c, a
	srl	c
	srl	c
	srl	c
	ld	a, (hl)
	sub	a, #0x06
	jr	NC, 00106$
	ld	a, c
	sub	a, #0x08
	jr	NC, 00106$
	inc	hl
	push	de
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	push	de
	push	bc
	ld	bc, #___str_3
	push	bc
	call	_printf
	add	sp, #4
	pop	de
	ldhl	sp,	#0
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	push	de
	ld	bc, #0x0006
	ld	e, l
	ld	d, h
	call	__modsint
	pop	de
	ld	a, b
	or	a, c
	jr	NZ, 00106$
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	call	_putchar
	inc	sp
	pop	de
00106$:
	ldhl	sp,	#1
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x40
	jr	C, 00108$
;src/scene1.c:228: }
	inc	sp
	inc	sp
	ret
___str_3:
	.ascii "%d "
	.db 0x00
;src/scene1.c:230: void scene1InitMap(Scene1_State *pState)
;	---------------------------------
; Function scene1InitMap
; ---------------------------------
_scene1InitMap::
	add	sp, #-64
	ld	c, e
	ld	b, d
;src/scene1.c:232: const U8 COCK_RING[] = 
	ldhl	sp,	#0
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a,#0x01
	ld	(hl+),a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/scene1.c:244: memcpy(pState->m_map, COCK_RING, sizeof(COCK_RING));
	ld	hl, #0
	add	hl, sp
	ld	e, c
	ld	d, b
	ld	bc, #0x0040
	push	bc
	ld	c, l
	ld	b, h
	call	_memcpy
;src/scene1.c:249: }
	add	sp, #64
	ret
;src/scene1.c:251: void scene1InitBG()
;	---------------------------------
; Function scene1InitBG
; ---------------------------------
_scene1InitBG::
;src/scene1.c:257: scene1_2_tileset
;src/scene1.c:255: 0, 
	ld	de, #_scene1_2_tileset
	push	de
	ld	hl, #0x6e00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/scene1.c:265: scene1_2_tilemap
;src/scene1.c:261: 0, 
	ld	de, #_scene1_2_tilemap
	push	de
	ld	hl, #0x1314
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/scene1.c:268: set_bkg_tile_xy(4, 3, scene1_2_tileset_size-2);
	ld	hl, #0x6c03
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/scene1.c:271: gbFadeIn();
;src/scene1.c:272: }
	jp	_gbFadeIn
;src/scene1.c:274: void scene1InitCounter()
;	---------------------------------
; Function scene1InitCounter
; ---------------------------------
_scene1InitCounter::
;src/scene1.c:276: set_bkg_tile_xy(16, 3, number_start_index + (max_time / 10));
	ld	hl, #_max_time
	ld	e, (hl)
	ld	d, #0x00
	ld	bc, #0x000a
	call	__divsint
	ld	a, c
	add	a, #0x64
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/scene1.c:277: set_bkg_tile_xy(17, 3, number_start_index + (max_time % 10));
	ld	hl, #_max_time
	ld	e, (hl)
	ld	d, #0x00
	ld	bc, #0x000a
	call	__modsint
	ld	a, c
	add	a, #0x64
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/scene1.c:278: }
	ret
;src/scene1.c:281: B8 scene1UpdateCountdown()
;	---------------------------------
; Function scene1UpdateCountdown
; ---------------------------------
_scene1UpdateCountdown::
	dec	sp
	dec	sp
;src/scene1.c:283: U8  old_countdown   = countdown;
	ld	hl, #_countdown
	ld	c, (hl)
;src/scene1.c:284: countdown = gbCountdownSeconds(max_time, start_time);
	push	bc
	ld	hl, #_start_time
	ld	e, (hl)
	ld	a, (#_max_time)
	call	_gbCountdownSeconds
	pop	bc
;src/scene1.c:287: if (old_countdown - countdown > 0)
	ld	(#_countdown),a
	ld	b, #0x00
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	c, e
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00112$
	bit	7, d
	jr	NZ, 00113$
	cp	a, a
	jr	00113$
00112$:
	bit	7, d
	jr	Z, 00113$
	scf
00113$:
	jr	NC, 00102$
;src/scene1.c:289: set_bkg_tile_xy(16, 3, number_start_index + (countdown / 10));
	ld	bc, #0x000a
	pop	de
	push	de
	call	__divsint
	ld	a, c
	add	a, #0x64
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x10
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;src/scene1.c:290: set_bkg_tile_xy(17, 3, number_start_index + (countdown % 10));
	ld	hl, #_countdown
	ld	e, (hl)
	ld	d, #0x00
	ld	bc, #0x000a
	call	__modsint
	ld	a, c
	add	a, #0x64
	ld	h, a
	ld	l, #0x03
	push	hl
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
00102$:
;src/scene1.c:292: return (countdown == 0);
	ld	a, (#_countdown)
	or	a, a
	ld	a, #0x01
	jr	Z, 00115$
	xor	a, a
00115$:
;src/scene1.c:293: }
	inc	sp
	inc	sp
	ret
;src/scene1.c:295: void scene1UpdatePlayerActions()
;	---------------------------------
; Function scene1UpdatePlayerActions
; ---------------------------------
_scene1UpdatePlayerActions::
;src/scene1.c:298: }
	ret
;src/scene1.c:300: void scene1UpdateCursor()
;	---------------------------------
; Function scene1UpdateCursor
; ---------------------------------
_scene1UpdateCursor::
;src/scene1.c:303: }
	ret
;src/scene1.c:305: void scene1Start()
;	---------------------------------
; Function scene1Start
; ---------------------------------
_scene1Start::
;src/scene1.c:308: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/scene1.c:309: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/scene1.c:312: scene1InitBG();
	call	_scene1InitBG
;src/scene1.c:313: scene1InitCounter();
	call	_scene1InitCounter
;src/scene1.c:316: initrand(start_time);
	ld	hl, #_start_time
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	call	_initrand
	pop	hl
;src/scene1.c:317: start_time = time(NULL);
	ld	de, #0x0000
	call	_time
	ld	hl, #_start_time
	ld	(hl), c
;src/scene1.c:318: scene1InitMap(&state);
	ld	de, #_state
;src/scene1.c:328: }
	jp	_scene1InitMap
;src/scene1.c:330: void scene1End()
;	---------------------------------
; Function scene1End
; ---------------------------------
_scene1End::
;src/scene1.c:332: gbFadeOut();
;src/scene1.c:333: }
	jp	_gbFadeOut
;src/scene1.c:335: void scene1Update()
;	---------------------------------
; Function scene1Update
; ---------------------------------
_scene1Update::
;src/scene1.c:337: while(1)
00104$:
;src/scene1.c:340: input = joypad();
	call	_joypad
	ld	(#_input),a
;src/scene1.c:343: if (scene1UpdateCountdown() == TRUE)
	call	_scene1UpdateCountdown
	dec	a
	jp	Z,_scene1End
;src/scene1.c:347: scene1UpdateCursor();
	call	_scene1UpdateCursor
;src/scene1.c:350: scene1UpdatePlayerActions();
	call	_scene1UpdatePlayerActions
;src/scene1.c:353: wait_vbl_done();
	call	_wait_vbl_done
;src/scene1.c:364: scene1End();
;src/scene1.c:365: }
	jr	00104$
	.area _CODE
	.area _INITIALIZER
__xinit__input:
	.db #0xff	; 255
__xinit__countdown:
	.db #0x00	; 0
__xinit__rng_val:
	.db #0x00	; 0
__xinit__max_time:
	.db #0x0a	; 10
__xinit__start_time:
	.db #0x00	; 0
	.area _CABS (ABS)
