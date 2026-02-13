<#
.SYNOPSIS
    Parses a Windows .customDestinations-ms file, extracting all LNK details according to the MS-SHLLINK spec.
.DESCRIPTION
    Uses the Autopsy JLnkParser.java logic to correctly handle LinkInfo, including Unicode offsets.
.PARAMETER FilePath
    Path to the .customDestinations-ms file (may be quoted).
.PARAMETER AsJson
    Switch to output the parsed data as JSON instead of a formatted list.
.EXAMPLE
    .\Parse-CustomDestinationFull.ps1 -FilePath "883c2d2f4cd4330e.customDestinations-ms" -AsJson
#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$FilePath,
    [switch]$AsJson
)

# Helper functions
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

# Parse a null-terminated string at a given offset (ANSI or Unicode)
function Read-StringAt {
    param(
        [byte[]]$Bytes,
        [int]$Offset,
        [bool]$Unicode,
        [int]$MaxLength = -1
    )
    $pos = $Offset
    $chars = [System.Collections.Generic.List[char]]::new()
    $i = 0
    while ($pos -lt $Bytes.Length -and ($MaxLength -eq -1 -or $i -lt $MaxLength)) {
        if ($Unicode) {
            if ($pos + 1 -ge $Bytes.Length) { break }
            $c = [System.BitConverter]::ToChar($Bytes, $pos)
            $pos += 2
        } else {
            $c = [char]$Bytes[$pos]
            $pos += 1
        }
        if ($c -eq 0) { break }
        $chars.Add($c)
        $i++
    }
    return -join $chars
}

# Parse the LinkInfo block according to Autopsy JLnkParser.java
function Parse-LinkInfo {
    param(
        [byte[]]$Bytes,
        [int]$StartOffset
    )
    $result = [ordered]@{
        VolumeID = $null
        LocalBasePath = $null
        LocalBasePathUnicode = $null
        CommonPathSuffix = $null
        CommonPathSuffixUnicode = $null
        CommonNetworkRelativeLink = $null
    }

    $pos = $StartOffset
    $linkInfoSize = Read-UInt32 $Bytes $pos; $pos += 4
    $linkInfoHeaderSize = Read-UInt32 $Bytes $pos; $pos += 4
    $hasUnicodeOffsets = $linkInfoHeaderSize -ge 0x24  # 36 bytes
    $linkInfoFlags = Read-UInt32 $Bytes $pos; $pos += 4
    $volumeIDOffset = Read-UInt32 $Bytes $pos; $pos += 4
    $localBasePathOffset = Read-UInt32 $Bytes $pos; $pos += 4
    $commonNetworkRelativeLinkOffset = Read-UInt32 $Bytes $pos; $pos += 4
    $commonPathSuffixOffset = Read-UInt32 $Bytes $pos; $pos += 4
    $localBasePathOffsetUnicode = 0
    $commonPathSuffixOffsetUnicode = 0
    if ($hasUnicodeOffsets) {
        $localBasePathOffsetUnicode = Read-UInt32 $Bytes $pos; $pos += 4
        $commonPathSuffixOffsetUnicode = Read-UInt32 $Bytes $pos; $pos += 4
    }

    # VolumeID
    if (($linkInfoFlags -band 0x01) -eq 0x01) {  # VolumeIDAndLocalBasePath flag
        $volPos = $StartOffset + $volumeIDOffset
        $volSize = Read-UInt32 $Bytes $volPos
        $driveType = Read-UInt32 $Bytes ($volPos+4)
        $driveSerial = Read-UInt32 $Bytes ($volPos+8)
        $volumeLabelOffset = Read-UInt32 $Bytes ($volPos+12)
        $volumeLabel = ""
        if ($volumeLabelOffset -ne 0x14) {
            # ANSI label
            $volumeLabel = Read-StringAt -Bytes $Bytes -Offset ($volPos + $volumeLabelOffset) -Unicode $false -MaxLength ($volSize - 0x10)
        } else {
            # Unicode label (offset 0x14 indicates Unicode)
            $volumeLabelOffsetUnicode = Read-UInt32 $Bytes ($volPos+16)
            $volumeLabel = Read-StringAt -Bytes $Bytes -Offset ($volPos + $volumeLabelOffsetUnicode) -Unicode $true -MaxLength ($volSize - 0x14)
        }
        $result.VolumeID = [ordered]@{
            DriveType = $driveType
            SerialNumber = $driveSerial.ToString("X8")
            Label = $volumeLabel
        }
        # LocalBasePath (ANSI)
        if ($localBasePathOffset -ne 0) {
            $result.LocalBasePath = Read-StringAt -Bytes $Bytes -Offset ($StartOffset + $localBasePathOffset) -Unicode $false
        }
    }

    # CommonNetworkRelativeLink
    if (($linkInfoFlags -band 0x02) -eq 0x02) {  # CommonNetworkRelativeLinkAndPathSuffix flag
        $netPos = $StartOffset + $commonNetworkRelativeLinkOffset
        $netSize = Read-UInt32 $Bytes $netPos
        $netFlags = Read-UInt32 $Bytes ($netPos+4)
        $netNameOffset = Read-UInt32 $Bytes ($netPos+8)
        $unicodeNet = $netNameOffset -gt 0x14
        $deviceNameOffset = Read-UInt32 $Bytes ($netPos+12)
        $netType = Read-UInt32 $Bytes ($netPos+16)
        $netNameOffsetUnicode = 0
        $deviceNameOffsetUnicode = 0
        if ($unicodeNet) {
            $netNameOffsetUnicode = Read-UInt32 $Bytes ($netPos+20)
            $deviceNameOffsetUnicode = Read-UInt32 $Bytes ($netPos+24)
        }
        $netName = Read-StringAt -Bytes $Bytes -Offset ($netPos + $netNameOffset) -Unicode $false
        $netNameUnicode = if ($unicodeNet) { Read-StringAt -Bytes $Bytes -Offset ($netPos + $netNameOffsetUnicode) -Unicode $true } else { $null }
        $deviceName = if (($netFlags -band 0x02) -eq 0x02) { Read-StringAt -Bytes $Bytes -Offset ($netPos + $deviceNameOffset) -Unicode $false } else { $null }
        $deviceNameUnicode = if ($unicodeNet -and ($netFlags -band 0x02) -eq 0x02) { Read-StringAt -Bytes $Bytes -Offset ($netPos + $deviceNameOffsetUnicode) -Unicode $true } else { $null }
        $result.CommonNetworkRelativeLink = [ordered]@{
            NetName = $netName
            NetNameUnicode = $netNameUnicode
            DeviceName = $deviceName
            DeviceNameUnicode = $deviceNameUnicode
            NetType = $netType
            Flags = $netFlags
        }
    }

    # CommonPathSuffix (ANSI)
    if ($commonPathSuffixOffset -ne 0) {
        $result.CommonPathSuffix = Read-StringAt -Bytes $Bytes -Offset ($StartOffset + $commonPathSuffixOffset) -Unicode $false
    }

    # Unicode versions (if present)
    if ($hasUnicodeOffsets) {
        if ($localBasePathOffsetUnicode -ne 0) {
            $result.LocalBasePathUnicode = Read-StringAt -Bytes $Bytes -Offset ($StartOffset + $localBasePathOffsetUnicode) -Unicode $true
        }
        if ($commonPathSuffixOffsetUnicode -ne 0) {
            $result.CommonPathSuffixUnicode = Read-StringAt -Bytes $Bytes -Offset ($StartOffset + $commonPathSuffixOffsetUnicode) -Unicode $true
        }
    }

    return $result
}

# LNK parser
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

    # ---- LinkTargetIDList (skip if present) ----
    if ($result['LinkFlags'].ContainsKey('HasLinkTargetIDList')) {
        if ($remaining -lt 2) { return $null, 0 }
        $idListSize = Read-UInt16 $FileBytes $pos
        $pos += 2
        $remaining -= 2
        if ($idListSize -gt 0) {
            if ($remaining -lt $idListSize) { return $null, 0 }
            # Skip the IDList data
            $pos += $idListSize
            $remaining -= $idListSize
        }
    }

    # ---- LinkInfo (extract target path using C# method) ----
    $linkInfo = $null
    $targetPath = ""
    if ($result['LinkFlags'].ContainsKey('HasLinkInfo')) {
        if ($remaining -lt 4) { return $null, 0 }
        $linkInfoStart = $pos
        $linkInfoSize = Read-UInt32 $FileBytes $pos
        if ($remaining -lt $linkInfoSize) { return $null, 0 }

        # Read LinkInfo header fields
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

        # Extract LocalBasePath (ANSI)
        if ($localBasePathOffset -ne 0 -and ($linkInfoFlags -band 0x01) -eq 0x01) {
            $pathStart = $linkInfoStart + $localBasePathOffset
            $pathEnd = $linkInfoStart + $linkInfoSize
            # Read until null terminator
            $base = Read-StringUntilNull -Bytes $FileBytes -Start $pathStart -End $pathEnd -Unicode $false
        } else {
            $base = $null
        }

        # Extract CommonPathSuffix (ANSI)
        if ($commonPathSuffixOffset -ne 0) {
            $suffixStart = $linkInfoStart + $commonPathSuffixOffset
            $suffixEnd = $linkInfoStart + $linkInfoSize
            $suffix = Read-StringUntilNull -Bytes $FileBytes -Start $suffixStart -End $suffixEnd -Unicode $false
        } else {
            $suffix = $null
        }

        # Unicode versions if available
        if ($hasUnicodeOffsets) {
            if ($localBasePathOffsetUnicode -ne 0) {
                $pathStart = $linkInfoStart + $localBasePathOffsetUnicode
                $baseUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $pathStart -End ($linkInfoStart + $linkInfoSize) -Unicode $true
                if ($baseUnicode) { $base = $baseUnicode }  # Prefer Unicode
            }
            if ($commonPathSuffixOffsetUnicode -ne 0) {
                $suffixStart = $linkInfoStart + $commonPathSuffixOffsetUnicode
                $suffixUnicode = Read-StringUntilNull -Bytes $FileBytes -Start $suffixStart -End ($linkInfoStart + $linkInfoSize) -Unicode $true
                if ($suffixUnicode) { $suffix = $suffixUnicode }
            }
        }

        # Build target path
        if ($base) {
            if ($suffix) {
                if ($base.EndsWith('\')) { $targetPath = $base + $suffix }
                else { $targetPath = $base + '\' + $suffix }
            } else {
                $targetPath = $base
            }
        } elseif ($commonNetworkRelativeLinkOffset -ne 0) {
            # Could parse network path, but simplified here
            $targetPath = "[Network path]"
        }

        # Store LinkInfo for debugging
        $linkInfo = [ordered]@{
            LinkInfoSize = $linkInfoSize
            LocalBasePath = $base
            CommonPathSuffix = $suffix
        }

        $pos += $linkInfoSize
        $remaining -= $linkInfoSize
    }

    # ---- StringData (optional) ----
    $stringData = @{}
    if ($result['LinkFlags'].ContainsKey('HasName') -or
        $result['LinkFlags'].ContainsKey('HasRelativePath') -or
        $result['LinkFlags'].ContainsKey('HasWorkingDir') -or
        $result['LinkFlags'].ContainsKey('HasArguments') -or
        $result['LinkFlags'].ContainsKey('HasIconLocation')) {
        $stringTypes = @('Name', 'RelativePath', 'WorkingDir', 'Arguments', 'IconLocation')
        foreach ($type in $stringTypes) {
            $flagName = "Has$type"
            if ($result['LinkFlags'].ContainsKey($flagName)) {
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

# Helper to read a null-terminated string within a byte range
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

# Main parsing function (unchanged except for Parse-LNK)
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

# ---- Execute ----
$cleanPath = $FilePath.Trim('"')
$fileInfo = [System.IO.FileInfo]::New($cleanPath)
if (-not $fileInfo.Exists) { Write-Error "File not found: $($fileInfo.FullName)"; exit 1 }

$parsed = Parse-CustomDestination -Path $fileInfo.FullName

if ($parsed) {
    if ($AsJson) {
        $parsed | ConvertTo-Json -Depth 10
    } else {
        Write-Host "File: $($parsed.FileName)" -ForegroundColor Cyan
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
            }
        }
    }
}