# Serialized Property Storage (1SPS) Format - Complete Documentation

*Based on PropertyStore .NET Library Analysis and Real-World Usage*

## Table of Contents

1.  [Overview](#overview)  
2.  [Format Variations](#format-variations)
3.  [Single Storage (1SPS) Format](#single-storage-1sps-format)
4.  [Container (PropertyStore) Format](#container-propertystore-format)
5.  [Property Entry Structure](#property-entry-structure)
6.  [Property Types (VT\_\* Constants)](#property-types-vt_-constants)
7.  [Common Property Sets](#common-property-sets)
8.  [Windows Jump List Variant](#windows-jump-list-variant)
    

## Overview

The **Serialized Property Storage (1SPS)** is a Windows binary format used to store typed name-value property pairs. It's commonly found in:

-   **Windows Jump Lists** (`automaticDestinations-ms`, `customDestinations-ms`)
-   **Windows Shell property stores**
-   **Office document properties** (serialized form)
-   **Windows thumbnail caches**
-   **Windows search indexes**

The format supports two types of property names: integer IDs (like PKEY values) and string names, with strongly-typed values using Windows `VT_*` (VARIANT) types.

## Format Variations

There are three main variations of this format:

1.  **Basic 1SPS (Single Storage)** - Standalone property storage
2.  **Container Format** - Collection of multiple 1SPS storages
3.  **Jump List Variant** - Extended format with additional fields

## Single Storage (1SPS) Format

**Total: Minimum 24 bytes + variable property data**

### Header (24 bytes)

| Offset | Size | Type | Field | Description | Example Value |
| --- | --- | --- | --- | --- | --- |
| 0x00 | 4   | UInt32 | `Size` | Total size of this storage in bytes (including this field) | `0x00000223` = 547 |
| 0x04 | 4   | UInt32 | `Version` | Signature: `0x53505331` (little-endian "1SPS") | `0x53505331` |
| 0x08 | 16  | GUID | `FormatId` | Property set identifier GUID | Shell Property Set GUID |

**Hex Representation:**

```text
Offset 0x00: 23 02 00 00    // Size = 0x00000223 = 547
Offset 0x04: 31 53 50 53    // Version = "1SPS" (0x53505331 in LE)
Offset 0x08: 05 D5 CD D5 9C 2E 1B 10 93 97 08 00 2B 2C F9 AE // GUID
```

### Property Entries (Variable)

Following the header are zero or more property entries. Parsing continues until reaching the specified `Size`.

## Container (PropertyStore) Format

**Used for collections of multiple property storages**

### Container Header (4 bytes)

| Offset | Size | Type | Field | Description |
| --- | --- | --- | --- | --- |
| 0x00 | 4   | UInt32 | `StoreSize` | Total size of entire container |

### Storage Entries

After the container header, one or more SerializedPropertyStorage structures:

```text
[4 bytes: Storage1 Size][Storage1 Data][4 bytes: Storage2 Size][Storage2 Data]...
```

**Important**: Each storage's size field includes:

-   The 4-byte size field itself
    
-   The SerializedPropertyStorage data
    

### Container Structure Example

```text
[StoreSize: 0x0000022B]      // Container total = 555 bytes
  [Storage1 Size: 0x00000223] // Storage 1 = 547 bytes (includes this 4-byte size)
    [547 bytes of 1SPS data...]
```

### Calculating Container Size

For a single storage of size `S`:

-   Container Size = `4 + (4 + S)` = `8 + S`
    
-   Where `S` is the Size field from the 1SPS header
    

**Example**: 1SPS storage with Size=547

-   Container Size = `4 + (4 + 547)` = `4 + 551` = **555 bytes**
    

## Property Entry Structure

Each property entry consists of two sections:

### 1\. Name Section (Variable)

**Two possible formats:**

#### A. Integer Name (Property ID)

```text
Offset 0:  4 bytes - UInt32 PropertyID (non-zero)
```

-   Used for well-known Windows properties (PKEY values)
    
-   Example: `0x0000000D` = PKEY\_DateModified
    

#### B. String Name

```text
Offset 0:  4 bytes - UInt32 NameLength (in characters, excluding null terminator)
Offset 4:  NameLength * 2 bytes - UTF-16LE string data
Offset +:  2 bytes - Null terminator (0x0000)
```

-   Used for custom property names
    
-   Example: `"AutoList"`, `"Pinned"`
    

**Name Type Determination:**

-   First 4 bytes = `0` → String name follows
    
-   First 4 bytes > `0` → Integer Property ID
    

### 2\. Type/Value Section (TypedPropertyValue)

```text
Offset 0:  2 bytes - UInt16 PropertyType (VT_* constant)
Offset 2:  2 bytes - Padding/Reserved (must be 0x0000)
Offset 4:  Variable - Value data (depends on PropertyType)
```

## [Property Types](VT_Constants.md) (VT\_\* Constants)

| Type | Value | Description | Data Format |
| --- | --- | --- | --- |
| VT\_EMPTY | 0x0000 | Empty value | No data |
| VT\_NULL | 0x0001 | NULL value | No data |
| VT\_I2 | 0x0002 | 16-bit signed integer | 2 bytes |
| VT\_I4 | 0x0003 | 32-bit signed integer | 4 bytes |
| VT\_R4 | 0x0004 | 32-bit float | 4 bytes |
| VT\_R8 | 0x0005 | 64-bit float (double) | 8 bytes |
| VT\_CY | 0x0006 | Currency (64-bit integer) | 8 bytes |
| VT\_DATE | 0x0007 | DATE (double) | 8 bytes |
| VT\_BSTR | 0x0008 | OLE string | 4-byte length + UTF-16LE data |
| VT\_ERROR | 0x000A | HRESULT error code | 4 bytes |
| VT\_BOOL | 0x000B | Boolean (16-bit) | 2 bytes (0x0000=false, 0xFFFF=true) |
| VT\_VARIANT | 0x000C | VARIANT (recursive) | Variable |
| VT\_I1 | 0x0010 | 8-bit signed integer | 1 byte |
| VT\_UI1 | 0x0011 | 8-bit unsigned integer | 1 byte |
| VT\_UI2 | 0x0012 | 16-bit unsigned integer | 2 bytes |
| VT\_UI4 | 0x0013 | 32-bit unsigned integer | 4 bytes |
| VT\_I8 | 0x0014 | 64-bit signed integer | 8 bytes |
| VT\_UI8 | 0x0015 | 64-bit unsigned integer | 8 bytes |
| VT\_LPSTR | 0x001E | ANSI string | 4-byte byte length + data + null |
| VT\_LPWSTR | 0x001F | Unicode string | 4-byte byte length + UTF-16LE + null |
| VT\_FILETIME | 0x0040 | Windows FILETIME | 8 bytes (100-ns intervals since 1601) |
| VT\_BLOB | 0x0041 | Binary blob | 4-byte byte length + data |
| VT\_STREAM | 0x0042 | Stream object | 4-byte byte length + data |
| VT\_STORAGE | 0x0043 | Storage object | 4-byte byte length + data |
| VT\_CLSID | 0x0048 | CLSID (GUID) | 16 bytes |

## Variable-Length Data Formats

### Strings (VT\_LPSTR, VT\_LPWSTR, VT\_BSTR)

```text
Offset 0:  4 bytes - UInt32 ByteLength (includes null terminator for LPSTR/LPWSTR)
Offset 4:  ByteLength bytes - String data
```

   -   **VT\_LPSTR**: ANSI, null-terminated
   -   **VT\_LPWSTR**: UTF-16LE, null-terminated (2-byte null)
   -   **VT\_BSTR**: OLE string, length-prefixed UTF-16LE (no null terminator)
    

### Binary Data (VT\_BLOB, VT\_CF, VT\_STREAM, VT\_STORAGE)

```text
Offset 0:  4 bytes - UInt32 ByteLength
Offset 4:  ByteLength bytes - Raw binary data
```

## Common Property Sets

| GUID | Description | Common Usage |
| --- | --- | --- |
| `{D5CDD505-2E9C-101B-9397-08002B2CF9AE}` | Shell Property Set | Jump Lists, Shell properties |
| `{F29F85E0-4FF9-1068-AB91-08002B27B3D9}` | Summary Information | Office documents |
| `{DEA5B7E1-7E39-11D0-9BD9-00A0C903C3EE}` | Document Summary Info | Office documents |
| `{B725F130-47EF-101A-A5F1-02608C9EEBAC}` | DocInfo Properties | Document information |

## Windows Jump List Variant

**Extended format with additional fields after the GUID:**

```text
Offset 0x00: [4 bytes] Size (total 1SPS structure)
Offset 0x04: [4 bytes] Version "1SPS" (0x53505331)
Offset 0x08: [16 bytes] FormatId GUID
Offset 0x18: [4 bytes] Extra Flags (0x5F010000 commonly)
Offset 0x1C: [4 bytes] Property Count (number of properties)
Offset 0x20: [Variable] Property entries...
```

### Jump List Header (32 bytes total)

-   **Basic 1SPS Header**: 24 bytes (Size + Version + GUID)
-   **Extra Fields**: 8 bytes (Flags + Property Count)
    

**Common Values:**

-   Extra Flags: `0x5F010000` = 0x15F = 351
    
-   Property Count: Typically 18 properties in Jump Lists
    

## Alignment and Padding

-   **4-byte alignment** throughout the format
    
-   String data padded to 4-byte boundaries if necessary
    
-   2-byte padding after PropertyType ensures value starts at 4-byte boundary
    

## File Signatures and Identification

**To identify 1SPS data:**

1.  **Check size field** (first 4 bytes) ≤ file/array length
    
2.  **Check version** (bytes 4-7) = `31 53 50 53` ("1SPS")
    
3.  **Check GUID** (bytes 8-23) = known property set GUID
    

**Magic bytes:** `31 53 50 53` at offset 4

## Real-World Examples

### Jump List File Structure

```text
[LNK file header?]          // Optional, some Jump Lists start with 1SPS
[Container Size: 4 bytes]
  [Storage1 Size: 4 bytes]
    [1SPS Header: 24 bytes]
    [Jump List extra: 8 bytes]  // Flags + Property Count
    [Properties...]
  [Storage2 Size: 4 bytes]
    [1SPS Header...]
    ...
```

### Common Jump List Properties

-   `"AutoList"` - Automatic destination entries
    
-   `"Pinned"` - Pinned entries
    
-   `"DestList"` - Destination list metadata
    
-   `"Recent"` - Recent items (in custom destinations)
    
  

## References

-   Microsoft: [PROPERTYKEY structure](https://learn.microsoft.com/en-us/windows/win32/api/wtypes/ns-wtypes-propertykey)
    
-   Windows SDK: `PropVariant.h` for VT\_\* constants
    
-   [[MS-PROPSTORE]: Property Store Binary File Format](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-propstore/39ea873f-7af5-44dd-92f9-bc1f293852cc)

- [[MS-OLEPS]: Object Linking and Embedding (OLE) Property Set Data Structures](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/bf7aeae8-c47a-4939-9f45-700158dac3bc9)    
	- [PropertyTypes](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/2a4589eb-9a23-4a8b-adbd-3e368233c099)
-   [[MS-SHLLINK]: Shell Link (.LNK) Binary File Format](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/16cb4ca1-9339-4d0c-a68d-bf1d6cc0f943?redirectedfrom=MSDN)
    

---

*Documentation based on [securifybv](https://github.com/securifybv/PropertyStore) PropertyStore .NET library v1.0 and Windows Shell property system analysis. Format variations exist in different Windows versions.*