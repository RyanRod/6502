# Allocate 32kB of memory (eeprom size)
rom = bytearray([0xea] * 32768)

# Start program counter at address 0x8000
rom[0x7ffc] = 0x00 # lsb
rom[0x7ffd] = 0x80 # msb

# Save as binary file
with open("rom.bin", "wb") as out_file:
  out_file.write(rom);