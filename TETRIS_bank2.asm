
	;; setting up game tile data in code bank 2, at position 0x0000
	.bank 2
	.org $0000

	;; including game tile data from sprite/background tile data file
	.incbin "bin\SpriteBackground_Tiles.chr"
