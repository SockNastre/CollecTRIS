
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking collision on X position of good block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckGoodBlockCollisionX:
		LDA $0203
		CMP goodBlockX
		BEQ CheckGoodBlockCollisionY

		LDA $0207
		CMP goodBlockX
		BEQ CheckGoodBlockCollisionY

		JMP GoodBlockCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; checking collision on Y position of good block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CheckGoodBlockCollisionY:
		LDA $0200
		CMP goodBlockY
		BEQ GoodBlockCollision

		LDA $0204
		CMP goodBlockY
		BEQ GoodBlockCollision

		LDA $0208
		CMP goodBlockY
		BEQ GoodBlockCollision

		LDA $020C
		CMP goodBlockY
		BEQ GoodBlockCollision

		JMP GoodBlockCollisionDone
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; handling collision with good block
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoodBlockCollision:
		DEC isGoodBlockDrawn
		DEC isBadBlockDrawn

		LDA scoreHigh
		CLC
		ADC #1
		STA scoreHigh
		CMP #0
		BNE GoodBlockCollisionDone
		LDA #0
		STA scoreHigh
		INC scoreLow
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; done checking for good block collision
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoodBlockCollisionDone:
		;; resetting A accumulator
		LDA #0
