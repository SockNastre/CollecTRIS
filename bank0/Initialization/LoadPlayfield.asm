
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing PPU to accept playfield nametable data
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadPlayfieldNametable:
		;; reading PPU status to reset high/low latch
		LDA $2002

		;; setting PPU to nametable 1 location
		LDA #$20
		STA $2006
		LDA #$00
		STA $2006

		;; putting low and high bytes of address (for playfield
		;; nametable) into pointer
		LDA #LOW(Playfield_Nametable)
		STA pointerLow
		LDA #HIGH(Playfield_Nametable)
		STA pointerHigh

		;; setting X = 0 and Y = 0 to prepare for playfield nametable
		;; loading loop
		LDX #0
		LDY #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; (outside) chunk loop for playfield tiles
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PlayfieldNametableChunkLoop:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; (inside) row loop for playfield tiles
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PlayfieldNametableRowLoop:
		;; copies one background byte from address in low pointer
		;; plus Y
		LDA [pointerLow], Y
		STA $2007

		;; row loop counter, runs 256 times before continuing down
		INY
		CPY #0
		BNE PlayfieldNametableRowLoop

		;; low byte went 0 to 256, so high byte needs to be
		;; changed now
		INC pointerHigh

		;; column loop counter that runs 4 times before continuing
		;; down, meaning entire loop runs 256 * 4 times
		INX
		CPX #4
		BNE PlayfieldNametableChunkLoop

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing PPU to accept playfield nametable attributes data
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadPlayfieldAttributes:
		;; reading PPU status to reset high/low latch
		LDA $2002

		;; setting PPU to nametable 1 attributes location
		LDA #$23
		STA $2006
		LDA #$C0
		STA $2006

		;; setting X = 0 to prepare for attribute loading loop
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; looping through playfield nametable attributes storing data
	;; into PPU data port
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadPlayfieldAttributesLoop:
		;; loading attribute data into A accumulator, at index X,
		;; then putting it into PPU data port
		LDA Playfield_Nametable_Attributes, X
		STA $2007

		;; incrementing index X
		INX

		;; if index X is not equal to amount of attributes in
		;; attribute table then attributes not done loading so loop
		;; is done again
		CPX #ATTRIBUTE_COUNT
		BNE LoadPlayfieldAttributesLoop
