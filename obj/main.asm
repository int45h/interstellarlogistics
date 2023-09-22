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
	.globl _gbCountdownSeconds
	.globl _gbPrintTiles
	.globl _gbInitTiles
	.globl _time
	.globl _rand
	.globl _initrand
	.globl _printf
	.globl _putchar
	.globl _joypad
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
;src/main.c:41: void gbInitTiles(GbGameState *pState)
;	---------------------------------
; Function gbInitTiles
; ---------------------------------
_gbInitTiles::
	ld	c, e
	ld	b, d
;src/main.c:44: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
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
;src/main.c:47: }
	ret
;src/main.c:49: void gbPrintTiles(GbGameState *pState)
;	---------------------------------
; Function gbPrintTiles
; ---------------------------------
_gbPrintTiles::
	dec	sp
	dec	sp
;src/main.c:52: GB_ITERATE_MAP(i, GB_FUNCTION_BODY(
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
;src/main.c:57: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "%c "
	.db 0x00
;src/main.c:59: U8 gbCountdownSeconds(U8 max_time, U8 start_time)
;	---------------------------------
; Function gbCountdownSeconds
; ---------------------------------
_gbCountdownSeconds::
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
;src/main.c:61: return max_time - ((time(NULL)-start_time) % (max_time+1));
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
;src/main.c:62: }
	ret
;src/main.c:64: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-64
;src/main.c:66: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:71: start_time  = time(NULL);
	ld	de, #0x0000
	call	_time
;src/main.c:75: initrand(start_time);
	ld	b, #0x00
	push	bc
	call	_initrand
	pop	hl
;src/main.c:77: gbInitTiles(&state);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_gbInitTiles
;src/main.c:78: printf("%d\n", countdown);
	ld	de, #0x0000
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;src/main.c:79: gbPrintTiles(&state);
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_gbPrintTiles
;src/main.c:81: while(1)
00102$:
;src/main.c:83: input = joypad();
	call	_joypad
;src/main.c:85: rng_val = rand();    
	call	_rand
;src/main.c:86: printf("%d\n", rng_val);
	ld	d, #0x00
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
	jr	00102$
;src/main.c:93: }
	add	sp, #64
	ret
___str_1:
	.ascii "%d"
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
