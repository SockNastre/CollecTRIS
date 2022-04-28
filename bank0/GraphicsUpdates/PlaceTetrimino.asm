
	PlaceTetrimino:
		;STA temp2

		;; checking if blocks are to be placed, if they are not then
		;; we skip placing the tetrimino
		LDA isPlaceBlocks
		;STA temp1
		CMP #FALSE
		BEQ PlaceTetriminoDone

		;; setting background to load at top row pointer
		LDA topRowLowPointer
		STA PPU_ADDRESS
		LDA topRowHighPointer
		STA PPU_ADDRESS

		;; storing top row blocks
		LDA $0201
		STA PPU_DATA
		LDA $0205
		STA PPU_DATA

		;; setting background to load at bottom row pointer
		LDA bottomRowLowPointer
		STA PPU_ADDRESS
		LDA bottomRowHighPointer
		STA PPU_ADDRESS

		;; storing bottom row blocks
		LDA $0209
		STA PPU_DATA
		LDA $020D
		STA PPU_DATA

		;; tetrimino is no longer drawn, and blocks are no longer
		;; to be placed
		DEC isTetriminoDrawn
		DEC isPlaceBlocks

		JMP EnableGraphicsRendering
	PlaceTetriminoDone:
		;; resetting PPU data address
		LDA #0
		STA PPU_ADDRESS
		STA PPU_ADDRESS