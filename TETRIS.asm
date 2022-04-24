;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; iNES Header
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .inesprg 1 ; 1x 16kb bank of PRG code
    .ineschr 1 ; 2x 8kb bank of CHR data
    .inesmap 0 ; mapper 0 = NROM, no bank swapping
    .inesmir 1 ; background mirroring (being ignored at the moment)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Game Variables/Constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	.rsset $0000

;; temporary variables, NEVER meant for any form of long-term of permanent
;; storage, these variables should be exhausted at the end of any subroutine
;; or process if they were used
temp1 .rs 1
temp2 .rs 1
temp3 .rs 1
temp4 .rs 1
temp5 .rs 1
temp6 .rs 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; general
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; low and high bytes of two-byte integer
pointerLow  .rs 1
pointerHigh .rs 1

;; true and false byte constants
FALSE = 0
TRUE  = 1

;; cancelation/invalid byte
IS_CANCELLED = $FF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tetrimino
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; whether current tetrimino has been drawn yet or not
isTetriminoDrawn .rs 1

;; whether to place down current blocks or not (set before
;; next NMI loop, block places in NMI upon reading)
isPlaceBlocks .rs 1

;; X and Y block positions of (if it exists) bottom left
;; block of tetrimino
xBlock1 .rs 1
yBlock1 .rs 1

;; X and Y block positions of (if it exists) bottom right
;; block of tetrimino
xBlock2 .rs 1
yBlock2 .rs 1

;; pointers to start of blocks on top and bottom rows
topRowLowPointer     .rs 1
topRowHighPointer    .rs 1
bottomRowLowPointer  .rs 1
bottomRowHighPointer .rs 1

;; pointers to blocks just below current blocks
belowBlocksLowPointer  .rs 1
belowBlocksHighPointer .rs 1

;; speed tetrimino moves down or left/right
tetriminoDownSpeed .rs 1
tetriminoSideSpeed .rs 1

;; default down and sideways speeds
TETRIMINO_DEFAULT_DOWNSPEED = 7
TETRIMINO_DEFAULT_SIDESPEED = 4

;; minimum and maximum X position values possible for a
;; tetrimino (block)
TETRIMINO_MINIMUM_X = 88
TETRIMINO_MAXIMUM_X = 160

;; minimum and maximum Y position values possible for a
;; tetrimino (block)
TETRIMINO_MINIMUM_Y = 39
TETRIMINO_MAXIMUM_Y = 191

;; length of a tetrimino block (in pixels)
TETRIMINO_BLOCK_LENGTH = 8

;; total size a tetrimino sprite will take up in bytes
TETRIMINO_SPRITE_SIZE = 16

;; blank tile in nametable for non-existant tetrimino block
TETRIMINO_BLANK_TILE = $0B

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tick counting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ticks .rs 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; palettes, sprites, background, or attributes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PALETTE_COUNT   = 16 ;; amount of colors in palettes
ATTRIBUTE_COUNT = 64 ;; amount of attributes in attribute table

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Main Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "TETRIS_bank0.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Main Game Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "TETRIS_bank1.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; Game Tile Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "TETRIS_bank2.asm"
