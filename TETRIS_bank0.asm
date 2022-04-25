
	;; setting up main code in code bank 0, at position 0xC0
	.bank 0
	.org $C000

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Reset mode when processor resets or first turns on.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\PreInitialization\RESET.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Period when no graphics are sent out, waiting for vblank to
	;; make sure PPU is ready.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\PreInitialization\VBlankWait1.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Clearing any extra memory.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\PreInitialization\ClearMemory.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Second wait for vblank, PPU is ready after this.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\PreInitialization\VBlankWait2.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Loading background and sprite palettes.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Initialization\LoadPalettes.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Loading playfield nametable and attributes.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Initialization\LoadPlayfield.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Setting PPU state based on previous changes towards PPU.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Initialization\SetPPUState.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Setting variables before game code loop starts.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Initialization\SetVariables.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; game code loop starting
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Forever:
		JMP Forever
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Processor jumps here once per frame indicating start of
	;; vblank, time for graphics updates.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    NMI:
		;; reading PPU status to reset high/low latch for later
		;; writes to 0x2006 PPU data offset port
		LDA PPU_STATUS

		;; resetting PPU CTRL and MASK
		LDA #0
		STA PPU_CTRL
		STA PPU_MASK

		;; if the tetrimino is not drawn, then we branch to graphics-
		;; enabling subroutine and skip some tetrimino-processing
		;; stuff
		LDA isTetriminoDrawn
		CMP #FALSE
		BEQ GoToEnableGraphicsRendering
		
		;; going to GetBlocks subroutine
		JMP GetBlocks
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Jumps to EnableGraphicsRendering subroutine.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GoToEnableGraphicsRendering:
		JMP EnableGraphicsRendering

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Starting process of getting block locations of tetrimino.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\GraphicsUpdates\GetTetriminoBlockPositions.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Checking below tetrimino blocks, seeing if we should place
	;; the current tetrimino.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\GraphicsUpdates\CheckTetriminoBelowBlocks.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Places tetrimino into nametable.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\GraphicsUpdates\PlaceTetrimino.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Now enabling graphics rendering.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	EnableGraphicsRendering:
		;; enabling NMI, sprites from pattern table 0, and background
		;; from pattern table 1
		LDA #PPU_CTRL_DAT
		STA PPU_CTRL

		;; enabling sprites, background, and disabling clipping on
		;; the left side
		LDA #PPU_MASK_DAT
		STA PPU_MASK

		;; incrementing tick-counting ticks variable
		INC ticks

		;; setting up direct memory access for sprites.
		;; setting the low byte (0x00) and then high byte (0x02) of
		;; the RAM address, starting the transfer.
		LDA #$00
		STA PPU_OAM_ADDR
		LDA #$02
		STA DMA

		;; resetting X/Y registers and A accumulator
		LDX #0
		LDY #0
		LDA #0

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Drawing tetrimino sprite if necessary.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Tetrimino_Draw.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Involves moving tetrimino down, left, or right.
	;; Invalid positioning of tetrimino is also checked.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Tetrimino_Position_MoveDown.asm"
	.include "bank0\Tetrimino_Position_MoveSideways.asm"
	.include "bank0\Tetrimino_PositionFix.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Checking for collision with floor.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Tetrimino_FloorCollisionCheck.asm"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Getting nametable pointer to blocks below tetrimino.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.include "bank0\Tetrimino_GetBlocksBelow.asm"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Last subroutine done before game code NMI loop ends.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	GameCodeNMILoopDone:
		;; return from interrupt
		RTI
