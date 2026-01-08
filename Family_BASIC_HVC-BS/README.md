# Nintendo Famicom Family BASIC
## Version 2.0A
This is the original version for the Famicom.<br>
- PRG: two 16KB (128Kbit) ROMs (RP2D129 0531 and RP2D129 0532) labelled "HVC-FBI-1A" and "HVC-FBI-1B"
- CHR: one 8KB (64Kbit) ROM (RP2D68 0047) labelled "HVC-FB1-0C"
- RAM: 2KB (Fujitsu MB8416A-15-SK)<br>

## Version 2.1A
This is a bugfix version that was available if you returned your v2.0A cartridge.<br>
- PRG: one 32KB (256Kbit) ROM (Fujitsu MB83256) labelled "HVC-FB1-2W"
- CHR: one 8KB (64Kbit) ROM (RP2D70 0032) labelled "HVC-FB1-0C"
- RAM: 2KB (Fujitsu MB8416A-16L-SK)

## Version 3.0
Improved BASIC with double the RAM of v2.<br>
- PRG: one 32KB (256Kbit) ROM (Toshiba TC53257P-1613) labelled "HVC-VT-0W"
- CHR: one 8KB (64Kbit) ROM (M3864-31) labelled "HVC-FB1-0C"
- RAM: 4KB (Toshiba TC5533P-B)

## Adding Support for 8KB RAM
The top of memory is hardcoded to 4KB (in v3.0) so simply replacing the 4KB (32Kbit) RAM won't make any difference - the code needs patching.<br>

There is a [information available](https://github.com/NipponNoraneko/FC-DiskBASIC) about patching v2.1A to mainly add Famicom Disk System (FDS) support, which also increases the RAM to 8KB.  This information mainly concerns itself with creating a Disk BASIC whereas I'm more interested in purely upgrading the cartridge.<br>

This [disassembly of the v3.0 ROM](https://github.com/micahcowan/fbdasm) is invaluable.<br>

So far it looks like these are the required patches in the v3.0 ROM to increase the top of RAM from 0x6FFF (4KB) to 0x7FFF (8KB) - working on verifying the others:<br>
```
   bgGetRam  .eq $6c00  {addr/1024} ; region to save bg data with BGGET
   memoryTop .eq $6fff              ; What FRETOP is set to by default

PATCH0: lda #>memoryTop
06A4: 6F -> 7F

PATCH1: cmp #$70 ;arg >= #$7000?
17D8: 70 -> 80

PATCH2: lda #(>memoryTop)+1
2DC9: 70 -> 80

PATCH3: cmp #>bgGetRam ;is there room after program for BG data?
31BE: 6C -> 7C     

PATCH4: lda #>bgGetRam
31CB: 6C -> 7C

PATCH5: lda #>bgGetRam
320C: 6C -> 7C
```

I am working on a Python script to make this patching of the binary ROM simple:<br>
```
% python3 fb_8kb_patch2.py Family_BASIC_v30_PRG.BIN

#############################################
# Brett's Nintendo Family BASIC ROM patcher #
# for 8KB RAM Support (Jan 2026)            #
#############################################

>> Input ROM checksum: 0x3AAEED3F
>> Matches Family BASIC v3.0

>> Applying patches:
Patching 0x06A4: 0x6F → 0x7F
Patching 0x17D8: 0x70 → 0x80
Patching 0x2DC9: 0x70 → 0x80
Patching 0x31BE: 0x6C → 0x7C
Patching 0x31CB: 0x6C → 0x7C
Patching 0x320C: 0x6C → 0x7C

>> Patched ROM saved as: Family_BASIC_v30_PRG_8KB_patch.BIN
>> Patched ROM checksum: 0xB66688F1
>> SUCCESS: Checksum verified
```
