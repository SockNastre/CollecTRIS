
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing to move tetrimino sideways
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoSideFrameCheck:
		;; preparing A accumulator for modulo about to be performed
		LDA ticks
		SEC
	MoveTetriminoSideFrameCheckModulo:
		;; performs modulo, looping as many times as needed until
		;; process is complete and modulo result is in A accumulator
		SBC tetriminoSideSpeed
		BCS MoveTetriminoSideFrameCheckModulo
		ADC tetriminoSideSpeed

		;; if modulo result is equal to 0 then tetrimino sprite
		;; blocks are moved down
		CMP #0
		BNE JumpToMoveTetriminoSideDone
		JMP MoveTetriminoSide
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; jumps to moving down done subroutine if this subroutine is ran
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	JumpToMoveTetriminoSideDone:
		JMP MoveTetriminoSideDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing to move tetramino sideways
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoSide:
		;; starting by telling both controllers to latch buttons
		LDA #1
		STA $4016
		LDA #0
		STA $4016
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; preparing left dpad button to be checked
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	StartButtonReadDPadLeftLoop:
		;; skipping player 1 inputs before left and right buttons
		LDA $4016

		;; increments X by 1, until is reaches 6 then we are at the
		;; left button
		INX
		CPX #6
		BNE StartButtonReadDPadLeftLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; reading dpad left button press state
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ReadDPadLeft:
		;; checking if left dpad button is pressed, if it is not
		;; then branch past the handler for it
		LDA $4016
		AND #%00000001 
		BEQ ReadDPadRight

		;; if left space is not open (false), then we do not move
		;; tetrimino right
		LDA isLeftSpaceOpen
		CMP #FALSE
		BEQ JumpToMoveTetriminoSideDone

		;; preparing X register for upcoming loop
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; moves tetrimino sprite blocks left
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoLeftLoop:
		;; loading X position of current block, decreasing it by
		;; tetrimino block length to move it left
		LDA $0203, X
		SEC
		SBC #TETRIMINO_BLOCK_LENGTH
		STA $0203, X

		;; incrementing X register by 4 since we need to go 4 ahead
		;; in sprite table
		INX
		INX
		INX
		INX

		;; seeing if we have hit the tetrimino sprite size yet or
		;; not, which indicates end of loop
		CPX #TETRIMINO_SPRITE_SIZE
		BNE MoveTetriminoLeftLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; reading dpad right button press state
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ReadDPadRight:
		;; checking if right dpad button is pressed, if it is not
		;; then branch past the handler for it
		LDA $4016
		AND #%00000001 
		BEQ MoveTetriminoSideDone

		;; if right space is not open (false), then we do not move
		;; tetrimino right
		LDA isRightSpaceOpen
		CMP #FALSE
		BEQ JumpToMoveTetriminoSideDone

		;; preparing X register for upcoming loop
		LDX #0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; moves tetrimino sprite blocks right
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoRightLoop:
		;; loading X position of current block, increasing it by
		;; tetrimino block length to move it right
		LDA $0203, X
		CLC
		ADC #TETRIMINO_BLOCK_LENGTH
		STA $0203, X

		;; incrementing X register by 4 since we need to go 4 ahead
		;; in sprite table
		INX
		INX
		INX
		INX

		;; seeing if we have hit the tetrimino sprite size yet or
		;; not, which indicates end of loop
		CPX #TETRIMINO_SPRITE_SIZE
		BNE MoveTetriminoRightLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; finished moving tetrimino sideways (if it was done at all)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MoveTetriminoSideDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
