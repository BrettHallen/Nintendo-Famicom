#######################################################
# Patch Nintendo Family BASIC ROM for 8KB RAM support #
# Top of RAM increases from 0x6FFF to 0x7FFF          #
# Expects the raw ROM binary file                     #
# Brett Hallen, Jan 2026                              #
# Excellent supporting information used:              #
# http://cmpslv3.stars.ne.jp/Konjo/027/027.htm        #
# https://github.com/micahcowan/fbdasm                #
# https://github.com/NipponNoraneko/FC-DiskBASIC      #
#######################################################

import zlib
import os
import sys
import argparse

################################################
# Expected CRC32 values: original, patched     #
# If your CRCs differ when you run the script, #
# simply patch the actual values below         #
################################################
KNOWN_CRCS = {
    # "FBv20A": (0x????????, 0x????????),  # Need to dump the ROMs
    "FBv21A":     (0xF7D29720, 0xE3E9B30B),
    "FBv30":      (0x3AAEED3F, 0xE6EC08AC),
    "FBv30_merge":(0xB2530AFC, 0xECD87504),
    "FBv30_iNES": (0x667F6EA6, 0x38F4115E),
    "FB_CHR":     (0x11848B93, 0x11848B93)
}

########################################################################
# Patches: offset (hex), original byte, new byte, optional description #
########################################################################
PATCHES = {
    "FBv30": [
        (0x06A4, 0x6F, 0x7F, "8KB RAM support"),        # lda #>memoryTop
        (0x17D8, 0x70, 0x80, "8KB RAM support"),        # cmp #$70
        (0x2DC9, 0x70, 0x80, "8KB RAM support"),        # lda #(>memoryTop)+1
        (0x31BE, 0x6C, 0x7C, "8KB RAM support"),        # cmp #>bgGetRam
        (0x31CB, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x320C, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x132E, 0xA0, 0xA9, "REM bugfix"),             # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F89, 0x30, 0x31, "Version change to v3.1")
    ],
    "FBv30_merge": [
        (0x06A4, 0x6F, 0x7F, "8KB RAM support"),        # lda #>memoryTop
        (0x17D8, 0x70, 0x80, "8KB RAM support"),        # cmp #$70
        (0x2DC9, 0x70, 0x80, "8KB RAM support"),        # lda #(>memoryTop)+1
        (0x31BE, 0x6C, 0x7C, "8KB RAM support"),        # cmp #>bgGetRam
        (0x31CB, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x320C, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x132E, 0xA0, 0xA9, "REM bugfix"),             # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F89, 0x30, 0x31, "Version change to v3.1")
    ],
    "FBv30_iNES": [
        (0x06B4, 0x6F, 0x7F, "8KB RAM support"),        # lda #>memoryTop
        (0x17E8, 0x70, 0x80, "8KB RAM support"),        # cmp #$70
        (0x2DD9, 0x70, 0x80, "8KB RAM support"),        # lda #(>memoryTop)+1
        (0x31CE, 0x6C, 0x7C, "8KB RAM support"),        # cmp #>bgGetRam
        (0x31DB, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x321C, 0x6C, 0x7C, "8KB RAM support"),        # lda #>bgGetRam
        (0x133E, 0xA0, 0xA9, "REM bugfix"),             # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F99, 0x30, 0x31, "Version change to v3.1")
    ],
    "FBv21A": [
        (0x40DB, 0x70, 0x60, ""),
        (0x40E0, 0x70, 0x60, ""),
        (0x40E7, 0x70, 0x60, ""),
        (0x40EC, 0x70, 0x60, ""),
        (0x40FD, 0x70, 0x60, ""),
        (0x4104, 0x70, 0x60, ""),
        (0x410B, 0x70, 0x60, ""),
        (0x4110, 0x70, 0x60, ""),
        (0x4118, 0x70, 0x60, ""),
        (0x4210, 0x70, 0x60, ""),
        (0x4213, 0x70, 0x60, ""),
        (0x438D, 0x70, 0x60, ""),
        (0x4390, 0x70, 0x60, ""),
        (0x4393, 0x70, 0x60, ""),
        (0x43A5, 0x70, 0x60, ""),
    ]
}

# Base friendly names (unpatched)
friendly_names = {
    "FBv20A":     "Family BASIC v2.0A",
    "FBv21A":     "Family BASIC v2.1A",
    "FBv30":      "Family BASIC v3.0",
    "FBv30_merge":"Family BASIC v3.0 (PRG+CHR)",
    "FBv30_iNES": "Family BASIC v3.0 (iNES header)",
    "FB_CHR":     "Family BASIC CHR ROM"
}

def calculate_crc32(filename):
    """Calculate standard CRC32 of a file"""
    with open(filename, 'rb') as f:
        crc = 0
        while chunk := f.read(8192):
            crc = zlib.crc32(chunk, crc)
    return crc & 0xFFFFFFFF

def calculate_crc32_data(data):
    """Calculate CRC32 directly from bytearray"""
    crc = 0
    i = 0
    while i < len(data):
        chunk = data[i:i+8192]
        crc = zlib.crc32(chunk, crc)
        i += len(chunk)
    return crc & 0xFFFFFFFF

def apply_patches(data, patches, version_name):
    """Apply patches with optional description and verify original bytes"""
    for patch in patches:
        if len(patch) == 4:
            offset, original, new, description = patch
        elif len(patch) == 3:
            offset, original, new = patch
            description = ""
        else:
            print(f"!! Error: Invalid patch format: {patch}")
            sys.exit(1)

        if offset >= len(data):
            print(f"!! Error: Patch offset 0x{offset:04X} is beyond file end ({len(data)} bytes).")
            sys.exit(1)

        current = data[offset]
        if current != original:
            print(f"!! Warning: Byte at 0x{offset:04X} is 0x{current:02X}, expected 0x{original:02X} "
                  f"(for {version_name}). Continuing anyway.")

        desc_part = f" ({description})" if description else ""
        print(f"Patching 0x{offset:04X}: 0x{current:02X} → 0x{new:02X}{desc_part}")
        data[offset] = new

def main():
    parser = argparse.ArgumentParser(
        description="Verify and patch Family BASIC ROMs (8KB RAM expansion support)"
    )
    parser.add_argument("romfile", help="Path to the Family BASIC ROM file")
    parser.add_argument("-o", "--output", help="Custom output filename (optional)")

    args = parser.parse_args()

    if not os.path.isfile(args.romfile):
        print(f"!! Error: File '{args.romfile}' not found.\n")
        sys.exit(1)

    print("\n#############################################")
    print("# Brett's Nintendo Family BASIC ROM patcher #")
    print("# for 8KB RAM Support (Jan 2026)            #")
    print("# Work in progress, 12/JAN/2026             #")
    print("#############################################\n")

    # Calculate input CRC32
    input_crc = calculate_crc32(args.romfile)
    print(f">> Input ROM checksum: 0x{input_crc:08X}")

    # Find matching version
    matched_version = None
    is_already_patched = False
    expected_original = None
    expected_patched = None

    for version, (orig_crc, pat_crc) in KNOWN_CRCS.items():
        if input_crc == orig_crc:
            matched_version = version
            expected_original = orig_crc
            expected_patched = pat_crc
            break
        elif input_crc == pat_crc:
            matched_version = version
            is_already_patched = True
            expected_original = orig_crc
            expected_patched = pat_crc
            break

    if matched_version is None:
        print("!! Doesn't match any expected value (original or patched).\n")
        sys.exit(1)

    # Determine display name
    base_name = friendly_names.get(matched_version, matched_version)
    display_name = f"{base_name} (patched)" if is_already_patched else base_name

    print(f">> Matches {display_name}\n")

    if is_already_patched:
        print("!! This ROM is already patched for 8KB RAM support.")
        print(">> Checksum verified correctly.")
        if not args.output:
            print(">> No output requested - nothing more to do.\n")
            sys.exit(0)

    if matched_version not in PATCHES or not PATCHES[matched_version]:
        print("!! No patches defined for this version.\n")
        sys.exit(0)

    # Load and apply patches
    with open(args.romfile, 'rb') as f:
        data = bytearray(f.read())

    print(">> Applying patches:")
    apply_patches(data, PATCHES[matched_version], base_name)

    # Generate output filename
    if args.output:
        output_file = args.output
    else:
        base, ext = os.path.splitext(args.romfile)
        output_file = f"{base}_8KB_patch{ext}"

    # Write patched ROM
    with open(output_file, 'wb') as f:
        f.write(data)

    print(f"\n>> Patched ROM saved as: {output_file}")

    # Verify patched CRC32
    patched_crc = calculate_crc32_data(data)
    print(f">> Patched ROM checksum: 0x{patched_crc:08X}")

    if patched_crc == expected_patched:
        print(f">> SUCCESS: Checksum verified\n")
    else:
        print(f"!! ERROR: Patched checksum does not match expected 0x{expected_patched:08X}")
        print("!! Patching failed or ROM was unexpected variant.\n")
        sys.exit(1)

if __name__ == "__main__":
    main()
