
	CheckBelowBlocks:
		;; loading offset in PPU address where below blocks in
		;; nametable should be stored
		LDA belowBlocksLowPointer
		STA PPU_ADDRESS
		LDA belowBlocksHighPointer
		STA PPU_ADDRESS

		;; discarding last PPU data byte
		LDA PPU_DATA

		;; checking if first block below tetrimino is not blank
		LDA PPU_DATA
		CMP #TETRIMINO_BLANK_TILE
		BNE BelowBlockExists

		;; checking if second block below tetrimino is not blank
		LDA PPU_DATA
		CMP #TETRIMINO_BLANK_TILE
		BNE BelowBlockExists

		;; since neither below block was non-blank, process is done
		JMP CheckBelowBlocksDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; handling first or second below block existing
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BelowBlockExists:
		;; since below block exists, we will want to place the
		;; current tetrimino blocks later
		INC isPlaceBlocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; getting block positions of current tetrimino to place
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoBlockPositions:
		;; starting off low and high pointers at below block start
		;; pointer so we can transition backwards
		LDA belowBlocksLowPointer
		STA pointerLow
		LDA belowBlocksHighPointer
		STA pointerHigh

		;; starting index X at one
		LDX #0
		;; going to tetrimino bottom row position-generating code
		JMP GetTetriminoBottomRowPosition
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements low pointer of tetrimino bottom row position
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoBottomRowPositionDecrementLow:
		DEC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements high pointer of tetrimino bottom row position
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoBottomRowPosition:
		;; decrementing the high pointer
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		;; incrementing index by one
		INX

		;; if high pointer has swung around back to 0, then we must
		;; decrement the low pointer now
		CMP #0
		BEQ GetTetriminoBottomRowPositionDecrementLow

		;; once X reaches 32 we are done (bottom row is set up)
		CPX #32
		BNE GetTetriminoBottomRowPosition

		;; storing low and high pointers in appropriate variables
		LDA pointerLow
		STA bottomRowLowPointer
		LDA pointerHigh
		STA bottomRowHighPointer

		;; starting index X at one
		LDX #0
		;; going to tetrimino top row position-generating code
		JMP GetTetriminoTopRowPosition
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements low pointer of tetrimino top row position
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoTopRowPositionDecrementLow:
		DEC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements high pointer of tetrimino top row position
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetTetriminoTopRowPosition:
		;; decrementing the high pointer
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		;; incrementing index by one
		INX

		;; if high pointer has swung around back to 0, then we must
		;; decrement the low pointer now
		CMP #0
		BEQ GetTetriminoTopRowPositionDecrementLow

		;; once X reaches 32 we are done (top row is set up)
		CPX #32
		BNE GetTetriminoTopRowPosition

		;; storing low and high pointers in appropriate variables
		LDA pointerLow
		STA topRowLowPointer
		LDA pointerHigh
		STA topRowHighPointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking below blocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBelowBlocksDone:
