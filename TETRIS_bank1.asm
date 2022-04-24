
	;; setting up main game data in code bank 1, at position 0xE000
	.bank 1
	.org $E000

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Palette data for background and sprites.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Palette_Background:
		.incbin "bin\Palette_Background.bin"
	Palette_Sprites:
		.incbin "bin\Palette_Sprites.bin"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Tile pieces for the playfield, and attributes for tiles
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Playfield_Nametable:
		.incbin "bin\Nametable_Playfield.bin"
	Playfield_Nametable_Attributes:
		.incbin "bin\Nametable_Playfield_Attributes.bin"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Tetrimino O piece
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Sprite_Tetrimino_OPiece:
		.incbin "bin\Sprite_Tetrimino_OPiece.bin"

	;; setting up some necessary functions at position 0xFFFA, where first of
	;; three vectors star
    .org $FFFA
    .dw NMI    ;; when NMI happens
    .dw RESET  ;; when processor first turns on or resets
    .dw 0      ;; IRQ not being used
