
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checks if tetrimino should be drawn on screen
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawTetrimino:
		;; if tetrimino is drawn, we skip over the loop
		LDA isTetriminoDrawn
		CMP #TRUE
		BEQ DrawTetriminoDone

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; draws tetrimino piece on screen
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawTetriminoLoop:
		;; loading byte from tetrimino sprite piece, storing it in
		;; sprite region
		LDA Sprite_Tetrimino_OPiece, X
		STA $0200,           X

		;; incrementing X register, seeing if we have hit the
		;; tetrimino sprite size yet or not
		INX
		CPX #TETRIMINO_SPRITE_SIZE
		BNE DrawTetriminoLoop

		;; since isTetriminoDrawn should be equal to 0 (FALSE), we
		;; can increment it to equal 1 (TRUE)
		INC isTetriminoDrawn

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; finished drawing tetrimino (if it was drawn at all)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DrawTetriminoDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
