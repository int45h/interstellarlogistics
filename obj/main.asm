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
	.globl _scene1Update
	.globl _scene1Start
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
;src/main.c:11: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:13: scene1Start();
	call	_scene1Start
;src/main.c:14: scene1Update();
;src/main.c:15: }
	jp	_scene1Update
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
