
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing PPU to accept palette data
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadPalettes:
		;; reading PPU status to reset high/low latch
		LDA PPU_STATUS

		;; setting PPU to palette location
		LDA #$3F
		STA PPU_ADDRESS
		LDA #$00
		STA PPU_ADDRESS

		;; setting X = 0 to prepare for background palette
		;; loading loop
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; looping through background palette data storing data into
	;; PPU data port
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadBackgroundPaletteLoop:
		;; loading background palette data into A accumulator, at
		;; index X, then putting it into PPU data port
		LDA Palette_Background, X
		STA PPU_DATA

		;; incrementing index X
		INX

		;; if index X is not equal to amount of colors in a palette
		;; then palette is not done loading so loop is done again
		CPX #PALETTE_COUNT
		BNE LoadBackgroundPaletteLoop

		;; setting X = 0 to prepare for sprite palette
		;; loading loop
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; looping through sprite palette data storing data into
	;; PPU data port
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadSpritePaletteLoop:
		;; loading sprite palette data into A accumulator, at
		;; index X, then putting it into PPU data port
		LDA Palette_Sprites, X
		STA PPU_DATA

		;; incrementing index X
		INX

		;; if index X is not equal to amount of colors in a palette
		;; then palette is not done loading so loop is done again
		CPX #PALETTE_COUNT
		BNE LoadSpritePaletteLoop
