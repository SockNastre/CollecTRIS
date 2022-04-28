
	CheckTetriminoRightSide:
		;; going to where right side bottom block would be stored in
		;; the nametable
		LDA rightBottomBlockLowPointer
		STA PPU_ADDRESS
		LDA rightBottomBlockHighPointer
		STA PPU_ADDRESS

		;; discarding last PPU data byte
		LDA PPU_DATA

		;; loading right bottom block, seeing if it equal to tile ID
		;; 0x02 or not
		LDA PPU_DATA
		CMP #02
		BEQ TetriminoRightSideBad

		;; since there is no tile 0x02 (tetrimino block) then the
		;; right space is open
		LDA #TRUE
		STA isRightSpaceOpen

		;; jumping to end of check, since we are done
		JMP CheckTetriminoRightSideDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; when the right side of the tetrimino is bad (not open)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TetriminoRightSideBad:
		;; since there is tile 0x02 (tetrimino block) then the right
		;; space is not open
		LDA #FALSE
		STA isRightSpaceOpen
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking tetrimino's right side
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckTetriminoRightSideDone:
