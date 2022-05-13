
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking if we should skip loading score sprites
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ScoreSpritesSkip:
		LDA isPlaceBlocks
		CMP #FALSE
		BEQ LoadScoreSprites
		JMP GameCodeNMILoopDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; loading score sprites start
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadScoreSprites:
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; loop to load score sprites
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadScoreSpritesLoop:
		LDA Sprite_Score, X
		STA SCORE_SPRITE, X

		INX
		CPX #SCORE_SPR_COUNT
		BNE LoadScoreSpritesLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checks score sprites, seeing if they are equal to 0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LoadScoreSpritesCheck:
		LDA scoreHigh
		CMP #0
		BNE DrawScore

		LDA scoreLow
		CMP #0
		BNE DrawScore

		JMP DrawScoreDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; drawing score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawScore:
		LDA scoreLow
		STA pointerLow
		LDA scoreHigh
		STA pointerHigh

		LDX pointerLow
		LDY pointerHigh
		JMP DrawScoreLoopPre
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments first visual digit of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementScoreFirstPart:
		LDA $0229
		CLC
		ADC #1
		STA $0229

		CMP #$3A
		BNE DrawScoreLoop
		DEC $0229
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments second visual digit of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementScoreSecondPart:
		LDA $0225
		CLC
		ADC #1
		STA $0225

		CMP #$3A
		BNE DrawScoreLoop
		LDA #$30
		STA $0225
		JMP IncrementScoreFirstPart
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments third visual digit of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementScoreThirdPart:
		LDA $0221
		CLC
		ADC #1
		STA $0221

		CMP #$3A
		BNE DrawScoreLoop
		LDA #$30
		STA $0221
		JMP IncrementScoreSecondPart
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments fourth visual digit of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementScoreFourthPart:
		LDA $021D
		CLC
		ADC #1
		STA $021D

		CMP #$3A
		BNE DrawScoreLoop
		LDA #$30
		STA $021D
		JMP IncrementScoreThirdPart
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments fifth visual digit of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementScoreFifthPart:
		LDA $0219
		CLC
		ADC #1
		STA $0219

		CMP #$3A
		BNE DrawScoreLoop
		LDA #$30
		STA $0219
		JMP IncrementScoreFourthPart
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; begins incrementation of score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawScoreLoopPre:
		JMP IncrementScoreFifthPart
		JMP DrawScoreLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; outside of score drawing loop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawScoreOutside:
		LDY #$FF
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; drawing score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawScoreLoop:
		DEY
		CPY #0
		BNE DrawScoreLoopPre

		DEX
		CPX #$FF
		BNE DrawScoreOutside
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done drawing score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawScoreDone:
		;; resetting X/Y registers and A accumulator
		LDX #0
		LDY #0
		LDA #0
