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
	.globl _gbFindChanceOfLostPkg
	.globl _gbCountdownSeconds
	.globl _gbPrintTiles
	.globl _gbInitTiles
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
;src/main.c:43: void gbInitTiles(GbGameState *pState)
;	---------------------------------
; Function gbInitTiles
; ---------------------------------
_gbInitTiles::
	ld	c, e
	ld	b, d
;src/main.c:46: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
	ld	e, #0x00
00106$:
	ld	a, e
	and	a, #0x07
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	srl	l
	srl	l
	srl	l
	sub	a, #0x06
	jr	NC, 00104$
	ld	a, l
	sub	a, #0x08
	jr	NC, 00104$
	ld	l, e
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0x57
00104$:
	inc	e
	ld	a, e
	sub	a, #0x40
	jr	C, 00106$
;src/main.c:49: }
	ret
;src/main.c:51: void gbPrintTiles(GbGameState *pState)
;	---------------------------------
; Function gbPrintTiles
; ---------------------------------
_gbPrintTiles::
	dec	sp
	dec	sp
;src/main.c:54: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
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
	ld	bc, #___str_0
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
;src/main.c:59: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "%c "
	.db 0x00
;src/main.c:61: U8 gbCountdownSeconds(U8 max_time, U8 start_time)
;	---------------------------------
; Function gbCountdownSeconds
; ---------------------------------
_gbCountdownSeconds::
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/main.c:63: return max_time - ((time(NULL)-start_time) % (max_time+1));
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
;src/main.c:64: }
	ret
;src/main.c:68: void gbFindChanceOfLostPkg(GbGameState *pState)
;	---------------------------------
; Function gbFindChanceOfLostPkg
; ---------------------------------
_gbFindChanceOfLostPkg::
	add	sp, #-6
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:70: U8  chance          = 64,
	ldhl	sp,	#0
;src/main.c:71: modifier        = 0,
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:75: GB_ITERATE_MAP(idx, GB_FUNCTION_BODY(
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
;src/main.c:101: printf("Package loss%%: %d%%\n", (chance*100) / 255);
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
	ld	de, #___str_1
	push	de
	call	_printf
;src/main.c:102: }
	add	sp, #10
	ret
_pkgLossFactor:
	.db #0xcd	; 205
	.db #0xb4	; 180
	.db #0x9a	; 154
	.db #0x80	; 128
	.db #0x40	; 64
___str_1:
	.ascii "Package loss%%: %d%%"
	.db 0x0a
	.db 0x00
;src/main.c:104: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-64
;src/main.c:106: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:111: start_time  = time(NULL);
	ld	de, #0x0000
	call	_time
;src/main.c:115: initrand(start_time);
	ld	b, #0x00
	push	bc
	call	_initrand
	pop	hl
;src/main.c:117: gbInitTiles(&state);
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	push	bc
	call	_gbInitTiles
	ld	de, #0x0000
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
	pop	bc
;src/main.c:119: gbPrintTiles(&state);
	ld	e, c
	ld	d, b
	push	bc
	call	_gbPrintTiles
;src/main.c:121: gbFindChanceOfLostPkg(&state);
	pop	de
	call	_gbFindChanceOfLostPkg
;src/main.c:123: while(1)
00102$:
;src/main.c:125: input = joypad();
	call	_joypad
	jr	00102$
;src/main.c:135: }
	add	sp, #64
	ret
___str_2:
	.ascii "%d"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
