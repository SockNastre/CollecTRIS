
	VBlankWait1:
		BIT PPU_STATUS
		BPL VBlankWait1
