
	RESET:
		;; disable IRQs and decimal mode
		SEI
		CLD

		;; disable APU frame IRQ
		LDX #$40
		STX $4017

		;; setting up stack
		LDX #$FF
		TXS

		;; resetting value of X (0xFF + 1 = 0x00)
		INX

		;; disabling NMI, rendering, and DMC IRQs
		STX PPU_CTRL
		STX PPU_MASK
		STX $4010
