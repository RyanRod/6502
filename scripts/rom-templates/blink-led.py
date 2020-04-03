code = bytearray([
  # Location 8000
  # Set register A and B to output
  0xa9, 0xff,        # lda #$ff   
  0x8d, 0x02, 0x60,  # sta $6002
  
  # Output 55 to register B
  0xa9, 0x55,        # lda #$55   
  0x8d, 0x00, 0x60,  # sta $6000

  # Output aa to register B
  0xa9, 0xaa,        # lda #$aa   
  0x8d, 0x00, 0x60,  # sta $6000

  # Jump back to byte 8005
  0x4c, 0x05, 0x80   # jmp $8005
])


# Allocate 32kB of memory (eeprom size)
rom = code + bytearray([0xea] * 32768 - len(code))

# Start program counter at address 0x8000
rom[0x7ffc] = 0x00 # lsb
rom[0x7ffd] = 0x80 # msb

# Save as binary file
with open("rom.bin", "wb") as out_file:
  out_file.write(rom);