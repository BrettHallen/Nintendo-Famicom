################################################
# Quickly dump out contents of NES file header #
# Brett Hallen, Jan 2026                       #
# NES 2.0 format:                              #
# https://www.nesdev.org/wiki/NES_2.0          #
################################################

import sys

def decode_size(value, low_byte):
    """
    Decode size for PRG/CHR in NES 2.0 format.
    """
    if value == 0xFFF:
        exponent = (low_byte >> 2) & 0x3F
        multiplier = (low_byte & 0x03) * 2 + 1
        return multiplier << exponent  # in bytes
    else:
        return value * (16384 if 'PRG' in decode_size.__name__ else 8192)  # Wait, no: PRG *16KB, CHR *8KB

# Fix: actually, since it's called separately, I'll handle in code.

def decode_ram_size(shift):
    if shift == 0:
        return 0
    return 64 << shift

def main():
    if len(sys.argv) < 2:
        print(">> Usage: python3 nes_header_read.py <rom_file>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'rb') as f:
            header = f.read(16)
    except IOError:
        print(f"\n!! Error opening file: {filename}")
        sys.exit(1)

    if len(header) != 16:
        print("\n !! Error: File is too small for NES header")
        sys.exit(1)

    if header[:4] != b'NES\x1a':
        actual_bytes = " ".join(f"0x{b:02X}" for b in header[:4])
        print("\n!! Error: Invalid NES magic bytes")
        print(f"             {actual_bytes}")
        print("   Expected: 0x4E 0x45 0x53 0x1A  ('NES' followed by 0x1A)\n")
        sys.exit(1)

    # Extract bytes as ints
    prg_rom_low = header[4]
    chr_rom_low = header[5]
    flags_6 = header[6]
    flags_7 = header[7]
    mapper_upper_low = header[8]  # For NES 2.0
    size_upper = header[9]
    prg_ram = header[10]
    chr_ram = header[11]
    cpu_ppu_timing = header[12]
    hardware_type = header[13]
    misc_roms = header[14]
    expansion_device = header[15]

    # Common fields
    mirroring = "Vertical" if (flags_6 & 0x01) else "Horizontal"
    has_battery = bool(flags_6 & 0x02)
    has_trainer = bool(flags_6 & 0x04)
    has_four_screen = bool(flags_6 & 0x08)
    mapper_low_nibble = flags_6 >> 4
    vs_unisystem = bool(flags_7 & 0x01)
    playchoice_10 = bool(flags_7 & 0x02)
    mapper_high_nibble = flags_7 >> 4

    # Determine format
    is_nes_20 = (flags_7 & 0x0C) == 0x08

    if not is_nes_20:
        print("\nFormat ........................... iNES (original)")
        mapper = (mapper_high_nibble << 4) | mapper_low_nibble
        prg_rom_size = prg_rom_low * 16384  # bytes
        chr_rom_size = chr_rom_low * 8192   # bytes
        prg_ram_size = 8192 if header[8] == 0 else header[8] * 8192  # Often 0 means 8KB
        tv_system = "PAL" if (header[9] & 0x01) else "NTSC"
        tv_system_compat = "Both" if (header[9] & 0x02) else tv_system  # Rare usage

        # Print decoded info
        print(f"PRG-ROM size ...................... {prg_rom_size} bytes ({prg_rom_low} * 16KB)")
        print(f"CHR-ROM size ...................... {chr_rom_size} bytes ({chr_rom_low} * 8KB)")
        print(f"PRG-RAM size ...................... {prg_ram_size} bytes")
        print(f"Mapper ............................ {mapper}")
        print(f"Mirroring ......................... {mirroring}")
        print(f"Battery-backed RAM ................ {has_battery}")
        print(f"Trainer ........................... {has_trainer}")
        print(f"Four-screen VRAM .................. {has_four_screen}")
        print(f"VS Unisystem ...................... {vs_unisystem}")
        print(f"PlayChoice-10 ..................... {playchoice_10}")
        print(f"TV System ......................... {tv_system}")
        if header[9] & 0x02:             
            print(f"TV System Compatibility .......... {tv_system_compat}")
        # Bytes 10-15 should be zero, but print if not
        if any(header[i] != 0 for i in range(10, 16)):
            print("!! Warning: Bytes 10-15 are not zero in iNES format:")
            print(" ".join(f"{header[i]:02X}" for i in range(10, 16)))
    else:
        print("\nFormat ............................ NES 2.0")
        mapper = (mapper_high_nibble << 4) | mapper_low_nibble | ((mapper_upper_low & 0x0F) << 8)
        submapper = mapper_upper_low >> 4

        # PRG-ROM size
        prg_val = prg_rom_low | ((size_upper & 0x0F) << 8)
        if prg_val == 0xFFF:
            exponent = (prg_rom_low >> 2) & 0x3F
            multiplier = (prg_rom_low & 0x03) * 2 + 1
            prg_rom_size = multiplier << exponent  # bytes
        else:
            prg_rom_size = prg_val * 16384

        # CHR-ROM size
        chr_val = chr_rom_low | ((size_upper >> 4) << 8)
        if chr_val == 0xFFF:
            exponent = (chr_rom_low >> 2) & 0x3F
            multiplier = (chr_rom_low & 0x03) * 2 + 1
            chr_rom_size = multiplier << exponent  # bytes
        else:
            chr_rom_size = chr_val * 8192

        # RAM sizes
        prg_ram_size = decode_ram_size(prg_ram & 0x0F)
        prg_nvram_size = decode_ram_size(prg_ram >> 4)
        chr_ram_size = decode_ram_size(chr_ram & 0x0F)
        chr_nvram_size = decode_ram_size(chr_ram >> 4)

        # CPU/PPU timing
        timing_mode = cpu_ppu_timing & 0x03
        if timing_mode == 0:
            timing_str = "RP2C02 (NTSC NES)"
        elif timing_mode == 1:
            timing_str = "RP2C07 (Licensed PAL NES)"
        elif timing_mode == 2:
            timing_str = "Multiple-region"
        elif timing_mode == 3:
            timing_str = "UMC 6527P (Dendy-like)"
        else:
            timing_str = "Unknown"

        # Byte 13 interpretation
        if timing_mode in [0, 3]:  # NTSC/Dendy
            vs_ppu_variant = hardware_type & 0x0F
            vs_protection = hardware_type >> 4
            extended_console_type = None
            print(f"Vs. System PPU variant ............ {vs_ppu_variant}")
            print(f"Vs. System hardware/protection .... {vs_protection}")
        else:  # PAL/Multiple
            extended_console_type = hardware_type & 0x0F
            vs_ppu_variant = None
            vs_protection = None
            console_types = {
                0x00: "Regular NES/Famicom/Dendy",
                0x01: "Nintendo Vs. System",
                0x02: "Nintendo Playchoice 10",
                0x03: "Regular Famiclone, but with CPU that supports Decimal Mode",
                0x04: "Regular NES/Famicom with EPSM module or plug-through cartridge",
                0x05: "V.R. Technology VT01 with red/cyan STN palette",
                0x06: "V.R. Technology VT02",
                0x07: "V.R. Technology VT03",
                0x08: "V.R. Technology VT09",
                0x09: "V.R. Technology VT32",
                0x0A: "V.R. Technology VT369",
                0x0B: "UMC UM6578",
                0x0C: "Famicom Network System"
            }
            print(f"Extended console type: ............ {console_types.get(extended_console_type, 'Unknown')}")

        # Misc ROMs
        num_misc_roms = misc_roms & 0x03

        # Expansion device
        exp_devices = {
              0x00: "Unspecified",
              0x01: "Standard NES/Famicom controllers",
              0x02: "NES Four Score/Satellite with two additional standard controllers",
              0x03: "Famicom Four Players Adapter with two additional standard controllers using the 'simple' protocol",
              0x04: "Vs. System (1P via $4016)",
              0x05: "Vs. System (1P via $4017)",
              0x06: "Reserved",
              0x07: "Vs. Zapper",
              0x08: "Zapper ($4017)",
              0x09: "Two Zappers",
              0x0A: "Bandai Hyper Shot Lightgun",
              0x0B: "Power Pad Side A",
              0x0C: "Power Pad Side B",
              0x0D: "Family Trainer Side A",
              0x0E: "Family Trainer Side B",
              0x0F: "Arkanoid Vaus Controller (NES)",
              0x10: "Arkanoid Vaus Controller (Famicom)",
              0x11: "Two Vaus Controllers plus Famicom Data Recorder",
              0x12: "Konami Hyper Shot Controller",
              0x13: "Coconuts Pachinko Controller",
              0x14: "Exciting Boxing Punching Bag (Blowup Doll)",
              0x15: "Jissen Mahjong Controller",
              0x16: "米澤 (Yonezawa) Party Tap",
              0x17: "Oeka Kids Tablet",
              0x18: "Sunsoft Barcode Battler",
              0x19: "Miracle Piano Keyboard",
              0x1A: "Pokkun Moguraa Tap-tap Mat (Whack-a-Mole Mat and Mallet)",
              0x1B: "Top Rider (Inflatable Bicycle)",
              0x1C: "Double-Fisted (Requires or allows use of two controllers by one player)",
              0x1D: "Famicom 3D System",
              0x1E: "Doremikko Keyboard",
              0x1F: "R.O.B. Gyromite",
              0x20: "Famicom Data Recorder ('silent' keyboard)",
              0x21: "ASCII Turbo File",
              0x22: "IGS Storage Battle Box",
              0x23: "Family BASIC Keyboard plus Famicom Data Recorder",
              0x24: "东达 (Dōngdá) PEC Keyboard",
              0x25: "普澤 (Pǔzé, a.k.a. Bit Corp.) Bit-79 Keyboard",
              0x26: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard",
              0x27: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus Macro Winners Mouse",
              0x28: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus Subor Mouse via $4016",
              0x29: "SNES Mouse ($4016)",
              0x2A: "Multicart",
              0x2B: "Two SNES controllers replacing the two standard NES controllers",
              0x2C: "RacerMate Bicycle",
              0x2D: "U-Force",
              0x2E: "R.O.B. Stack-Up",
              0x2F: "City Patrolman Lightgun",
              0x30: "Sharp C1 Cassette Interface",
              0x31: "Standard Controller with swapped Left-Right/Up-Down/B-A",
              0x32: "Excalibur Sudoku Pad",
              0x33: "ABL Pinball",
              0x34: "Golden Nugget Casino extra buttons",
              0x35: "科达 (Kēdá) Keyboard",
              0x36: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus Subor Mouse via $4017",
              0x37: "Port test controller",
              0x38: "Bandai Multi Game Player Gamepad buttons",
              0x39: "Venom TV Dance Mat",
              0x3A: "LG TV Remote Control",
              0x3B: "Famicom Network Controller",
              0x3C: "King Fishing Controller",
              0x3D: "Croaky Karaoke Controller",
              0x3E: "科王 (Kēwáng, a.k.a. Kingwon) Keyboard",
              0x3F: "泽诚 (Zéchéng) Keyboard",
              0x40: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus L90-rotated PS/2 mouse in $4017",
              0x41: "PS/2 Keyboard in UM6578 PS/2 port, PS/2 Mouse via $4017",
              0x42: "PS/2 Mouse in UM6578 PS/2 port",
              0x43: "裕兴 (Yùxìng) Mouse via $4016",
              0x44: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus 裕兴 (Yùxìng) Mouse mouse in $4016",
              0x45: "Gigggle TV Pump",
              0x46: "步步高 (Bùbùgāo, a.k.a. BBK) Keyboard plus R90-rotated PS/2 mouse in $4017",
              0x47: "Magical Cooking",
              0x48: "SNES Mouse ($4017)",
              0x49: "Zapper ($4016)",
              0x4A: "Arkanoid Vaus Controller (Prototype)",
              0x4B: "TV 麻雀 Game (TV Mahjong Game) Controller",
              0x4C: "麻雀激闘伝説 (Mahjong Gekitou Densetsu) Controller",
              0x4D: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus X-inverted PS/2 mouse in $4017",
              0x4E: "IBM PC/XT Keyboard",
              0x4F: "小霸王 (Xiǎobàwáng, a.k.a. Subor) Keyboard plus Mega Book Mouse"
        }
        exp_device_str = exp_devices.get(expansion_device, "Unknown")

        # Print decoded info
        print(f"PRG-ROM size ...................... {prg_rom_size} bytes")
        print(f"CHR-ROM size ...................... {chr_rom_size} bytes")
        print(f"PRG-RAM (volatile) size ........... {prg_ram_size} bytes")
        print(f"PRG-NVRAM (battery-backed) size ... {prg_nvram_size} bytes")
        print(f"CHR-RAM (volatile) size ........... {chr_ram_size} bytes")
        print(f"CHR-NVRAM (battery-backed) size ... {chr_nvram_size} bytes")
        print(f"Mapper ............................ {mapper}")
        print(f"Submapper ......................... {submapper}")
        print(f"Mirroring ......................... {mirroring}")
        print(f"Battery-backed .................... {has_battery}")
        print(f"Trainer ........................... {has_trainer}")
        print(f"Four-screen VRAM .................. {has_four_screen}")
        print(f"VS Unisystem ...................... {vs_unisystem}")
        print(f"PlayChoice-10 ..................... {playchoice_10}")
        print(f"CPU/PPU Timing .................... {timing_str}")
        if num_misc_roms > 0:
            print(f"Miscellaneous ROMs ................ {num_misc_roms}")
        print(f"Default expansion device .......... {exp_device_str}")
        # Byte 14 bits 2-7 and byte 15 bit 6-7 are reserved, should be 0
        if (misc_roms & 0xFC) != 0 or (expansion_device & 0xC0) != 0:
            print("!! Warning: Reserved bits in bytes 14 or 15 are set")
    print()

if __name__ == "__main__":
    main()