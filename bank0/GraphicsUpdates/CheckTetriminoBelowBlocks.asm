
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking below blocks to see if tetrimino should be placed
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
		STA temp2
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
		;; making sure that the below block is not the default
		;; background tile (weird bug) or the bottom of the playgrid
		CMP #$00
		BEQ GoToCheckBelowBlocksDone
		CMP #$81
		BEQ GoToCheckBelowBlocksDone

		LDA yBlock1
		CMP #06
		BEQ GoToCheckBelowBlocksDone

		;; since below block exists, we will want to place the
		;; current tetrimino blocks later
		INC isPlaceBlocks
	GetTetriminoBlockPositions:
		;; starting off low and high pointers at below block start
		;; pointer so we can transition backwards
		LDA belowBlocksLowPointer
		STA pointerLow
		LDA belowBlocksHighPointer
		STA pointerHigh

		LDX #0
		JMP GetTetriminoBottomRowPosition
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; jumps to end of entire check below blocks process, this is
	;; placed in the middle of the subroutines so that it can be
	;; accessed easily
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoToCheckBelowBlocksDone:
		JMP CheckBelowBlocksDone
	GetTetriminoBottomRowPositionDecrementLow:
		DEC pointerLow
	GetTetriminoBottomRowPosition:
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		INX

		CMP #0
		BEQ GetTetriminoBottomRowPositionDecrementLow

		CPX #32
		BNE GetTetriminoBottomRowPosition

		LDA pointerLow
		STA bottomRowLowPointer
		LDA pointerHigh
		STA bottomRowHighPointer

		LDX #0
		JMP GetTetriminoTopRowPosition

	GetTetriminoTopRowPositionDecrementLow:
		DEC pointerLow
	GetTetriminoTopRowPosition:
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		INX

		CMP #0
		BEQ GetTetriminoTopRowPositionDecrementLow

		CPX #32
		BNE GetTetriminoTopRowPosition

		LDA pointerLow
		STA topRowLowPointer
		LDA pointerHigh
		STA topRowHighPointer

		LDA #IS_CANCELLED
		STA belowBlocksLowPointer

		JMP PlaceTetrimino
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking below blocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBelowBlocksDone:
		;; resetting PPU data address
		LDA #0
		STA PPU_ADDRESS
		STA PPU_ADDRESS

		LDX #0
