
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; beginning process to draw life sprites
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawLifeSprites:
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; drawing life sprites loop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawLifeSpritesLoop:
		LDA Sprite_Lives, X
		STA LIFE_SPRITE,  X

		INX
		CPX #LIFE_SPRITE_BYTE_COUNT
		BNE DrawLifeSpritesLoop
