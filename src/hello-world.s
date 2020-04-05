;  Simple program to blink leds on the 6502 project
;  6502 architechture / oldstyle syntax
;  Assemble with the -dotdir flag to enable dot directives (vasm)

PORTB = $6000       ;interface adapter port B
PORTA = $6001       ;interface adapter port A
DDRB = $6002        ;data direction register B
DDRA = $6003        ;data direction register A

E = %10000000       ;enable output
RW = %01000000      ;read/write
RS = %00100000      ;register select

  .org $8000        ;set start index -> actual index = virtual index + $8000

reset:              ;sequence loaded on initial start & reset
  lda #%11111111    ;set every pin to '1' for output
  sta DDRB          ;set data direction of register B on the interface adapter

  lda #%11100000    ;set top 3 pins to '1' for output
  sta DDRA          ;set data direction of register A on the interface adapter


  lda #%00111000    ;8 bit mode, 2-line display, 5x8 pixel font
  sta PORTB         ;output to interface adapter

  lda #0            ;clear RS/RW/E
  sta PORTA

  lda #E            ;set enable bit
  sta PORTA

  lda #0            ;clear RS/RW/E
  sta PORTA


  lda #%00001110    ;display on, cursor on, blink off
  sta PORTB         ;output to interface adapter

  lda #0            ;clear RS/RW/E
  sta PORTA

  lda #E            ;set enable bit
  sta PORTA

  lda #0            ;clear RS/RW/E
  sta PORTA

  
  lda #%00000110    ;increment & shift cursor, don't shift display
  sta PORTB         ;output to interface adapter

  lda #0            ;clear RS/RW/E
  sta PORTA

  lda #E            ;set enable bit
  sta PORTA

  lda #0            ;clear RS/RW/E
  sta PORTA


  lda #"H"
  sta PORTB

  lda #RS            ;clear RS/RW/E
  sta PORTA

  lda #(RS | E)      ;set enable bit and register select
  sta PORTA

  lda #RS            ;clear RS/RW/E
  sta PORTA



loop:
  jmp loop          ;keep doing this forever

  .org $fffc        ;goto location where the start address is stored ($fffc-$fffd)
  .word reset       ;store address of reset instruction
  .word $0000       ;store null byte (padding)