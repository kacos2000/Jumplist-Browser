<#
.SYNOPSIS
    Parses a Windows .customDestinations-ms (Jump List) file and displays its group structure.
.DESCRIPTION
    This script reads a custom destinations file, locates group markers, and extracts
    group titles, entry counts, and data ranges. It does not parse the individual LNK entries.
    Based on the logic from the original Process-Custom function, but with efficiency improvements.
.PARAMETER FilePath
    Path to the .customDestinations-ms file to parse.
.PARAMETER AsJson
    Switch to output the group information as JSON instead of a formatted list.
.EXAMPLE
    .\Parse-CustomDestination.ps1 -FilePath "C:\Users\Example\AppData\Roaming\Microsoft\Windows\Recent\CustomDestinations\5f7b5f1e3b4f3d4a.customDestinations-ms"
.EXAMPLE
    .\Parse-CustomDestination.ps1 -FilePath "test.customDestinations-ms" -AsJson | ConvertFrom-Json
#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$FilePath,
    
    [switch]$AsJson
)

# Helper function: find all occurrences of a byte pattern in a byte array
function Find-Bytes {
    param(
        [byte[]]$Bytes,
        [byte[]]$Pattern
    )
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
            # Optionally move past the pattern to avoid overlapping (not required for this format)
            $i += $plen - 1
        }
    }
    return $indices
}

# Main parsing function
function Parse-CustomDestination {
    param($Path)

    # Read entire file as byte array
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
    } catch {
        Write-Error "Cannot read file: $_"
        return $null
    }

    $fs = $bytes.Length
    if ($fs -lt 512) {
        Write-Warning "File size is less than 512 bytes. This may not be a valid .customDestinations-ms file."
    }

    # Define byte patterns (same as original)
    $patternHeader = [byte[]]@(0x01, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46)
    $patternMarker = [byte[]]@(0xAB, 0xFB, 0xBF, 0xBA)

    # Find all occurrences of the patterns
    $headerIndices = Find-Bytes -Bytes $bytes -Pattern $patternHeader
    $markerIndices = Find-Bytes -Bytes $bytes -Pattern $patternMarker

    # If no marker found, the file is likely not a custom destinations file
    if ($markerIndices.Count -eq 0) {
        Write-Error "No group markers (AB FB BF BA) found. File may not be a valid .customDestinations-ms."
        return $null
    }

    $idx = if ($headerIndices.Count -gt 0) { $headerIndices[0] } else { $null }
    $tidx = $markerIndices

    # Read group count from bytes 4-7 (little-endian UInt32)
    if ($fs -lt 8) {
        Write-Error "File too small to contain header."
        return $null
    }
    $TypeCount = [System.BitConverter]::ToUInt32($bytes[4..7], 0)

    $groups = @()

    # ---- Parse the first group (special handling) ----
    if ($fs -ge 18) {
        $ECount = [System.BitConverter]::ToUInt16($bytes[16..17], 0)

        # Original logic:
        # If header pattern is at offset 20 AND first marker is NOT at 20, treat as "Tasks" group
        if ($idx -eq 20 -and $tidx[0] -ne 20) {
            $groups += [PSCustomObject]@{
                Title      = 'Tasks'
                EntryCount = $ECount
                Offset     = $idx
                End        = $tidx[0]
            }
        }
        # Else if ECound is not 65535 and first marker is not at 20, treat as named group
        elseif ($ECount -ne 65535 -and $tidx[0] -ne 20) {
            $TitleSize = [System.BitConverter]::ToUInt16($bytes[16..17], 0)
            $Title = ""
            if ($TitleSize -gt 0 -and (18 + $TitleSize * 2) -lt $idx) {
                $titleBytes = $bytes[18..(18 + $TitleSize * 2 - 1)]
                $Title = [System.Text.Encoding]::Unicode.GetString($titleBytes)
            }
            $off = 18 + $TitleSize * 2
            $EntryCount = 0
            if (($off + 1) -lt $idx) {
                $EntryCount = [System.BitConverter]::ToUInt16($bytes[$off..($off+1)], 0)
            }
            $groups += [PSCustomObject]@{
                Title      = $Title
                EntryCount = $EntryCount
                Offset     = $idx
                End        = $tidx[0]
            }
        }
        # If none of the conditions match, no first group is added (original behavior)
    }

    # ---- Parse additional groups (if any) ----
    if ($TypeCount -gt 1 -and $tidx.Count -gt 1) {
        for ($ti = 0; $ti -lt ($TypeCount - 1); $ti++) {
            # Ensure we have a next marker and that the group is large enough (>=76 bytes)
            if ($ti + 1 -ge $tidx.Count) { break }
            if (($tidx[$ti + 1] - $tidx[$ti]) -lt 76) { continue }

            $i = $tidx[$ti] + 4   # start of group header after marker

            # Read the 4-byte field at $i to determine if group is named (0) or unnamed (non-zero)
            if ($i + 3 -ge $fs) { continue }
            $t = [System.BitConverter]::ToUInt32($bytes[$i..($i+3)], 0)

            if ($t -eq 0) {
                # Named group: TitleSize (2 bytes), Title (Unicode), then EntryCount (2 bytes)
                if ($i + 5 -ge $fs) { continue }
                $TitleSize = [System.BitConverter]::ToUInt16($bytes[($i+4)..($i+5)], 0)
                $titleStart = $i + 6
                $titleEnd = $titleStart + $TitleSize * 2 - 1
                if ($titleEnd -ge $fs) { continue }
                $Title = [System.Text.Encoding]::Unicode.GetString($bytes[$titleStart..$titleEnd])
                $entryCountPos = $titleEnd + 1
                if ($entryCountPos + 1 -ge $fs) { continue }
                $EntryCount = [System.BitConverter]::ToUInt16($bytes[$entryCountPos..($entryCountPos+1)], 0)
                $groups += [PSCustomObject]@{
                    Title      = $Title
                    EntryCount = $EntryCount
                    Offset     = $i
                    End        = $tidx[$ti + 1]
                }
            } else {
                # Unnamed group: "Tasks", EntryCount at $i+4
                if ($i + 5 -ge $fs) { continue }
                $EntryCount = [System.BitConverter]::ToUInt16($bytes[($i+4)..($i+5)], 0)
                $groups += [PSCustomObject]@{
                    Title      = 'Tasks'
                    EntryCount = $EntryCount
                    Offset     = $i
                    End        = $tidx[$ti + 1]
                }
            }
        }
    }

    # Add file metadata
    $fileName = Split-Path $Path -Leaf
    $appId = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
    $result = [PSCustomObject]@{
        File        = $Path
        FileName    = $fileName
        AppID       = $appId
        GroupCount  = $TypeCount
        Groups      = $groups
    }

    return $result
}

# Execute parsing
$File = [System.IO.FileInfo]::New($FilePath.Trim('"'))
$parsed = Parse-CustomDestination -Path $file.FullName

if ($parsed) {
    if ($AsJson) {
        # Convert to JSON (depth to handle nested groups)
        $parsed | ConvertTo-Json -Depth 3
    } else {
        # Display friendly output
        Write-Host "File: $($parsed.FileName)" -ForegroundColor Cyan
        Write-Host "AppID: $($parsed.AppID)" -ForegroundColor Cyan
        Write-Host "Group Count (from header): $($parsed.GroupCount)" -ForegroundColor Cyan
        Write-Host "`nGroups Found:" -ForegroundColor Yellow
        foreach ($g in $parsed.Groups) {
            Write-Host "  [$($g.Offset)..$($g.End)] '$($g.Title)' - Entries: $($g.EntryCount)" -ForegroundColor Green
        }
    }
}