
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking if tetrimino had collision with floor
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckFloorCollision:
		;; if tetrimino bottom left block is beyond the maximum Y
		;; value possible, collision has happened
		LDA $020C
		CMP #TETRIMINO_MAXIMUM_Y
		BCS SetTetriminoOnFloor

		;; if no collision, skip handling
		JMP CheckFloorCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; sets tetrimino onto floor
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SetTetriminoOnFloor:
		;; setting top row blocks to maximum Y, minus one block
		;; length
		LDA #TETRIMINO_MAXIMUM_Y
		SEC
		SBC #TETRIMINO_BLOCK_LENGTH
		STA $0200
		STA $0204

		;; setting bottom row blocks to maximum Y
		LDA #TETRIMINO_MAXIMUM_Y
		STA $0208
		STA $020C

		;; preparing low and high pointers for bottom row
		LDA #$23
		STA pointerLow
		LDA #$00
		STA pointerHigh

		;; resetting X register and going into high pointer
		;; generation loop for bottom row start pointer
		LDX #0
		JMP BottomRowHighPointerLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; increments low pointer of bottom row
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	IncrementBottomRowLowPointer:
		INC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; creates bottom row pointer, points to start of first block
	;; on bottom row in nametable
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BottomRowHighPointerLoop:
		;; incrementing high pointer
		LDA pointerHigh
		CLC
		ADC #1
		STA pointerHigh

		;; if high pointer increments and loops around to 0, then
		;; low pointer must be incremented
		CMP #0
		BEQ IncrementBottomRowLowPointer

		;; incrementing X register, checking if X equals the bottom
		;; left block's X block position yet
		INX
		CPX xBlock1
		BNE BottomRowHighPointerLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; bottom row pointer creation done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BottomRowPointerLoopDone:
		;; storing low and high pointers into bottom row low and
		;; high pointer variables
		LDA pointerLow
		STA bottomRowLowPointer
		LDA pointerHigh
		STA bottomRowHighPointer

		;; resetting X register and going into high pointer
		;; generation loop for top row start pointer
		LDX #0
		JMP TopRowHighPointerLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; decrements low pointer of top row
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	DecrementTopRowLowPointer:
		DEC pointerLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; creates top row pointer, points to start of first block
	;; on top row in nametable
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TopRowHighPointerLoop:
		;; decrementing high pointer
		LDA pointerHigh
		SEC
		SBC #1
		STA pointerHigh

		;; if high pointer decrements and loops around to 255, then
		;; low pointer must be decremented
		CMP #255
		BEQ DecrementTopRowLowPointer

		;; incrementing X register, checking if X equals 31 yet
		INX
		CPX #31
		BNE TopRowHighPointerLoop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; top row pointer creation done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TopRowPointerLoopDone:
		;; storing low and high pointers into top row low and
		;; high pointer variables
		LDA pointerLow
		STA topRowLowPointer
		LDA pointerHigh
		STA topRowHighPointer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; pointer creation loops done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	PointerLoopsDone:
		;; we now want blocks to be placed in main NMI subroutine
		INC isPlaceBlocks

		;; we will jump here, because there are no blocks below the
		;; tetrimino currently so running that whole process is
		;; useless
		JMP GetBlocksBelowTetriminoCancel
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; floor collision checking is now done
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckFloorCollisionDone:
		;; resetting X register and A accumulator
		LDX #0
		LDA #0
