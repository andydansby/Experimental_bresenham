org $9200

PUBLIC dxLarger         ;$9200
dxLarger:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;#9200
;fraction = deltaY - (deltaX >> 1);
    ld HL, (deltaY)
    ld DE, (deltaX)

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


;#9215
deltaX_iteration:
    ld A, (iterations)          ; this probally can be optimized out
    ld HL, (steps)              ; Load steps into H
    cp L                        ; Compare iterations (A) with steps (L)
    jp z, deltaX_iteration_end  ; If iterations = steps, exit loop



;#921F
DX_iteration_loop:
    ; Code for the loop body goes here

    ;plot or point code goes here
    ;buffer_plotX = line_x1;        line_x1
    ;buffer_plotY = line_y1;        line_y1
    ;buffer_plot();
    ;buffer_point();
    ld A, (line_x1)
    ld (plot_x),A
    ld A, (line_y1)
    ld (plot_y),A
    call _joffa_pixel2


;fraction is 16 bits and can be negative
;stepy is 8 bits and can also be negative
;line_y1 is is 16 bits and positive
;deltaX is 16 bits and also positive

;#922E
;if (fraction >= 0)
    ld HL, (fraction)           ; Load fraction into HL
    ; check to see if fraction is less than 0
    ld A, H
    or L
    jp m, DX_fraction_negative  ;check Sign flag

; only if fraction is Greater than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF
; fraction -= deltaX
    ;fraction is already in HL
    ld DE, (deltaX)
    sbc HL, DE
    ld (fraction), HL

;line_y1 += stepy;
    ld a, (stepy)
    ld hl, (line_y1) ; Load line_y1 into HL

    ; Load stepy into E and clear D
    ld e, a          ; Load stepy into E
    xor a            ; clear D
    ld d, a          ;

    add hl, de
    ld (line_y1), hl    ;save answer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;inside IF

;if fraction is less than 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;outside IF


;fraction is 16 bits and can be negative
;stepy is 8 bits and can also be negative
;stepx is 8 bits and can also be negative
;line_y1 is is 16 bits and positive
;line_x1 is is 16 bits and positive
;deltaX is 16 bits and also positive
;deltaY is 16 bits and also positive


DX_fraction_negative:   ; #924D
; line_x1 += stepx
    xor A           ; set D to 0
    ld D, A
    ld A, (stepx)   ; Load stepx into E
    ld E, A
    ld HL, (line_x1); Load line_x1 into HL
    add HL, DE
    ld (line_x1), HL; answer


;fraction += deltaY;    //
    ld HL, (fraction)
    ld DE, (deltaY)
    add HL, DE
    ld (fraction), HL


;#9267
; iterations++
    ;increase iterations, place just before deltaX_iteration_end
    ld A, (iterations)      ; Load iterations into A
    inc A                   ; Increment iterations
    ld (iterations), A      ; Store the incremented value back to iterations
    jp deltaX_iteration    ; Repeat the loop

deltaX_iteration_end:
    jp deltaX_iteration_end





;;;;;;;;;;;;
; STOPPED
;;;;;;;;;;;;

