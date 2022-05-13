
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking if good block should be drawn
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawGoodBlockCheck:
		LDA isGoodBlockDrawn
		CMP #TRUE
		BEQ DrawGoodBlockDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; starting to generate good block X location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetGoodBlockX:
		LDA seed1
		SEC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating good block X location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetGoodBlockXModulus:
		SBC #10
		BCS GetGoodBlockXModulus
		ADC #10
		ASL A
		ASL A
		ASL A
		CLC
		ADC #TETRIMINO_MINIMUM_X
		STA goodBlockX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; starting to generate good block Y location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetGoodBlockY:
		LDA seed1
		SEC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating good block Y location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetGoodBlockYModulus:
		SBC #18
		BCS GetGoodBlockYModulus
		ADC #18
		ASL A
		ASL A
		ASL A
		CLC
		ADC #TETRIMINO_MINIMUM_Y
		ADC #TETRIMINO_BLOCK_LENGTH
		ADC #TETRIMINO_BLOCK_LENGTH
		STA goodBlockY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; drawing in good block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawGoodBlock:
		LDA goodBlockY
		STA $0210
		LDA #$03
		STA $0211
		LDA #%00000001
		STA $0212
		LDA goodBlockX
		STA $0213

		INC isGoodBlockDrawn
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done drawing the good block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawGoodBlockDone:
		;; resetting A accumulator
		LDA #0