
	SetVariables:
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
