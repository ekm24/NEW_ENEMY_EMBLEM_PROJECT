.thumb
.align

.global CheckThreat
.type CheckThreat, %function

CheckThreat:
    push {r4-r7, lr}     @ Save registers
    ldr r4, =0x203A4D0   @ Load target unit data (example pointer)
    ldrb r5, [r4, #0x13] @ Load attack stat
    ldrb r6, [r4, #0x15] @ Load defense stat

    sub r7, r5, r6       @ Calculate damage
    cmp r7, #0           @ Ensure damage is non-negative
    bge SkipNeg
    mov r7, #0           @ Set to 0 if negative
SkipNeg:

    ldrb r0, [r4, #0x17] @ Load hit chance
    mul r7, r0           @ Threat = Damage * HitChance
    add r7, #99          @ Add 99 for rounding
    lsr r7, r7, #8       @ Divide by 100 (scaled threat)

    cmp r7, #255         @ Cap at 255
    ble SkipCap
    mov r7, #255
SkipCap:

    strb r7, [r4, #0x19] @ Store threat value

    pop {r4-r7, pc}      @ Restore registers and return
