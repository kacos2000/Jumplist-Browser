# Documentation: Structure of Windows .customDestinations‑ms Files 
*Based on reverse engineering and successful parsing of Jump List files.*

## 1. Overview
`.customDestinations‑ms` files are used by Windows to store per‑application jump lists. They are found in:
```
%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\
```
Each file is named by an **Application ID** (AppID) – a hash of the application's executable path – and contains a collection of **jump list groups**. Each group holds one or more **shell links (LNK)** that represent tasks, pinned items, or recent/frequent destinations.

The file format is a binary container that groups LNK records. The structure consists of:
- A **global header** (optional, but usually present).
- **Group markers** (`0xABFB BFBA`) that separate groups.
- **Group descriptors** containing the group title and entry count.
- **Embedded LNK files** (standard `[MS‑SHLLINK]` format) concatenated within each group.

## 2. File‑Level Structure

### 2.1. Global Header (first 8+ bytes)
| Offset | Size | Description |
|--------|------|-------------|
| 0x00   | 4    | Unknown – often `0x02` |
| 0x04   | 4    | **Number of groups** (little‑endian `UInt32`) |
| 0x08   | ...  | Variable data leading to first group |

A known signature `0x01140200 00000000 C0000000 00000046` (16 bytes) is often found at offset 0x14, but its presence is not mandatory for parsing.

### 2.2. Group Markers
Groups are separated by a 4‑byte marker:  
`AB FB BF BA` (little‑endian: `0xAB`, `0xFB`, `0xBF`, `0xBA`).  
This marker appears **before each group descriptor** (except possibly the first group, which may start immediately after the global header).

### 2.3. Group Descriptor
Immediately following a group marker (or at the start of the file for the first group), a variable‑length structure describes the group:

#### 2.3.1. First Group Special Case
If the file contains the 16‑byte signature at offset 0x14, the first group may be located at offset **0x20** (as seen in many samples). In that case, the group descriptor is read from there.

#### 2.3.2. General Group Descriptor Format
| Offset | Size | Description |
|--------|------|-------------|
| 0x00   | 2    | **Title size** in characters (UTF‑16) – if the group is named; otherwise this field may be the entry count (see below). |
| 0x02   | N    | **Group title** (UTF‑16, `TitleSize` characters). |
| after title | 2 | **Entry count** – number of LNKs in this group. |
| after count | … | **LNK data** – concatenated LNK files, each starting at a 20‑byte signature. |

If the group is unnamed (e.g., the default "Tasks" group), the `TitleSize` field is often `0xFFFF` (`65535`) and the entry count is stored at the same location where the title would be.

### 2.4. LNK Embedding
LNK files are stored **back‑to‑back** within the group. Each LNK begins with a 20‑byte signature:

```
4C 00 00 00 01 14 02 00 00 00 00 00 C0 00 00 00 00 00 00 46
```
This is the concatenation of:
- **HeaderSize** = `0x4C` (76 bytes)
- **LinkCLSID** = `00021401-0000-0000-C000-000000000046` (the standard LNK class ID)

Therefore, to locate LNKs, scan the file (or a group’s byte range) for the pattern `0x4C0000000114020000000000C0000000000046`. Each occurrence marks the start of a valid LNK record.

## 3. LNK Structure (Simplified)
Once a LNK is located, its internal format follows the **Shell Link (.LNK) Binary File Format** ([MS‑SHLLINK]). The essential parts extracted for jump list purposes are:

### 3.1. ShellLinkHeader (76 bytes)
| Offset | Size | Field |
|--------|------|-------|
| 0x00   | 4    | HeaderSize (always 0x4C) |
| 0x04   | 16   | LinkCLSID (as above) |
| 0x14   | 4    | LinkFlags (bitmask) |
| 0x18   | 4    | FileAttributes |
| 0x1C   | 8    | CreationTime (FILETIME) |
| 0x24   | 8    | AccessTime |
| 0x2C   | 8    | WriteTime |
| 0x34   | 4    | FileSize |
| 0x38   | 4    | IconIndex |
| 0x3C   | 4    | ShowCommand |
| 0x40   | 2    | HotKey |
| 0x42   | 10   | Reserved |

### 3.2. Optional Structures (depending on LinkFlags)
- **LinkTargetIDList** – a shell namespace path (skipped in our simple target extraction).
- **LinkInfo** – contains drive and path information (critical for target path).
- **StringData** – holds Name, RelativePath, WorkingDir, Arguments, IconLocation.
- **ExtraData** – various extensions (often ignored).

### 3.3. Extracting the Target Path
The target path is assembled from the **LinkInfo** structure:

#### LinkInfo Header
| Offset | Size | Field |
|--------|------|-------|
| 0x00   | 4    | LinkInfoSize |
| 0x04   | 4    | LinkInfoHeaderSize |
| 0x08   | 4    | LinkInfoFlags |
| 0x0C   | 4    | VolumeIDOffset |
| 0x10   | 4    | LocalBasePathOffset |
| 0x14   | 4    | CommonNetworkRelativeLinkOffset |
| 0x18   | 4    | CommonPathSuffixOffset |
| 0x1C   | 4    | (if LinkInfoHeaderSize ≥ 0x24) LocalBasePathOffsetUnicode |
| 0x20   | 4    | (if LinkInfoHeaderSize ≥ 0x24) CommonPathSuffixOffsetUnicode |

#### Path Extraction Method
1. **LocalBasePath** – read from `LinkInfoStart + LocalBasePathOffset` as a null‑terminated string. If the Unicode offset is present and non‑zero, prefer the Unicode version (UTF‑16).
2. **CommonPathSuffix** – read from `LinkInfoStart + CommonPathSuffixOffset` (or its Unicode variant) as a null‑terminated string.
3. Combine: if both exist, concatenate with a backslash (ensuring no double backslash). The result is the full target path.

If the LNK points to a network resource, the `CommonNetworkRelativeLink` structure can be parsed to obtain a UNC path.

### 3.4. Arguments and Other String Data
The **StringData** section contains strings with a leading character count (UTF‑16). These are stored in the order determined by the LinkFlags (Name, RelativePath, WorkingDir, Arguments, IconLocation). Each string is preceded by a `UInt16` character count (excluding the null terminator), followed by that many UTF‑16 characters.

## 4. Parsing Algorithm (as implemented in PowerShell)

### 4.1. Group Detection
- Read the entire file as a byte array.
- Locate all occurrences of the marker `AB FB BF BA` using a byte‑search function.
- The number of markers + 1 usually equals the number of groups (except when the first group lacks a leading marker).
- The group count can also be read from the `UInt32` at offset `0x04` (often reliable).

### 4.2. Group Range Determination
- The first group starts at offset `0x20` if the 16‑byte signature is present; otherwise at offset `0x00`.
- Each group ends at the next marker (or the end of the file).
- For each group, extract the byte range `[groupStart..groupEnd-1]`.

### 4.3. LNK Location within Group
- Scan the group’s byte range for the 20‑byte LNK signature `0x4C0000000114020000000000C0000000000046`.
- Each found offset (absolute within the file) is the start of an LNK.
- The LNK’s length is assumed to extend until the next signature or the end of the group.

### 4.4. LNK Parsing
For each LNK:
- Verify the header size and CLSID.
- Read LinkFlags and timestamps.
- If the `HasLinkInfo` flag is set, parse the LinkInfo block as described above to obtain `LocalBasePath` and `CommonPathSuffix`. Prefer Unicode if available.
- If the `HasArguments` flag is set, read the arguments string from the StringData section.
- If the `HasName` flag is set, read the LNK name (display name).
- If the `HasIconLocation` flag is set, read the icon location.
- Build the target path from the LinkInfo strings.
- Return a structured object with all extracted fields.

## 5. Example (from a working parser)
*Given a `.customDestinations‑ms` file, the parser outputs:  
(example from [Microsoft.GamingApp])*
```ruby
File: 497f749b9f1a5d16.customDestinations-ms
AppID: 497f749b9f1a5d16

Groups:
  [1136] Store
    Number of Entries: 2
    [1172] LNK #000 - Redeem an Xbox code
      Name: Redeem an Xbox code
    [2202] LNK #001 - Buy game from Store tab
      Name: Buy game from Store tab
  [3188] Tasks
    Number of Entries: 1
    [3212] LNK #000 - Go to Settings
      Name: Go to Settings
  [24] Games
    Number of Entries: 1
    [60] LNK #000 - New additions to Game Pass
      Name: New additions to Game Pass
```

# 6. Parsing examples
- [`Parse-CustomDestination.ps1` - will only show the Groups & Number of LNK files within each group.](https://github.com/kacos2000/Jumplist-Browser/blob/master/Parse-CustomDestination.ps1)
- [`Parse-CustomDestinationFull.ps1` - adds basic LNK parsing to the above.](https://github.com/kacos2000/Jumplist-Browser/blob/master/Parse-CustomDestinationFull.ps1)

## 7. References
- [`MS‑SHLLINK`](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/) Shell Link (.LNK) Binary File Format
- [Autopsy `JLnkParser.java`](https://sleuthkit.org/autopsy/docs/api-docs/4.4/_j_lnk_parser_8java_source.html)
- [Stack Overflow C# LNK target extraction](https://stackoverflow.com/questions/64126236/)

## 8. Notes
- Some `.customDestinations‑ms` files may contain **only LNKs** without groups (treated as a single implicit group). The group markers may be absent; in such cases, treat the whole file as one group.
- LNKs may be stored with extra padding between them; scanning for the signature is the most reliable detection method.
- The `LinkInfo` structure may contain **both ANSI and Unicode** strings. Always prefer Unicode when available, as it preserves non‑ASCII characters correctly.
