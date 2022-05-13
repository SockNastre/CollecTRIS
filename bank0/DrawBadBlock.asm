
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking if bad block should be drawn
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawBadBlockCheck:
		LDA isBadBlockDrawn
		CMP #TRUE
		BEQ DrawBadBlockDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; starting to generate bad block X location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBadBlockX:
		LDA seed2
		SEC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating bad block X location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBadBlockXModulus:
		SBC #10
		BCS GetBadBlockXModulus
		ADC #10
		ASL A
		ASL A
		ASL A
		CLC
		ADC #TETRIMINO_MINIMUM_X
		STA badBlockX
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; starting to generate bad block Y location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBadBlockY:
		LDA seed2
		SEC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating bad block Y location
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetBadBlockYModulus:
		SBC #13
		BCS GetBadBlockYModulus
		ADC #13
		ASL A
		ASL A
		ASL A
		CLC
		ADC #TETRIMINO_MINIMUM_Y
		ADC #56
		STA badBlockY
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; drawing in bad block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawBadBlock:
		LDA badBlockY
		STA $0214
		LDA #$04
		STA $0215
		LDA #%00000001
		STA $0216
		LDA badBlockX
		STA $0217

		INC isBadBlockDrawn
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done drawing the bad block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawBadBlockDone:
		;; resetting A accumulator
		LDA #0
