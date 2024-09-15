
org $9050
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
negativeDY:
    ld A, -1
    ld (stepy), A
    jp dy_step_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDY:
    ld A, 1
    ld (stepy), A
    jp dy_step_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
negativeDX:
    ld A, -1
    ld (stepx), A
    jp dx_step_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
positiveDX:
    ld A, 1
    ld (stepx), A
    jp dx_step_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;from http://z80-heaven.wikidot.com/math#toc12
absHL:
    bit 7,h
    ret z

    xor a
    sub l
    ld l,a
    sbc a,a
    sub h
    ld h,a
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;calculate Steps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int steps = (deltaX > deltaY) ? deltaX : deltaY;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if (deltaX > deltaY) {
;    steps = deltaX;
;} else {
;    steps = deltaY;
;}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Assuming deltaX and deltaY are 16-bit values and steps is an 8-bit value
steps_calculation:

    ld HL, (deltaX)      ; Load deltaX into HL
    ld DE, (deltaY)      ; Load deltaY into DE

    ; Compare deltaX and deltaY
    or A                 ; Clear the carry flag
    sbc HL, DE           ; Subtract DE from HL with carry

    ; If deltaX > deltaY, set steps to deltaX
    jp p, set_steps_to_deltaX

    ; Else, set steps to deltaY
    ld A, (deltaY)
    ld (steps), A
    jp end_steps

set_steps_to_deltaX:
    ld A, (deltaX)
    ld (steps), A

end_steps:
ret
