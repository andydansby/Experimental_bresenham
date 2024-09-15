org $9200

;if (deltaX > deltaY)

PUBLIC dxLarger         ;$9200
dxLarger:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    xor A                       ; Clear A (equivalent to ld A, 0)
    ld (iterations), A

deltaX_iteration:
    ld A, (iterations)
    ld H, A                     ; Store iterations in H for comparison
    ld A, (steps)               ; Load steps into A
    cp H                        ; Compare steps with iterations
    jr c, DX_iteration_loop     ; Jump to loop body if iterations <= steps
    jp deltaX_iteration_end     ; Jump to end if iterations > steps





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




;if (fraction >= 0)
    ld HL, (fraction)           ; Load fraction into HL

; Check if fraction is negative
    bit 7, h
    jp m, DX_fraction_negative  ;fraction is negative

;line_y1 += stepy;
;fraction is already in HL
    ;ld A, 0
    ;ld D, A
    ;ld A, (stepy)
    ;ld E, A
    ;add HL, DE
    ;ld (line_y1), HL
    ld A, (stepy)
    ld E, A
    ld D, 0
    ld HL, (line_y1)
    add HL, DE
    ld (line_y1), HL



; fraction -= deltaX
    ld DE, (deltaX)
    ld HL, (fraction)
    sbc HL, DE
    ld (fraction), HL


DX_fraction_negative:
;line_x1 += stepx;
;    ld HL, (line_x1)
;    ld A, 0
;    ld D, A
;    ld A, (stepx)
;    ld E, A
;    add HL, DE
;    ld (line_x1), HL


; line_x1 += stepx
    ld HL, (line_x1)
    ld A, (stepx)
    ld E, A
    ld D, 0
    add HL, DE
    ld (line_x1), HL


;fraction += deltaY;
    ld HL, (fraction)
    ld DE, (deltaY)
    add HL, DE
    ld (fraction), HL



; iterations++
    ;increase iterations, place just before deltaX_iteration_end
    ld A, (iterations)      ; Load iterations into A
    inc A                   ; Increment iterations
    ld (iterations), A      ; Store the incremented value back to iterations
    jp DX_iteration_loop    ; Repeat the loop

deltaX_iteration_end:
    jp deltaX_iteration_end





;;;;;;;;;;;;
; STOPPED
;;;;;;;;;;;;

