
	CheckBelowBlocksStartup:
		;; if the blow block low pointer is equal to the cancellation
		;; byte then we skip to the end of this entire process
		LDA belowBlocksLowPointer
		CMP #IS_CANCELLED
		BEQ GoToCheckBelowBlocksDone

		;; going to official start of checking low blocks
		JMP CheckBelowBlocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; jumps to end of entire check below blocks process
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoToCheckBelowBlocksDone:
		JMP CheckBelowBlocksDone

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking below blocks to see if tetrimino should be placed
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBelowBlocks:
		;; loading offset in PPU address where below blocks in
		;; nametable should be stored
		LDA belowBlocksLowPointer
		STA PPU_ADDRESS
		STA temp5
		LDA belowBlocksHighPointer
		STA PPU_ADDRESS
		STA temp6

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
		;; making sure that the below block is not the default
		;; background tile (weird bug) or the bottom of the playgrid
		CMP #$00
		BEQ GoToCheckBelowBlocksDone
		CMP #$81
		BEQ GoToCheckBelowBlocksDone

		LDA #0
		STA PPU_ADDRESS
		STA PPU_ADDRESS

		;LDA belowBlocksLowPointer
		;STA PPU_ADDRESS
		;LDA belowBlocksHighPointer
		;STA PPU_ADDRESS

		;LDA PPU_DATA
		;STA temp1

		;CMP #TETRIMINO_BLANK_TILE
		;BEQ GoToCheckBelowBlocksDone

		LDA belowBlocksLowPointer
		STA temp5
		LDA belowBlocksHighPointer
		STA temp6


		LDA yBlock1
		CMP #07
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
		;STA temp5
		LDA pointerHigh
		STA bottomRowHighPointer
		;STA temp6

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
		;STA temp5
		LDA pointerHigh
		STA topRowHighPointer
		;STA temp6

		LDA #IS_CANCELLED
		STA belowBlocksLowPointer

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking below blocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBelowBlocksDone:
		;; resetting PPU data address
		;LDA #0
		;STA PPU_ADDRESS
		;STA PPU_ADDRESS

		;LDA $2002

		LDX #0
