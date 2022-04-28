
	CheckResetPlayfield:
		;; place in nametable below tetrimino spawnpoint
		LDA #$20
		STA PPU_ADDRESS
		LDA #$EF
		STA PPU_ADDRESS

		;; discarding previous PPU data byte
		LDA PPU_DATA

		;; if bottom left block is occupied, reset playfield
		LDA PPU_DATA
		CMP #$02
		BEQ ResetPlayfield

		;; if bottom right block is occupied, reset playfield
		LDA PPU_DATA
		CMP #$02
		BEQ ResetPlayfield

		;; otherwise, do not reset the playfield
		JMP ResetPlayfieldDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; resetting playfield per row in playfield.
	;; it is less efficient (more cycles) to make this any kind
	;; of loop.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ResetPlayfield:
		;; X register will hold the blank tetrimino tile ID
		LDX #TETRIMINO_BLANK_TILE

		;; setting address and blank tiles for row 1
		LDA #$20
		STA PPU_ADDRESS
		LDA #$AB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 2
		LDA #$20
		STA PPU_ADDRESS
		LDA #$CB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 3
		LDA #$20
		STA PPU_ADDRESS
		LDA #$EB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 4
		LDA #$21
		STA PPU_ADDRESS
		LDA #$0B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 5
		LDA #$21
		STA PPU_ADDRESS
		LDA #$2B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 6
		LDA #$21
		STA PPU_ADDRESS
		LDA #$4B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 7
		LDA #$21
		STA PPU_ADDRESS
		LDA #$6B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 8
		LDA #$21
		STA PPU_ADDRESS
		LDA #$8B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 9
		LDA #$21
		STA PPU_ADDRESS
		LDA #$AB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 10
		LDA #$21
		STA PPU_ADDRESS
		LDA #$CB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 11
		LDA #$21
		STA PPU_ADDRESS
		LDA #$EB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 12
		LDA #$22
		STA PPU_ADDRESS
		LDA #$0B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 13
		LDA #$22
		STA PPU_ADDRESS
		LDA #$2B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 14
		LDA #$22
		STA PPU_ADDRESS
		LDA #$4B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 15
		LDA #$22
		STA PPU_ADDRESS
		LDA #$6B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 16
		LDA #$22
		STA PPU_ADDRESS
		LDA #$8B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 17
		LDA #$22
		STA PPU_ADDRESS
		LDA #$AB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 18
		LDA #$22
		STA PPU_ADDRESS
		LDA #$CB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 19
		LDA #$22
		STA PPU_ADDRESS
		LDA #$EB
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA

		;; setting address and blank tiles for row 20
		LDA #$23
		STA PPU_ADDRESS
		LDA #$0B
		STA PPU_ADDRESS

		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
		STX PPU_DATA
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done resetting playfield (if it was reset at all)
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ResetPlayfieldDone:
