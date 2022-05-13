
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking collision on X position of bad block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBadBlockCollisionX:
		LDA $0203
		CMP badBlockX
		BEQ CheckBadBlockCollisionY

		LDA $0207
		CMP badBlockX
		BEQ CheckBadBlockCollisionY

		JMP BadBlockCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking collision on Y position of bad block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckBadBlockCollisionY:
		LDA $0200
		CMP badBlockY
		BEQ BadBlockCollision

		LDA $0204
		CMP badBlockY
		BEQ BadBlockCollision

		LDA $0208
		CMP badBlockY
		BEQ BadBlockCollision

		LDA $020C
		CMP badBlockY
		BEQ BadBlockCollision

		JMP BadBlockCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; handling collision with bad block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BadBlockCollision:
		DEC isBadBlockDrawn
		DEC lifeCount

		LDA scoreHigh
		CMP #0
		BNE LowerScore

		LDA scoreLow
		CMP #0
		BNE LowerScore

		JMP BadBlockCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; lowers current score
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	LowerScore:
		LDA scoreHigh
		SEC
		SBC #1

		STA scoreHigh
		CMP #0
		BNE BadBlockCollisionDone

		LDA scoreLow
		CMP #0
		BEQ BadBlockCollisionDone

		DEC scoreLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking for bad block collision
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BadBlockCollisionDone:
		;; resetting A accumulator
		LDA #0
