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

;; temporary debug variables, NEVER meant for any form of long-term of
;; permanent storage, these variables should be exhausted at the end of any
;; subroutine or process if they were used.
;; ideally, one should not use these at all if it can be helped.
temp1 .rs 1
temp2 .rs 1
temp3 .rs 1
temp4 .rs 1
temp5 .rs 1
temp6 .rs 1
temp7 .rs 1
temp8 .rs 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; memory offsets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; sprite table offset in accessible memory
SPRITE_TABLE = $0200

;; where score sprites are saved
SCORE_SPRITE = $0218

;; where life sprites are saved
LIFE_SPRITE = $022C

;; amount of bytes storing life sprites
LIFE_SPRITE_BYTE_COUNT = 20

;; direct memory access offset
DMA = $4014

;; default PPU_CTRL and PPU_MASK data
PPU_CTRL_DAT = %10010000
PPU_MASK_DAT = %00011110

;; PPU data ports
PPU_CTRL     = $2000
PPU_MASK     = $2001
PPU_STATUS   = $2002
PPU_OAM_ADDR = $2003
PPU_OAM_DATA = $2004
PPU_SCROLL   = $2005
PPU_ADDRESS  = $2006
PPU_DATA     = $2007

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; general
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; seeding values for entire game (RNG-related)
seed1 .rs 1
seed2 .rs 1

;; low and high bytes of two-byte integer
pointerLow  .rs 1
pointerHigh .rs 1

;; score used in game
scoreLow  .rs 1
scoreHigh .rs 1

;; true and false byte constants
FALSE = 0
TRUE  = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; related to lives in game
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; amount of lives player has
lifeCount .rs 1

;; default lifes player gets
LIFE_DEFAULT_COUNT = 5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; good and bad blocks for falling tetrimino
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; whether the good/bad blocks are drawn yet or not
isGoodBlockDrawn .rs 1
isBadBlockDrawn  .rs 1

;; X and Y sprite coordinates of good block
goodBlockX .rs 1
goodBlockY .rs 1

;; X and Y sprite coordinates of bad block
badBlockX .rs 1
badBlockY .rs 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tetrimino
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; whether current tetrimino has been drawn yet or not
isTetriminoDrawn .rs 1

;; whether to place down current blocks or not (set before
;; next NMI loop, block places in NMI upon reading)
isPlaceBlocks .rs 1

;; whether the tetrimino has hit the bottom or not
hasTetriminoHitBottom .rs 1

;; indicating if left or right spaces of blocks are open
;; for tetrimino to be moved into or not
isLeftSpaceOpen  .rs 1
isRightSpaceOpen .rs 1

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

;; pointers to left/right bottom
leftBottomBlockLowPointer   .rs 1
leftBottomBlockHighPointer  .rs 1
rightBottomBlockLowPointer  .rs 1
rightBottomBlockHighPointer .rs 1

;; pointers to blocks just below current blocks
belowBlocksLowPointer  .rs 1
belowBlocksHighPointer .rs 1

;; speed tetrimino moves down or left/right
tetriminoDownSpeed .rs 1
tetriminoSideSpeed .rs 1

;; default down and sideways speeds
TETRIMINO_DEFAULT_DOWNSPEED = 6
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
SCORE_SPR_COUNT = 20 ;; amount of sprites used for score

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
