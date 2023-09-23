;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _gbFloodFill
	.globl _gbMapSampleNeighbor
	.globl _gbSampleDirection
	.globl _gbPointInBounds
	.globl _gbFindChanceOfLostPkg
	.globl _gbCountdownSeconds
	.globl _gbPrintMap
	.globl _gbInitMap
	.globl _gbQueuePop
	.globl _gbQueuePush
	.globl _time
	.globl _rand
	.globl _initrand
	.globl _printf
	.globl _putchar
	.globl _joypad
	.globl _pkgLossFactor
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;src/utils.h:8: static void* memcpy(void *dest, const void *source, uint16_t size)
;	---------------------------------
; Function memcpy
; ---------------------------------
_memcpy:
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/utils.h:10: printf("size: %d\n", size);
	push	bc
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
	pop	bc
;src/utils.h:12: uint8_t*        dest_u8 = dest;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
;src/utils.h:13: const uint8_t*  src_u8  = source;
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils.h:15: while (size)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00101$:
	ld	a, b
	or	a, c
	jr	Z, 00103$
;src/utils.h:17: dest_u8[size-1] = src_u8[size-1];
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
;src/utils.h:18: --size;
	dec	bc
	jr	00101$
00103$:
;src/utils.h:21: return dest;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/utils.h:22: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
___str_0:
	.ascii "size: %d"
	.db 0x0a
	.db 0x00
;src/main.c:39: B8 gbQueuePush( P2 xy, 
;	---------------------------------
; Function gbQueuePush
; ---------------------------------
_gbQueuePush::
	ld	c, a
;src/main.c:42: if (pQueue->m_size >= GB_MAX_QUEUE_LENGTH)
	ld	hl, #0x0040
	add	hl, de
	ld	a, (hl)
	cp	a, #0x40
	jr	C, 00102$
;src/main.c:43: return FALSE;
	xor	a, a
	ret
00102$:
;src/main.c:45: pQueue->m_queue[pQueue->m_size++] = xy;
	ld	b, a
	inc	b
	ld	(hl), b
	ld	l, a
	ld	h, #0x00
	add	hl, de
	ld	(hl), c
;src/main.c:46: return TRUE;
	ld	a, #0x01
;src/main.c:47: }
	ret
;src/main.c:49: B8 gbQueuePop(  P2 *xy, 
;	---------------------------------
; Function gbQueuePop
; ---------------------------------
_gbQueuePop::
	push	de
;src/main.c:52: if (pQueue->m_size == 0)
	ld	hl, #0x0040
	add	hl, bc
	ld	a, (hl)
;src/main.c:53: return FALSE;
	or	a,a
	jr	Z, 00103$
;src/main.c:55: *xy = pQueue->m_queue[--pQueue->m_size];
	dec	a
	ld	(hl), a
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, (hl)
	pop	hl
	push	hl
	ld	(hl), c
;src/main.c:56: return TRUE;
	ld	a, #0x01
00103$:
;src/main.c:57: }
	inc	sp
	inc	sp
	ret
;src/main.c:79: void gbInitMap(GbGameState *pState)
;	---------------------------------
; Function gbInitMap
; ---------------------------------
_gbInitMap::
	add	sp, #-64
	ld	c, e
	ld	b, d
;src/main.c:81: const U8 COCK_RING[] = 
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
;src/main.c:93: memcpy(pState->m_map, COCK_RING, sizeof(COCK_RING));
	ld	hl, #0
	add	hl, sp
	ld	e, c
	ld	d, b
	ld	bc, #0x0040
	push	bc
	ld	c, l
	ld	b, h
	call	_memcpy
;src/main.c:98: }
	add	sp, #64
	ret
;src/main.c:100: void gbPrintMap(GbGameState *pState)
;	---------------------------------
; Function gbPrintMap
; ---------------------------------
_gbPrintMap::
	dec	sp
	dec	sp
;src/main.c:103: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
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
	ld	bc, #___str_1
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
;src/main.c:108: }
	inc	sp
	inc	sp
	ret
___str_1:
	.ascii "%c "
	.db 0x00
;src/main.c:110: U8 gbCountdownSeconds(U8 max_time, U8 start_time)
;	---------------------------------
; Function gbCountdownSeconds
; ---------------------------------
_gbCountdownSeconds::
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/main.c:112: return max_time - ((time(NULL)-start_time) % (max_time+1));
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
;src/main.c:113: }
	ret
;src/main.c:117: void gbFindChanceOfLostPkg(GbGameState *pState)
;	---------------------------------
; Function gbFindChanceOfLostPkg
; ---------------------------------
_gbFindChanceOfLostPkg::
	add	sp, #-6
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:119: U8  chance          = 64,
	ldhl	sp,	#0
;src/main.c:120: modifier        = 0,
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:124: GB_ITERATE_MAP(idx, GB_FUNCTION_BODY(
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
;src/main.c:150: printf("Package loss%%: %d%%\n", (chance*100) / 255);
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
	ld	de, #___str_2
	push	de
	call	_printf
;src/main.c:151: }
	add	sp, #10
	ret
_pkgLossFactor:
	.db #0xcd	; 205
	.db #0xb4	; 180
	.db #0x9a	; 154
	.db #0x80	; 128
	.db #0x40	; 64
___str_2:
	.ascii "Package loss%%: %d%%"
	.db 0x0a
	.db 0x00
;src/main.c:157: B8 gbPointInBounds(P2 xy)
;	---------------------------------
; Function gbPointInBounds
; ---------------------------------
_gbPointInBounds::
;src/main.c:159: return (((xy & 7) < 6) && ((xy >> 3) < 8));
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
;src/main.c:160: }
	ret
;src/main.c:162: P2 gbSampleDirection(   P2 xy, 
;	---------------------------------
; Function gbSampleDirection
; ---------------------------------
_gbSampleDirection::
	dec	sp
	dec	sp
	ld	c, a
	ld	a, e
;src/main.c:165: P2 next_point = xy;
	ld	e, c
;src/main.c:169: next_point =    xy + 1;
	ldhl	sp,	#0
	ld	(hl), c
;src/main.c:180: next_point =    (xy & 0x07) | 
	inc	hl
	push	af
	ld	a, c
	and	a, #0x07
	ld	(hl), a
	pop	af
;src/main.c:166: switch (dir)
	or	a, a
	jr	Z, 00103$
	cp	a, #0x01
	jr	Z, 00104$
;src/main.c:170: next_point =    (xy & 0x38) | 
	push	af
	ld	a, c
	and	a, #0x38
	ld	c, a
	pop	af
;src/main.c:166: switch (dir)
	cp	a, #0x02
	jr	Z, 00102$
	sub	a, #0x03
	jr	NZ, 00105$
;src/main.c:169: next_point =    xy + 1;
	dec	hl
	ld	a, (hl)
	inc	a
;src/main.c:171: (next_point & 0x07);
	and	a, #0x07
	or	a, c
	ld	e, a
;src/main.c:172: break;
	jr	00105$
;src/main.c:173: case GB_LEFT:
00102$:
;src/main.c:174: next_point =    xy - 1;
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
;src/main.c:176: (next_point & 0x07);
	and	a, #0x07
	or	a, c
	ld	e, a
;src/main.c:177: break;
	jr	00105$
;src/main.c:178: case GB_UP:
00103$:
;src/main.c:179: next_point =    xy + 8;
	ldhl	sp,	#0
;src/main.c:181: (next_point & 0x38);
	ld	a, (hl+)
	add	a, #0x08
	and	a, #0x38
	or	a, (hl)
	ld	e, a
;src/main.c:182: break;
	jr	00105$
;src/main.c:183: case GB_DOWN:
00104$:
;src/main.c:184: next_point =    xy - 8;
	ldhl	sp,	#0
;src/main.c:186: (next_point & 0x38);
	ld	a, (hl+)
	add	a, #0xf8
	and	a, #0x38
	or	a, (hl)
	ld	e, a
;src/main.c:188: }
00105$:
;src/main.c:190: return next_point;
	ld	a, e
;src/main.c:191: }
	inc	sp
	inc	sp
	ret
;src/main.c:194: void gbMapSampleNeighbor(   P2 current_point, 
;	---------------------------------
; Function gbMapSampleNeighbor
; ---------------------------------
_gbMapSampleNeighbor::
	add	sp, #-8
;src/main.c:200: P2 next_point = gbSampleDirection(current_point, dir);
	call	_gbSampleDirection
	ld	c, a
;src/main.c:203: if (!gbPointInBounds(next_point) || 
	push	bc
	ld	a, c
	call	_gbPointInBounds
	pop	bc
	or	a, a
	jp	Z,00110$
;src/main.c:204: pState->m_map[next_point] != current_color) // THIS IS A LOAD-BEARING COLOR CHECK. WITHOUT THIS, THE FUNCTION WILL FAIL.
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	pop	de
	push	de
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, b
;src/main.c:205: return;
	jp	NZ,00110$
;src/main.c:207: success = gbQueuePush(next_point, pQueue);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	call	_gbQueuePush
;src/main.c:208: if (success)
	or	a, a
;src/main.c:209: return;
;src/main.c:212: for (int i = 0; i < pQueue->m_size; i++)
	jp	NZ,00110$
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0040
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00108$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
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
;src/main.c:216: pQueue->m_queue[i] >> 3
	ldhl	sp,	#6
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
;src/main.c:215: pQueue->m_queue[i] & 7,
;	spillPairReg hl
;	spillPairReg hl
	and	a, #0x07
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
;src/main.c:213: printf("queue[%d]: <%d,%d>\n", 
	push	bc
	push	de
	push	hl
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #8
	pop	bc
;src/main.c:212: for (int i = 0; i < pQueue->m_size; i++)
	ldhl	sp,	#6
	inc	(hl)
	jr	NZ, 00108$
	inc	hl
	inc	(hl)
	jr	00108$
00106$:
;src/main.c:219: gbPrintMap(pState);
	pop	de
	push	de
	call	_gbPrintMap
;src/main.c:220: printf("error: failed to push to queue!");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
00110$:
;src/main.c:221: }
	add	sp, #8
	pop	hl
	add	sp, #5
	jp	(hl)
___str_3:
	.ascii "queue[%d]: <%d,%d>"
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "error: failed to push to queue!"
	.db 0x00
;src/main.c:223: B8 gbFloodFill( P2 xy, 
;	---------------------------------
; Function gbFloodFill
; ---------------------------------
_gbFloodFill::
	add	sp, #-74
	ldhl	sp,	#73
	ld	(hl-), a
	ld	(hl), e
;src/main.c:234: point_queue.m_size      = 0;
	ldhl	sp,	#64
	ld	(hl), #0x00
;src/main.c:237: if (!gbPointInBounds(xy) || 
	ldhl	sp,	#73
	ld	a, (hl)
	call	_gbPointInBounds
	ldhl	sp,#71
	ld	(hl), a
	or	a, a
	jr	Z, 00101$
;src/main.c:238: pState->m_map[xy] == color)
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
;src/main.c:239: return FALSE;
	xor	a, a
	jp	00109$
00102$:
;src/main.c:242: start_color = pState->m_map[xy];
	ldhl	sp,	#71
	ld	a, (hl)
	ldhl	sp,	#68
	ld	(hl), a
;src/main.c:245: gbQueuePush(xy, &point_queue);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	ldhl	sp,	#73
	ld	a, (hl)
	call	_gbQueuePush
;src/main.c:247: do
00106$:
;src/main.c:250: gbQueuePop(&current_point, &point_queue);
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#65
	ld	e, l
	ld	d, h
	call	_gbQueuePop
;src/main.c:251: current_color = pState->m_map[current_point];
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
;src/main.c:253: if (start_color != current_color)
	ldhl	sp,	#68
	ld	a, (hl)
	ldhl	sp,	#71
	sub	a, (hl)
	jr	NZ, 00107$
;src/main.c:257: pState->m_map[current_point] = color;
	ldhl	sp,#69
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/main.c:260: gbMapSampleNeighbor(current_point, GB_UP,      current_color, pState, &point_queue);
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
;src/main.c:261: gbMapSampleNeighbor(current_point, GB_DOWN,    current_color, pState, &point_queue);
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
;src/main.c:262: gbMapSampleNeighbor(current_point, GB_LEFT,    current_color, pState, &point_queue);
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
;src/main.c:263: gbMapSampleNeighbor(current_point, GB_RIGHT,   current_color, pState, &point_queue);
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
;src/main.c:265: while (point_queue.m_size != 0);
	ldhl	sp,	#64
	ld	a, (hl)
	or	a, a
	jp	NZ, 00106$
;src/main.c:267: return TRUE;
	ld	a, #0x01
00109$:
;src/main.c:268: }
	add	sp, #74
	pop	hl
	pop	bc
	jp	(hl)
;src/main.c:270: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-64
;src/main.c:272: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:277: start_time  = time(NULL);
	ld	de, #0x0000
	call	_time
;src/main.c:281: initrand(start_time);
	ld	b, #0x00
	push	bc
	call	_initrand
	pop	hl
;src/main.c:283: gbInitMap(&state);
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	push	bc
	call	_gbInitMap
	pop	bc
;src/main.c:285: gbPrintMap(&state);
	ld	e, c
	ld	d, b
	push	bc
	call	_gbPrintMap
;src/main.c:287: gbFindChanceOfLostPkg(&state);
	pop	de
	call	_gbFindChanceOfLostPkg
;src/main.c:289: while(1)
00102$:
;src/main.c:291: input = joypad();
	call	_joypad
	jr	00102$
;src/main.c:301: }
	add	sp, #64
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
