
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking position of tetriminos to see if any are invalid
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckTetriminoPosition:
		;; checking if tetrimino is beyond left wall
		LDA #TETRIMINO_MINIMUM_X
		CMP $0203
		BCS FixTetriminoLeftPosition

		;; checking if tetrimino is beyond right wall
		LDA $020F
		CMP #TETRIMINO_MAXIMUM_X
		BCS FixTetriminoRightPosition

		;; if neither, we can jump past fixing subroutines
		JMP FixingDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; fixing position of tetrimino on the left wall
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	FixTetriminoLeftPosition:
		;; setting blocks to minimum X
		LDA #TETRIMINO_MINIMUM_X
		STA $0203
		STA $020F

		;; setting second two blocks to minimum X plus one block
		;; length ahead
		LDA #TETRIMINO_MINIMUM_X
		CLC
		ADC #TETRIMINO_BLOCK_LENGTH
		STA $020B
		STA $0207

		;; fix is done
		JMP FixingDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; fixing position of tetrimino on the right wall
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	FixTetriminoRightPosition:
		;; setting second two blocks to maximum X minus one block
		;; length ahead
		LDA #TETRIMINO_MAXIMUM_X
		SEC
		SBC #TETRIMINO_BLOCK_LENGTH
		STA $0203
		STA $020F

		;; setting blocks to maximum X
		LDA #TETRIMINO_MAXIMUM_X
		STA $020B
		STA $0207

		;; fix is done
		JMP FixingDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; finished fixing tetrimino position (if it was fixed at all)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	FixingDone:
		;; resetting A accumulator
		LDA #0
