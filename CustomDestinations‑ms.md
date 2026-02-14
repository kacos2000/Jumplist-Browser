# Documentation: Structure of Windows .customDestinations‑ms Files 
*Based on reverse engineering and successful parsing of Jump List files.*

## 1. Overview
`.customDestinations‑ms` files are used by Windows to store per‑application jump lists. They are found in:
```
%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\
```
Each file is named by an **Application ID** (AppID) – *a hash of the application's executable path* – and contains a collection of **jump list groups**. Each group holds one or more **shell links (LNK)** that represent tasks, pinned items, or recent/frequent destinations.

The file format is a binary container that groups LNK records. The structure consists of:
- A **global header** (optional, but usually present).
- **Group markers** (`0xABFB BFBA`) that separate groups.
- **Group descriptors** containing the group title and entry count.
- **Embedded LNK files** (standard `[MS‑SHLLINK]` format) concatenated within each group.

## 2. File‑Level Structure

### **2.1. Global Header (First 20+ bytes)**
| Offset | Size | Field Name (Code) | Description |
|--------|------|-------------------|-------------|
| 0x00-0x03 | 4 | (Unknown/Header ID) | Often `0x02` or other identifier |
| 0x04-0x07 | 4 | **TypeCount** (UInt32) | Number of groups/task sections |
| 0x08-0x0F | 8 | Reserved/Unknown | Not parsed in code |
| 0x10-0x11 | 2 | **ECount** (UInt16) | Variable: First group's title size OR entry count sentinel (0xFFFF) |
| 0x12+ | Variable | Variable Data | Data leading to first group |

**Important Signatures:**
- **16-byte group signature**: `\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46`
  - Often found at offset 0x14 (20 decimal)
  - Marks start of first group in many files
- **20-byte LNK signature**: `\x4C\x00\x00\x00\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46`
  - Standard LNK header (76 bytes + CLSID)
  - Marks start of each embedded LNK file

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

##### **Format A: Named Groups (has title)**
```
[4 bytes] Type = 0x00000000
[2 bytes] TitleSize (UInt16) - character count (UTF-16)
[TitleSize × 2] Title (UTF-16 string)
[2 bytes] EntryCount (UInt16)
```

##### **Format B: Unnamed "Tasks" Groups**
```
[4 bytes] Type ≠ 0 (e.g., 0x00000001)
[2 bytes] EntryCount (UInt16) - stored at offset 4-5
```

**Special Cases:**
1. **First group at offset 20**: If 16-byte signature at offset 20 AND no title present
   - Treated as "Tasks" group
   - EntryCount read from offset 16-17

2. **First group with title**: If `ECount` ≠ 65535 (0xFFFF)
   - `ECount` = TitleSize in characters
   - Title follows at offset 18
   - EntryCount follows title

### **2.3.3. Group Location Determination**
```powershell
First Group Start = 
  IF (16-byte sig at offset 20) THEN offset 20 
  ELSE offset 0 OR first regex match location

Subsequent Groups Start = 
  Next ABFBBFBA delimiter + 4 bytes

Group End = 
  Next ABFBBFBA delimiter OR file end
```

### 2.4. LNK Embedding
LNK files are stored **back‑to‑back** within the group. Each LNK begins with a 20‑byte signature:

```
4C 00 00 00 01 14 02 00 00 00 00 00 C0 00 00 00 00 00 00 46
```
This is the concatenation of:
- **HeaderSize** = `0x4C` (76 bytes)
- **LinkCLSID** = `00021401-0000-0000-C000-000000000046` (the standard LNK class ID)

Therefore, to locate LNKs, scan the file (or a group’s byte range) for the pattern `0x4C0000000114020000000000C0000000000046`. Each occurrence marks the start of a valid LNK record.

## 3. Embedded LNK Structure
Once a LNK is located, its internal format follows the **Shell Link (.LNK) Binary File Format** 

### 3.1. ShellLinkHeader (76 bytes)
| Field | Offset | Size | Description |
|-------|--------|------|-------------|
| HeaderSize | 0x00 | 4 | Always 0x4C (76) |
| LinkCLSID | 0x04 | 16 | `00021401-0000-0000-C000-000000000046` |
| LinkFlags | 0x14 | 4 | Bitmask of optional structures |
| FileAttributes | 0x18 | 4 | DOS file attributes |
| CreationTime | 0x1C | 8 | FILETIME |
| AccessTime | 0x24 | 8 | FILETIME |
| WriteTime | 0x2C | 8 | FILETIME |
| FileSize | 0x34 | 4 | Target file size |
| IconIndex | 0x38 | 4 | Icon index in resource |
| ShowCommand | 0x3C | 4 | SW_* constant |
| HotKey | 0x40 | 2 | Keyboard shortcut |
| Reserved | 0x42 | 10 | Zero-filled |

### 3.2. Optional Structures (determined on LinkFlags)
```
1. LinkTargetIDList    (if HasLinkTargetIDList flag)
2. LinkInfo           (if HasLinkInfo flag) - CRITICAL for path
3. StringData         (if HasName/HasRelativePath/HasWorkingDir/HasArguments/HasIconLocation)
4. ExtraData          (various extensions)
```

### 3.3. Extracting the Target Path
The target path is assembled from the **LinkInfo** structure:

#### Path Extraction Method
1. **LocalBasePath** – read from `LinkInfoStart + LocalBasePathOffset` as a null‑terminated string. If the Unicode offset is present and non‑zero, prefer the Unicode version (UTF‑16).
2. **CommonPathSuffix** – read from `LinkInfoStart + CommonPathSuffixOffset` (or its Unicode variant) as a null‑terminated string.
3. Combine: if both exist, concatenate with a backslash (ensuring no double backslash). The result is the full target path.

If the LNK points to a network resource, the `CommonNetworkRelativeLink` structure can be parsed to obtain a UNC path.

```powershell
IF (LinkInfoHeaderSize ≥ 0x24 AND LocalBasePathOffsetUnicode ≠ 0) THEN
    Use Unicode path from LocalBasePathOffsetUnicode
ELSE
    Use ANSI path from LocalBasePathOffset

Combine: LocalBasePath + (optional backslash) + CommonPathSuffix
```

### 3.4. Arguments and Other String Data
The **StringData** section contains strings with a leading character count (UTF‑16). These are stored in the order determined by the LinkFlags (Name, RelativePath, WorkingDir, Arguments, IconLocation). Each string is preceded by a `UInt16` character count (excluding the null terminator), followed by that many UTF‑16 characters.

## 4. Parsing Algorithm 

### **Step 1: File Validation**
- Check file size ≥ 512 bytes
- Verify no sparse/offline/reparse point attributes

### **Step 2: Signature Detection**
```powershell
# Find group start signatures
$regex = "(\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46)"

# Find group delimiters
$regexC = "(\xAB\xFB\xBF\xBA)"
```

### **Step 3: Group Discovery Logic**
```powershell
IF (16-byte signature at offset 20) THEN
    First Group:
        Offset = 20
        IF (ECount = 65535) THEN
            Type = "Tasks"
            EntryCount = FileBytes[16-17]
        ELSE
            TitleSize = ECount
            Title = Unicode(FileBytes[18..(18+TitleSize×2-1)])
            EntryCount = FileBytes[18+TitleSize×2..(19+TitleSize×2)]
ELSE
    # Alternative detection via regex matching

FOR each delimiter at tidx[i]:
    Group Start = tidx[i] + 4
    Read Type from FileBytes[GroupStart..(GroupStart+3)]
  
    IF (Type = 0) THEN
        Parse as Named Group
    ELSE
        Parse as "Tasks" Group
```

### **Step 4: LNK Extraction**
```
FOR each group:
    Scan group byte range for 20-byte LNK signature
    FOR each signature found:
        LNK Start = Signature offset
        LNK End = Next signature OR group end
        Parse LNK structure using standard [MS-SHLLINK] format
```

## 5. Example (from a simple parser)
*(AppID: 497f749b9f1a5d16 => Microsoft.GamingApp)  
Given a `.customDestinations‑ms` file, the parser outputs:*  
```powershell
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
*Example Structure with Offsets*
```
File: 497f749b9f1a5d16.customDestinations-ms (AppID: 497f749b9f1a5d16)

0x00-0x03: [02 00 00 00]           // Header ID
0x04-0x07: [03 00 00 00]           // TypeCount = 3 groups
0x08-0x0F: [00 00 00 00 00 00 00 00] // Reserved
0x10-0x11: [FF FF]                 // ECount = 65535 (no title)
0x12-0x13: [00 00]                 // Unknown
0x14-0x23: [01 14 02 00 00 00 00 00 C0 00 00 00 00 00 00 46] // 1st group sig

// Group 1: "Tasks" (untitled)
0x24-0x27: [01 00 00 00]           // Type ≠ 0 = "Tasks"
0x28-0x29: [02 00]                 // EntryCount = 2
0x2A-0x??: [LNK data...]

0x???-0x???+3: [AB FB BF BA]       // Group delimiter

// Group 2: "Store" (titled)
[+4] 0x???+4-0x???+7: [00 00 00 00] // Type = 0
[+4] 0x???+8-0x???+9: [05 00]       // TitleSize = 5 chars
[+10] 0x???+A-0x???+13: [53 00 74 00 6F 00 72 00 65 00] // "Store" (UTF-16)
[+14] 0x???+E-0x???+F: [03 00]       // EntryCount = 3
```



## 6. Simple Parser examples

*AppID: 9E312F4ADEE9107 => Opera Browser*

- [`Parse-CustomDestination.ps1`](https://github.com/kacos2000/Jumplist-Browser/blob/master/Parse-CustomDestination.ps1) - will only show the Groups & Number of LNK files within each group:
```powershell
File: 9e312f4adee9107.customDestinations-ms
AppID: 9e312f4adee9107
Group Count (from header): 2

Groups Found:
  [42..14336] 'Speed Dial' - Entries: 7
  [14340..19406] 'Tasks' - Entries: 3
```

- [`Parse-CustomDestinationFull.ps1`](https://github.com/kacos2000/Jumplist-Browser/blob/master/Parse-CustomDestinationFull.ps1) - adds basic LNK parsing to the above:
```powershell
File: 9e312f4adee9107.customDestinations-ms
AppID: 9e312f4adee9107

Groups:
  [42] Speed Dial
    Number of Entries: 7
    [58] LNK #000
      Target: C:\Program Files\Opera\opera.exe
      Args:  http://www.amazon.co.uk/?tag=operadesktop14-sd-uk-21
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\e9cf71a8-df9c-4551-bc4b-5a4c7972fa51.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [2028] LNK #001
      Target: C:\Program Files\Opera\opera.exe
      Args:  http://www.awin1.com/cread.php?awinmid=3090&awinaffid=141629&clickref=Speed+Dial&p=http%3A%2F%2Fwww.very.co.uk
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\5761cdf8-b312-4b86-9660-b549c178d366.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [4110] LNK #002
      Target: C:\Program Files\Opera\opera.exe
      Args:  https://s.click.aliexpress.com/e/Fg3oCAJO
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\a887f1f7-e24a-418f-9318-8a5c17ef0ac9.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [6066] LNK #003
      Target: C:\Program Files\Opera\opera.exe
      Args:  https://www.booking.com/index.html?aid=343339&label=operasoft-sdg015-343339&utm_source=Opera&utm_medium=web&utm_campaign=sdg015
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\0202683f-8e77-4173-98be-e1e85e30bb82.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [8194] LNK #004
      Target: C:\Program Files\Opera\opera.exe
      Args:  http://solarmovie.sc/movie/the-grand-tour-season-1-17912/563174-8/watching.html#player-area
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\c54d665f-0285-4fe5-b2ff-57a36fa7b879.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [10342] LNK #005
      Target: C:\Program Files\Opera\opera.exe
      Args:  https://www.amazon.co.uk/gp/prime/pipeline/landing/?tag=operadesktop14-sdf-uk-prime-21
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\59a60404-c4e9-4fa6-89f4-1b865f725399.tmp
      Created: 17-Nov-2022 17:59:50.9839760
    [12392] LNK #006
      Target: C:\Program Files\Opera\opera.exe
      Args:  https://www.facebook.com/
      Icon: C:\Users\Username\AppData\Roaming\Opera Software\Opera Stable\Default\Jump List Icons\be5cfec9-1acd-4c69-836b-e39f4609eaca.tmp
      Created: 17-Nov-2022 17:59:50.9839760
  [14340] Tasks
    Number of Entries: 3
    [14364] LNK #000
      Target: C:\Program Files\Opera\opera.exe
      Args:  --new-tab
      Icon: C:\Program Files\Opera\opera.exe
      Created: 17-Nov-2022 17:59:50.9839760
    [16036] LNK #001
      Target: C:\Program Files\Opera\opera.exe
      Args:  --new-window
      Icon: C:\Program Files\Opera\opera.exe
      Created: 17-Nov-2022 17:59:50.9839760
    [17722] LNK #002
      Target: C:\Program Files\Opera\opera.exe
      Args:  --incognito
      Icon: C:\Program Files\Opera\opera.exe
      Created: 17-Nov-2022 17:59:50.9839760
```

## 7. References
- [`MS‑SHLLINK`](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/) Shell Link (.LNK) Binary File Format
- [Autopsy `JLnkParser.java`](https://sleuthkit.org/autopsy/docs/api-docs/4.4/_j_lnk_parser_8java_source.html)
- [Stack Overflow C# LNK target extraction](https://stackoverflow.com/questions/64126236/)

## 8. Notes
- Some `.customDestinations‑ms` files may contain **only LNKs** without groups (treated as a single implicit group). The group markers may be absent; in such cases, treat the whole file as one group.
- LNKs may be stored with extra padding between them; scanning for the signature is the most reliable detection method.
- The `LinkInfo` structure may contain **both ANSI and Unicode** strings. Always prefer Unicode when available, as it preserves non‑ASCII characters correctly.
