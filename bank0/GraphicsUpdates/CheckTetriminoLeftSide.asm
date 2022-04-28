
	CheckTetriminoLeftSide:
		LDA leftBottomBlockLowPointer
		STA PPU_ADDRESS
		LDA leftBottomBlockHighPointer
		STA PPU_ADDRESS

		LDA PPU_DATA ;; discarding what was in PPU_DATA last

		LDA PPU_DATA
		STA temp3
		CMP #02
		BEQ TetriminoLeftSideBad

		LDA #TRUE
		STA isLeftSpaceOpen

		JMP CheckTetriminoLeftSideDone
	TetriminoLeftSideBad:
		LDA #FALSE
		STA isLeftSpaceOpen
		JMP CheckTetriminoLeftSideDone
	CheckTetriminoLeftSideDone:
