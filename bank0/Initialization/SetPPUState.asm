
	SetPPUState:
		;; enables NMI, sprites from Pattern Table 0, and
		;; background from Pattern Table 1
		LDA #%10010000
		STA $2000
		;; enables sprites and enables background
		LDA #%00011110
		STA $2001

		;; telling PPU that we are not doing any scrolling at the
		;; end of NMI
		LDA #0
		STA $2005
		STA $2005
