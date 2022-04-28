
	GetTetriminoLeftSide:
		;; starting off with the below block pointers, storing them
		;; in pointer low/high variable for later manipulation
		LDA belowBlocksLowPointer
		STA pointerLow
		LDA belowBlocksHighPointer
		STA pointerHigh

		;; going straight to the left bottom block pointer-generating
		;; loop
		JMP GettingLeftBlockBottom
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements left below blocks low pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GettingLeftBlockBottomDecrementLow:
		DEC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; creates left blocks high pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GettingLeftBlockBottom:
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
		BEQ GettingLeftBlockBottomDecrementLow

		;; checking if X equals 33 meaning we are done
		CPX #33
		BNE GettingLeftBlockBottom

		;; storing low and high pointers into appropriate variables
		LDA pointerLow
		STA leftBottomBlockLowPointer
		LDA pointerHigh
		STA leftBottomBlockHighPointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Done getting left side of tetrimino.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoLeftSideDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
