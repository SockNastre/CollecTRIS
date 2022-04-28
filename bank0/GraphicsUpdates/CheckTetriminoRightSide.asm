
	CheckTetriminoRightSide:
		LDA rightBottomBlockLowPointer
		STA PPU_ADDRESS
		STA temp2
		LDA rightBottomBlockHighPointer
		STA PPU_ADDRESS
		STA temp3

		LDA #$69
		STA temp1

		LDA PPU_DATA ;; discarding what was in PPU_DATA last

		LDA PPU_DATA
		STA temp3
		CMP #02
		BEQ TetriminoRightSideBad

		LDA #TRUE
		STA isRightSpaceOpen

		JMP CheckTetriminoRightSideDone
	TetriminoRightSideBad:
		LDA #FALSE
		STA isRightSpaceOpen
		JMP CheckTetriminoRightSideDone
	CheckTetriminoRightSideDone:
