
	CheckTetriminoLeftSide:
		;; going to where left side bottom block would be stored in
		;; the nametable
		LDA leftBottomBlockLowPointer
		STA PPU_ADDRESS
		LDA leftBottomBlockHighPointer
		STA PPU_ADDRESS

		;; discarding last PPU data byte
		LDA PPU_DATA

		;; loading left bottom block, seeing if it equal to tile ID
		;; 0x02 or not
		LDA PPU_DATA
		CMP #02
		BEQ TetriminoLeftSideBad

		;; since there is no tile 0x02 (tetrimino block) then the
		;; left space is open
		LDA #TRUE
		STA isLeftSpaceOpen

		;; jumping to end of check, since we are done
		JMP CheckTetriminoLeftSideDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; when the left side of the tetrimino is bad (not open)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TetriminoLeftSideBad:
		;; since there is tile 0x02 (tetrimino block) then the left
		;; space is not open
		LDA #FALSE
		STA isLeftSpaceOpen
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking tetrimino's left side
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckTetriminoLeftSideDone:
