
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; starts process of getting blocks below tetrimino
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBlocksBelowTetrimino:
		;; preparing low and high pointers for bottom row
		LDA #$20
		STA pointerLow
		LDA #$00
		STA pointerHigh

		;; resetting Y register and going into high pointer
		;; generation loop for bottom block pointer
		LDY #0
		JMP IncrementBelowBlocksHighY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments below blocks low pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementBelowBlocksLow:
		INC pointerLow
		JMP IncrementBelowBlocksHighX2
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; resetting X register to load next chunk (1 chunk = 32 bytes)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementBelowBlocksHighY:
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; creates below blocks high pointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementBelowBlocksHighX:
		;; incrementing high pointer
		LDA pointerHigh
		CLC
		ADC #1
		STA pointerHigh

		;; if high pointer increments and loops around to 0, then
		;; low pointer must be incremented
		CMP #0
		BEQ IncrementBelowBlocksLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; second part of below block high pointer creation
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementBelowBlocksHighX2:
		;; incrementing X register, checking if X equals 32 meaning
		;; one chunk is over with
		INX
		CPX #32
		BNE IncrementBelowBlocksHighX

		;; incrementing Y register, checking if Y equals the Y block
		;; position of the bottom left tetrimino block
		INY
		CPY yBlock1
		BNE IncrementBelowBlocksHighY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; now we will begin to go to the blocks below the current
	;; tetrimino, as we are one row behind that
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoToBelowBlocks:
		LDX #0
		JMP BelowBlocksHighPointerFixLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; fixes (increments) low pointer of below blocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BelowBlocksLowPointerFixLoop:
		INC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; fixes high pointer of below blocks to become accurate
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BelowBlocksHighPointerFixLoop:
		;; incrementing high pointer
		LDA pointerHigh
		CLC
		ADC #1
		STA pointerHigh

		;; if high pointer increments and loops around to 0, then
		;; low pointer must be incremented
		CMP #0
		BEQ BelowBlocksLowPointerFixLoop

		;; incrementing X register, checking if X equals the bottom
		;; left block's X block position yet
		INX
		CPX xBlock1
		BNE BelowBlocksHighPointerFixLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; below block pointer generation done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BelowBlocksPointerGenerationDone:
		;; storing low and high pointers into below blocks low and
		;; high pointer variables
		LDA pointerLow
		STA belowBlocksLowPointer
		LDA pointerHigh
		STA belowBlocksHighPointer

		;; skipping cancelation subroutine
		JMP GetBlocksBelowTetriminoDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; should be called when below block pointers need to be
	;; nullified
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBlocksBelowTetriminoCancel:
		LDA #IS_CANCELLED
		STA belowBlocksLowPointer
		STA belowBlocksHighPointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; getting blocks below tetrimino is now done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBlocksBelowTetriminoDone:
		;; resetting X/Y registers and A accumulator
		LDX #0
		LDY #0
		LDA #0
