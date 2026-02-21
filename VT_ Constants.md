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
    0x004B = "VT_SHELL_I2_VERSIONED_STREAM"
    0x004E = "VT_SHELL_CY_CLSID"
    0x0054 = "VT_SHELL_I1_STREAMED_OBJECT"
    
    # Special types
    0x0FFF = "VT_BSTR_BLOB"        # Reserved for system use
    
    # Modifier flags
    0x1000 = "VT_VECTOR"           # Simple counted array
    0x2000 = "VT_ARRAY"            # SAFEARRAY pointer
    0x4000 = "VT_BYREF"            # Reference type
    0x8000 = "VT_RESERVED"         # Reserved flag
    
    # Combined types - Basic types with VT_VECTOR modifier
    0x1002 = "VT_VECTOR | VT_I2"
    0x1003 = "VT_VECTOR | VT_I4"
    0x1004 = "VT_VECTOR | VT_R4"
    0x1005 = "VT_VECTOR | VT_R8"
    0x1006 = "VT_VECTOR | VT_CY"
    0x1007 = "VT_VECTOR | VT_DATE"
    0x1008 = "VT_VECTOR | VT_BSTR"
    0x1009 = "VT_VECTOR | VT_DISPATCH"
    0x100A = "VT_VECTOR | VT_ERROR"
    0x100B = "VT_VECTOR | VT_BOOL"
    0x100C = "VT_VECTOR | VT_VARIANT"
    0x100D = "VT_VECTOR | VT_UNKNOWN"
    0x100E = "VT_VECTOR | VT_DECIMAL"
    0x100F = "VT_VECTOR | VT_I1"
    0x1010 = "VT_VECTOR | VT_UI1"
    0x1011 = "VT_VECTOR | VT_UI2"
    0x1012 = "VT_VECTOR | VT_UI4"
    0x1013 = "VT_VECTOR | VT_I8"
    0x1014 = "VT_VECTOR | VT_UI8"
    0x1015 = "VT_VECTOR | VT_INT"
    0x1016 = "VT_VECTOR | VT_UINT"
    0x1017 = "VT_VECTOR | VT_VOID"
    0x1018 = "VT_VECTOR | VT_HRESULT"
    0x1019 = "VT_VECTOR | VT_PTR"
    0x101A = "VT_VECTOR | VT_SAFEARRAY"
    0x101B = "VT_VECTOR | VT_CARRAY"
    0x101C = "VT_VECTOR | VT_USERDEFINED"
    0x101D = "VT_VECTOR | VT_LPSTR"
    0x101E = "VT_VECTOR | VT_LPWSTR"
    
    # Combined types - Record/pointer types with VT_VECTOR modifier
    0x1024 = "VT_VECTOR | VT_RECORD"
    0x1025 = "VT_VECTOR | VT_INT_PTR"
    0x1026 = "VT_VECTOR | VT_UINT_PTR"
    
    # Combined types - Extended types with VT_VECTOR modifier
    0x1040 = "VT_VECTOR | VT_FILETIME"
    0x1041 = "VT_VECTOR | VT_BLOB"
    0x1042 = "VT_VECTOR | VT_STREAM"
    0x1043 = "VT_VECTOR | VT_STORAGE"
    0x1044 = "VT_VECTOR | VT_STREAMED_OBJECT"
    0x1045 = "VT_VECTOR | VT_STORED_OBJECT"
    0x1046 = "VT_VECTOR | VT_BLOB_OBJECT"
    0x1047 = "VT_VECTOR | VT_CF"
    0x1048 = "VT_VECTOR | VT_CLSID"
    0x1049 = "VT_VECTOR | VT_VERSIONED_STREAM"
    
    # Combined types - Shell-specific types with VT_VECTOR modifier
    0x104B = "VT_VECTOR | VT_SHELL_I2_VERSIONED_STREAM"
    0x104E = "VT_VECTOR | VT_SHELL_CY_CLSID"
    0x1054 = "VT_VECTOR | VT_SHELL_I1_STREAMED_OBJECT"
    
    # Combined types - Basic types with VT_ARRAY modifier
    0x2002 = "VT_ARRAY | VT_I2"
    0x2003 = "VT_ARRAY | VT_I4"
    0x2004 = "VT_ARRAY | VT_R4"
    0x2005 = "VT_ARRAY | VT_R8"
    0x2006 = "VT_ARRAY | VT_CY"
    0x2007 = "VT_ARRAY | VT_DATE"
    0x2008 = "VT_ARRAY | VT_BSTR"
    0x2009 = "VT_ARRAY | VT_DISPATCH"
    0x200A = "VT_ARRAY | VT_ERROR"
    0x200B = "VT_ARRAY | VT_BOOL"
    0x200C = "VT_ARRAY | VT_VARIANT"
    0x200D = "VT_ARRAY | VT_UNKNOWN"
    0x200E = "VT_ARRAY | VT_DECIMAL"
    0x200F = "VT_ARRAY | VT_I1"
    0x2010 = "VT_ARRAY | VT_UI1"
    0x2011 = "VT_ARRAY | VT_UI2"
    0x2012 = "VT_ARRAY | VT_UI4"
    0x2013 = "VT_ARRAY | VT_I8"
    0x2014 = "VT_ARRAY | VT_UI8"
    0x2015 = "VT_ARRAY | VT_INT"
    0x2016 = "VT_ARRAY | VT_UINT"
    0x2017 = "VT_ARRAY | VT_VOID"
    0x2018 = "VT_ARRAY | VT_HRESULT"
    0x2019 = "VT_ARRAY | VT_PTR"
    0x201A = "VT_ARRAY | VT_SAFEARRAY"
    0x201B = "VT_ARRAY | VT_CARRAY"
    0x201C = "VT_ARRAY | VT_USERDEFINED"
    0x201D = "VT_ARRAY | VT_LPSTR"
    0x201E = "VT_ARRAY | VT_LPWSTR"
    
    # Combined types - Record/pointer types with VT_ARRAY modifier
    0x2024 = "VT_ARRAY | VT_RECORD"
    0x2025 = "VT_ARRAY | VT_INT_PTR"
    0x2026 = "VT_ARRAY | VT_UINT_PTR"
    
    # Combined types - Extended types with VT_ARRAY modifier
    0x2040 = "VT_ARRAY | VT_FILETIME"
    0x2041 = "VT_ARRAY | VT_BLOB"
    0x2042 = "VT_ARRAY | VT_STREAM"
    0x2043 = "VT_ARRAY | VT_STORAGE"
    0x2044 = "VT_ARRAY | VT_STREAMED_OBJECT"
    0x2045 = "VT_ARRAY | VT_STORED_OBJECT"
    0x2046 = "VT_ARRAY | VT_BLOB_OBJECT"
    0x2047 = "VT_ARRAY | VT_CF"
    0x2048 = "VT_ARRAY | VT_CLSID"
    0x2049 = "VT_ARRAY | VT_VERSIONED_STREAM"
    
    # Combined types - Shell-specific types with VT_ARRAY modifier
    0x204B = "VT_ARRAY | VT_SHELL_I2_VERSIONED_STREAM"
    0x204E = "VT_ARRAY | VT_SHELL_CY_CLSID"
    0x2054 = "VT_ARRAY | VT_SHELL_I1_STREAMED_OBJECT"
    
    # Combined types - Basic types with VT_BYREF modifier
    0x4002 = "VT_BYREF | VT_I2"
    0x4003 = "VT_BYREF | VT_I4"
    0x4004 = "VT_BYREF | VT_R4"
    0x4005 = "VT_BYREF | VT_R8"
    0x4006 = "VT_BYREF | VT_CY"
    0x4007 = "VT_BYREF | VT_DATE"
    0x4008 = "VT_BYREF | VT_BSTR"
    0x4009 = "VT_BYREF | VT_DISPATCH"
    0x400A = "VT_BYREF | VT_ERROR"
    0x400B = "VT_BYREF | VT_BOOL"
    0x400C = "VT_BYREF | VT_VARIANT"
    0x400D = "VT_BYREF | VT_UNKNOWN"
    0x400E = "VT_BYREF | VT_DECIMAL"
    0x400F = "VT_BYREF | VT_I1"
    0x4010 = "VT_BYREF | VT_UI1"
    0x4011 = "VT_BYREF | VT_UI2"
    0x4012 = "VT_BYREF | VT_UI4"
    0x4013 = "VT_BYREF | VT_I8"
    0x4014 = "VT_BYREF | VT_UI8"
    0x4015 = "VT_BYREF | VT_INT"
    0x4016 = "VT_BYREF | VT_UINT"
    0x4017 = "VT_BYREF | VT_VOID"
    0x4018 = "VT_BYREF | VT_HRESULT"
    0x4019 = "VT_BYREF | VT_PTR"
    0x401A = "VT_BYREF | VT_SAFEARRAY"
    0x401B = "VT_BYREF | VT_CARRAY"
    0x401C = "VT_BYREF | VT_USERDEFINED"
    0x401D = "VT_BYREF | VT_LPSTR"
    0x401E = "VT_BYREF | VT_LPWSTR"
    
    # Combined types - Record/pointer types with VT_BYREF modifier
    0x4024 = "VT_BYREF | VT_RECORD"
    0x4025 = "VT_BYREF | VT_INT_PTR"
    0x4026 = "VT_BYREF | VT_UINT_PTR"
    
    # Combined types - Extended types with VT_BYREF modifier
    0x4040 = "VT_BYREF | VT_FILETIME"
    0x4041 = "VT_BYREF | VT_BLOB"
    0x4042 = "VT_BYREF | VT_STREAM"
    0x4043 = "VT_BYREF | VT_STORAGE"
    0x4044 = "VT_BYREF | VT_STREAMED_OBJECT"
    0x4045 = "VT_BYREF | VT_STORED_OBJECT"
    0x4046 = "VT_BYREF | VT_BLOB_OBJECT"
    0x4047 = "VT_BYREF | VT_CF"
    0x4048 = "VT_BYREF | VT_CLSID"
    0x4049 = "VT_BYREF | VT_VERSIONED_STREAM"
    
    # Combined types - Shell-specific types with VT_BYREF modifier
    0x404B = "VT_BYREF | VT_SHELL_I2_VERSIONED_STREAM"
    0x404E = "VT_BYREF | VT_SHELL_CY_CLSID"
    0x4054 = "VT_BYREF | VT_SHELL_I1_STREAMED_OBJECT"
    
    # Combined modifier types (VT_VECTOR + VT_ARRAY, etc.)
    0x3000 = "VT_VECTOR | VT_ARRAY"
    0x5000 = "VT_VECTOR | VT_BYREF"
    0x6000 = "VT_ARRAY | VT_BYREF"
    0x7000 = "VT_VECTOR | VT_ARRAY | VT_BYREF"
    
    # Illegal values
    0xFFFF = "VT_ILLEGAL"
    
    # Note: There are more possible combinations with VT_RESERVED flag (0x8000)
    # but these are rarely used in practice
    0x9000 = "VT_RESERVED | VT_VECTOR"
    0xA000 = "VT_RESERVED | VT_ARRAY"
    0xC000 = "VT_RESERVED | VT_BYREF"
    0xB000 = "VT_RESERVED | VT_VECTOR | VT_ARRAY"
    0xD000 = "VT_RESERVED | VT_VECTOR | VT_BYREF"
    0xE000 = "VT_RESERVED | VT_ARRAY | VT_BYREF"
    0xF000 = "VT_RESERVED | VT_VECTOR | VT_ARRAY | VT_BYREF"
}
```
- [*PropertyType enumeration*](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/2a4589eb-9a23-4a8b-adbd-3e368233c099)
- *..\Windows Kits\10\Include\10.0.22621.0\shared\wtypes.h*

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
    Returns: "VT_VECTOR | VT_UI1"
    
    .EXAMPLE
    Get-VTTypeName -TypeCode 0x004B
    Returns: "VT_SHELL_I2_VERSIONED_STREAM"
    
    .EXAMPLE
    Get-VTTypeName -TypeCode 0x9999
    Returns: "VT_UNKNOWN_0x1999 (VT_VECTOR | VT_BYREF | VT_UNKNOWN_0x0999)"
    #>
    param(
        [Parameter(Mandatory = $true)]
        [uint16]$TypeCode
    )
    
    # First, check if we have an exact match in the lookup table
    if ($PropertyTypeNames.ContainsKey($TypeCode)) {
        return $PropertyTypeNames[$TypeCode]
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
    
    # If the base type was unknown, also show the full hex value
    if ($baseName.StartsWith("VT_UNKNOWN_")) {
        $result = "VT_UNKNOWN_0x{0:X4} ({1})" -f $TypeCode, $result
    }
    
    return $result
}

# Function to generate all possible combinations programmatically
function Initialize-PropertyTypeNames {
    <#
    .SYNOPSIS
    Initializes the global PropertyTypeNames hashtable with all known VT_* types.
    
    .DESCRIPTION
    This function creates a comprehensive hashtable of VT_* type codes and their
    string representations, including all possible combinations of base types
    with modifiers (VT_VECTOR, VT_ARRAY, VT_BYREF, VT_RESERVED).
    #>
    
    # Clear any existing hashtable
    $script:PropertyTypeNames = @{}
    
    # Base type definitions (without modifiers)
    $baseTypes = @{
        # Basic types (0x0000 - 0x001F)
        0x0000="VT_EMPTY"; 0x0001="VT_NULL"; 0x0002="VT_I2"; 0x0003="VT_I4"
        0x0004="VT_R4"; 0x0005="VT_R8"; 0x0006="VT_CY"; 0x0007="VT_DATE"
        0x0008="VT_BSTR"; 0x0009="VT_DISPATCH"; 0x000A="VT_ERROR"; 0x000B="VT_BOOL"
        0x000C="VT_VARIANT"; 0x000D="VT_UNKNOWN"; 0x000E="VT_DECIMAL"; 0x000F="VT_I1"
        0x0010="VT_UI1"; 0x0011="VT_UI2"; 0x0012="VT_UI4"; 0x0013="VT_I8"
        0x0014="VT_UI8"; 0x0015="VT_INT"; 0x0016="VT_UINT"; 0x0017="VT_VOID"
        0x0018="VT_HRESULT"; 0x0019="VT_PTR"; 0x001A="VT_SAFEARRAY"; 0x001B="VT_CARRAY"
        0x001C="VT_USERDEFINED"; 0x001D="VT_LPSTR"; 0x001E="VT_LPWSTR"
        
        # Record and pointer types (0x0024-0x0026)
        0x0024="VT_RECORD"; 0x0025="VT_INT_PTR"; 0x0026="VT_UINT_PTR"
        
        # Extended types (0x0040-0x0049)
        0x0040="VT_FILETIME"; 0x0041="VT_BLOB"; 0x0042="VT_STREAM"; 0x0043="VT_STORAGE"
        0x0044="VT_STREAMED_OBJECT"; 0x0045="VT_STORED_OBJECT"; 0x0046="VT_BLOB_OBJECT"
        0x0047="VT_CF"; 0x0048="VT_CLSID"; 0x0049="VT_VERSIONED_STREAM"
        
        # Shell-specific types
        0x004B="VT_SHELL_I2_VERSIONED_STREAM"
        0x004E="VT_SHELL_CY_CLSID"
        0x0054="VT_SHELL_I1_STREAMED_OBJECT"
        
        # Special types
        0x0FFF="VT_BSTR_BLOB"
    }
    
    # Modifier definitions
    $modifiers = @{
        0x1000="VT_VECTOR"
        0x2000="VT_ARRAY"
        0x4000="VT_BYREF"
        0x8000="VT_RESERVED"
    }
    
    # Add base types
    foreach ($key in $baseTypes.Keys) {
        $script:PropertyTypeNames[$key] = $baseTypes[$key]
    }
    
    # Add modifiers alone
    foreach ($key in $modifiers.Keys) {
        $script:PropertyTypeNames[$key] = $modifiers[$key]
    }
    
    # Add combined modifier types
    $script:PropertyTypeNames[0x3000] = "VT_VECTOR | VT_ARRAY"
    $script:PropertyTypeNames[0x5000] = "VT_VECTOR | VT_BYREF"
    $script:PropertyTypeNames[0x6000] = "VT_ARRAY | VT_BYREF"
    $script:PropertyTypeNames[0x7000] = "VT_VECTOR | VT_ARRAY | VT_BYREF"
    $script:PropertyTypeNames[0x9000] = "VT_RESERVED | VT_VECTOR"
    $script:PropertyTypeNames[0xA000] = "VT_RESERVED | VT_ARRAY"
    $script:PropertyTypeNames[0xC000] = "VT_RESERVED | VT_BYREF"
    $script:PropertyTypeNames[0xB000] = "VT_RESERVED | VT_VECTOR | VT_ARRAY"
    $script:PropertyTypeNames[0xD000] = "VT_RESERVED | VT_VECTOR | VT_BYREF"
    $script:PropertyTypeNames[0xE000] = "VT_RESERVED | VT_ARRAY | VT_BYREF"
    $script:PropertyTypeNames[0xF000] = "VT_RESERVED | VT_VECTOR | VT_ARRAY | VT_BYREF"
    
    # Generate all combinations of base types with modifiers
    foreach ($baseKey in $baseTypes.Keys) {
        foreach ($modKey in $modifiers.Keys) {
            $combined = $baseKey -bor $modKey
            if (-not $script:PropertyTypeNames.ContainsKey($combined)) {
                $script:PropertyTypeNames[$combined] = "$($modifiers[$modKey]) | $($baseTypes[$baseKey])"
            }
        }
    }
    
    # Add VT_ILLEGAL
    $script:PropertyTypeNames[0xFFFF] = "VT_ILLEGAL"
    
    Write-Output "Initialized PropertyTypeNames with $($script:PropertyTypeNames.Count) entries"
}

# Example usage:
# Initialize-PropertyTypeNames
# Get-VTTypeName -TypeCode 0x1011  # Returns: "VT_VECTOR | VT_UI1"
# Get-VTTypeName -TypeCode 0x404B  # Returns: "VT_BYREF | VT_SHELL_I2_VERSIONED_STREAM"

```

# VT_* Property Type Structures and Data Formats

## Basic Simple Types (Fixed Size)

### VT_EMPTY (0x0000)
- **Description**: No value is associated with this property
- **Structure**: No data present
- **Size**: 0 bytes
- **Example**: Empty property

### VT_NULL (0x0001)
- **Description**: Null value (like SQL NULL)
- **Structure**: No data present, but property exists
- **Size**: 0 bytes
- **Example**: Property exists but has null value

### VT_I1 (0x0010) - Signed 8-bit Integer
- **Description**: 1-byte signed integer (C++ `char`, C# `sbyte`)
- **Structure**: Single byte, signed
- **Size**: 1 byte
- **Range**: -128 to 127
- **Example**: `0x01`, `0xFF` (-1)

### VT_UI1 (0x0011) - Unsigned 8-bit Integer
- **Description**: 1-byte unsigned integer (C++ `BYTE`, C# `byte`)
- **Structure**: Single byte, unsigned
- **Size**: 1 byte
- **Range**: 0 to 255
- **Example**: `0x41` (65/A), `0xFF` (255)

### VT_I2 (0x0002) - Signed 16-bit Integer
- **Description**: 2-byte signed integer (C++ `SHORT`, C# `short`)
- **Structure**: 2 bytes, little-endian
- **Size**: 2 bytes
- **Range**: -32,768 to 32,767
- **Example**: `0x0001` (1), `0xFFFF` (-1)
- **Format**: `[byte1][byte0]` (little-endian)

### VT_UI2 (0x0012) - Unsigned 16-bit Integer
- **Description**: 2-byte unsigned integer (C++ `USHORT`, C# `ushort`)
- **Structure**: 2 bytes, little-endian
- **Size**: 2 bytes
- **Range**: 0 to 65,535
- **Example**: `0x0100` (256), `0xFFFF` (65,535)

### VT_I4 (0x0003) - Signed 32-bit Integer
- **Description**: 4-byte signed integer (C++ `LONG`, C# `int`)
- **Structure**: 4 bytes, little-endian
- **Size**: 4 bytes
- **Range**: -2,147,483,648 to 2,147,483,647
- **Example**: `0x01000000` (16,777,216)
- **Format**: `[byte3][byte2][byte1][byte0]`

### VT_UI4 (0x0013) - Unsigned 32-bit Integer
- **Description**: 4-byte unsigned integer (C++ `ULONG`, C# `uint`)
- **Structure**: 4 bytes, little-endian
- **Size**: 4 bytes
- **Range**: 0 to 4,294,967,295
- **Example**: `0xFFFFFFFF` (4,294,967,295)

### VT_I8 (0x0014) - Signed 64-bit Integer
- **Description**: 8-byte signed integer (C++ `LONGLONG`, C# `long`)
- **Structure**: 8 bytes, little-endian
- **Size**: 8 bytes
- **Range**: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
- **Example**: File sizes, timestamps (when not using FILETIME)

### VT_UI8 (0x0015) - Unsigned 64-bit Integer
- **Description**: 8-byte unsigned integer (C++ `ULONGLONG`, C# `ulong`)
- **Structure**: 8 bytes, little-endian
- **Size**: 8 bytes
- **Range**: 0 to 18,446,744,073,709,551,615
- **Example**: Large file sizes, big counts

### VT_R4 (0x0004) - 4-byte Floating Point
- **Description**: Single-precision floating point (C++ `FLOAT`, C# `float`)
- **Structure**: IEEE 754 single-precision, little-endian
- **Size**: 4 bytes
- **Format**: Sign (1 bit) + Exponent (8 bits) + Mantissa (23 bits)
- **Range**: ±1.5 × 10⁻⁴⁵ to ±3.4 × 10³⁸
- **Example**: `0x40490FDB` (3.141593f)

### VT_R8 (0x0005) - 8-byte Floating Point
- **Description**: Double-precision floating point (C++ `DOUBLE`, C# `double`)
- **Structure**: IEEE 754 double-precision, little-endian
- **Size**: 8 bytes
- **Format**: Sign (1 bit) + Exponent (11 bits) + Mantissa (52 bits)
- **Range**: ±5.0 × 10⁻³²⁴ to ±1.7 × 10³⁰⁸
- **Example**: `0x400921FB54442D18` (3.141592653589793)

### VT_CY (0x0006) - Currency
- **Description**: 8-byte integer scaled by 10,000 (C++ `CY`, C# `decimal` with scale 4)
- **Structure**: 8-byte signed integer, little-endian
- **Size**: 8 bytes
- **Format**: Actual value = stored value / 10,000
- **Example**: `0x00000000000186A0` (100,000 = $10.0000)
- **Note**: Used for financial calculations, avoids floating-point rounding errors

### VT_DATE (0x0007) - OLE Automation Date
- **Description**: 8-byte floating point date/time
- **Structure**: 8-byte double, little-endian
- **Size**: 8 bytes
- **Format**: Days since Dec 30, 1899 00:00:00 + fractional days
- **Range**: -657434.0 (Jan 1, 100) to 2958465.9999999999 (Dec 31, 9999)
- **Special Values**: 0.0 = Dec 30, 1899 00:00:00
- **Example**: `41424.7083333333` = Sep 13, 2013 17:00:00

### VT_BOOL (0x000B) - Boolean
- **Description**: 2-byte Boolean (C++ `VARIANT_BOOL`)
- **Structure**: 2-byte signed integer (SHORT), little-endian
- **Size**: 2 bytes
- **Values**: 0xFFFF = True (-1), 0x0000 = False (0)
- **Other values**: Should be normalized to -1/0, but sometimes 1 is used
- **Example**: `0xFFFF` = True, `0x0000` = False

### VT_ERROR (0x000A) - HRESULT/SCODE
- **Description**: 4-byte error code
- **Structure**: 4-byte signed integer, little-endian
- **Size**: 4 bytes
- **Format**: Windows HRESULT format (bit 31 = severity, bits 30-16 = facility, bits 15-0 = code)
- **Examples**: `0x00000000` = S_OK, `0x80004005` = E_FAIL
- **Common HRESULTS**: 0x80070002 = ERROR_FILE_NOT_FOUND, 0x80030002 = STG_E_FILENOTFOUND

### VT_DECIMAL (0x000E) - 16-byte Decimal
- **Description**: 16-byte decimal number for financial calculations
- **Structure**: 96-bit integer + 8-bit scale + 8-bit sign flags
- **Size**: 16 bytes
- **Format**: 
  - Bytes 0-11: 96-bit integer (little-endian)
  - Byte 12-13: unused/reserved
  - Byte 14: scale (0-28, number of decimal places)
  - Byte 15: sign (0x80 = negative, 0x00 = positive)
- **Range**: ±79,228,162,514,264,337,593,543,950,335 (with 28 decimal places)
- **Example**: Decimal value = integer × 10⁻ˢᶜᵃˡᵉ

### VT_RECORD (0x0024) - User-Defined Record
- **Description**: User-defined structure or record
- **Structure**: Variable, defined by the record type
- **Size**: Variable
- **Format**: Depends on the record definition
- **Note**: Rare in property stores

### VT_INT_PTR (0x0025) - Signed Machine Pointer
- **Description**: Signed pointer-sized integer
- **Structure**: 4 or 8 bytes depending on platform (32/64-bit)
- **Size**: Pointer size
- **Format**: Native pointer representation
- **Note**: Size depends on the architecture (32-bit vs 64-bit)

### VT_UINT_PTR (0x0026) - Unsigned Machine Pointer
- **Description**: Unsigned pointer-sized integer
- **Structure**: 4 or 8 bytes depending on platform (32/64-bit)
- **Size**: Pointer size
- **Format**: Native pointer representation
- **Note**: Size depends on the architecture (32-bit vs 64-bit)

## String Types (1SPS Serialized Format)

### VT_BSTR (0x0008) - Binary String (OLE BSTR)
- **Description**: Length-prefixed Unicode string with null terminator
- **Structure**: 
  - 4 bytes: length in bytes (EXCLUDES null terminator)
  - N bytes: UTF-16LE characters (INCLUDES null terminator)
- **Size**: 4 + length + 2 bytes
- **Format**: `[UInt32 byteLength][UTF-16LE chars...][UInt16 0x0000]`
- **Character Count**: (length / 2) - 1
- **Example**: "Hello" = `0x0A000000` (10 bytes) + `0x4800 6500 6C00 6C00 6F00 0000` (H e l l o null)
- **Note**: Rare in 1SPS; VT_LPWSTR is more common

### VT_LPSTR (0x001E) - Null-Terminated ANSI String
- **Description**: Length-prefixed ANSI string in 1SPS format
- **Structure**: 
  - 4 bytes: character count (NOT byte count)
  - N bytes: ANSI characters (NO null terminator)
- **Size**: 4 + character count bytes
- **Format**: `[UInt32 charCount][ANSI chars...]` (no null terminator)
- **Encoding**: Current system ANSI code page (Windows-1252 on Western systems)
- **Example**: "Hello" = `0x05000000` (5 chars) + `0x48 65 6C 6C 6F` (H e l l o)
- **Note**: This differs from OLE VT_LPSTR which is null-terminated

### VT_LPWSTR (0x001F) - Null-Terminated Unicode String
- **Description**: Length-prefixed Unicode string in 1SPS format
- **Structure**:
  - 4 bytes: character count (NOT byte count)
  - N×2 bytes: UTF-16LE characters (NO null terminator)
- **Size**: 4 + (character count × 2) bytes
- **Format**: `[UInt32 charCount][UTF-16LE chars...]` (no null terminator)
- **Example**: "Hello" = `0x05000000` (5 chars) + `0x4800 6500 6C00 6C00 6F00`
- **Note**: This is the standard string type in property stores; differs from OLE VT_LPWSTR

## Date/Time Types

### VT_FILETIME (0x0040) - 64-bit File Time
- **Description**: 64-bit value representing # of 100ns intervals since Jan 1, 1601 UTC
- **Structure**: 8-byte unsigned integer, little-endian
- **Size**: 8 bytes
- **Format**: `[UInt64 filetime]`
- **Epoch**: Jan 1, 1601 00:00:00 UTC
- **Resolution**: 100 nanoseconds
- **Special Values**: 
  - 0 = Never (often used for "not set")
  - 0xFFFFFFFFFFFFFFFF = Infinite future
- **Conversion**: `DateTime.FromFileTimeUtc(filetime)`
- **Example**: `0x01D5CD9D1F2F8000` = Sep 13, 2013 17:00:00 UTC

## Binary Data Types

### VT_BLOB (0x0041) - Binary Large Object
- **Description**: Length-prefixed raw bytes
- **Structure**:
  - 4 bytes: length (in bytes)
  - N bytes: raw data
- **Size**: 4 + length bytes
- **Format**: `[UInt32 byteLength][raw bytes...]`
- **Note**: No null terminator, pure binary data
- **Example**: Image data, serialized objects

### VT_CF (0x0047) - Clipboard Format
- **Description**: Clipboard data format
- **Structure**:
  - 4 bytes: total size (including this header + data)
  - 4 bytes: clipboard format ID
  - N bytes: format-specific data
- **Size**: Variable (8 + data size)
- **Format**: `[UInt32 totalSize][UInt32 format][data...]`
- **Common Formats**:
  - 1 = CF_TEXT (ANSI text)
  - 13 = CF_UNICODETEXT (Unicode text)
  - 2 = CF_BITMAP (Bitmap handle)
  - 8 = CF_DIB (Device-independent bitmap)
- **Example**: Clipboard data with text or images

### VT_CLSID (0x0048) - Class ID (GUID)
- **Description**: 128-bit Globally Unique Identifier
- **Structure**: 16 bytes in standard Windows GUID format
- **Size**: 16 bytes
- **Format**: Mixed-endian:
  - 4 bytes: Data1 (big-endian)
  - 2 bytes: Data2 (big-endian)
  - 2 bytes: Data3 (big-endian)
  - 8 bytes: Data4 (byte array, big-endian for first 2 bytes)
- **String Format**: `{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}`
- **Example**: `0xDEADBEEFFEEDFACE1234567890ABCDEF`
- **Note**: .NET's `Guid` constructor handles the endian conversion automatically

## Stream and Storage Types

### VT_STREAM (0x0042) - Stream Object
- **Description**: Reference to an IStream object
- **Structure**: Variable, stream-specific
- **Format**: Stream name followed by stream data
- **Note**: Contains persistent stream object

### VT_STORAGE (0x0043) - Storage Object
- **Description**: Reference to an IStorage object
- **Structure**: Variable, storage-specific
- **Format**: Storage structure with substorages and streams

### VT_STREAMED_OBJECT (0x0044) - Streamed Object
- **Description**: Object saved in a stream
- **Structure**: Stream containing serialized object
- **Format**: Class ID followed by object data

### VT_STORED_OBJECT (0x0045) - Stored Object
- **Description**: Object saved in a storage
- **Structure**: Storage containing object data
- **Format**: Class ID followed by storage structure

### VT_BLOB_OBJECT (0x0046) - Blob Object
- **Description**: Object saved in a BLOB
- **Structure**: Class ID followed by BLOB data
- **Format**: `[CLSID][BLOB data]`

### VT_VERSIONED_STREAM (0x0049) - Versioned Stream
- **Description**: Stream with version GUID
- **Structure**:
  - 16 bytes: GUID (version identifier)
  - Variable: Stream data (format depends on version)
- **Size**: 16 + stream size
- **Format**: `[GUID version][stream data...]`
- **Common Uses**: Versioned serialization formats

## Shell-Specific Custom Types (Not in Standard VARENUM)

### VT_SHELL_I2_VERSIONED_STREAM (0x004B)
- **Description**: Shell extension type combining VT_I2 with versioned stream
- **Structure**: Custom shell format (exact structure undocumented)
- **Note**: Appears in Shell Item property stores, not standard VARENUM

### VT_SHELL_CY_CLSID (0x004E)
- **Description**: Shell extension type combining VT_CY with CLSID
- **Structure**: Custom shell format (exact structure undocumented)
- **Note**: Appears in Shell Item property stores, not standard VARENUM

### VT_SHELL_I1_STREAMED_OBJECT (0x0054)
- **Description**: Shell extension type combining VT_I1 with streamed object
- **Structure**: Custom shell format (exact structure undocumented)
- **Note**: Appears in Shell Item property stores, not standard VARENUM

## Complex/Structured Types

### VT_VARIANT (0x000C) - Variant
- **Description**: Can contain any other VT type
- **Structure** (when used in 1SPS):
  - 2 bytes: VT type code
  - 6 bytes: reserved/padding (often 0)
  - Variable: data based on type
- **Size**: 8 + data size
- **Format**: `[UInt16 type][UInt16 wReserved1][UInt32 wReserved2][data...]`
- **Used In**: `VT_VECTOR | VT_VARIANT`, `VT_ARRAY | VT_VARIANT`
- **Note**: Rare as standalone type in property stores

### VT_VECTOR (Base: 0x1000) - Simple Counted Array
- **Description**: Counted array of items (not a SAFEARRAY)
- **Structure for `VT_VECTOR | VT_TYPE`**:
  - 4 bytes: count of elements
  - For each element: element data (format depends on VT_TYPE)
- **Size**: 4 + (count × element_size)
- **Format**: `[UInt32 count][element1][element2]...[elementN]`

#### Specific Vector Types:

**`VT_VECTOR | VT_I4` (0x1003)**:
- Format: `[UInt32 count][Int32 elem1][Int32 elem2]...`

**`VT_VECTOR | VT_UI1` (0x1011)**:
- Format: `[UInt32 count][Byte elem1][Byte elem2]...`

**`VT_VECTOR | VT_LPWSTR` (0x101F)**:
- Format: `[UInt32 count]`
  - Then for each string: `[UInt32 charCount][UTF-16LE chars...]` (no null terminator)

**`VT_VECTOR | VT_VARIANT` (0x100C)**:
- Format: `[UInt32 count]`
  - Then for each variant: `[UInt16 type][6 bytes reserved][data...]`

### VT_ARRAY (Base: 0x2000) - SAFEARRAY
- **Description**: Multi-dimensional array with bounds information
- **Structure** (simplified):
  - 2 bytes: dimensions
  - 2 bytes: features/flags
  - 4 bytes: element size
  - For each dimension:
    - 4 bytes: element count
    - 4 bytes: lower bound
  - N × element_size: array data
- **Size**: Variable (header + bounds + data)
- **Format**: Complex SAFEARRAY structure
- **Note**: Rare in property stores, more common in COM automation

## Object/Reference Types

### VT_UNKNOWN (0x000D) - IUnknown Pointer
- **Description**: COM IUnknown interface pointer
- **Structure**: 4 or 8 bytes (32/64-bit pointer)
- **Size**: Pointer size
- **Format**: Binary pointer (not usable in serialized form)
- **Note**: Usually marshaled as interface pointer, not raw data

### VT_DISPATCH (0x0009) - IDispatch Pointer
- **Description**: COM IDispatch interface pointer
- **Structure**: 4 or 8 bytes (32/64-bit pointer)
- **Size**: Pointer size
- **Format**: Binary pointer
- **Note**: For OLE Automation objects

## Flag Combinations

### VT_BYREF (Mask: 0x4000) - By Reference
- **Description**: Value is a pointer/reference
- **Usage**: Combined with other types (e.g., `VT_BYREF | VT_I4`)
- **Structure**: Pointer to the actual data
- **Example**: `0x4003` = `VT_BYREF | VT_I4` (pointer to 32-bit integer)

### Common Combinations:
- **`VT_VECTOR | VT_I4`** (0x1003): Array of 32-bit integers
- **`VT_VECTOR | VT_LPWSTR`** (0x101F): Array of Unicode strings
- **`VT_VECTOR | VT_VARIANT`** (0x100C): Array of variants (can be mixed types)
- **`VT_ARRAY | VT_UI1`** (0x2011): Byte array (SAFEARRAY of bytes)
- **`VT_BYREF | VT_BOOL`** (0x400B): Pointer to boolean

## Implementation Notes for Property Store:

1. **1SPS Format**: The Serialized Property Store (1SPS) stores these types with:
   - Property ID
   - Type code
   - Value (formatted as above)

2. **Alignment**: Values are often padded to 4-byte boundaries

3. **String Handling**: Most strings in property stores are VT_LPWSTR (Unicode) with character count, not null-terminated

4. **Common Types in Shell Property Stores**:
   - VT_LPWSTR: File names, paths, strings
   - VT_UI4: Counts, sizes, flags
   - VT_FILETIME: Dates (modified, created, accessed)
   - VT_BOOL: Boolean properties
   - VT_CLSID: GUIDs for interfaces, formats
   - VT_BLOB: Binary data (thumbnails, custom data)

5. **Vector Usage**: Used for multi-valued properties (e.g., multiple authors, keywords)

## Helper Functions for Parsing (1SPS Format):

```powershell
# VT_I4 (4-byte integer)
$value = [System.BitConverter]::ToInt32($bytes, 0)

# VT_UI4 (4-byte unsigned integer)
$value = [System.BitConverter]::ToUInt32($bytes, 0)

# VT_FILETIME (8-byte timestamp)
$fileTime = [System.BitConverter]::ToInt64($bytes, 0)
$dateTime = [DateTime]::FromFileTimeUtc($fileTime)

# VT_LPWSTR (Unicode string in 1SPS format)
$charCount = [System.BitConverter]::ToUInt32($bytes, 0)
$string = [System.Text.Encoding]::Unicode.GetString($bytes, 4, $charCount * 2)

# VT_LPSTR (ANSI string in 1SPS format)
$charCount = [System.BitConverter]::ToUInt32($bytes, 0)
$string = [System.Text.Encoding]::Default.GetString($bytes, 4, $charCount)

# VT_CLSID (16-byte GUID)
$guid = [Guid]::new($bytes)  # .NET handles endian conversion

# VT_BLOB (binary data)
$byteCount = [System.BitConverter]::ToUInt32($bytes, 0)
$data = $bytes[4..($byteCount + 3)]

# VT_VECTOR | VT_LPWSTR (array of Unicode strings)
function Parse-VT_VECTOR_LPWSTR {
    param([byte[]]$bytes)
    $offset = 0
    $count = [BitConverter]::ToUInt32($bytes, $offset)
    $offset += 4
    $strings = @()
    for ($i = 0; $i -lt $count; $i++) {
        $charCount = [BitConverter]::ToUInt32($bytes, $offset)
        $offset += 4
        $string = [Text.Encoding]::Unicode.GetString($bytes, $offset, $charCount * 2)
        $offset += $charCount * 2
        $strings += $string
    }
    return $strings
}

# VT_BSTR (OLE BSTR format)
function Parse-VT_BSTR {
    param([byte[]]$bytes)
    $byteLength = [BitConverter]::ToUInt32($bytes, 0)
    # BSTR includes null terminator, so length in chars = (byteLength / 2) - 1
    $string = [Text.Encoding]::Unicode.GetString($bytes, 4, $byteLength)
    return $string.TrimEnd([char]0)
}
```

## References:
- [Object Linking and Embedding (OLE) - PropertyType](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/2a4589eb-9a23-4a8b-adbd-3e368233c099)
- [Object Linking and Embedding (OLE) - TypedPropertyValue](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/f122b9d7-e5cf-4484-8466-83f6fd94b3cc)
- [Object Linking and Embedding (OLE) - Property Types in Variable-Typed Vectors and Arrays](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/8e6b33cd-3fb2-4329-9c6b-cb3a6c976e0f)
- [Object Linking and Embedding (OLE) - Non-Simple Property Set Storage Format](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/83b0f831-6adf-48c5-8bef-b62e7ac1cc1e)
- [Object Linking and Embedding (OLE) - SummaryInformation](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/f7933d28-2cc4-4b36-bc23-8861cbcd37c4)
- [VARENUM enumeration (wtypes.h)](https://learn.microsoft.com/en-us/windows/win32/api/wtypes/ne-wtypes-varenum)
