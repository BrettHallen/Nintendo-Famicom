#######################################################
# Patch Nintendo Family BASIC ROM for 8KB RAM support #
# Top of RAM increases from 0x6FFF to 0x7FFF          #
# Also implements some bug fixes                      #
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
    "FBv10":        (0x868FCD89, 0x00000000), # no 8KB patch planned
    "FBv10_merge":  (0xF7DB8B5C, 0x00000000), # no 8KB patch planned
    "FBv10_NES":    (0x30B1840A, 0x00000000), # no 8KB patch planned
    "FBv20A_merge": (0xF7606810, 0x00000000), # no 8KB patch planned
    "FBv20A_NES2":  (0x300A6746, 0x00000000), # no 8KB patch planned
    "FBv21A":       (0xDE34526E, 0xCDC434C6),
    "FBv21A_merge": (0x895037BC, 0x141C2FEF),
    "FBv21A_NES2":  (0x4E3A38EA, 0x714825EC),
    "FBv30":        (0x3AAEED3F, 0xE6EC08AC),
    "FBv30_merge":  (0xB2530AFC, 0xECD87504),
    "FBv30_NES2":   (0x6BA08175, 0x2FBC0BF8),
    "FB_CHR":       (0x11848B93, 0x11848B93)
}

########################################################################
# Patches: offset (hex), original byte, new byte, optional description #
########################################################################
PATCHES_BYTES = {
    # Family BASIC v3.0 PRG only
    "FBv30": [
        (0x06A4, 0x6F, 0x7F, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>memoryTop
        (0x17D8, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #$70
        (0x2DC9, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #(>memoryTop)+1
        (0x31BE, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #>bgGetRam
        (0x31CB, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x320C, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x132E, 0xA0, 0xA9, "REM statement bug fix"),                      # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F89, 0x30, 0x31, "Version change to v3.1")
    ],
    # Family BASIC v3.0 PRG+CHR combined
    "FBv30_merge": [
        (0x06A4, 0x6F, 0x7F, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>memoryTop
        (0x17D8, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #$70
        (0x2DC9, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #(>memoryTop)+1
        (0x31BE, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #>bgGetRam
        (0x31CB, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x320C, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x132E, 0xA0, 0xA9, "REM statement bug fix"),                      # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F89, 0x30, 0x31, "Version change to v3.1")
    ],
    # Family BASIC v3.0 PRG+CHR+NES header
    "FBv30_NES2": [
        (0x000A, 0x60, 0x70, "NES 2.0 header 4KB->8KB"),
        (0x06B4, 0x6F, 0x7F, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>memoryTop
        (0x17E8, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #$70
        (0x2DD9, 0x70, 0x80, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #(>memoryTop)+1
        (0x31CE, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # cmp #>bgGetRam
        (0x31DB, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x321C, 0x6C, 0x7C, "Increase RAM limit from 0x6C00 to 0x7C00"),  # lda #>bgGetRam
        (0x133E, 0xA0, 0xA9, "REM statement bug fix"),                      # ldy #$00 -> lda #$00 (Micah's REM bugfix)
        (0x4F99, 0x30, 0x31, "Version change to v3.1")
    ]
}

########################################################################
# Multi-byte patches: (offset, original_bytes, new_bytes, description) #
# Bytes can be given as hex string or list of ints                     #
########################################################################
PATCHES_BYTESTRINGS = {
    # Family BASIC v3.0 PRG+CHR+NES header
    "FBv30_NES2": [
        (
            0x0CAD,
            [0xA5, 0x7D, 0xC5, 0x7F, 0xF0, 0x02, 0xB0, 0x0C, 0xA5, 0x7C, 0xC5, 0x7E, 0xB0, 0x06],
            [0xA5, 0x7C, 0x38, 0xE5, 0x7E, 0xA5, 0x7D, 0xE5, 0x7F, 0xB0, 0x09, 0x4C, 0xAB, 0x8C],
            "RENUM command bug fix"
        ),
    ]
}

# Base friendly names (unpatched)
friendly_names = {
    "FBv10":        "Family BASIC v1.0 (PRG)",
    "FBv10_merge":  "Family BASIC v1.0 (PRG+CHR)",
    "FBv20A":       "Family BASIC v2.0A (PRG)",
    "FBv20A_merge": "Family BASIC v2.0A (PRG+CHR)",
    "FBv20A_NES2":  "Family BASIC v2.0A (NES 2.0 header)",
    "FBv21A":       "Family BASIC v2.1A (PRG)",
    "FBv21A_merge": "Family BASIC v2.1A (PRG+CHR)",
    "FBv21A_NES2":  "Family BASIC v2.1A (NES 2.0 header)",
    "FBv30":        "Family BASIC v3.0 (PRG)",
    "FBv30_merge":  "Family BASIC v3.0 (PRG+CHR)",
    "FBv30_NES2":   "Family BASIC v3.0 (NES 2.0 header)",
    "FB_CHR":       "Family BASIC CHR ROM"
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

def apply_patches(data, version_name):
    """Apply both single-byte and multi-byte patches"""
    error_found = False

    # 1. Apply single-byte patches first
    if version_name in PATCHES_BYTES:
        print("\n>> Applying single-byte patches:")
        for patch in PATCHES_BYTES[version_name]:
            if len(patch) == 4:
                offset, original, new, description = patch
            else:
                offset, original, new = patch
                description = ""

            if offset >= len(data):
                print(f"!! Error: Patch offset 0x{offset:04X} beyond file end")
                error_found = True
                continue

            current = data[offset]
            if current != original:
                print(f"!! Warning: Byte at 0x{offset:04X} is 0x{current:02X}, expected 0x{original:02X} – skipping")
                error_found = True
            else:
                desc_part = f" ({description})" if description else ""
                print(f"Patching 0x{offset:04X}: 0x{current:02X} → 0x{new:02X}{desc_part}")
                data[offset] = new

    # 2. Apply multi-byte patches afterwards
    if version_name in PATCHES_BYTESTRINGS:
        print("\n>> Applying multi-byte patches:")
        for patch in PATCHES_BYTESTRINGS[version_name]:
            offset, orig_bytes, new_bytes, description = patch

            # Convert hex strings to lists if needed
            if isinstance(orig_bytes, str):
                orig_bytes = [int(x, 16) for x in orig_bytes.split()]
            if isinstance(new_bytes, str):
                new_bytes = [int(x, 16) for x in new_bytes.split()]

            patch_len = len(orig_bytes)
            if offset + patch_len > len(data):
                print(f"!! Error: Multi-byte patch at 0x{offset:04X} (len {patch_len}) exceeds file size")
                error_found = True
                continue

            current = data[offset:offset + patch_len]
            if list(current) != orig_bytes:
                print(f"!! Warning: Bytes at 0x{offset:04X} do not match expected sequence – skipping")
                print(f"   Expected: {' '.join(f'{b:02X}' for b in orig_bytes)}")
                print(f"   Found:    {' '.join(f'{b:02X}' for b in current)}")
                error_found = True
            else:
                for i in range(patch_len):
                    old_b = orig_bytes[i]
                    new_b = new_bytes[i]
                    print(f"Patching 0x{offset + i:04X}: 0x{old_b:02X} → 0x{new_b:02X} ({description})")
                    data[offset + i] = new_b

    return error_found

def main():
    parser = argparse.ArgumentParser(
        description="Patch Family BASIC ROMs for 8KB RAM support + bug fixes"
    )
    parser.add_argument("romfile", help="Path to the Family BASIC ROM file")
    parser.add_argument("-o", "--output", help="Custom output filename (optional)")

    args = parser.parse_args()

    if not os.path.isfile(args.romfile):
        print(f"!! Error: File '{args.romfile}' not found.")
        sys.exit(1)

    print("\n#############################################")
    print("# Brett's Nintendo Family BASIC ROM patcher #")
    print("# for 8KB RAM Support (Jan 2026)            #")
    print("# Work in progress, 13/JAN/2026             #")
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

    base_name = friendly_names.get(matched_version, matched_version)
    display_name = f"{base_name} (patched)" if is_already_patched else base_name
    print(f">> Detected: {display_name}")

    if is_already_patched:
        print("This ROM appears to be already patched.")
        if not args.output:
            sys.exit(0)

    with open(args.romfile, 'rb') as f:
        data = bytearray(f.read())

    error_found = apply_patches(data, matched_version)

    if args.output:
        output_file = args.output
    else:
        base, ext = os.path.splitext(args.romfile)
        output_file = f"{base}_patched{ext}"

    if not error_found:
        with open(output_file, 'wb') as f:
            f.write(data)
        print(f"\n>> Patched ROM saved as: {output_file}")

        patched_crc = calculate_crc32_data(data)
         # Verify patched CRC32
        patched_crc = calculate_crc32_data(data)
        print(f">> Patched ROM checksum: 0x{patched_crc:08X}")

        if patched_crc == expected_patched:
            print(f">> SUCCESS: Checksum verified\n")
        else:
            print(f"!! ERROR: Patched checksum does not match expected 0x{expected_patched:08X}")
            print("!! Patching failed or ROM was unexpected variant.\n")
            sys.exit(1)
    else:
    	print("\n!! Errors found, patching aborted.\n")
    	sys.exit(1)

if __name__ == "__main__":
    main()