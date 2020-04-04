;  Simple program to blink leds on the 6502 project
;  6502 architechture / oldstyle syntax
;  Assemble with the -dotdir flag to enable dot directives (vasm)

  .org $8000        ;set start index -> actual index = virtual index + $8000

reset:              ;sequence loaded on initial start & reset
  lda #$ff          ;$ff sets every bit (pin) to '1' - for output
  sta $6002         ;output $ff to register B on the interface adapter

  lda #$50          ;load initial led pattern: [o0o0ooo]
  sta $6000         ;output to interface adapter

loop:
  ror               ;rotate stored byte right by one bit
  sta $6000         ;output to interface adapter

  jmp loop          ;keep doing this forever

  .org $fffc        ;goto location where the start address is stored ($fffc-$fffd)
  .word reset       ;store address of reset instruction
  .word $0000       ;store null byte (padding)