
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; as documented here:
	;; http://www.gravelstudios.com/dabadace/post.php?postid=27
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating first random seed
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GenerateRandomSeed1:
		;; random variable being used as seed, adding ticks to make
		;; it more random
		LDA leftBottomBlockHighPointer
		CLC
		ADC ticks

		;; multiplying it by four
		ASL A
		ASL A

		;; finally, adding back original value plus prime number
		CLC
		ADC leftBottomBlockHighPointer
		CLC
		ADC #3

		;; storing first seed
		STA seed1
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; generating second random seed
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GenerateRandomSeed2:
		;; random variable being used as seed, adding ticks to make
		;; it more random
		LDA belowBlocksHighPointer
		CLC
		ADC ticks

		;; multiplying it by four
		ASL A
		ASL A

		;; finally, adding back original value plus prime number
		CLC
		ADC belowBlocksHighPointer
		CLC
		ADC #7

		;; storing second seed
		STA seed2
