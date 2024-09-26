org $9300

PUBLIC dyLarger         ;$9300
dyLarger:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;#9200
;fraction = deltaX - (deltaY >> 1);
    ld HL, (deltaX)
    ld DE, (deltaY)

    ; Right shift deltaX by 1 (equivalent to dividing by 2)
    srl D                       ; Shift the high byte right
    rr E                        ; Rotate right through carry the low byte

    ; Subtract (deltaX >> 1) from deltaY
    or A                        ; Clear the carry flag
    sbc HL, DE                  ; Subtract DE from HL with carry

    ; Store the result in fraction
    LD (fraction), HL


;for (iterations = 0; iterations <= steps; iterations++)
    ;initilize iterations loop
    xor A                       ; Clear A (equivalent to ld A, 0)
    ld (iterations), A          ; set iterations to 0





DY_forever_loop2:			;$9257
    jp DY_forever_loop2

end_DY_larger:

