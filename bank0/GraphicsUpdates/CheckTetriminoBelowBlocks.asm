
	;; in theory, if this code is made to work it should allow blocks
	;; to be placed on blocks, lines 432 through 435 are the problem
	;CheckBelowBlocksStartup:
	;	LDA belowBlocksLowPointer
	;	CMP #IS_CANCELLED
	;	BEQ GoToPlaceTetrimino

	;	JMP CheckBelowBlocks
	;GoToPlaceTetrimino:
	;	JMP PlaceTetrimino
	;CheckBelowBlocks:
	;	LDA belowBlocksLowPointer
	;	STA $2006
	;	LDA belowBlocksHighPointer
	;	STA $2006

	;	LDA $2007
	;	STA temp2
	;	CMP #TETRIMINO_BLANK_TILE
	;	BNE BelowBlockExists

		;; weird bug where I have to load another byte from PPU data
		;; port else the next below block is never loaded
		;; LDA $2007

	;	LDA $2007
	;	CMP #TETRIMINO_BLANK_TILE
	;	BNE BelowBlock2Exists

	;	LDA #$0D
	;	STA temp1

	;	JMP PlaceTetrimino
	;BelowBlockExists:
		;; fixes weird bug where below block is detected at very start of the
		;; game (when it should not be detected)
		;CMP #$00
		;BEQ PlaceTetrimino

	;	CMP #$81
	;	BEQ PlaceTetrimino

	;	LDA #$03
	;	STA temp1
	;	LDA #$68
	;	STA temp3

	;	LDA ticks
	;	CMP #0
	;	BNE PlaceTetrimino

		;LDA belowBlocksLowPointer
		;STA temp5
		;LDA belowBlocksHighPointer
		;STA temp6

	;	JMP PlaceTetrimino
	;BelowBlock2Exists:
	;	CMP #$81
	;	BEQ PlaceTetrimino

	;	LDA #$04
	;	STA temp1
	;	LDA #$69
	;	STA temp4
	;	LDA $2007
	;	CMP #TETRIMINO_BLANK_TILE
	;	BNE BelowBlockExists

	;	;; resetting PPU data address
	;	LDA #0
	;	STA $2006
	;	STA $2006

	;	JMP BelowBlockDoesNotExist
	;BelowBlockExists:
	;	LDA belowBlocksLowPointer
	;	STA topRowLowPointer
	;	LDA belowBlocksHighPointer
	;	STA topRowHighPointer
	;BelowBlockDecrementTopLow:
	;	DEC topRowLowPointer
	;BelowBlockDecrementTopHigh:
	;	LDA topRowHighPointer
	;	SEC
	;	SBC #1
	;	STA topRowHighPointer

	;	CMP #0
	;	BEQ BelowBlockDecrementTopLow

	;	INX
	;	CPX #64
	;	BNE BelowBlockDecrementTopHigh

	;	LDA belowBlocksLowPointer
	;	STA bottomRowLowPointer
	;	LDA belowBlocksHighPointer
	;	STA bottomRowHighPointer

	;BelowBlockDecrementBottomLow:
	;	DEC topRowLowPointer
	;BelowBlockDecrementBottomHigh:
	;	LDA topRowHighPointer
	;	SEC
	;	SBC #1
	;	STA topRowHighPointer

	;	CMP #0
	;	BEQ BelowBlockDecrementBottomLow

	;	INX
	;	CPX #64
	;	BNE BelowBlockDecrementBottomHigh

	;	INC isPlaceBlocks

	;	JMP PlaceTetrimino
	;BelowBlockDoesNotExist:

		;LDA belowBlocksLowPointer
		;STA $2006
		;LDA belowBlocksHighPointer
		;STA $2006

		;LDA #$49
		;STA $2007

		;LDA #00
		;STA $2006
		;STA $2006
