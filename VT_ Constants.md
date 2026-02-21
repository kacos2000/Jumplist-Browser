# Property Types (VT_* Constants) 

## Hashtable for Serialized Property Store

```powershell
$PropertyTypeNames = [System.Collections.Hashtable]@{
    # Basic types (0x0000 - 0x001F)
    0x0000 = "VT_EMPTY"            # Empty
    0x0001 = "VT_NULL"             # Null
    0x0002 = "VT_I2"               # 2-byte signed integer
    0x0003 = "VT_I4"               # 4-byte signed integer
    0x0004 = "VT_R4"               # 4-byte floating point
    0x0005 = "VT_R8"               # 8-byte floating point
    0x0006 = "VT_CY"               # Currency (8-byte integer / 10000)
    0x0007 = "VT_DATE"             # OLE Automation date
    0x0008 = "VT_BSTR"             # COM BSTR string
    0x0009 = "VT_DISPATCH"         # IDispatch pointer
    0x000A = "VT_ERROR"            # HRESULT error code
    0x000B = "VT_BOOL"             # Boolean
    0x000C = "VT_VARIANT"          # Variant
    0x000D = "VT_UNKNOWN"          # IUnknown pointer
    0x000E = "VT_DECIMAL"          # 16-byte decimal
    0x000F = "VT_I1"               # 1-byte signed integer
    0x0010 = "VT_UI1"              # 1-byte unsigned integer  
    0x0011 = "VT_UI2"              # 2-byte unsigned integer  
    0x0012 = "VT_UI4"              # 4-byte unsigned integer  
    0x0013 = "VT_I8"               # 8-byte signed integer    
    0x0014 = "VT_UI8"              # 8-byte unsigned integer  
    0x0015 = "VT_INT"              # Signed machine integer   
    0x0016 = "VT_UINT"             # Unsigned machine integer 
    0x0017 = "VT_VOID"             # C-style void
    0x0018 = "VT_HRESULT"          # HRESULT
    0x0019 = "VT_PTR"              # Pointer type
    0x001A = "VT_SAFEARRAY"        # Safe array
    0x001B = "VT_CARRAY"           # C-style array
    0x001C = "VT_USERDEFINED"      # User-defined type
    0x001D = "VT_LPSTR"            # Null-terminated ANSI string
    0x001E = "VT_LPWSTR"           # Null-terminated Unicode string
  
    # Record and pointer types (0x0020-0x002F)
    0x0024 = "VT_RECORD"           # User-defined record type
    0x0025 = "VT_INT_PTR"          # Signed machine pointer
    0x0026 = "VT_UINT_PTR"         # Unsigned machine pointer
  
    # Extended types (0x0040-0x0049) - Property set specific
    0x0040 = "VT_FILETIME"         # 64-bit FILETIME
    0x0041 = "VT_BLOB"             # Binary large object
    0x0042 = "VT_STREAM"           # Stream object
    0x0043 = "VT_STORAGE"          # Storage object
    0x0044 = "VT_STREAMED_OBJECT"  # Streamed object
    0x0045 = "VT_STORED_OBJECT"    # Stored object
    0x0046 = "VT_BLOB_OBJECT"      # Blob object
    0x0047 = "VT_CF"               # Clipboard format
    0x0048 = "VT_CLSID"            # Class ID (GUID)
    0x0049 = "VT_VERSIONED_STREAM" # Versioned stream
  
    # Shell-specific custom types (not in standard VARENUM)
    # Note: These are not in MS-OLEPS but observed in Windows Shell
    0x004B = "VT_SHELL_I2_VERSIONED_STREAM"
    0x004E = "VT_SHELL_CY_CLSID"
    0x0054 = "VT_SHELL_I1_STREAMED_OBJECT"
  
    # Search/Windows Property System specific types (extended)
    0x0055 = "VT_UNKNOWN_0x0055"   # Observed in Windows Search
    0x0056 = "VT_UNKNOWN_0x0056"   # Observed in Windows Search
    0x0057 = "VT_UNKNOWN_0x0057"   # Observed in Windows Search
    0x0058 = "VT_UNKNOWN_0x0058"   # Observed in Windows Search
    0x0059 = "VT_UNKNOWN_0x0059"   # Observed in Windows Search
  
    # Special types
    0x0FFF = "VT_BSTR_BLOB"        # Reserved for system use
  
    # Modifier flags
    0x1000 = "VT_VECTOR"           # Simple counted array
    0x2000 = "VT_ARRAY"            # SAFEARRAY pointer
    0x4000 = "VT_BYREF"            # Reference type
    0x8000 = "VT_RESERVED"         # Reserved flag
  
    # Illegal values
    0xFFFF = "VT_ILLEGAL"
}
```

## Helper function to dynamically generate type names for unknown types

```powershell
function Get-VTTypeName {
    <#
    .SYNOPSIS
    Returns the string representation of a VT_* type code.
  
    .DESCRIPTION
    This function converts a VT_* type code (VARENUM value) to its string
    representation. It first checks the comprehensive lookup table, and if
    not found, dynamically constructs the name using bitwise decomposition.
  
    .PARAMETER TypeCode
    The VT_* type code as a 16-bit unsigned integer.
  
    .EXAMPLE
    Get-VTTypeName -TypeCode 0x001F
    Returns: "VT_LPWSTR"
  
    .EXAMPLE
    Get-VTTypeName -TypeCode 0x1011
    Returns: "VT_VECTOR | VT_UI2"
  
    .EXAMPLE
    Get-VTTypeName -TypeCode 0x004B
    Returns: "VT_SHELL_I2_VERSIONED_STREAM"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [uint16]$TypeCode
    )
  
    # First, check if we have an exact match in the lookup table
    if ($PropertyTypeNames.Contains([int]$TypeCode)) {
        return $PropertyTypeNames[[int]$TypeCode]
    }
  
    # If not found, try to decompose the type code
    $baseType = $TypeCode -band 0x0FFF  # Mask off modifiers (bits 0-11)
    $modifiers = @()
  
    # Check for VT_VECTOR modifier (bit 12)
    if ($TypeCode -band 0x1000) {
        $modifiers += "VT_VECTOR"
    }
  
    # Check for VT_ARRAY modifier (bit 13)
    if ($TypeCode -band 0x2000) {
        $modifiers += "VT_ARRAY"
    }
  
    # Check for VT_BYREF modifier (bit 14)
    if ($TypeCode -band 0x4000) {
        $modifiers += "VT_BYREF"
    }
  
    # Check for VT_RESERVED modifier (bit 15)
    if ($TypeCode -band 0x8000) {
        $modifiers += "VT_RESERVED"
    }
  
    # Get the base type name
    if ($PropertyTypeNames.ContainsKey($baseType)) {
        $baseName = $PropertyTypeNames[$baseType]
    } else {
        # Unknown base type - create a descriptive name
        $baseName = "VT_UNKNOWN_0x{0:X4}" -f $baseType
    }
  
    # If there are no modifiers, just return the base name
    if ($modifiers.Count -eq 0) {
        return $baseName
    }
  
    # Combine modifiers and base type
    $result = ($modifiers -join " | ") + " | " + $baseName
  
    return $result
}
```

# VT_* Property Type Structures and Data Formats 

## Basic Simple Types (Fixed Size)

### VT_I1 (0x000F) - Signed 8-bit Integer
- **Description**: 1-byte signed integer (C++ `char`, C# `sbyte`)
- **Structure**: Single byte, signed
- **Size**: 1 byte
- **Range**: -128 to 127
- **Example**: `0x01` (1), `0xFF` (-1)


### VT_UI1 (0x0010) - Unsigned 8-bit Integer
- **Description**: 1-byte unsigned integer (C++ `BYTE`, C# `byte`)
- **Structure**: Single byte, unsigned
- **Size**: 1 byte
- **Range**: 0 to 255
- **Example**: `0x41` (65/A), `0xFF` (255)

### VT_UI2 (0x0011) - Unsigned 16-bit Integer
- **Description**: 2-byte unsigned integer (C++ `USHORT`, C# `ushort`)
- **Structure**: 2 bytes, little-endian
- **Size**: 2 bytes
- **Range**: 0 to 65,535
- **Example**: `0x0100` (256), `0xFFFF` (65,535)

### VT_UI4 (0x0012) - Unsigned 32-bit Integer
- **Description**: 4-byte unsigned integer (C++ `ULONG`, C# `uint`)
- **Structure**: 4 bytes, little-endian
- **Size**: 4 bytes
- **Range**: 0 to 4,294,967,295
- **Example**: `0xFFFFFFFF` (4,294,967,295)

### VT_I8 (0x0013) - Signed 64-bit Integer
- **Description**: 8-byte signed integer (C++ `LONGLONG`, C# `long`)
- **Structure**: 8 bytes, little-endian
- **Size**: 8 bytes
- **Range**: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

### VT_UI8 (0x0014) - Unsigned 64-bit Integer
- **Description**: 8-byte unsigned integer (C++ `ULONGLONG`, C# `ulong`)
- **Structure**: 8 bytes, little-endian
- **Size**: 8 bytes
- **Range**: 0 to 18,446,744,073,709,551,615

### VT_INT (0x0015) - Signed Machine Integer
- **Description**: Signed pointer-sized integer
- **Structure**: 4 or 8 bytes depending on platform (32/64-bit)
- **Size**: Pointer size
- **Range**: Platform-dependent

### VT_UINT (0x0016) - Unsigned Machine Integer
- **Description**: Unsigned pointer-sized integer
- **Structure**: 4 or 8 bytes depending on platform (32/64-bit)
- **Size**: Pointer size
- **Range**: Platform-dependent

## String Types (1SPS Serialized Format) 

### VT_LPSTR (0x001D) - Length-Prefixed ANSI String
- **Description**: ANSI string with 4-byte character count prefix (in 1SPS format)
- **Structure in 1SPS**: 
  - 4 bytes: character count (NOT byte count, NOT null-terminated)
  - N bytes: ANSI characters
- **Size**: 4 + character count bytes
- **Encoding**: Current system ANSI code page
- **Difference from OLE VT_LPSTR**: OLE version is null-terminated without length prefix
- **Example**: "Hello" = `0x05000000` + `0x48 65 6C 6C 6F`

### VT_LPWSTR (0x001E) - Length-Prefixed Unicode String
- **Description**: Unicode string with 4-byte character count prefix (in 1SPS format)
- **Structure in 1SPS**:
  - 4 bytes: character count (NOT byte count, NOT null-terminated)
  - N×2 bytes: UTF-16LE characters
- **Size**: 4 + (character count × 2) bytes
- **Difference from OLE VT_LPWSTR**: OLE version is null-terminated without length prefix
- **Example**: "Hello" = `0x05000000` + `0x4800 6500 6C00 6C00 6F00`

## Date/Time Types

### VT_FILETIME (0x0040) - 64-bit File Time
- **Description**: 64-bit value representing # of 100ns intervals since Jan 1, 1601 UTC
- **Structure**: 8-byte unsigned integer, little-endian
- **Epoch**: Jan 1, 1601 00:00:00 UTC
- **Resolution**: 100 nanoseconds
- **Common in Property Stores**: Used for file dates (created, modified, accessed)

## Binary Data Types

### VT_BLOB (0x0041) - Binary Large Object
- **Description**: Length-prefixed raw bytes
- **Structure**:
  - 4 bytes: byte length
  - N bytes: raw data
- **Size**: 4 + length bytes
- **Common Use**: Storing thumbnails, custom binary data

### VT_CLSID (0x0048) - Class ID (GUID)
- **Description**: 128-bit Globally Unique Identifier
- **Structure**: 16 bytes in mixed-endian Windows GUID format
- **Format in memory**: Mixed-endian (Data1-3 big-endian, Data4 byte array)
- **Common Use**: Property set GUIDs, format identifiers

## Search/Windows Property System Specific Types

### Types Observed in Windows Search (Extended beyond MS-OLEPS):
- **0x004B-0x0059**: Various shell/search-specific types
- **These are NOT in MS-OLEPS** but observed in Windows property stores
- **Format**: Typically specialized structures for search indexing

## Complex/Structured Types

### VT_VECTOR (Mask: 0x1000) - Simple Counted Array
- **Description**: Counted array of items (not SAFEARRAY)
- **Structure for VT_VECTOR | VT_TYPE**:
  - 4 bytes: element count
  - For each element: element data (format depends on VT_TYPE)
- **Size**: 4 + (count × element_size)
- **Example VT_VECTOR | VT_LPWSTR (0x101E)**:
  - 4 bytes: string count
  - For each string: 4-byte char count + UTF-16LE characters

### VT_ARRAY (Mask: 0x2000) - SAFEARRAY
- **Description**: Multi-dimensional array with bounds
- **Structure**: Complex SAFEARRAY header with bounds + data
- **Rare in property stores**, more common in COM

### VT_BYREF (Mask: 0x4000) - By Reference
- **Description**: Value is a pointer/reference
- **Usage**: Combined with other types (e.g., VT_BYREF | VT_I4)
- **Structure**: Pointer to actual data
- **Rare in serialized property stores**

## **NOTES:**

1. **String Types in 1SPS**: VT_LPSTR (0x001D) and VT_LPWSTR (0x001E) in Serialized Property Stores have a 4-byte character count prefix, NOT null-terminated.

2. **VT_VECTOR Format**: Always starts with 4-byte element count, then each element in sequence.

3. **VT_BLOB Format**: 4-byte byte count, then raw bytes.

4. **Endianness**: All integers are little-endian.

5. **Padding**: Values often padded to 4-byte boundaries in property stores.

6. **Common in Shell Property Stores**:
   - VT_LPWSTR (0x001E): File names, paths
   - VT_FILETIME (0x0040): Dates
   - VT_UI4 (0x0012): Sizes, flags
   - VT_BOOL (0x000B): Boolean properties
   - VT_CLSID (0x0048): GUIDs
   - VT_VECTOR | VT_LPWSTR (0x101E): Multi-valued strings (authors, keywords)

-------------
## References:
- **[MS-OLEPS 2.1.2.2.1 PropertyType Enumeration](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/2a4589eb-9a23-4a8b-adbd-3e368233c099)**
- **[MS-OLEPS 2.1.2.2.2 TypedPropertyValue Structure](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/f122b9d7-e5cf-4484-8466-83f6fd94b3cc)**
- **[MS-OLEPS 2.1.2.2.3 Property Types in Variable-Typed Vectors and Arrays](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/8e6b33cd-3fb2-4329-9c6b-cb3a6c976e0f)**
- **[MS-OLEPS 2.1.2.3 Non-Simple Property Set Storage Format](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/83b0f831-6adf-48c5-8bef-b62e7ac1cc1e)**
- **[VARENUM enumeration (wtypes.h)](https://learn.microsoft.com/en-us/windows/win32/api/wtypes/ne-wtypes-varenum)**
- **Windows Kits\10\Include\10.0.22621.0\shared\wtypes.h**
- **Windows Kits\10\Include\10.0.22621.0\shared\propvarutil.h**


