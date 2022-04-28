
	SetVariables:
		;; setting the debug variables
		LDA #$53
		STA temp1
		LDA #$4D
		STA temp2
		LDA #$3A
		STA temp3
		LDA #$33
		STA temp4
		LDA #$48
		STA temp5
		LDA #$45
		STA temp6
		LDA #$59
		STA temp7
		LDA #$3F
		STA temp8

		;; setting the tetrimino down/side speed variables to their
		;; default speeds
		LDX #TETRIMINO_DEFAULT_DOWNSPEED
		STX tetriminoDownSpeed
		LDX #TETRIMINO_DEFAULT_SIDESPEED
		STX tetriminoSideSpeed

		;; resetting X/Y registers and A accumulator
		LDX #0
		LDY #0
		LDA #0
