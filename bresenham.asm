include "variables.asm"
include "routines.asm"
include "dx_larger.asm"
include "dy_larger.asm"
;include "plot.asm"
include "plot2.asm"

org	$8000
start:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in variables.asm
; you will find x1, y1, x2 and y2
; as
; gfx_x1, gfx_y1, gfx_x2, gfx_y1
; gfx_x, gfx_y as used exclusively for
; _joffa_pixel2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;plot the first pixel x1, y1
;was here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int deltaX = abs(xx2 - xx1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_deltaX:
    ld HL, (line_x2)    ; Load xx2 into register pair HL
    ld DE, (line_x1)    ; Load xx1 into register pair DE
    or A                ; Clear the carry flag
    sbc HL, DE          ; Subtract DE from HL with borrow
    ;;;;;;
    ;answer in HL

    ;now calculate the absolute value
    call absHL
    ;answer in HL
    ld (deltaX), HL     ; Store the result in deltaX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int deltaY = abs(yy2 - yy1);
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_deltaY:       ; #8010
    ld HL, (line_y2)    ; Load xx2 into register pair HL
    ld DE, (line_y1)    ; Load xx1 into register pair DE
    or A                ; Clear the carry flag
    sbc HL, DE          ; Subtract DE from HL with borrow
    ;;;;;;
    ;answer in HL

    ;now calculate the absolete value
    call absHL
    ;answer in HL
    ld (deltaY), HL ; Store the result in deltaX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;now we are calculating STEP X & Y to determine the direction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;int stepx = (xx1 < xx2) ? 1 : -1;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calculate_stepX:
    or A                ;clear carry flag
	ld HL, (line_x2)    ; load point X2
    ld DE, (line_x1)    ; load point X1

    sbc HL, DE          ; x2 - x1 answer in HL
    ld A, 1             ; Default to 1
    jr z, stepX_equal
    jr nc, stepX_answer

stepX_equal:
    ld A, -1            ; otherwise -1

stepX_answer:
    ld (stepx), A       ;answer in A

dx_step_end:

;<---------------------
; stepx has answer -1 if X2 is larger
; stepx has answer  1 if X1 is larger or equal


;;;;;;;;;;;;
;int stepy = (yy1 < yy2) ? 1 : -1;
;;;;;;;;;;;;
calculate_stepY:
    or a                ;clear carry flag
	ld HL, (line_y2)    ; load point X2
    ld DE, (line_y1)    ; load point X1

    sbc HL, DE          ; x2 - x1 answer in HL
	ld A, 1             ; Default to 1
	jr z, stepY_equal
    jr nc, stepY_answer

stepY_equal:
    ld A, -1            ; otherwise -1

stepY_answer:
    ld (stepy), A

dy_step_end:
;<---------------------
; stepy has answer -1 if Y2 is larger
; stepy has answer  1 if Y1 is larger or equal


steps_calc:
;steps = max (deltaX,deltaY)
    ld HL, (deltaX)      ; Load deltaX into HL
    ld DE, (deltaY)      ; Load deltaY into DE

    ; Compare deltaX and deltaY
    or A                 ; Clear the carry flag
    sbc HL, DE           ; Subtract DE from HL with carry

    ; If deltaX >= deltaY, set steps to deltaX
    jp p, deltaX_MAX

    ; Else, set steps to deltaY
deltaY_MAX:
    ld HL, (deltaY)
    ld A, L
    ld (steps), A
    jp end_steps_calc

deltaX_MAX:
    ld HL, (deltaX)
    ld A, L
    ld (steps), A

end_steps_calc:



DYorDY_start:
	xor a				;clear flags
	ld HL, (deltaY)
	ld DE, (deltaX)
	sbc HL, DE          ; deltaX - deltaY answer in HL

	jp m, dxLarger      ;check to see if greater
                        ; sign flag IS set
                        ;$9200

	jp p, dyLarger      ;check to see if lesser
                        ; sign flag NOT set
                        ;$9300

	jp z, dyLarger      ;check to see if equal
                        ;if so the DY larger
                        ;$9300




PUBLIC bresenham_end
bresenham_end:


ret

