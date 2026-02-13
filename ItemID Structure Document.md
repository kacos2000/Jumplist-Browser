# **MS-SHLLINK LinkTargetIDList (ItemID) Structure Document**
## **Combined with ItemID Extension Analysis**

---

## **1. OVERVIEW**
The **LinkTargetIDList** structure in MS-SHLLINK files contains a sequence of **ItemID** structures that collectively define a shell namespace path. Each ItemID can be followed by optional extension blocks that provide additional metadata. This document details both the base ItemID structure and the various extension types.

---

## **2. BASE ITEMID STRUCTURE**

### **2.1 Basic Format**
```
ITEMID (Base Structure)
├── ItemIDSize (2 bytes) - Size of this ItemID (including this field)
├── Data (variable)     - Shell namespace data
└── [Optional Extension Block]
```

**Important Notes:**
- The ItemIDList is terminated by a 2-byte NULL (0x0000)
- Each ItemID is parsed sequentially until the terminator
- Extension blocks follow immediately after the ItemID data

### **2.2 Common ItemID Data Patterns**
1. **Root Items**: Often start with known GUIDs (e.g., "My Computer", "Network")
2. **File System Items**: Contain filesystem paths
3. **Virtual/Special Folders**: Use shell namespace GUIDs


Based on the provided PowerShell code analysis, here's a comprehensive breakdown of Windows Shell ItemID structures according to the actual implementation:

## Windows Shell ItemID Structure Breakdown

## **Common ItemID Header**
```
+0x00: USHORT   ItemIDSize      // Total size including this field (little-endian)
+0x02: BYTE[ItemIDSize-2] Data  // Item-specific data
```

## **Type 0x0F/0x09/0x16/0x52 - Compressed File/Folder Entry**
```
+0x00: BYTE      ItemIDType = 0x0F/0x09/0x16/0x52
+0x01: BYTE[17]  Unknown Header (17 bytes)
+0x12: WORD      Type/Attributes (mixed field)
+0x14: DWORD     Attributes (overlaps with Type field)
+0x16: WCHAR[16] Timestamp (32 bytes, Unicode string)
+0x36: WORD      ZipIndex (compression index)
+0x38: WORD      ParentLength (in characters)
+0x3A: WORD      NameLength (in characters)
+0x3C: BYTE[6]   Unknown (6 bytes)
+0x42: WCHAR[]   Name (Unicode, NameLength * 2 bytes)
+? : BYTE[2]     Null terminator/padding (2 bytes)
+? : WCHAR[]     Parent Path (Unicode, ParentLength * 2 bytes)
```

### **Detailed Structure:**
- **ItemIDType**: Single byte identifying the compressed item type
- **Unknown Header**: 17 bytes starting at offset 0x01 (contains flag 0x10 at offset 0x08/0x09)
- **Type/Attributes**: WORD at offset 0x12 (interpreted as file type in code)
- **Attributes**: DWORD at offset 0x14 (file attributes, overlaps with Type field)
- **Timestamp**: 32-byte Unicode string (16 characters) at offset 0x16
- **ZipIndex**: WORD indicating compression index at offset 0x36
- **ParentLength**: WORD at offset 0x38 (number of Unicode characters in parent path)
- **NameLength**: WORD at offset 0x3A (number of Unicode characters in name)
- **Unknown**: 6 bytes at offset 0x3C
- **Name**: Unicode string starting at offset 0x42 (NameLength * 2 bytes)
- **Null Padding**: 2 bytes after Name
- **Parent**: Optional Unicode string (ParentLength * 2 bytes) starting after padding

### **Field Notes:**
1. **Timestamp Format**: The 32-byte Unicode string appears to store timestamp information, though the specific format isn't clear ..
2. **ZipIndex**: An index into a compression/cabinet file
3. **Parent Path**: Optional field; only present if ParentLength > 0
4. **Alignment**: Structure appears to be 2-byte aligned (Unicode strings, WORD fields)


### **Signature Subtypes for Type 0x00:**
1. **'47465349' (GFSI)** - GUID Folder Shell Item
   ```
   +0x06: GUID    FolderCLSID
   +0x16: OPTIONAL Extension Block
   ```

2. **'1A00EEBB'** - Embedded ItemID with Attributes
   ```
   +0x08: DWORD    Attributes
   +0x0C: GUID     FolderCLSID
   +0x1C: OPTIONAL Extension Block
   ```

3. **'4175674D' (AugM)** - Embedded ItemID List
   ```
   +0x0E: EMBEDDED ItemID List
   ```

4. **'FFFFFFFF'** - Path/Description Item
   ```
   +0x06: WORD     PathSize
   +0x08: CHAR[]   Path (ANSI)
   +? : CHAR[]     Description (ANSI)
   ```

5. **'00DBBABE'** - Name Item
   ```
   +0x0A: WCHAR[]  Name (Unicode)
   ```

6. **Property Store Variants:**
   - **'338B0123'** - PropertyStore Type 1
   - **'81191410'** - PropertyStore Type 2
   - **'1F00A104'** - PropertyStore Type 3 (Autolist)
   - **'00EEEBBE','BBAF933B','26017719','02087619','14038719','99671245'** - PropertyStore Type 4
   - **'14001F58'** - PropertyStore Type 5 + Embedded IDlist
   - **'41505053','45740304'** - PropertyStore Type 6 (APPS)
   - **'70190801'** - PropertyStore Type 7 (Control Panel)
   - **'EEBBFE23'** - PropertyStore with 1SPS

7. **'00000000'** Variants:
   - With **'F1F1F1F1'** at offset 0x1A - Registry Stream PropertyStore
   - With attribute 0x10 at offset 0x12 - Directory Entry

## **Type 0x01 - Control Panel Category**
```
+0x00: BYTE      ItemIDType = 0x01
+0x02: DWORD     Signature (optional)
+0x06: BYTE      CategoryID
```

## **Type 0x1F - ShellDesktop/GUID Item**
```
+0x00: BYTE      ItemIDType = 0x1F
+0x01: BYTE      ClassType (SortOrderIndex)
+0x02: GUID      CLSID
+0x12: OPTIONAL Extension Block
```

### **ClassType Values for Type 0x1F:**
- **0x00** - Regular GUID Item
- **0x41,0x42,0x44,0x46,0x47,0x48,0x49,0x50,0x80** - Various Shell Items with Extensions

## **Types 0x23, 0x2E, 0x2F - Volume/MyComputer Items**

### **Type 0x23/0x2F - Drive Letter Item**
```
+0x00: BYTE      ItemIDType = 0x23/0x2F
+0x01: CHAR[4]   DriveLetter (e.g., "C:\")
+0x05: GUID      CLSID0 (optional)
+0x15: GUID      CLSID1 (optional)
```

### **Type 0x2E - MyComputer Item**
```
+0x00: BYTE      ItemIDType = 0x2E
+0x01: BYTE      Subtype
+0x02: GUID      CLSID (if Subtype = 0x80)
+0x12: OPTIONAL Extension Block
```

## **Types 0x31/0x32 - File/Folder Entry (Legacy)**
```
+0x00: BYTE      ItemIDType = 0x31 (Folder) / 0x32 (File)
+0x02: DWORD     FileSize (0x32 only)
+0x06: FILETIME  ModifiedTime (DOS format)
+0x0A: WORD      FileAttributes
+0x0C: CHAR[]    Name (ANSI, null-terminated)
+? : OPTIONAL Extension Block
```

## **Types 0x35/0x36 - File/Folder Entry (Unicode/ANSI)**
```
+0x00: BYTE      ItemIDType = 0x35 (Folder) / 0x36 (File)
+0x02: DWORD     FileSize (0x36 only)
+0x06: FILETIME  ModifiedTime (DOS format)
+0x0A: WORD      FileAttributes
+0x0C: CHAR[]/WCHAR[] Name (mixed encoding)
+? : OPTIONAL Extension Block
```

## **Type 0x3A - File Entry**
```
+0x00: BYTE      ItemIDType = 0x3A
+0x02: DWORD     FileSize
+0x06: FILETIME  ModifiedTime (DOS format)
+0x0A: WORD      FileAttributes
+0x0C: CHAR[]    Name (ANSI, null-terminated)
+? : OPTIONAL Extension Block
```

## **Type 0x46 - Network Item (Two Strings)**
```
+0x00: BYTE      ItemIDType = 0x46
+0x02: BYTE      Flags
+0x03: CHAR[]    Name (ANSI)
+? : CHAR[]      Description (ANSI)
+? : OPTIONAL WCHAR[] Unicode versions
```

## **Type 0x47 - Network Item (One String)**
```
+0x00: BYTE      ItemIDType = 0x47
+0x02: BYTE      Flags
+0x03: CHAR[]    Name (ANSI)
+? : OPTIONAL WCHAR[] Unicode version
```

## **Type 0x61 - URI Shell Item**
```
+0x00: BYTE      ItemIDType = 0x61
+0x01: BYTE      Flags
+...:           Variable structure based on Flags
```

### **Flags for Type 0x61:**
- **0x80** - Unicode URI
- **0x03** - FTP Connection
  ```
  +0x02: QWORD    Timestamp (FILETIME)
  +0x0A: WORD     Port
  +0x0C: WORD     URILength
  +0x0E: CHAR[]   URI
  +...: DWORD     UserLength, CHAR[] Username
  +...: DWORD     PassLength, CHAR[] Password
  ```

## **Type 0x71 - Property Store GUID**
```
+0x00: BYTE      ItemIDType = 0x71
+0x0C: GUID      CLSID
+0x1C: OPTIONAL Extension Block
```

## **Types 0x73/0x74/0x77 - Delegate Folder**
```
+0x00: BYTE      ItemIDType = 0x73/0x74/0x77
+0x04: DWORD     Signature = '43465346' (CFSF)
+0x08: GUID      DelegateCLSID
+0x18: DWORD     FileSize (0x77 only)
+0x1C: FILETIME  ModifiedTime (DOS format)
+0x20: WORD      FileAttributes
+0x22: CHAR[]    Name (ANSI, null-terminated)
+...: GUID       GUID1
+...: GUID       GUID2
+...: OPTIONAL Extension Block
```

## **Type 0xB1 - File/Folder Entry (Alternate)**
```
+0x00: BYTE      ItemIDType = 0xB1
+0x06: FILETIME  ModifiedTime (DOS format)
+0x0A: WORD      FileAttributes
+0x0C: CHAR[]    Name (ANSI, null-terminated)
+? : OPTIONAL Extension Block or 8.3 Name
```

## **Type 0xC3 - Network Item (Three Strings)**
```
+0x00: BYTE      ItemIDType = 0xC3
+0x02: BYTE      Flags
+0x03: CHAR[]    Path (ANSI)
+? : CHAR[]      Name (ANSI)
+? : CHAR[]      Description (ANSI)
+? : OPTIONAL WCHAR[] Unicode versions
+? : OPTIONAL Extension Block
```

## **Type 0x0F/0x09/0x16/0x52 - Compressed w32 Entry**
```
+0x00: BYTE      ItemIDType
+0x08: BYTE      CompressionFlag = 0x10
+...:           Compressed data structure
```

## **Types 0x00/0x10/0x0E/0x08 - Folder with Names**
```
+0x00: BYTE      ItemIDType
+0x08: BYTE      NameFlag = 0x90
+0x09: CHAR[]    SubfolderName (ANSI)
+? : WCHAR[]     SubfolderName (Unicode)
```

## **Network Place Types (0x47/0x46/0x41/0x42)**
```
+0x00: BYTE      ItemIDType
+0x02: BYTE      NetworkType (0x02, 0x82, 0xC2)
+0x03: CHAR[]    Path (ANSI)
+? : CHAR[]      NetworkTypeString (ANSI)
+? : CHAR[]      Device (ANSI, optional)
```

## **Extension Block Structure**
```
+0x00: WORD      ExtensionSize (including this field)
+0x02: WORD      ExtensionVersion (usually 0xBEEF)
+0x04: DWORD     ExtensionSignature
+0x08: BYTE[]    ExtensionData
```

## **Serialized Property Store (1SPS) Structure**
```
+0x00: DWORD     TotalSize
+0x04: CHAR[4]   Signature = "1SPS"
+0x08: DWORD     Version (usually 0x53505331)
+0x0C: DWORD     FormatIDCount
+0x10: FORMATID_ENTRY[] FormatIDs
```

### **FormatID Entry:**
```
+0x00: GUID      FormatID
+0x10: DWORD     PropertyCount
+0x14: PROPERTY_ENTRY[] Properties
```

### **Property Entry:**
```
+0x00: DWORD     ValueSize
+0x04: WORD      NameSize
+0x06: WCHAR[]   PropertyName (optional)
+0x? : DWORD     PropertyID
+0x? : WORD      PropertyType
+0x? : BYTE[]    PropertyValue
```



## **Notes**
1. All numeric fields are **little-endian**
2. String encodings vary: ANSI (CP1252), UTF-8, or Unicode (UTF-16LE)
3. Many structures have optional trailing data or extension blocks
4. The actual implementation may have additional types and variants not shown in this code
5. Some ItemID types support multiple structure versions based on size or flags
6. Property Store structures can be deeply nested with complex type systems

This breakdown represents the ItemID structures as implemented in the Windows Shell based on the provided parsing code. The actual Windows implementation may contain additional types and variations.






---

## **3. ITEMID EXTENSION FRAMEWORK**

### **3.1 Extension Header Structure**
All extensions share a common header:
```
EXTENSION HEADER (8 bytes)
├── extLength (2 bytes)  - Total extension size (including header)
├── extVersion (2 bytes) - Extension version
└── itemIdExtType (4 bytes) - Extension type (little-endian, but parsed as reversed hex)
```

### **3.2 Extension Type Overview**
| Type (Hex) | Common Name | Description |
|------------|-------------|-------------|
| BEEF0000 | Removed Extension | Legacy/deleted extension |
| BEEF0001 | Selection Data | Contains user selection strings |
| BEEF0003 | Previous Versions | GUID-based version tracking |
| BEEF0004 | File/Folder Info | Filesystem metadata (timestamps, MFT, names) |
| BEEF0005 | Embedded IDList | Nested ItemID list |
| BEEF0006 | User Name | User information |
| BEEF000A | Entry Number | Index/position information |
| BEEF000B | Link/AUMID | Application User Model ID and path data |
| BEEF0010 | Property Store v1 | Serialized property storage |
| BEEF0013 | Attributes | File attributes |
| BEEF0014 | URI Property | URI-related metadata |
| BEEF0019 | CLSID/GUID | Folder/object identifiers |
| BEEF001A | Document Type | Application/document association |
| BEEF001B | Application Name | Associated application |
| BEEF001D | AppUserModelID | Modern application ID |
| BEEF001E | Pin Status | Taskbar/jump list pinning info |
| BEEF0024 | Property Store v2 | Enhanced property storage |
| BEEF0025 | Timestamps + Attributes | File times with attributes |
| BEEF0026 | Timestamps + Attributes + 1SPS | Combined time/attr/property |
| BEEF0027 | Property Store v3 | Latest property format |
| BEEF0029 | File Attributes | File system attributes |
| BEEF002B | LastWriteTime | Last modification timestamp |
| BEEF002C | LastAccessedTime | Last access timestamp |
| BEEF000E | Embedded IDList Alt | Alternate embedded ID format |

---

## **4. DETAILED EXTENSION STRUCTURES**

### **4.1 BEEF0004 - File/Folder Extension**
## **Purpose**
Stores comprehensive filesystem metadata including timestamps, MFT information, reparse point data, and 64-bit file size for large files (>4GB).

## **Structure Overview**
```
BEEF0004 EXTENSION (Variable Length)
├── EXTENSION HEADER (8 bytes)
│   ├── 00-01: extLength (2 bytes) - Total size including header
│   ├── 02-03: extVersion (2 bytes) - Version code (3, 7, 8, or 9)
│   └── 04-07: itemIdExtType (4 bytes) = "BEEF0004"
├── TIMESTAMPS (8 bytes)
│   ├── 08-11: DOS Creation Time (4 bytes) - Packed DOS datetime
│   └── 12-15: DOS Access Time (4 bytes) - Packed DOS datetime
├── OS IDENTIFIER (2 bytes)
│   └── 16-17: OS Type Code (2 bytes) - Windows version identifier
├── VERSION-SPECIFIC DATA (Variable)
│   └── [See version tables below]
└── FILENAME STRINGS (Variable)
    ├── Unicode Name (UTF-16LE, null-terminated)
    └── Localized Name (UTF-16LE/UTF-8, null-terminated, optional)
```

**OS Type Codes**:
```
20 = Windows 2000
22 = Windows XP
38 = Windows Vista
42 = Windows 7
46 = Windows 8/8.1/10/11
```
## **Version-Specific Structures**

### **Version 9 (Windows 8/10/11)**
```
OFFSET | FIELD                     | SIZE | DESCRIPTION
-------|---------------------------|------|------------
18-25  | MFT Record Number         | 8    | File's MFT record number (64-bit)
26-27  | MFT Sequence Number       | 2    | MFT entry sequence number
28-31  | File Size High Bits       | 4    | High 32 bits of 64-bit file size
32-35  | Reparse Point Tag         | 4    | NTFS reparse point tag (if applicable)
36-41  | Unknown/Reserved 1        | 6    | Typically 0x000000000000
42-45  | Unknown/Reserved 2        | 4    | Typically 0x00000000
46-XX  | Unicode Name String       | Var  | UTF-16LE filename (null-terminated)
[XX]-  | Localized Name String     | Var  | UTF-16LE localized name (null-terminated, optional)
```

### **Version 8 (Windows 7)**
```
OFFSET | FIELD                     | SIZE | DESCRIPTION
-------|---------------------------|------|------------
18-25  | MFT Record Number         | 8    | File's MFT record number (64-bit)*
26-27  | MFT Sequence Number       | 2    | MFT entry sequence number*
28-31  | File Size High Bits       | 4    | High 32 bits of 64-bit file size*
32-35  | Reparse Point Tag         | 4    | NTFS reparse point tag (if applicable)*
36-41  | Unknown/Reserved          | 6    | Typically 0x000000000000*
42-XX  | Unicode Name String       | Var  | UTF-16LE filename (null-terminated)
[XX]-  | Localized Name String     | Var  | UTF-16LE localized name (null-terminated, optional)

*Note: These fields are only present if byte at offset 20 (ByteArray[extStart + 20]) ≠ 0
```

### **Version 7 (Windows Vista)**
```
OFFSET | FIELD                     | SIZE | DESCRIPTION
-------|---------------------------|------|------------
18-25  | MFT Record Number         | 8    | File's MFT record number (64-bit)
26-27  | MFT Sequence Number       | 2    | MFT entry sequence number
28-31  | File Size High Bits       | 4    | High 32 bits of 64-bit file size
32-35  | Reparse Point Tag         | 4    | NTFS reparse point tag (if applicable)
36-37  | Unknown/Reserved          | 2    | Typically 0x0000
38-XX  | Unicode Name String       | Var  | UTF-16LE filename (null-terminated)
[XX]-  | Localized Name String     | Var  | UTF-16LE localized name (null-terminated, optional)
```

### **Version 3 (Windows 2000)**
```
OFFSET | FIELD                     | SIZE | DESCRIPTION
-------|---------------------------|------|------------
18-XX  | Unicode Name String       | Var  | UTF-16LE filename (null-terminated)
[XX]-  | Localized Name String     | Var  | UTF-8 localized name (null-terminated, optional)
```

## **Reparse Point Tag Details**

### **Presence Conditions**
The Reparse Point Tag is present when:
1. **Extension version is 7, 8, or 9**
2. **File attributes in the base ItemID indicate a reparse point** (FILE_ATTRIBUTE_REPARSE_POINT flag set)
3. **For Version 8 only**: When `ByteArray[extStart + 20] ≠ 0` (MFT data present)

### **Offset and Format**
- **Offset from extension start**: 32 bytes (0x20)
- **Size**: 4 bytes (32-bit)
- **Endianness**: Little-endian, but displayed in reversed hex order
- **Parsing in code**: 
  ```powershell
  $Reparse_Tag = "$([System.BitConverter]::ToString($ByteArray[($idx + 27) .. ($idx + 24)]) -replace '-', '')"
  ```
## **64-Bit File Size Reconstruction**

### **Two-Part Storage**
Large files (>4GB) store their size in two parts:

1. **Low 32 bits**: Stored in the base ItemID at offset 0x02-0x05 (standard filesize field)
   ```csharp
   // From ShellLinkHeader
   DWORD FileSize;  // Low 32 bits of file size
   ```

2. **High 32 bits**: Stored in BEEF0004 extension at offset 28-31 (0x1C-0x1F)
   ```powershell
   // In extension parsing code
   $unknown_1 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 20) .. ($idx + 23)]) -replace '-', '')"
   $fsraw = $ByteArray[($idx + 20) .. ($idx + 23)]  // 4-byte array
   ```
### **Reconstruction Algorithm**
```powershell
# PowerShell implementation example
$lowSize = [System.BitConverter]::ToUInt32($ByteArray[2..5], 0)  # From base ItemID
$highSizeBytes = $ByteArray[($idx + 20) .. ($idx + 23)]          # From BEEF0004
$highSize = [System.BitConverter]::ToUInt32($highSizeBytes, 0)
$fullSize = ($highSize -shl 32) -bor $lowSize
```

### **File Size Examples**
```
Example 1: 45.7GB File
  Low 32 bits (from ItemID):    0x9E8DB700 = 2,661,376,000
  High 32 bits (from BEEF0004): 0x0000000B = 11
  Full size: (11 << 32) | 2,661,376,000 = 47,244,357,376 bytes ≈ 45.7GB

Example 2: 1.5GB File (<4GB)
  Low 32 bits: 0x60000000 = 1,610,612,736
  High 32 bits: 0x00000000
  Full size: 1,610,612,736 bytes = 1.5GB
```


### **4.2 BEEF000B - Link/AUMID Extension**
**Purpose**: Application launching metadata for modern Windows apps
```
STRUCTURE:
00-01: extLength
02-03: extVersion
04-07: itemIdExtType = BEEF000B
08-15: Unknown
16-xx: Target Path (Unicode, null-terminated)
    [padding to 16-byte boundary]
    Darwin/Component ID (Unicode, null-terminated)
    AppUserModelID (Unicode, null-terminated)
    App Parameters (Unicode, null-terminated, optional)
    Target Creation Time (8 bytes, FILETIME)
    Shortcut Creation Time (8 bytes, FILETIME)
    Unknown Flags (12 bytes)
    Extra Path (Unicode, null-terminated)
```

### **4.3 BEEF0010/BEEF0024/BEEF0027 - Property Store Extensions**
**Purpose**: Store shell property system data
```
COMMON STRUCTURE:
00-01: extLength
02-03: extVersion
04-07: itemIdExtType
08-xx: Serialized Property Store (1SPS format)
```

**Property Store Format**:
- Starts with signature "1SPS" (0x31535053)
- Contains typed property values with FormatID (GUID) and PropertyID
- Supports various data types (string, integer, date, blob, etc.)

### **4.4 BEEF0005/BEEF000E - Embedded IDList Extensions**
**Purpose**: Contain nested shell namespace paths
```
STRUCTURE:
00-01: extLength
02-03: extVersion
04-07: itemIdExtType
08-xx: Complete ItemIDList structure
    [ItemID1]
    [ItemID2]
    ...
    [Terminator 0x0000]
```

### **4.5 BEEF0014 - URI Property Extension**
**Purpose**: Store URI-related metadata for internet shortcuts
```
STRUCTURE:
00-01: extLength
02-03: extVersion
04-07: itemIdExtType = BEEF0014
08-23: CLSID (16 bytes)
24-27: Data Length (4 bytes)
28-xx: URI Property Entries
    [Entry Count (4 bytes)]
    [Entry1: Type (4), Length (4), Data]
    [Entry2: ...]
```

**Common URI Entry Types**:
- 16 = URI Flags (DWORD)
- 17 = URI String (Unicode)
- 18 = Display Name (Unicode)
- 19 = Icon File (Unicode)

---

## **5. PARSING ALGORITHM**

### **5.1 Main Parsing Flow**
```
1. Read ItemIDSize (2 bytes)
2. If ItemIDSize == 0: End of list
3. Read ItemIDData (ItemIDSize - 2 bytes)
4. Check for extension:
   - Read extLength (next 2 bytes, but don't advance)
   - If extLength > 0: Parse extension
   - Else: Move to next ItemID
5. Repeat until termination
```

### **5.2 Extension Parsing Logic**
```
FUNCTION ParseExtension(ByteArray, StartIndex):
    extLength = ReadUInt16(StartIndex)
    extVersion = ReadUInt16(StartIndex + 2)
    extType = ReverseBytesToHex(StartIndex + 4, 4)
    
    SWITCH extType:
        CASE "BEEF0004": ParseFileFolderExtension()
        CASE "BEEF000B": ParseAUMIDExtension()
        CASE "BEEF0010": ParsePropertyStore()
        CASE "BEEF0014": ParseURIProperty()
        ... etc ...
    
    RETURN StartIndex + extLength
```

### **5.3 Version-Specific Behaviors**
- **Windows Version Detection**: Based on OS Type in BEEF0004
- **Field Presence**: Later Windows versions add more metadata
- **Alignment**: Some extensions use 16-byte alignment for string data
- **Encoding**: Mix of UTF-16LE and UTF-8 strings

---

## **6. FORENSIC SIGNIFICANCE**

### **6.1 Key Evidence Sources**
1. **Timestamps**: Creation, access, modification times across multiple extensions
2. **User Context**: User names, AUMIDs, application associations
3. **Filesystem Artifacts**: MFT records, reparse points, volume info
4. **User Activity**: Pinned items, recent documents, navigation history
5. **Application Usage**: Associated programs, command-line parameters

### **6.2 Anti-Forensic Considerations**
1. **Timestamp Manipulation**: Multiple timestamp sources allow cross-validation
2. **Extension Removal**: BEEF0000 indicates deleted extensions
3. **Custom Extensions**: Unknown BEEFxxxx types may contain custom data
4. **Compression**: Some paths may use custom compression (see Get-Compressed_w32)

### **6.3 Analysis Techniques**
1. **Timeline Analysis**: Correlate timestamps from different extensions
2. **Path Reconstruction**: Combine ItemIDs and extension path data
3. **User Profiling**: Analyze AUMIDs, document types, pinned items
4. **System Context**: OS version, filesystem type, network paths

---

## **7. IMPLEMENTATION NOTES**

### **7.1 Byte Order Considerations**
- All multi-byte values are little-endian
- itemIdExtType is stored as little-endian but parsed as reversed hex string
- GUIDs use Microsoft byte order (mixed endian)

### **7.2 String Encoding**
- Primary: UTF-16LE (Windows Unicode)
- Secondary: UTF-8 (for localized names in older extensions)
- Null termination: Usually double null (UTF-16) or single null (UTF-8)

### **7.3 Alignment Rules**
- Some extensions align to 16-byte boundaries after strings
- Property stores have internal alignment requirements
- MFT record numbers are 8-byte aligned

---

## **8. APPENDIX: KNOWN VALUES**

### **8.1 Common CLSIDs in Extensions**
```
0C39A5CF-1A7A-40C8-BA74-8900E6DF5FCD = NoPreviousVersions
```
(others from [CLSID database/CSV](https://github.com/kacos2000/Jumplist-Browser/blob/master/GUIDs.csv) )


### **8.2 Reparse Point Tags**
```
	"00000000" = "IO_REPARSE_TAG_RESERVED_ZERO"
	"00000001" = "IO_REPARSE_TAG_RESERVED_ONE"
	"00000002" = "IO_REPARSE_TAG_RESERVED_TWO"
	"80000005" = "IO_REPARSE_TAG_DRIVE_EXTENDER"
	"80000006" = "IO_REPARSE_TAG_HSM2"
	"80000007" = "IO_REPARSE_TAG_SIS"
	"80000008" = "IO_REPARSE_TAG_WIM"
	"80000009" = "IO_REPARSE_TAG_CSV"
	"8000000A" = "IO_REPARSE_TAG_DFS"
	"8000000B" = "IO_REPARSE_TAG_FILTER_MANAGER"
	"80000012" = "IO_REPARSE_TAG_DFSR"
	"80000013" = "IO_REPARSE_TAG_DEDUP"
	"80000014" = "IO_REPARSE_TAG_NFS"
	"80000015" = "IO_REPARSE_TAG_FILE_PLACEHOLDER"
	"80000016" = "IO_REPARSE_TAG_DFM"
	"80000017" = "IO_REPARSE_TAG_WOF"
	"80000018" = "IO_REPARSE_TAG_WCI"
	"8000001B" = "IO_REPARSE_TAG_APPEXECLINK"
	"8000001E" = "IO_REPARSE_TAG_STORAGE_SYNC"
	"80000020" = "IO_REPARSE_TAG_UNHANDLED"
	"80000021" = "IO_REPARSE_TAG_ONEDRIVE"
	"80000023" = "IO_REPARSE_TAG_AF_UNIX" # (Windows Subsystem for Linux)
	"80000024" = "IO_REPARSE_TAG_LX_FIFO"
	"80000025" = "IO_REPARSE_TAG_LX_CHR"
	"80000026" = "IO_REPARSE_TAG_LX_BLK"
	"9000001C" = "IO_REPARSE_TAG_PROJFS"
	"90001018" = "IO_REPARSE_TAG_WCI_1" # Used by the Windows Container Isolation filter
	"9000101A" = "IO_REPARSE_TAG_CLOUD_1"
	"9000201A" = "IO_REPARSE_TAG_CLOUD_2"
	"9000301A" = "IO_REPARSE_TAG_CLOUD_3"
	"9000401A" = "IO_REPARSE_TAG_CLOUD_4"
	"9000501A" = "IO_REPARSE_TAG_CLOUD_5"
	"9000601A" = "IO_REPARSE_TAG_CLOUD_6"
	"9000701A" = "IO_REPARSE_TAG_CLOUD_7"
	"9000801A" = "IO_REPARSE_TAG_CLOUD_8"
	"9000901A" = "IO_REPARSE_TAG_CLOUD_9"
	"9000A01A" = "IO_REPARSE_TAG_CLOUD_A"
	"9000B01A" = "IO_REPARSE_TAG_CLOUD_B"
	"9000C01A" = "IO_REPARSE_TAG_CLOUD_C"
	"9000D01A" = "IO_REPARSE_TAG_CLOUD_D"
	"9000E01A" = "IO_REPARSE_TAG_CLOUD_E"
	"9000F01A" = "IO_REPARSE_TAG_CLOUD_F"
	"0000F000" = "IO_REPARSE_TAG_CLOUD_MASK" # https://www.codemachine.com/downloads/win10.1803/winnt.h
	"A0000003" = "IO_REPARSE_TAG_MOUNT_POINT"
	"A000000C" = "IO_REPARSE_TAG_SYMLINK"
	"A0000010" = "IO_REPARSE_TAG_IIS_CACHE"
	"A0000019" = "IO_REPARSE_TAG_GLOBAL_REPARSE"
	"A000001D" = "IO_REPARSE_TAG_LX_SYMLINK"
	"A000001F" = "IO_REPARSE_TAG_WCI_TOMBSTONE"
	"A0000022" = "IO_REPARSE_TAG_PROJFS_TOMBSTONE"
	"A0000027" = "IO_REPARSE_TAG_WCI_LINK"
	"A0001027" = "IO_REPARSE_TAG_WCI_LINK_1"
	"C0000004" = "IO_REPARSE_TAG_HSM"
	"C0000014" = "IO_REPARSE_TAG_APPXSTRM"
```

### **8.3 OS Type to Version Mapping**
```
'46' = 'Windows 8.1/10/11'
'42' = 'Windows 2000/7/8'
'38' = 'Windows Vista'
'20' = 'Windows XP/2003'
```

## **8.4 File Attributes Flags (WORD)**
```
	'1'		    = 'ReadOnly'
	'2'		    = 'Hidden'
	'4'		    = 'System'
	'16'	    = 'Directory'
	'32'	    = 'Archive'
	'64'	    = 'Device'
	'128'	    = 'Normal'
	'256'	    = 'Temporary'
	'512'	    = 'Sparse_File' # LocallyIncomplete
	'1024'	    = 'Reparse_Point'
	'2048'	    = 'Compressed'
	'4096'	    = 'Offline'
	'8192'	    = 'Not_Content_Indexed'
	'16384'	    = 'Encrypted'
	'32768'	    = 'Integrity_Stream'
	'65536'	    = 'Virtual'
	'131072'    = 'No_Scrub_Data'
	'524288'    = 'Pinned'
	'262144'    = 'Recall_On_Open'
	'1048576'   = 'Unpinned'
	'4194304'   = 'Recall_On_DataAccess'
	'536870912' = 'View_Index' # Strictly_Sequential
```
*[FileAttributes Enum(]https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes?view=net-7.0)*  
*[File Attribute Constants](https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants)*  
*C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\winnt.h*  

## **8.5 Property Types (VT_*)**
```
0x0001: VT_NULL
0x0002: VT_I2 (SHORT)
0x0003: VT_I4 (LONG)
0x0004: VT_R4 (FLOAT)
0x0005: VT_R8 (DOUBLE)
0x0006: VT_CY (CURRENCY)
0x0007: VT_DATE (DATE)
0x0008: VT_BSTR (STRING)
0x0009: VT_DISPATCH
0x000A: VT_ERROR
0x000B: VT_BOOL
0x000C: VT_VARIANT
0x000D: VT_UNKNOWN
0x000E: VT_DECIMAL
0x0010: VT_I1 (CHAR)
0x0011: VT_UI1 (BYTE)
0x0012: VT_UI2 (USHORT)
0x0013: VT_UI4 (ULONG)
0x0014: VT_I8 (LONGLONG)
0x0015: VT_UI8 (ULONGLONG)
0x0016: VT_INT (INT)
0x0017: VT_UINT (UINT)
0x0018: VT_VOID
0x0019: VT_HRESULT
0x001A: VT_PTR
0x001B: VT_SAFEARRAY
0x001C: VT_CARRAY
0x001D: VT_USERDEFINED
0x001E: VT_LPSTR
0x001F: VT_LPWSTR
0x0040: VT_FILETIME
0x0041: VT_BLOB
0x0042: VT_STREAM
0x0043: VT_STORAGE
0x0044: VT_STREAMED_OBJECT
0x0045: VT_STORED_OBJECT
0x0046: VT_BLOB_OBJECT
0x0047: VT_CF (CLIPBOARD)
0x0048: VT_CLSID
0x0049: VT_VERSIONED_STREAM
0x1000: VT_VECTOR
0x2000: VT_ARRAY
```

## **8.6 SFGAO flags**
```
	'0x00000001' = 'Can be Copied'
	'0x00000002' = 'Can be Moved'
	'0x00000004' = 'Can be Linked'
	'0x00000008' = 'Supports BindToObject' # supports BindToObject(IID_IStorage)
	'0x00000010' = 'Can be Renamed' # Objects can be renamed
	'0x00000020' = 'Can be Deleted'
	'0x00000040' = 'Has Property Sheet'
	'0x00000100' = 'Is DropTarget' # Objects are drop target
	'0x00000177' = 'Capability Mask' # This flag is a mask for the capability attributes: SFGAO_CANCOPY, SFGAO_CANMOVE, SFGAO_CANLINK, SFGAO_CANRENAME, SFGAO_CANDELETE, SFGAO_HASPROPSHEET, and SFGAO_DROPTARGET. Callers normally do not use this value.
	'0x00000800' = 'Placeholder (Recall on Open/Access)' # File or folder is not fully present and recalled on open or access
	'0x00001000' = 'System Object' # System object
	'0x00002000' = 'Encrypted' # Object is encrypted
	'0x00004000' = 'Is Slow' # 'Slow' object
	'0x00008000' = 'Ghosted icon'
	'0x00010000' = 'Shortcut (link)'
	'0x00020000' = 'Shared'
	'0x00040000' = 'Read-Only' # Read-only
	'0x000FC000' = 'Display Attribute Mask'
	'0x00100000' = 'Non Enumerated' # non-enumerated object (should be hidden)
	'0x00200000' = 'New Content' # Should show bold in explorer tree
	'0x00400000' = 'Stream' # Supports BindToObject(IID_IStream)
	'0x00800000' = 'Storage Ancestor' # May contain children with SFGAO_STORAGE or SFGAO_STREAM
	'0x01000000' = 'Validate' # Invalidate cached information (may be slow)
	'0x02000000' = 'Removable'
	'0x04000000' = 'Compressed'
	'0x08000000' = 'Browsable' # Supports IShellFolder, but only implements CreateViewObject() (non-folder view)
	'0x10000000' = 'File System Ancestor' # May contain children with SFGAO_FILESYSTEM
	'0x20000000' = 'Folder' # Support BindToObject(IID_IShellFolder)
	'0x40000000' = 'File System (file/folder/root)' # Is a win32 file system object (file/folder/root)
	'0x70C50008' = 'Storage Cap Mask' # For determining storage capabilities, ie for open/save semantics
	'0x80000000' = 'ContentsMask' # mask for content attributes, at present only SFGAO_HASSUBFOLDER
	'0x81044000' = 'Pkey_SFGAO Mask' # Mask used by the PKEY_SFGAOFlags property to determine attributes that are considered to cause slow calculations or lack context
```
*[Maps FormatID+PID to property descriptions](https://learn.microsoft.com/en-us/windows/win32/shell/sfgao)*
*[SFGAO](https://learn.microsoft.com/en-us/windows/win32/shell/sfgao)*
*..Include\10.0.22621.0\um\ShObjIdl_core.h*

### **8.7 PS1 FormatIDHashTable**
```
028636aa6-953d-11d2-b5d6-00c04fd918d0\4	= Network Location
```
(others from [FormatID-Descriptions](https://github.com/kacos2000/Jumplist-Browser/blob/master/FormatID-Descriptions.csv) )
*[Utils.cs](https://github.com/EricZimmerman/ExtensionBlocks/blob/e0cef99c81776641e68a3f436bfcde21f6807334/ExtensionBlocks/Utils.cs)*
*'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\propkey.h'*  
*'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um\functiondiscoverykeys.h'*  
*'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared\hidclass.h'*  
*'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared\ntddser.h'*


### **8.8 Sort Order Index**
```
	'00' = "Shell User's Folder" # ThisPCDesktopRegFolder
	'20' = 'Box'
	'29' = "ThisPCDocumentsRegFolder"
	'40' = 'System Home (MSGraphHomeFolder)'
	'42' = 'Pinned to Tree'
	'41' = "Shell User's Folder"
	'44' = 'Other Users Folder'
	'4C' = 'Public Folder'
	'48' = 'Shell Documents Folder'
	'50' = 'This PC'
	'54' = 'Users Libraries'
	'58' = 'Computers and Devices/Device Center'
	'60' = 'Recycle Bin'
	'68' = 'The Internet'
	'70' = 'Control Panel'
	'29' = 'Full Details'
	'77' = 'Linux'
	'78' = 'Recycle Bin'
	'80' = 'All Tasks'
  '1000' = 'Frequent Places Folder'
```

### **8.9 Uri Entry Types**
```
	'1'  = 'Authority'
	'2'  = 'Display URI'
	'3'  = 'Domain'
	'4'  = 'Extension'
	'5'  = 'Fragment'
	'6'  = 'Host'
	'7'  = 'Password'
	'8'  = 'Path'
	'9'  = 'Path & Query'
	'10' = 'Query'
	'11' = 'Raw URI'
	'12' = 'Scheme Name'
	'13' = 'User Info'
	'14' = 'User Name'
	'15' = 'Host Type'
	'16' = 'Port'
	'17' = 'Scheme'
	'18' = 'Zone'
```
*[Uri_PROPERTY enumeration](https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms775141(v=vs.85))*

### **8.10 Control Panel CategoryID / Description**
```
	"00" = "All Control Panel Items"
	"01" = "Appearance and Personalization"
	"02" = "Hardware and Sound"
	"03" = "Network and Internet"
	"04" = "Sound, Speech and Audio Devices"
	"05" = "System and Security"
	"06" = "Clock, Language, and Region"
	"07" = "Ease of Access"
	"08" = "Programs"
	"09" = "User Accounts"
	"10" = "Security Center"
	"11" = "Mobile PC"
```
---

## **9. REFERENCES**
1. [MS-SHLLINK Specification (Microsoft)](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/16cb4ca1-9339-4d0c-a68d-bf1d6cc0f943)
2. [Windows Shell Namespace Documentation](https://learn.microsoft.com/en-us/windows/win32/shell/namespace-intro)
3. NTFS Documentation (Microsoft)
4. [Property System Documentation](https://learn.microsoft.com/en-us/windows/win32/properties/property-system-overview)
5. [AppUserModelID Guidelines](https://learn.microsoft.com/en-us/windows/win32/shell/appids)

