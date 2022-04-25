
	SetPPUState:
		;; enables NMI, sprites from Pattern Table 0, and
		;; background from Pattern Table 1
		LDA #PPU_CTRL_DAT
		STA PPU_CTRL
		;; enables sprites and enables background
		LDA #PPU_MASK_DAT
		STA PPU_MASK

		;; telling PPU that we are not doing any scrolling at the
		;; end of NMI
		LDA #FALSE
		STA PPU_SCROLL
		STA PPU_SCROLL
