CheckThreat:
 push	{r4, r5, r6, r7, lr}
 ldr	r4, [pc, #32]	; (24 <SkipCap+0x6>)
 ldrb	r5, [r4, #19]
 ldrb	r6, [r4, #21]
 subs	r7, r5, r6
 cmp	r7, #0
 bge.n	10 <SkipNeg>
 movs	r7, #0
SkipNeg:
 ldrb	r0, [r4, #23]
 muls	r7, r0
 adds	r7, #99	; 0x63
 lsrs	r7, r7, #8
 cmp	r7, #255	; 0xff
 ble.n	1e <SkipCap>
 movs	r7, #255	; 0xff
SkipCap:
 strb	r7, [r4, #25]
 pop	{r4, r5, r6, r7, pc}
 .short	0x0000
 .word	0x0203a4d0