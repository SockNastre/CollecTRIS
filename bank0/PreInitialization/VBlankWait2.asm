
	VBlankWait2:
		BIT PPU_STATUS
		BPL VBlankWait2
