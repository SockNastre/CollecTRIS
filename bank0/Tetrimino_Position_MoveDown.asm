
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing to move tetrimino down
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoDownFrameCheck:
		;; preparing A accumulator for modulo about to be performed
		LDA ticks
		SEC
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; performs modulo to check tick if tetrimino should move down
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoDownFrameCheckModulo:
		;; performs modulo, looping as many times as needed until
		;; process is complete and modulo result is in A accumulator
		SBC tetriminoDownSpeed
		BCS MoveTetriminoDownFrameCheckModulo
		ADC tetriminoDownSpeed

		;; if modulo result is equal to 0 then tetrimino sprite
		;; blocks are moved down
		CMP #0
		BNE JumpToMoveTetriminoDownDone
		JMP MoveTetriminoDownLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; jumps to moving down done subroutine if this subroutine is ran
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JumpToMoveTetriminoDownDone:
		JMP MoveTetriminoDownDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; moves tetrimino sprite blocks down
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoDownLoop:
		;; loading Y position of current block, increasing it by
		;; tetrimino block length to move it down
		LDA $0200, X
		CLC
		ADC #TETRIMINO_BLOCK_LENGTH
		STA $0200, X

		;; incrementing X register by 4 since we need to go 4 ahead
		;; in sprite table
		INX
		INX
		INX
		INX

		;; seeing if we have hit the tetrimino sprite size yet or
		;; not, which indicates end of loop
		CPX #TETRIMINO_SPRITE_SIZE
		BNE MoveTetriminoDownLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; finished moving tetrimino down (if it was done at all)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoDownDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
