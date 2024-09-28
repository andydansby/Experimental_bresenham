org $8080

;input variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
line_x1:	defw 0 		;$8080	line start point X
line_y1:	defw 5 		;$8082	line start point Y
line_x2:	defw 5  	;$8084	line end point X
line_y2:	defw 0		;$8086	line end point Y
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



PUBLIC deltaX
	deltaX:			defw 0000   ;$
PUBLIC deltaY
	deltaY:			defw 0000   ;$

PUBLIC stepx
    stepx:		defb 00         ;$
PUBLIC stepy
    stepy:		defb 00		    ;$
PUBLIC steps
    steps:      defb 00         ;$

PUBLIC fraction			        ;$
fraction:	defw 0000

iterations:	defb 00


PUBLIC plot_x			;$809A
plot_x:		defb 00

PUBLIC plot_y			;$809B
plot_y:		defb 00

PUBLIC X_PositionBits	;$80A5
X_PositionBits:
defb 128,64,32,16,8,4,2,1

