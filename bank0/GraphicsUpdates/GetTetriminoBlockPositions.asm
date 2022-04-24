
	GetBlocks:
		;; getting X and Y position of bottom left block
		LDY $0208
		INY
		LDX $020B
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; gets Y block position of current tetrimino
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetYBlockLoop:
		;; decreasing Y register by 8
		DEY
		DEY
		DEY
		DEY
		DEY
		DEY
		DEY
		DEY

		;; incrementing A accumulator then seeing if Y register now
		;; equals 0, if it does not then we loop
		CLC
		ADC #1
		CPY #0
		BNE GetYBlockLoop

		;; getting A accumulator result (this is effectively
		;; division) then storing it into Y block variables
		TAY
		STY yBlock1
		STY yBlock2

		;; resetting A accumulator for next loop
		LDA #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; gets X block position of current tetrimino
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GetXBlockLoop:
		;; decreasing Y register by 8
		DEX
		DEX
		DEX
		DEX
		DEX
		DEX
		DEX
		DEX

		;; incrementing A accumulator then seeing if X register now
		;; equals 0, if it does not then we loop
		CLC
		ADC #1
		CPX #0
		BNE GetXBlockLoop

		;; getting A accumulator result (this is effectively
		;; division) then storing it into second X block variable,
		;; then first X block variable, which is one behind
		TAX
		STX xBlock2
		DEX
		STX xBlock1
