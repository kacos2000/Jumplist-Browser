<#
.SYNOPSIS
    Parses Windows .lnk files and .customDestinations-ms jump list files.
    Displays full LNK details with color‑coded output and extensive metadata.
.PARAMETER FilePath
    Path to the .lnk or .customDestinations-ms file (may be quoted).
.PARAMETER AsJson
    Switch to output the parsed data as JSON instead of a formatted list.
.PARAMETER UseRegistry
    Switch to enable registry lookup for CLSID descriptions (slower). Default is false.
#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$FilePath,
    [switch]$AsJson,
    [switch]$UseRegistry
)

#region Constants and Mappings
$FileAttributesEnum = [Ordered]@{
    '1'          = 'ReadOnly'
    '2'          = 'Hidden'
    '4'          = 'System'
    '8'          = 'Volume_Label'
    '16'         = 'Directory'
    '32'         = 'Archive'
    '64'         = 'Device'
    '128'        = 'Normal'
    '256'        = 'Temporary'
    '512'        = 'Sparse_File'
    '1024'       = 'Reparse_Point'
    '2048'       = 'Compressed'
    '4096'       = 'Offline'
    '8192'       = 'Not_Content_Indexed'
    '16384'      = 'Encrypted'
    '32768'      = 'Integrity_Stream'
    '65536'      = 'Virtual'
    '131072'     = 'No_Scrub_Data'
    '262144'     = 'Recall_On_Open'
    '524288'     = 'Pinned'
    '1048576'    = 'Unpinned'
    '4194304'    = 'Recall_On_DataAccess'
    '16777216'   = 'Partially_Hydrated'
    '536870912'  = 'View_Index'
    '2147483648' = 'Reserved'
}

$ReparseFilter = [Ordered]@{
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
    "80000023" = "IO_REPARSE_TAG_AF_UNIX"
    "80000024" = "IO_REPARSE_TAG_LX_FIFO"
    "80000025" = "IO_REPARSE_TAG_LX_CHR"
    "80000026" = "IO_REPARSE_TAG_LX_BLK"
    "9000001C" = "IO_REPARSE_TAG_PROJFS"
    "90001018" = "IO_REPARSE_TAG_WCI_1"
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
    "0000F000" = "IO_REPARSE_TAG_CLOUD_MASK"
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
}

$DriveTypes = [Ordered]@{
    0 = "UNKNOWN"
    1 = "NO_ROOT_DIR"
    2 = "REMOVABLE"
    3 = "FIXED"
    4 = "REMOTE"
    5 = "CDROM"
    6 = "RAMDISK"
}

$ShowCommands = [Ordered]@{
    0  = '[SW_HIDE] Hides the window and activates another window.'
    1  = '[SW_SHOWNORMAL] Window is activated and restored to its original size and position.'
    2  = '[SW_SHOWMINIMIZED] Window is minimized and activated.'
    3  = '[SW_SHOWMAXIMIZED] Window is maximized and activated.'
    4  = '[SW_SHOWNOACTIVATE] Window in its most recent size and position. The window is NOT activated.'
    5  = '[SW_SHOW] Activates the window and displays it in its current size and position.'
    6  = '[SW_MINIMIZE] Minimizes the specified window and activates the next top-level window in the Z order.'
    7  = '[SW_SHOWMINNOACTIVE] Window is minimized and NOT activated.'
    8  = '[SW_SHOWNA] Displays the window in its current size and position. The window is NOT activated.'
    9  = '[SW_RESTORE] Displays the window in its current size and position. The window is activated.'
    10 = '[SW_SHOWDEFAULT] Sets the show state to the default used by the program that started the application.'
    11 = '[SW_FORCEMINIMIZE] Minimizes a window, even if the thread that owns the window is not responding.'
}

$FolderIDs = [Ordered]@{
    0  = 'Desktop'
    2  = 'Programs folder on Start menu'
    3  = 'Control Panel'
    4  = 'Printers'
    5  = 'My Documents'
    6  = 'Favorites'
    7  = 'Startup folder on Start menu'
    8  = 'Recent Files'
    9  = 'Send To'
    10 = 'Recycle Bin'
    12 = 'Start menu'
    17 = 'My Computer'
    18 = 'My Network Places'
    20 = 'Fonts'
}

$ViewModes = [Ordered]@{
    '-1' = 'Auto (Best Option)'
    '1'  = 'Icons'
    '2'  = 'Small Icons'
    '3'  = 'List'
    '4'  = 'Details'
    '5'  = 'Thumbnail'
    '6'  = 'Tiles'
    '7'  = 'Thumbstrip'
    '8'  = 'Content'
}

$Vendors = [Ordered]@{
    "00010000" = "WNNC_NET_MSNET"
    "00020000" = "WNNC_NET_LANMAN"
    "00030000" = "WNNC_NET_NETWARE"
    "00040000" = "WNNC_NET_VINES"
    "00050000" = "WNNC_NET_10NET"
    "00060000" = "WNNC_NET_LOCUS"
    "00070000" = "WNNC_NET_SUN_PC_NFS"
    "00080000" = "WNNC_NET_LANSTEP"
    "00090000" = "WNNC_NET_9TILES"
    "000A0000" = "WNNC_NET_LANTASTIC"
    "000B0000" = "WNNC_NET_AS400"
    "000C0000" = "WNNC_NET_FTP_NFS"
    "000D0000" = "WNNC_NET_PATHWORKS"
    "000E0000" = "WNNC_NET_LIFENET"
    "000F0000" = "WNNC_NET_POWERLAN"
    "00100000" = "WNNC_NET_BWNFS"
    "00110000" = "WNNC_NET_COGENT"
    "00120000" = "WNNC_NET_FARALLON"
    "00130000" = "WNNC_NET_APPLETALK"
    "00140000" = "WNNC_NET_INTERGRAPH"
    "00150000" = "WNNC_NET_SYMFONET"
    "00160000" = "WNNC_NET_CLEARCASE"
    "00170000" = "WNNC_NET_FRONTIER"
    "00180000" = "WNNC_NET_BMC"
    "00190000" = "WNNC_NET_DCE"
    "001A0000" = "WNNC_NET_AVID"
    "001B0000" = "WNNC_NET_DOCUSPACE"
    "001C0000" = "WNNC_NET_MANGOSOFT"
    "001D0000" = "WNNC_NET_SERNET"
    "001E0000" = "WNNC_NET_RIVERFRONT1"
    "001F0000" = "WNNC_NET_RIVERFRONT2"
    "00200000" = "WNNC_NET_DECORB"
    "00210000" = "WNNC_NET_PROTSTOR"
    "00220000" = "WNNC_NET_FJ_REDIR"
    "00230000" = "WNNC_NET_DISTINCT"
    "00240000" = "WNNC_NET_TWINS"
    "00250000" = "WNNC_NET_RDR2SAMPLE"
    "00260000" = "WNNC_NET_CSC"
    "00270000" = "WNNC_NET_3IN1"
    "00290000" = "WNNC_NET_EXTENDNET"
    "002A0000" = "WNNC_NET_STAC"
    "002B0000" = "WNNC_NET_FOXBAT"
    "002C0000" = "WNNC_NET_YAHOO"
    "002D0000" = "WNNC_NET_EXIFS"
    "002E0000" = "WNNC_NET_DAV"
    "002F0000" = "WNNC_NET_KNOWARE"
    "00300000" = "WNNC_NET_OBJECT_DIRE"
    "00310000" = "WNNC_NET_MASFAX"
    "00320000" = "WNNC_NET_HOB_NFS"
    "00330000" = "WNNC_NET_SHIVA"
    "00340000" = "WNNC_NET_IBMAL"
    "00350000" = "WNNC_NET_LOCK"
    "00360000" = "WNNC_NET_TERMSRV"
    "00370000" = "WNNC_NET_SRT"
    "00380000" = "WNNC_NET_QUINCY"
    "00390000" = "WNNC_NET_OPENAFS"
    "003A0000" = "WNNC_NET_AVID1"
    "003B0000" = "WNNC_NET_DFS"
    "003C0000" = "WNNC_NET_KWNP"
    "003D0000" = "WNNC_NET_ZENWORKS"
    "003E0000" = "WNNC_NET_DRIVEONWEB"
    "003F0000" = "WNNC_NET_VMWARE"
    "00400000" = "WNNC_NET_RSFX"
    "00410000" = "WNNC_NET_MFILES"
    "00420000" = "WNNC_NET_MS_NFS"
    "00430000" = "WNNC_NET_GOOGLE"
    "00440000" = "WNNC_NET_NDFS"
}

# Sort order index for type 0x1F (classType byte)
$SortOrderIndex = [Ordered]@{
    '00' = "Shell User's Folder"
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
    '77' = 'Linux'
    '78' = 'Recycle Bin'
    '80' = 'All Tasks'
    '1F' = 'Drive'
    '2F' = 'Folder'
    '32' = 'File'
    '36' = 'File'
    '3A' = 'File'
}

# Built‑in known CLSID descriptions (for speed when -UseRegistry is false)
$KnownCLSID = @{
    "B4FB3F98-C1EA-428D-A78A-D1F5659CBA93" = "Microsoft.NetworkAndSharingCenter /ShareMedia"
    "018D5C66-4533-4307-9B53-224DE2ED1FE6" = "OneDrivePersonal"
    "184E877F-522E-4F52-B483-7681678F1722" = "Dropbox"
    "68284FAA-6A48-11D0-8C78-00C04FD918B4" = "TaskBand"
    "20D04FE0-3AEA-1069-A2D8-08002B30309D" = "My Computer"
    "59031A47-3F72-44A7-89C5-5595FE6B30EE" = "UsersFiles"
    "208D2C60-3AEA-1069-A2D7-08002B30309D" = "My Network Places"
    "450D8FBA-AD25-11D0-98A8-0800361B1103" = "My Documents"
    "031E4825-7B94-4DC3-B131-E946B44C8DD5" = "Libraries"
    "24ad3ad4-a569-4530-98e1-ab02f9417aa8" = "This PC"
    "B4BFCC3A-DB2C-424C-B029-7FE99A87C641" = "ThisPCDesktopRegFolder"   # Corrected from "Temp Folder"
}
#endregion

#region Helper functions
function Read-UInt16 { param([byte[]]$Bytes, [int]$Offset) [System.BitConverter]::ToUInt16($Bytes, $Offset) }
function Read-UInt32 { param([byte[]]$Bytes, [int]$Offset) [System.BitConverter]::ToUInt32($Bytes, $Offset) }
function Read-UInt64 { param([byte[]]$Bytes, [int]$Offset) [System.BitConverter]::ToUInt64($Bytes, $Offset) }

function Read-Guid {
    param([byte[]]$Bytes, [int]$Offset)
    $guidBytes = New-Object byte[] 16
    [Array]::Copy($Bytes, $Offset, $guidBytes, 0, 16)
    return [System.Guid]::new($guidBytes)
}

function Read-FileTime {
    param([byte[]]$Bytes, [int]$Offset)
    $ft = Read-UInt64 $Bytes $Offset
    if ($ft -eq 0) { return $null }
    [DateTime]::FromFileTimeUtc($ft)
}

function Find-Bytes {
    param([byte[]]$Bytes, [byte[]]$Pattern)
    $indices = @()
    $len = $Bytes.Length
    $plen = $Pattern.Length
    for ($i = 0; $i -le $len - $plen; $i++) {
        $match = $true
        for ($j = 0; $j -lt $plen; $j++) {
            if ($Bytes[$i + $j] -ne $Pattern[$j]) {
                $match = $false
                break
            }
        }
        if ($match) {
            $indices += $i
            $i += $plen - 1
        }
    }
    return $indices
}

function Read-StringUntilNull {
    param(
        [byte[]]$Bytes,
        [int]$Start,
        [int]$End,
        [bool]$Unicode
    )
    $pos = $Start
    $chars = [System.Collections.Generic.List[char]]::new()
    while ($pos -lt $End) {
        if ($Unicode) {
            if ($pos + 1 -ge $End) { break }
            $c = [System.BitConverter]::ToChar($Bytes, $pos)
            $pos += 2
        } else {
            $c = [char]$Bytes[$pos]
            $pos += 1
        }
        if ($c -eq 0) { break }
        $chars.Add($c)
    }
    if ($chars.Count -eq 0) { return $null }
    return -join $chars
}

function Get-Attributes {
    param(
        [Byte[]]$Bytes,
        [switch]$NoNumber
    )
    $attr = [System.Collections.ArrayList]::new()
    $attrInt = if ($bytes.Count -eq 2) {
        [System.BitConverter]::ToUInt16($Bytes, 0)
        $maxBit = 0xFFFF
    } elseif ($bytes.Count -eq 4) {
        [System.BitConverter]::ToUInt32($Bytes, 0)
        $maxBit = [UInt32]::MaxValue
    } else { return "" }

    $FileAttributesEnum.GetEnumerator().foreach{
        if ([uint64]$_.key -le $maxBit -and ($attrInt -band $_.key) -eq $_.key) {
            $null = $attr.Add($FileAttributesEnum[$_.key])
        }
    }

    if (!$NoNumber) {
        [System.Array]::Reverse($bytes)
        $attrhx = "0x$([System.BitConverter]::ToString($Bytes) -replace '-', '')"
        return "$($attr -join ', ') ($($attrhx))"
    } else {
        return "$($attr -join ', ')"
    }
}

function DosDateTime-FromHex {
    param([string]$Hex)
    if ($Hex.Length -ne 8) { return $null }
    $hex_time = "0x$(($hex -split '(....)')[1])"
    $hex_date = "0x$(($hex -split '(....)')[3])"
    $bin_t = [Convert]::ToString($hex_time, 2).PadLeft(16, '0')
    $bin_d = [Convert]::ToString($hex_date, 2).PadLeft(16, '0')
    $hour = [Convert]::ToInt32($bin_t.Substring(0,5), 2)
    $minute = [Convert]::ToInt32($bin_t.Substring(5,6), 2)
    $second = [Convert]::ToInt32($bin_t.Substring(11,5), 2) * 2
    $year = [Convert]::ToInt32($bin_d.Substring(0,7), 2) + 1980
    $month = [Convert]::ToInt32($bin_d.Substring(7,4), 2)
    $day = [Convert]::ToInt32($bin_d.Substring(11,5), 2)
    try {
        return Get-Date -Year $year -Month $month -Day $day -Hour $hour -Minute $minute -Second $second -Millisecond 0
    } catch {
        return $null
    }
}

function Get-GUIDfromHexString {
    param([string]$Hex)
    $Hex = $Hex -replace '[^0-9A-Fa-f]', ''
    if ($Hex.Length -ne 32) { return $null }
    $guidHex = $Hex -replace '(..)(..)(..)(..)(..)(..)(..)(..)(..)(..)', '$4$3$2$1-$6$5-$8$7-$9$10-'
    try {
        return [System.Guid]::Parse($guidHex).Guid.ToUpper()
    } catch {
        return $null
    }
}

function Get-CLSID {
    param([string]$CLSIDstring)
    $CLSIDstring = $CLSIDstring.TrimStart('{').TrimEnd('}')
    if ($CLSIDstring.Length -ne 36) { return "[$CLSIDstring]" }
    # Check built‑in list first
    if ($KnownCLSID.Contains($CLSIDstring)) {
        return "$($KnownCLSID[$CLSIDstring]) [$CLSIDstring]"
    }
    # If registry lookup is enabled, try it
    if ($UseRegistry) {
        $paths = @(
            "Software\Classes\CLSID",
            "Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace",
            "Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace"
        )
        foreach ($path in $paths) {
            try {
                $reg = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($path)
                if ($reg) {
                    $sub = $reg.OpenSubKey($CLSIDstring)
                    if ($sub) {
                        $val = $sub.GetValue('')
                        $sub.Close()
                        $reg.Close()
                        if ($val) { return "$val [$CLSIDstring]" }
                    }
                    $reg.Close()
                }
            } catch { continue }
        }
    }
    # Fallback: just return the GUID in brackets
    return "[$CLSIDstring]"
}
#endregion

#region LNK parser functions
function Parse-LNK {
    param(
        [byte[]]$FileBytes,
        [int]$Offset,
        [int]$MaxLength
    )

    $result = [ordered]@{}
    $startOffset = $Offset
    $remaining = if ($MaxLength) { $MaxLength } else { $FileBytes.Length - $Offset }

    # ---- ShellLinkHeader (76 bytes) ----
    if ($remaining -lt 76) {
        Write-Warning "Insufficient data for LNK header at offset $Offset"
        return $null, 0
    }
    $headerSize = Read-UInt32 $FileBytes $Offset
    if ($headerSize -ne 0x4C) { return $null, 0 }
    $clsid = Read-Guid $FileBytes ($Offset+4)
    if ($clsid -ne [Guid]"00021401-0000-0000-c000-000000000046") { return $null, 0 }

    $linkFlags = Read-UInt32 $FileBytes ($Offset+20)
    $fileAttr = Read-UInt32 $FileBytes ($Offset+24)
    $creationTime = Read-FileTime $FileBytes ($Offset+28)
    $accessTime   = Read-FileTime $FileBytes ($Offset+36)
    $writeTime    = Read-FileTime $FileBytes ($Offset+44)
    $fileSizeLow  = Read-UInt32 $FileBytes ($Offset+52)
    $iconIndex    = Read-UInt32 $FileBytes ($Offset+56)
    $showCmd      = Read-UInt32 $FileBytes ($Offset+60)
    $hotKey       = Read-UInt16 $FileBytes ($Offset+64)

    $result['LinkCLSID'] = $clsid.ToString("B").ToUpper()
    $result['LinkFlags'] = @{}
    $flags = @(
        @{bit=0; name="HasLinkTargetIDList"}, @{bit=1; name="HasLinkInfo"},
        @{bit=2; name="HasName"}, @{bit=3; name="HasRelativePath"},
        @{bit=4; name="HasWorkingDir"}, @{bit=5; name="HasArguments"},
        @{bit=6; name="HasIconLocation"}, @{bit=7; name="IsUnicode"},
        @{bit=8; name="ForceNoLinkInfo"}, @{bit=9; name="HasExpString"},
        @{bit=10; name="RunInSeparateProcess"}, @{bit=11; name="HasDarwinID"},
        @{bit=12; name="RunAsUser"}, @{bit=13; name="HasExpIcon"},
        @{bit=14; name="NoPidlAlias"}, @{bit=15; name="RunWithShimLayer"},
        @{bit=16; name="ForceNoLinkTrack"}, @{bit=17; name="EnableTargetMetadata"},
        @{bit=18; name="DisableLinkPathTracking"}, @{bit=19; name="DisableKnownFolderTracking"},
        @{bit=20; name="DisableKnownFolderAlias"}, @{bit=21; name="AllowLinkToLink"},
        @{bit=22; name="UnaliasOnSave"}, @{bit=23; name="PreferEnvironmentPath"},
        @{bit=24; name="KeepLocalIDListForUNCTarget"}
    )
    foreach ($f in $flags) {
        if ($linkFlags -band [math]::Pow(2, $f.bit)) { $result['LinkFlags'][$f.name] = $true }
    }
    $result['FileAttributes'] = $fileAttr
    $result['CreationTimeUtc'] = if ($creationTime) { $creationTime.ToString("dd-MMM-yyyy HH:mm:ss.fffffff") } else { $null }
    $result['AccessTimeUtc']   = if ($accessTime)   { $accessTime.ToString("dd-MMM-yyyy HH:mm:ss.fffffff") } else { $null }
    $result['WriteTimeUtc']    = if ($writeTime)    { $writeTime.ToString("dd-MMM-yyyy HH:mm:ss.fffffff") } else { $null }
    $result['FileSize']        = $fileSizeLow
    $result['IconIndex']       = $iconIndex
    $result['ShowCommand']     = $showCmd
    $result['HotKey']          = $hotKey

    $pos = $Offset + 76
    $remaining -= 76
    $idListBytes = $null
    $itemInfos = @()
    $targetItem = $null

    # ---- LinkTargetIDList ----
    if ($result['LinkFlags'].Contains('HasLinkTargetIDList')) {
        if ($remaining -lt 2) { return $null, 0 }
        $idListSize = Read-UInt16 $FileBytes $pos
        $pos += 2
        $remaining -= 2
        if ($idListSize -gt 0) {
            if ($remaining -lt $idListSize) { return $null, 0 }
            $idListBytes = $FileBytes[$pos..($pos+$idListSize-1)]
            $idListResult = Parse-IDList -IdListBytes $idListBytes
            $itemInfos = $idListResult.Items
            $targetItem = $idListResult.TargetItem
            $pos += $idListSize
            $remaining -= $idListSize
        }
    }

    $result['ItemInfos'] = $itemInfos
    if ($targetItem) { $result['TargetItem'] = $targetItem }

    # ---- LinkInfo (enhanced) ----
    $linkInfo = $null
    $targetPath = ""
    if ($result['LinkFlags'].Contains('HasLinkInfo')) {
        if ($remaining -lt 4) { return $null, 0 }
        $linkInfoStart = $pos
        $linkInfoSize = Read-UInt32 $FileBytes $pos
        if ($remaining -lt $linkInfoSize) { return $null, 0 }

        $linkInfoHeaderSize = Read-UInt32 $FileBytes ($pos+4)
        $linkInfoFlags = Read-UInt32 $FileBytes ($pos+8)
        $volumeIDOffset = Read-UInt32 $FileBytes ($pos+12)
        $localBasePathOffset = Read-UInt32 $FileBytes ($pos+16)
        $commonNetworkRelativeLinkOffset = Read-UInt32 $FileBytes ($pos+20)
        $commonPathSuffixOffset = Read-UInt32 $FileBytes ($pos+24)

        $hasUnicodeOffsets = $linkInfoHeaderSize -ge 0x24
        $localBasePathOffsetUnicode = 0
        $commonPathSuffixOffsetUnicode = 0
        if ($hasUnicodeOffsets) {
            $localBasePathOffsetUnicode = Read-UInt32 $FileBytes ($pos+28)
            $commonPathSuffixOffsetUnicode = Read-UInt32 $FileBytes ($pos+32)
        }

        # VolumeID
        $volumeInfo = $null
        if ($volumeIDOffset -ne 0) {
            $volStart = $linkInfoStart + $volumeIDOffset
            $volSize = Read-UInt32 $FileBytes $volStart
            $driveType = Read-UInt32 $FileBytes ($volStart+4)
            $driveSerial = Read-UInt32 $FileBytes ($volStart+8)
            $volNameOffset = Read-UInt32 $FileBytes ($volStart+12)
            $volName = ""
            if ($volNameOffset -ne 0) {
                if ($volNameOffset -eq 0x14) {
                    $volNameOffsetUnicode = Read-UInt32 $FileBytes ($volStart+16)
                    $volNameStart = $volStart + $volNameOffsetUnicode
                    $volNameEnd = $volStart + $volSize
                    $volName = Read-StringUntilNull -Bytes $FileBytes -Start $volNameStart -End $volNameEnd -Unicode $true
                } else {
                    $volNameStart = $volStart + $volNameOffset
                    $volNameEnd = $volStart + $volSize
                    $volName = Read-StringUntilNull -Bytes $FileBytes -Start $volNameStart -End $volNameEnd -Unicode $false
                }
            }
            $volumeInfo = [ordered]@{
                DriveType = if ($DriveTypes.Contains($driveType)) { $DriveTypes[$driveType] } else { "Unknown ($driveType)" }
                SerialNumber = $driveSerial.ToString('X8')
                Label = $volName
            }
        }

        # LocalBasePath (ANSI)
        $base = $null
        if ($localBasePathOffset -ne 0 -and ($linkInfoFlags -band 0x01) -eq 0x01) {
            $pathStart = $linkInfoStart + $localBasePathOffset
            $pathEnd = $linkInfoStart + $linkInfoSize
            $base = Read-StringUntilNull -Bytes $FileBytes -Start $pathStart -End $pathEnd -Unicode $false
        }

        # LocalBasePath Unicode
        $baseUnicode = $null
        if ($hasUnicodeOffsets -and $localBasePathOffsetUnicode -ne 0) {
            $pathStart = $linkInfoStart + $localBasePathOffsetUnicode
            $baseUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $pathStart -End ($linkInfoStart + $linkInfoSize) -Unicode $true
        }

        # CommonPathSuffix (ANSI)
        $suffix = $null
        if ($commonPathSuffixOffset -ne 0) {
            $suffixStart = $linkInfoStart + $commonPathSuffixOffset
            $suffixEnd = $linkInfoStart + $linkInfoSize
            $suffix = Read-StringUntilNull -Bytes $FileBytes -Start $suffixStart -End $suffixEnd -Unicode $false
        }

        # CommonPathSuffix Unicode
        $suffixUnicode = $null
        if ($hasUnicodeOffsets -and $commonPathSuffixOffsetUnicode -ne 0) {
            $suffixStart = $linkInfoStart + $commonPathSuffixOffsetUnicode
            $suffixUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $suffixStart -End ($linkInfoStart + $linkInfoSize) -Unicode $true
        }

        # Build target path (prefer Unicode)
        $targetBase = if ($baseUnicode) { $baseUnicode } else { $base }
        $targetSuffix = if ($suffixUnicode) { $suffixUnicode } else { $suffix }
        if ($targetBase) {
            if ($targetSuffix) {
                if ($targetBase.EndsWith('\')) { $targetPath = $targetBase + $targetSuffix }
                else { $targetPath = $targetBase + '\' + $targetSuffix }
            } else {
                $targetPath = $targetBase
            }
        }

        # CommonNetworkRelativeLink
        $netInfo = $null
        if ($commonNetworkRelativeLinkOffset -ne 0) {
            $netStart = $linkInfoStart + $commonNetworkRelativeLinkOffset
            $netSize = Read-UInt32 $FileBytes $netStart
            $netFlags = Read-UInt32 $FileBytes ($netStart+4)
            $netNameOffset = Read-UInt32 $FileBytes ($netStart+8)
            $unicodeNet = $netNameOffset -gt 0x14
            $deviceNameOffset = Read-UInt32 $FileBytes ($netStart+12)
            $netType = Read-UInt32 $FileBytes ($netStart+16)
            $netNameOffsetUnicode = 0
            $deviceNameOffsetUnicode = 0
            if ($unicodeNet) {
                $netNameOffsetUnicode = Read-UInt32 $FileBytes ($netStart+20)
                $deviceNameOffsetUnicode = Read-UInt32 $FileBytes ($netStart+24)
            }
            $netName = $null
            if ($netNameOffset -ne 0) {
                $netNameStart = $netStart + $netNameOffset
                $netNameEnd = $netStart + $netSize
                $netName = Read-StringUntilNull -Bytes $FileBytes -Start $netNameStart -End $netNameEnd -Unicode $false
            }
            $netNameUnicode = $null
            if ($unicodeNet -and $netNameOffsetUnicode -ne 0) {
                $netNameStart = $netStart + $netNameOffsetUnicode
                $netNameEnd = $netStart + $netSize
                $netNameUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $netNameStart -End $netNameEnd -Unicode $true
            }
            $deviceName = $null
            if ($deviceNameOffset -ne 0 -and ($netFlags -band 0x02) -eq 0x02) {
                $deviceNameStart = $netStart + $deviceNameOffset
                $deviceNameEnd = $netStart + $netSize
                $deviceName = Read-StringUntilNull -Bytes $FileBytes -Start $deviceNameStart -End $deviceNameEnd -Unicode $false
            }
            $deviceNameUnicode = $null
            if ($unicodeNet -and $deviceNameOffsetUnicode -ne 0 -and ($netFlags -band 0x02) -eq 0x02) {
                $deviceNameStart = $netStart + $deviceNameOffsetUnicode
                $deviceNameEnd = $netStart + $netSize
                $deviceNameUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $deviceNameStart -End $deviceNameEnd -Unicode $true
            }
            $netTypeHex = $netType.ToString('X8')
            $providerType = if ($Vendors.Contains($netTypeHex)) { $Vendors[$netTypeHex] } else { "0x$netTypeHex" }
            $netInfo = [ordered]@{
                NetName = $netName
                NetNameUnicode = $netNameUnicode
                DeviceName = $deviceName
                DeviceNameUnicode = $deviceNameUnicode
                NetType = $providerType
                Flags = $netFlags
            }
        }

        $linkInfo = [ordered]@{
            LinkInfoSize = $linkInfoSize
            VolumeID = $volumeInfo
            LocalBasePath = $base
            LocalBasePathUnicode = $baseUnicode
            CommonPathSuffix = $suffix
            CommonPathSuffixUnicode = $suffixUnicode
            CommonNetworkRelativeLink = $netInfo
        }

        $pos += $linkInfoSize
        $remaining -= $linkInfoSize
    }

    # ---- StringData ----
    $stringData = @{}
    if ($result['LinkFlags'].Contains('HasName') -or
        $result['LinkFlags'].Contains('HasRelativePath') -or
        $result['LinkFlags'].Contains('HasWorkingDir') -or
        $result['LinkFlags'].Contains('HasArguments') -or
        $result['LinkFlags'].Contains('HasIconLocation')) {
        $stringTypes = @('Name', 'RelativePath', 'WorkingDir', 'Arguments', 'IconLocation')
        foreach ($type in $stringTypes) {
            $flagName = "Has$type"
            if ($result['LinkFlags'].Contains($flagName)) {
                if ($remaining -lt 2) { break }
                $charCount = Read-UInt16 $FileBytes $pos
                $pos += 2
                $remaining -= 2
                if ($charCount -gt 0) {
                    if ($remaining -lt $charCount*2) { break }
                    $strBytes = $FileBytes[$pos..($pos + $charCount*2 - 1)]
                    $str = [System.Text.Encoding]::Unicode.GetString($strBytes).TrimEnd("`0")
                    $pos += $charCount * 2
                    $remaining -= $charCount * 2
                    $stringData[$type] = $str
                } else {
                    $stringData[$type] = ""
                }
            }
        }
    }

    $result['LNKName'] = $stringData['Name']
    $result['Arguments'] = $stringData['Arguments']
    $result['IconLocation'] = $stringData['IconLocation']
    $result['RelativePath'] = $stringData['RelativePath']
    $result['WorkingDir'] = $stringData['WorkingDir']
    $result['TargetPath'] = $targetPath
    if ($linkInfo) { $result['LinkInfo'] = $linkInfo }

    $bytesConsumed = $pos - $startOffset
    return $result, $bytesConsumed
}

function Parse-IDList {
    param([byte[]]$IdListBytes)

    $items = @()
    $targetItem = $null
    $pos = 0
    while ($pos -lt $IdListBytes.Length) {
        $itemSize = Read-UInt16 $IdListBytes $pos
        if ($itemSize -eq 0) { break }
        $typeByte = $IdListBytes[$pos+2]
        $itemData = $IdListBytes[($pos+2)..($pos+$itemSize-1)]

        $basic = [ordered]@{
            Offset = $pos
            Size = $itemSize
            Type = "0x$($typeByte.ToString('X2'))"
        }

        switch ($typeByte) {
            0x1F {
                # GUID/ShellDesktop item
                $parsed = Parse-ItemType1F -ItemData $itemData
                $basic['Details'] = $parsed
            }
            0x31 {
                # Folder item
                $parsed = Parse-FolderItem -ItemData $itemData
                $basic['Details'] = $parsed
            }
            { $_ -in @(0x32, 0x36, 0x3A) } {
                # File item
                $parsed = Parse-FileItem -ItemData $itemData
                if ($parsed.Contains('Extension')) {
                    $basic['Extension'] = $parsed.Extension
                    $basic['FileSize64'] = $parsed.FileSize64
                    $targetItem = $basic
                }
                $basic['FileSizeLow'] = $parsed.FileSizeLow
                $basic['DOSModifiedTime'] = $parsed.DOSModifiedTime
                $basic['Attributes'] = $parsed.Attributes
                $basic['ShortName'] = $parsed.ShortName
            }
            default {
                # Unknown type – just show size
            }
        }

        $items += $basic
        $pos += $itemSize
    }

    return @{ Items = $items; TargetItem = $targetItem }
}

function Parse-ItemType1F {
    param([byte[]]$ItemData)
    $typeByte = $ItemData[0]
    $classType = $ItemData[1].ToString('X2')
    $size = $ItemData.Length
    $result = [ordered]@{
        ClassType = $classType   # store without "0x"
    }
    # Sort order index
    if ($SortOrderIndex.Contains($classType)) {
        $result['SortOrder'] = $SortOrderIndex[$classType]
    }
    # CLSID (bytes 2-17)
    if ($size -ge 18) {
        $guidHex = [System.BitConverter]::ToString($ItemData[2..17]).Replace('-','')
        $guid = Get-GUIDfromHexString -Hex $guidHex
        if ($guid) {
            $result['CLSID'] = Get-CLSID -CLSIDstring $guid
        }
    }
    # Check for extensions (starting after 18 if size > 18)
    if ($size -gt 18) {
        $extStart = 18
        $ext = Parse-Extensions -ItemData $ItemData -Start $extStart
        if ($ext) {
            $result['Extensions'] = $ext
        }
    }
    return $result
}

function Parse-FolderItem {
    param([byte[]]$ItemData)
    $typeByte = $ItemData[0]
    $size = $ItemData.Length
    $result = [ordered]@{
        Type = "0x$($typeByte.ToString('X2'))"
    }
    # DOS Modified time at bytes 6-9 (reversed)
    if ($size -ge 10) {
        $dosModifiedBytes = $ItemData[9], $ItemData[8], $ItemData[7], $ItemData[6]
        $dosModifiedHex = [System.BitConverter]::ToString($dosModifiedBytes).Replace('-','')
        $result['DOSModifiedTime'] = DosDateTime-FromHex -Hex $dosModifiedHex
    }
    # Attributes at bytes 10-11
    if ($size -ge 12) {
        $attrBytes = $ItemData[10..11]
        $result['Attributes'] = Get-Attributes -Bytes $attrBytes -NoNumber
    }
    # ANSI short name (8.3) from offset 12 until null
    $shortName = ""
    $shortNameEnd = 12
    while ($shortNameEnd -lt $size -and $ItemData[$shortNameEnd] -ne 0) {
        $shortNameEnd++
    }
    if ($shortNameEnd -gt 12) {
        $shortNameBytes = $ItemData[12..($shortNameEnd-1)]
        $shortName = [System.Text.Encoding]::ASCII.GetString($shortNameBytes)
        $result['ShortName'] = $shortName
    }
    # Look for BEEF0004 extension
    if ($size -ge 12) {
        $remaining = $ItemData[12..($size-1)]
        for ($i = 0; $i -le $remaining.Length - 4; $i++) {
            if ($remaining[$i] -eq 0x04 -and $remaining[$i+1] -eq 0x00 -and $remaining[$i+2] -eq 0xEF -and $remaining[$i+3] -eq 0xBE) {
                $signatureOffsetInRemaining = $i
                $signatureOffset = 12 + $signatureOffsetInRemaining
                $extStart = $signatureOffset - 4
                if ($extStart -ge 0 -and $extStart -lt $size) {
                    $ext = Parse-BEEF0004 -ItemData $ItemData -ExtStart $extStart
                    if ($ext) {
                        $result['Extension'] = $ext
                    }
                }
                break
            }
        }
    }
    return $result
}

function Parse-FileItem {
    param([byte[]]$ItemData)
    $typeByte = $ItemData[0]
    $size = $ItemData.Length
    $result = [ordered]@{
        FileSizeLow = [System.BitConverter]::ToUInt32($ItemData, 2)
    }
    # DOS Modified time at bytes 6-9 (reversed)
    if ($size -ge 10) {
        $dosModifiedBytes = $ItemData[9], $ItemData[8], $ItemData[7], $ItemData[6]
        $dosModifiedHex = [System.BitConverter]::ToString($dosModifiedBytes).Replace('-','')
        $result['DOSModifiedTime'] = DosDateTime-FromHex -Hex $dosModifiedHex
    }
    # Attributes at bytes 10-11
    if ($size -ge 12) {
        $attrBytes = $ItemData[10..11]
        $result['Attributes'] = Get-Attributes -Bytes $attrBytes -NoNumber
    }
    # ANSI short name
    $shortName = ""
    $shortNameEnd = 12
    while ($shortNameEnd -lt $size -and $ItemData[$shortNameEnd] -ne 0) {
        $shortNameEnd++
    }
    if ($shortNameEnd -gt 12) {
        $shortNameBytes = $ItemData[12..($shortNameEnd-1)]
        $shortName = [System.Text.Encoding]::ASCII.GetString($shortNameBytes)
        $result['ShortName'] = $shortName
    }
    # Look for BEEF0004 extension
    if ($size -ge 12) {
        $remaining = $ItemData[12..($size-1)]
        for ($i = 0; $i -le $remaining.Length - 4; $i++) {
            if ($remaining[$i] -eq 0x04 -and $remaining[$i+1] -eq 0x00 -and $remaining[$i+2] -eq 0xEF -and $remaining[$i+3] -eq 0xBE) {
                $signatureOffsetInRemaining = $i
                $signatureOffset = 12 + $signatureOffsetInRemaining
                $extStart = $signatureOffset - 4
                if ($extStart -ge 0 -and $extStart -lt $size) {
                    $ext = Parse-BEEF0004 -ItemData $ItemData -ExtStart $extStart
                    if ($ext) {
                        $result['Extension'] = $ext
                        $result['FileSize64'] = ($ext.FileSizeHigh * [math]::Pow(2, 32)) + $result.FileSizeLow
                    }
                }
                break
            }
        }
    }
    return $result
}

function Parse-Extensions {
    param([byte[]]$ItemData, [int]$Start)
    # Placeholder for generic extension parsing if needed
    return $null
}

function Parse-BEEF0004 {
    param(
        [byte[]]$ItemData,
        [int]$ExtStart
    )
    $extLength = [System.BitConverter]::ToUInt16($ItemData, $ExtStart)
    $extVersion = [System.BitConverter]::ToUInt16($ItemData, $ExtStart+2)
    $sigBytes = $ItemData[($ExtStart+4)..($ExtStart+7)]
    [Array]::Reverse($sigBytes)
    $signature = [System.BitConverter]::ToString($sigBytes).Replace('-','')
    if ($signature -ne 'BEEF0004') { return $null }
    if ($extVersion -ne 9) {
        Write-Warning "Unsupported BEEF0004 version: $extVersion (expected 9)"
        return $null
    }

    $dataStart = $ExtStart + 8
    $extension = [ordered]@{
        Version = $extVersion
        Length = $extLength
        Signature = $signature
    }

    try {
        # DOS creation time: bytes dataStart+3, dataStart+2, dataStart+1, dataStart
        $createBytes = $ItemData[($dataStart+3)], $ItemData[($dataStart+2)], $ItemData[($dataStart+1)], $ItemData[$dataStart]
        $createHex = [System.BitConverter]::ToString($createBytes).Replace('-','')
        $extension['DOSCreationTime'] = DosDateTime-FromHex -Hex $createHex

        # DOS access time: bytes dataStart+7, dataStart+6, dataStart+5, dataStart+4
        $accessBytes = $ItemData[($dataStart+7)], $ItemData[($dataStart+6)], $ItemData[($dataStart+5)], $ItemData[($dataStart+4)]
        $accessHex = [System.BitConverter]::ToString($accessBytes).Replace('-','')
        $extension['DOSAccessTime'] = DosDateTime-FromHex -Hex $accessHex

        $osType = [System.BitConverter]::ToUInt16($ItemData, $dataStart+8)
        $extension['OSType'] = switch ($osType) {
            20 { "Windows 2000" }
            22 { "Windows XP" }
            38 { "Windows Vista" }
            42 { "Windows 7" }
            46 { "Windows 8/8.1/10/11" }
            default { "Unknown ($osType)" }
        }

        $mftLowBytes = $ItemData[($dataStart+12)..($dataStart+17)]
        $mftHigh = [System.BitConverter]::ToUInt16($ItemData, $dataStart+10)
        $mftLow = 0
        for ($b = 0; $b -lt 6; $b++) { $mftLow += [UInt64]$mftLowBytes[$b] -shl ($b*8) }
        $mftFull = $mftLow + ([UInt64]$mftHigh -shl 48)
        $extension['MFTRecord'] = $mftFull
        $extension['MFTSequence'] = [System.BitConverter]::ToUInt16($ItemData, $dataStart+18)

        $fsHigh = [System.BitConverter]::ToUInt32($ItemData, $dataStart+20)
        $extension['FileSizeHigh'] = $fsHigh

        $reparseBytes = $ItemData[($dataStart+24)..($dataStart+27)]
        [Array]::Reverse($reparseBytes)
        $reparseHex = [System.BitConverter]::ToString($reparseBytes).Replace('-','')
        if ($ReparseFilter.Contains($reparseHex)) {
            $extension['ReparseTag'] = $ReparseFilter[$reparseHex]
        } else {
            $extension['ReparseTag'] = "0x$reparseHex"
        }

        $nameStart = $ExtStart + 46
        $nameBytes = New-Object System.Collections.Generic.List[byte]
        for ($j = $nameStart; $j -lt $ExtStart + $extLength - 2; $j += 2) {
            if ($ItemData[$j] -eq 0 -and $ItemData[$j+1] -eq 0) { break }
            $nameBytes.Add($ItemData[$j])
            $nameBytes.Add($ItemData[$j+1])
        }
        $extension['UnicodeName'] = if ($nameBytes.Count -gt 0) { [System.Text.Encoding]::Unicode.GetString($nameBytes.ToArray()) } else { $null }

        return $extension
    } catch {
        Write-Warning "Error parsing BEEF0004 extension: $_"
        return $null
    }
}
#endregion

#region CustomDestinations parser
function Parse-CustomDestination {
    param([string]$Path)

    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
    } catch {
        Write-Error "Cannot read file: $_"
        return $null
    }

    $patternHeader = [byte[]]@(0x01,0x14,0x02,0,0,0,0,0,0xC0,0,0,0,0,0,0,0x46)
    $patternMarker = [byte[]]@(0xAB,0xFB,0xBF,0xBA)
    $lnkPattern = [byte[]]@(0x4C,0,0,0,0x01,0x14,0x02,0,0,0,0,0,0xC0,0,0,0,0,0,0,0x46)

    $headerIndices = Find-Bytes -Bytes $bytes -Pattern $patternHeader
    $markerIndices = Find-Bytes -Bytes $bytes -Pattern $patternMarker

    if ($markerIndices.Count -eq 0) {
        Write-Warning "No group markers found. File may not be a valid .customDestinations-ms."
        return $null
    }

    $idx = if ($headerIndices.Count -gt 0) { $headerIndices[0] } else { $null }
    $tidx = $markerIndices
    $TypeCount = Read-UInt32 $bytes 4
    $groups = @()

    # ---- Parse first group ----
    if ($bytes.Length -ge 18) {
        $ECount = Read-UInt16 $bytes 16
        if ($idx -eq 20 -and $tidx[0] -ne 20) {
            $groups += [PSCustomObject]@{ Title='Tasks'; EntryCount=$ECount; Offset=$idx; End=$tidx[0] }
        } elseif ($ECount -ne 65535 -and $tidx[0] -ne 20) {
            $TitleSize = Read-UInt16 $bytes 16
            $Title = ""
            if ($TitleSize -gt 0 -and (18 + $TitleSize*2) -lt $idx) {
                $Title = [System.Text.Encoding]::Unicode.GetString($bytes[18..(18+$TitleSize*2-1)]).TrimEnd("`0")
            }
            $off = 18 + $TitleSize*2
            $EntryCount = 0
            if (($off+1) -lt $idx) { $EntryCount = Read-UInt16 $bytes $off }
            $groups += [PSCustomObject]@{ Title=$Title; EntryCount=$EntryCount; Offset=$idx; End=$tidx[0] }
        }
    }

    # ---- Parse additional groups ----
    if ($TypeCount -gt 1 -and $tidx.Count -gt 1) {
        for ($ti=0; $ti -lt ($TypeCount-1); $ti++) {
            if ($ti+1 -ge $tidx.Count) { break }
            if (($tidx[$ti+1] - $tidx[$ti]) -lt 76) { continue }

            $i = $tidx[$ti] + 4
            if ($i+3 -ge $bytes.Length) { continue }
            $t = Read-UInt32 $bytes $i

            if ($t -eq 0) {
                if ($i+5 -ge $bytes.Length) { continue }
                $TitleSize = Read-UInt16 $bytes ($i+4)
                $titleStart = $i + 6
                $titleEnd = $titleStart + $TitleSize*2 - 1
                if ($titleEnd -ge $bytes.Length) { continue }
                $Title = [System.Text.Encoding]::Unicode.GetString($bytes[$titleStart..$titleEnd]).TrimEnd("`0")
                $entryCountPos = $titleEnd + 1
                if ($entryCountPos+1 -ge $bytes.Length) { continue }
                $EntryCount = Read-UInt16 $bytes $entryCountPos
                $groups += [PSCustomObject]@{ Title=$Title; EntryCount=$EntryCount; Offset=$i; End=$tidx[$ti+1] }
            } else {
                if ($i+5 -ge $bytes.Length) { continue }
                $EntryCount = Read-UInt16 $bytes ($i+4)
                $groups += [PSCustomObject]@{ Title='Tasks'; EntryCount=$EntryCount; Offset=$i; End=$tidx[$ti+1] }
            }
        }
    }

    # ---- Locate LNKs within each group ----
    foreach ($group in $groups) {
        $groupStart = $group.Offset
        $groupEnd = $group.End
        $groupBytes = $bytes[$groupStart..($groupEnd-1)]
        $lnkOffsets = Find-Bytes -Bytes $groupBytes -Pattern $lnkPattern
        $absOffsets = $lnkOffsets | ForEach-Object { $groupStart + $_ }
        $entries = @()
        for ($i=0; $i -lt $absOffsets.Count; $i++) {
            $off = $absOffsets[$i]
            $nextOff = if ($i -lt $absOffsets.Count-1) { $absOffsets[$i+1] } else { $groupEnd }
            $maxLen = $nextOff - $off
            $lnk, $consumed = Parse-LNK -FileBytes $bytes -Offset $off -MaxLength $maxLen
            if ($lnk) {
                $lnk['Offset'] = $off
                $entries += $lnk
            } else {
                Write-Warning "Failed to parse LNK at offset $off"
            }
        }
        $group | Add-Member -MemberType NoteProperty -Name 'Entries' -Value $entries
    }

    # Prepare result
    $fileName = Split-Path $Path -Leaf
    $appId = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $result = [ordered]@{ File=$Path; FileName=$fileName; AppID=$appId; Groups=@{} }
    foreach ($g in $groups) {
        $groupObj = [ordered]@{ "Number of Entries" = $g.EntryCount }
        $i = 0
        foreach ($e in $g.Entries) {
            $key = "[$($e.Offset)] LNK #$(($i++).ToString('D3'))"
            if ($e.LNKName) { $key += " - $($e.LNKName)" }
            $groupObj[$key] = $e
        }
        $result.Groups["[$($g.Offset)] $($g.Title)"] = $groupObj
    }
    return $result
}
#endregion

# ---- Main execution ----
$cleanPath = $FilePath.Trim('"')
$fileInfo = [System.IO.FileInfo]::New($cleanPath)
if (-not $fileInfo.Exists) { Write-Error "File not found: $($fileInfo.FullName)"; exit 1 }

$ext = $fileInfo.Extension.ToLower()
if ($ext -eq '.lnk') {
    try {
        $bytes = [System.IO.File]::ReadAllBytes($fileInfo.FullName)
    } catch {
        Write-Error "Cannot read file: $_"
        exit 1
    }
    $lnk, $consumed = Parse-LNK -FileBytes $bytes -Offset 0 -MaxLength $bytes.Length
    if ($lnk) {
        if ($AsJson) {
            $lnk | ConvertTo-Json -Depth 10
        } else {
            Write-Host "`nFile: $($fileInfo.Name)" -ForegroundColor Cyan
            Write-Host "LNK Details:" -ForegroundColor Yellow
            if ($lnk.TargetPath) { Write-Host "  Target: $($lnk.TargetPath)" }
            if ($lnk.Arguments) { Write-Host "  Args: $($lnk.Arguments)" }
            if ($lnk.LNKName) { Write-Host "  Name: $($lnk.LNKName)" }
            if ($lnk.IconLocation) { Write-Host "  Icon: $($lnk.IconLocation)" }

            # LNK Header information
            Write-Host "  Header Info:" -ForegroundColor Yellow
            if ($lnk.CreationTimeUtc) { Write-Host "    Created (UTC): $($lnk.CreationTimeUtc)" }
            if ($lnk.AccessTimeUtc)   { Write-Host "    Accessed (UTC): $($lnk.AccessTimeUtc)" }
            if ($lnk.WriteTimeUtc)    { Write-Host "    Modified (UTC): $($lnk.WriteTimeUtc)" }
            if ($lnk.FileAttributes) {
                $attrBytes = [System.BitConverter]::GetBytes([UInt32]$lnk.FileAttributes)
                Write-Host "    Attributes: $(Get-Attributes -Bytes $attrBytes -NoNumber)"
            }
            if ($lnk.LinkFlags) {
                $flagNames = $lnk.LinkFlags.Keys -join ', '
                Write-Host "    Link Flags: $flagNames"
            }
            if ($lnk.ShowCommand -is [int]) {
                $show = if ($ShowCommands.Contains($lnk.ShowCommand)) { $ShowCommands[$lnk.ShowCommand] } else { "Unknown ($($lnk.ShowCommand))" }
                Write-Host "    ShowCommand: $show"
            }
            if ($lnk.HotKey -is [int]) { Write-Host "    HotKey: 0x$($lnk.HotKey.ToString('X4'))" }
            if ($lnk.IconIndex -is [int]) { Write-Host "    Icon Index: $($lnk.IconIndex)" }

            # ---- IDList items ----
            if ($lnk.ItemInfos -and $lnk.ItemInfos.Count -gt 0) {
                Write-Host "  IDList Items:" -ForegroundColor Yellow
                foreach ($item in $lnk.ItemInfos) {
                    Write-Host "    [Offset $($item.Offset)] Type $($item.Type), Size $($item.Size)" -ForegroundColor White
                    if ($item.Contains('Details')) {
                        $d = $item.Details
                        if ($d.Contains('ClassType')) { Write-Host "      ClassType: 0x$($d.ClassType)" }
                        if ($d.Contains('SortOrder')) { Write-Host "      SortOrder: $($d.SortOrder)" }
                        if ($d.Contains('CLSID')) { Write-Host "      CLSID: $($d.CLSID)" }
                        if ($d.Contains('DOSModifiedTime')) { Write-Host "      DOS Modified: $($d.DOSModifiedTime)" }
                        if ($d.Contains('Attributes')) { Write-Host "      Attributes: $($d.Attributes)" }
                        if ($d.Contains('ShortName')) { Write-Host "      Short Name: $($d.ShortName)" }
                        if ($d.Contains('Extension')) {
                            $ext = $d.Extension
                            Write-Host "      BEEF0004 Extension (v$($ext.Version)):" -ForegroundColor Green
                            if ($ext.UnicodeName) { Write-Host "        Unicode Name: $($ext.UnicodeName)" }
                            if ($ext.MFTRecord) { Write-Host "        MFT Record: $($ext.MFTRecord)" }
                            if ($ext.MFTSequence) { Write-Host "        MFT Sequence: $($ext.MFTSequence)" }
                            if ($ext.ReparseTag) { Write-Host "        Reparse Tag: $($ext.ReparseTag)" }
                            if ($ext.OSType) { Write-Host "        OS Type: $($ext.OSType)" }
                            if ($ext.DOSCreationTime) { Write-Host "        DOS Creation: $($ext.DOSCreationTime)" }
                            if ($ext.DOSAccessTime) { Write-Host "        DOS Access: $($ext.DOSAccessTime)" }
                        }
                    } else {
                        if ($item.Contains('FileSizeLow')) {
                            Write-Host "      File Size (low 32): $($item.FileSizeLow)"
                        }
                        if ($item.Contains('DOSModifiedTime') -and $item.DOSModifiedTime) {
                            Write-Host "      DOS Modified: $($item.DOSModifiedTime)"
                        }
                        if ($item.Contains('Attributes')) {
                            Write-Host "      Attributes: $($item.Attributes)"
                        }
                        if ($item.Contains('ShortName')) {
                            Write-Host "      Short Name: $($item.ShortName)"
                        }
                        if ($item.Contains('Extension')) {
                            $ext = $item.Extension
                            Write-Host "      BEEF0004 Extension (v$($ext.Version)):" -ForegroundColor Green
                            if ($ext.UnicodeName) { Write-Host "        Unicode Name: $($ext.UnicodeName)" }
                            if ($ext.MFTRecord) { Write-Host "        MFT Record: $($ext.MFTRecord)" }
                            if ($ext.MFTSequence) { Write-Host "        MFT Sequence: $($ext.MFTSequence)" }
                            if ($ext.ReparseTag) { Write-Host "        Reparse Tag: $($ext.ReparseTag)" }
                            if ($ext.OSType) { Write-Host "        OS Type: $($ext.OSType)" }
                            if ($ext.DOSCreationTime) { Write-Host "        DOS Creation: $($ext.DOSCreationTime)" }
                            if ($ext.DOSAccessTime) { Write-Host "        DOS Access: $($ext.DOSAccessTime)" }
                        }
                    }
                }
            }

            # ---- Target file (with extension) ----
            if ($lnk.TargetItem) {
                $item = $lnk.TargetItem
                if ($item.Contains('FileSize64')) {
                    Write-Host "  File Size (64-bit): $($item.FileSize64)" -ForegroundColor Yellow
                } else {
                    Write-Host "  File Size (32-bit): $($item.FileSizeLow)" -ForegroundColor Yellow
                }
                if ($item.Contains('Extension')) {
                    $ext = $item.Extension
                    Write-Host "  IDList Extension (v$($ext.Version)):" -ForegroundColor Green
                    if ($ext.UnicodeName) { Write-Host "    Unicode Name: $($ext.UnicodeName)" }
                    if ($ext.MFTRecord) { Write-Host "    MFT Record: $($ext.MFTRecord)" }
                    if ($ext.MFTSequence) { Write-Host "    MFT Sequence: $($ext.MFTSequence)" }
                    if ($ext.ReparseTag) { Write-Host "    Reparse Tag: $($ext.ReparseTag)" }
                    if ($ext.OSType) { Write-Host "    OS Type: $($ext.OSType)" }
                    if ($ext.DOSCreationTime) { Write-Host "    DOS Creation: $($ext.DOSCreationTime)" }
                    if ($ext.DOSAccessTime) { Write-Host "    DOS Access: $($ext.DOSAccessTime)" }
                }
            } else {
                Write-Host "  File Size (32-bit): $($lnk.FileSize)" -ForegroundColor Yellow
            }

            # ---- LinkInfo details ----
            if ($lnk.LinkInfo) {
                Write-Host "  LinkInfo:" -ForegroundColor Yellow
                if ($lnk.LinkInfo.VolumeID) {
                    $vol = $lnk.LinkInfo.VolumeID
                    Write-Host "    Volume: DriveType=$($vol.DriveType), Serial=$($vol.SerialNumber), Label='$($vol.Label)'"
                }
                if ($lnk.LinkInfo.LocalBasePath) { Write-Host "    LocalBasePath (ANSI): $($lnk.LinkInfo.LocalBasePath)" }
                if ($lnk.LinkInfo.LocalBasePathUnicode) { Write-Host "    LocalBasePath (Unicode): $($lnk.LinkInfo.LocalBasePathUnicode)" }
                if ($lnk.LinkInfo.CommonPathSuffix) { Write-Host "    CommonPathSuffix (ANSI): $($lnk.LinkInfo.CommonPathSuffix)" }
                if ($lnk.LinkInfo.CommonPathSuffixUnicode) { Write-Host "    CommonPathSuffix (Unicode): $($lnk.LinkInfo.CommonPathSuffixUnicode)" }
                if ($lnk.LinkInfo.CommonNetworkRelativeLink) {
                    $net = $lnk.LinkInfo.CommonNetworkRelativeLink
                    Write-Host "    CommonNetworkRelativeLink:"
                    if ($net.NetName) { Write-Host "      NetName (ANSI): $($net.NetName)" }
                    if ($net.NetNameUnicode) { Write-Host "      NetName (Unicode): $($net.NetNameUnicode)" }
                    if ($net.DeviceName) { Write-Host "      DeviceName (ANSI): $($net.DeviceName)" }
                    if ($net.DeviceNameUnicode) { Write-Host "      DeviceName (Unicode): $($net.DeviceNameUnicode)" }
                    if ($net.NetType) { Write-Host "      NetType: $($net.NetType)" }
                }
            }
        }
    } else {
        Write-Error "Failed to parse LNK file."
    }
} else {
    # .customDestinations-ms
    $parsed = Parse-CustomDestination -Path $fileInfo.FullName
    if ($parsed) {
        if ($AsJson) {
            $parsed | ConvertTo-Json -Depth 10
        } else {
            Write-Host "`nFile: $($parsed.FileName)" -ForegroundColor Cyan
            Write-Host "AppID: $($parsed.AppID)" -ForegroundColor Cyan
            Write-Host "`nGroups:" -ForegroundColor Yellow
            foreach ($gName in $parsed.Groups.Keys) {
                $g = $parsed.Groups[$gName]
                Write-Host "  $gName" -ForegroundColor Green
                Write-Host "    Number of Entries: $($g['Number of Entries'])" -ForegroundColor Gray
                foreach ($lnkKey in $g.Keys | Where-Object { $_ -ne 'Number of Entries' }) {
                    $lnk = $g[$lnkKey]
                    Write-Host "    $lnkKey" -ForegroundColor White
                    if ($lnk.TargetPath) { Write-Host "      Target: $($lnk.TargetPath)" }
                    if ($lnk.Arguments) { Write-Host "      Args: $($lnk.Arguments)" }
                    if ($lnk.LNKName) { Write-Host "      Name: $($lnk.LNKName)" }
                    if ($lnk.IconLocation) { Write-Host "      Icon: $($lnk.IconLocation)" }
                    if ($lnk.CreationTimeUtc) { Write-Host "      Created: $($lnk.CreationTimeUtc)" }
                    if ($lnk.TargetItem) {
                        $item = $lnk.TargetItem
                        if ($item.Contains('FileSize64')) {
                            Write-Host "      File Size (64-bit): $($item.FileSize64)"
                        } else {
                            Write-Host "      File Size (32-bit): $($item.FileSizeLow)"
                        }
                        if ($item.Contains('Extension')) {
                            $ext = $item.Extension
                            Write-Host "      IDList Extension (v$($ext.Version)):" -ForegroundColor Green
                            if ($ext.UnicodeName) { Write-Host "        Unicode Name: $($ext.UnicodeName)" }
                            if ($ext.MFTRecord) { Write-Host "        MFT Record: $($ext.MFTRecord)" }
                            if ($ext.MFTSequence) { Write-Host "        MFT Sequence: $($ext.MFTSequence)" }
                            if ($ext.ReparseTag) { Write-Host "        Reparse Tag: $($ext.ReparseTag)" }
                            if ($ext.OSType) { Write-Host "        OS Type: $($ext.OSType)" }
                            if ($ext.DOSCreationTime) { Write-Host "        DOS Creation: $($ext.DOSCreationTime)" }
                            if ($ext.DOSAccessTime) { Write-Host "        DOS Access: $($ext.DOSAccessTime)" }
                        }
                    } else {
                        Write-Host "      File Size (32-bit): $($lnk.FileSize)"
                    }
                }
            }
        }
    }
}