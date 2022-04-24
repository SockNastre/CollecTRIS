
	PlaceTetrimino:
		;; checking if blocks are to be placed, if they are not then
		;; we skip placing the tetrimino
		LDA isPlaceBlocks
		CMP #FALSE
		BEQ EnableGraphicsRendering

		;; setting background to load at top row pointer
		LDA topRowLowPointer
		STA $2006
		LDA topRowHighPointer
		STA $2006

		;; storing top row blocks
		LDA $0201
		STA $2007
		LDA $0205
		STA $2007

		;; setting background to load at bottom row pointer
		LDA bottomRowLowPointer
		STA $2006
		LDA bottomRowHighPointer
		STA $2006

		;; storing bottom row blocks
		LDA $0209
		STA $2007
		LDA $020D
		STA $2007

		;; resetting PPU data address
		LDA #0
		STA $2006
		STA $2006

		;; tetrimino is no longer drawn, and blocks are no longer
		;; to be placed
		DEC isTetriminoDrawn
		DEC isPlaceBlocks
