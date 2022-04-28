
	GetTetriminoRightSide:
		;; starting off with the below block pointers, storing them
		;; in pointer low/high variable for later manipulation
		LDA belowBlocksLowPointer
		STA pointerLow
		LDA belowBlocksHighPointer
		STA pointerHigh

		;; going straight to the right bottom block pointer-
		;; generating loop
		JMP GettingRightBlockBottom
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements right below blocks low pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GettingRightBlockBottomDecrementLow:
		DEC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; creates right blocks high pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GettingRightBlockBottom:
		;; incrementing high pointer
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		;; incrementing our index by one
		INX

		;; if high pointer increments and loops around to 0, then
		;; low pointer must be decremented
		CMP #0
		BEQ GettingRightBlockBottomDecrementLow

		;; checking if X equals 30 meaning we are done
		CPX #30
		BNE GettingRightBlockBottom

		;; storing low and high pointers into appropriate variables
		LDA pointerLow
		STA rightBottomBlockLowPointer
		LDA pointerHigh
		STA rightBottomBlockHighPointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Done getting right side of tetrimino.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoRightSideDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
