<#
    --------------------------------------------------------------------------------
     Costas Katsavounidis © 2022-2024
	 https://github.com/kacos2000/Jumplist-Browser
    --------------------------------------------------------------------------------
#>

#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
	[void][reflection.assembly]::Load('WindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('PresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35')
	[void][reflection.assembly]::Load('PresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35')
#endregion Import Assemblies

$SelfPath = [System.Windows.Forms.Application]::ExecutablePath
$SelfName = Split-Path $SelfPath -Leaf

try
{
	if ($SelfName -eq 'JumplistBrowser.exe') # Add Jumplist only for the compiled App
	{
		# Create New JumpTask & set the properties
		$JumplistTask1 = [System.Windows.Shell.JumpTask]::New()
		$JumplistTask1.ApplicationPath = "https://github.com/kacos2000/Jumplist-Browser"
		$JumplistTask1.Title = "Open GitHub"
		$JumplistTask1.Description = "Jumplist Browser on GitHub"
		# $JumplistTask1.IconResourcePath = [System.Windows.Forms.Application]::ExecutablePath
		$JumplistTask1.CustomCategory = "JumplistBrowser"
		# Create New JumpTask & set the properties
		$JumplistTask2 = [System.Windows.Shell.JumpTask]::New()
		$JumplistTask2.ApplicationPath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('System'), 'calc.exe')
		$JumplistTask2.Title = "Calculator"
		$JumplistTask2.Description = "Open Calculator"
		$JumplistTask2.IconResourcePath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('System'), 'calc.exe')
		$JumplistTask2.CustomCategory = "Windows Tools"
		# Create New JumpTask & set the properties
		$JumplistTask3 = [System.Windows.Shell.JumpTask]::New()
		$JumplistTask3.ApplicationPath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('System'), 'notepad.exe')
		$JumplistTask3.Title = "Notepad"
		$JumplistTask3.Description = "Open Notepad"
		$JumplistTask3.IconResourcePath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('System'), 'notepad.exe')
		$JumplistTask3.CustomCategory = "Windows Tools"
		# Create New JumpTask & set the properties
		$JumplistTask4 = [System.Windows.Shell.JumpTask]::New()
		$JumplistTask4.ApplicationPath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('System'), 'regedt32.exe')
		$JumplistTask4.Title = "Registry Editor"
		$JumplistTask4.Description = "Open Registry Editor"
		$JumplistTask4.IconResourcePath = "%windir%\regedit.exe."
		$JumplistTask4.CustomCategory = "Windows Tools"
		# Recent Items Folder Path
		$recentfolder = [System.Environment]::GetFolderPath("Recent")
		if (!!(Test-Path -Path $recentfolder)) # Open with JumplistBrowser
		{
			# Create New JumpTask & set the properties
			$JumplistTask5 = [System.Windows.Shell.JumpTask]::New()
			$JumplistTask5.ApplicationPath = [System.Windows.Forms.Application]::ExecutablePath
			$JumplistTask5.Title = "Open 'Recent' folder"
			$JumplistTask5.Description = "Open 'Recent' folder in Jumplist Browser"
			$JumplistTask5.IconResourcePath = [System.Windows.Forms.Application]::ExecutablePath
			$JumplistTask5.Arguments = $recentfolder
			$JumplistTask5.CustomCategory = "JumplistBrowser"
		}
		# Create New JumpTask & set the properties
		$JumplistTask6 = [System.Windows.Shell.JumpTask]::New()
		$JumplistTask6.ApplicationPath = [System.Windows.Forms.Application]::ExecutablePath
		$JumplistTask6.Title = "Open Jumplist Browser"
		$JumplistTask6.Description = "Open Jumplist Browser"
		$JumplistTask6.IconResourcePath = [System.Windows.Forms.Application]::ExecutablePath
		$JumplistTask6.CustomCategory = "JumplistBrowser"
		# Add Terminal if installed
		$TerminalPath = $TerminalPath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('LocalApplicationData'), 'Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe')
		if (!!(Test-Path -Path $TerminalPath))
		{
			# Create New JumpTask & set the properties
			$JumplistTask8 = [System.Windows.Shell.JumpTask]::New()
			$JumplistTask8.ApplicationPath = $TerminalPath
			$JumplistTask8.Title = "Terminal"
			$JumplistTask8.Description = "Open Terminal (PowerShell/cmd)"
			$JumplistTask8.IconResourcePath = "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe"
			# [System.Uri]::new("ms-appx:///ProfileIcons/{61c54bbd-c2c6-5271-96e7-009a87ff44bf}.png")
			$JumplistTask8.CustomCategory = "Windows Tools"
		}
		if (!!(Test-Path -Path $recentfolder)) # Open with Explorer
		{
			# Create New JumpTask & set the properties
			$JumplistTask9 = [System.Windows.Shell.JumpTask]::New()
			$JumplistTask9.ApplicationPath = $recentfolder
			$JumplistTask9.Title = "Recent"
			$JumplistTask9.Description = "Open the 'Recent' items Folder"
			$JumplistTask9.IconResourcePath = $recentfolder
			$JumplistTask9.CustomCategory = "Open with Explorer"
			if (!![System.IO.Directory]::EnumerateDirectories($recentfolder))
			{
				# Create New JumpTask & set the properties
				$JumplistTask11 = [System.Windows.Shell.JumpTask]::New()
				$JumplistTask11.ApplicationPath = [System.IO.Path]::Combine($recentfolder, "automaticDestinations")
				$JumplistTask11.Title = "automaticDestinations Folder"
				$JumplistTask11.Description = "Open the 'automaticDestinations' Folder"
				$JumplistTask11.IconResourcePath = "%SystemRoot%\System32\SHELL32.dll"
				$JumplistTask11.IconResourceIndex = 3
				$JumplistTask11.CustomCategory = "Open with Explorer"
				# Create New JumpTask & set the properties
				$JumplistTask12 = [System.Windows.Shell.JumpTask]::New()
				$JumplistTask12.ApplicationPath = [System.IO.Path]::Combine($recentfolder, "customDestinations")
				$JumplistTask12.Title = "customDestinations Folder"
				$JumplistTask12.Description = "Open the 'customDestinations' Folder"
				$JumplistTask12.IconResourcePath = "%SystemRoot%\System32\SHELL32.dll"
				$JumplistTask12.IconResourceIndex = 3
				$JumplistTask12.CustomCategory = "Open with Explorer"
			}
		}
		# Add HxD if installed
		$HxDpath = [System.IO.Path]::Combine([System.environment]::GetFolderPath('ProgramFiles'), 'HxD\HxD.exe')
		if (!!(Test-Path -Path $HxDpath))
		{
			# Create New JumpTask & set the properties
			$JumplistTask7 = [System.Windows.Shell.JumpTask]::New()
			$JumplistTask7.ApplicationPath = $HxDpath
			$JumplistTask7.Title = "HxD"
			$JumplistTask7.Description = "Open HxD Hex Editor"
			$JumplistTask7.IconResourcePath = $HxDpath
			$JumplistTask7.CustomCategory = "Windows Tools"
		}
		
		if ($null -eq [System.Windows.Application]::Current) # Create new jumplist
		{
			$null = [System.Windows.Application]::New()
			$Jumplist = [System.Windows.Shell.JumpList]::New()
		}
		else # Get Current Jumplist
		{
			$Jumplist = [System.Windows.Shell.JumpList]::GetJumpList([System.Windows.Application]::Current)
			if (!!$Jumplist.JumpItems) # Get Current Jumplist and reset it
			{
				$Jumplist.JumpItems.Clear()
				[System.GC]::Collect()
			}
		}
		
		if (!!$Jumplist)
		{
			$Jumplist.JumpItems.Add($JumplistTask1) # GitHub
			$Jumplist.JumpItems.Add($JumplistTask2) # Calculator
			$Jumplist.JumpItems.Add($JumplistTask3) # Notepad
			$Jumplist.JumpItems.Add($JumplistTask4) # regedt32
			$Jumplist.JumpItems.Add($JumplistTask5) # Open Recent in JB
			$Jumplist.JumpItems.Add($JumplistTask6) # Open JB
			$Jumplist.JumpItems.Add($JumplistTask8) # Terminal
			$Jumplist.JumpItems.Add($JumplistTask7) # HxD
			$Jumplist.JumpItems.Add($JumplistTask9) # Recent Folder
			# $Jumplist.JumpItems.Add($JumplistTask10)
			$Jumplist.JumpItems.Add($JumplistTask11) # automaticDestinations
			$Jumplist.JumpItems.Add($JumplistTask12) # customDestinations
			$Jumplist.ShowFrequentCategory = $true
			$Jumplist.ShowRecentCategory = $false
			[System.Windows.Shell.JumpList]::SetJumpList([System.Windows.Application]::Current, $Jumplist)
			$Jumplist.Apply()
		}
	}
}
catch { $null }

<#
	.SYNOPSIS
		The Main function starts the project application.
	
	.DESCRIPTION
		A detailed description of the Main function.
	
	.PARAMETER Commandline
		$Commandline contains the complete argument string passed to the script packager executable.
	
	.NOTES
		Use this function to initialize your script and to call GUI forms.
	
	.NOTES
		To get the console output in the Packager (Forms Engine) use:
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
function Main
{
	param
	(
		[String]$Commandline
	)
	
	if ((Show-MainForm_psf) -eq 'OK')
	{
		
	}
	$script:ExitCode = 0 #Set the exit code for the Packager
}

#endregion Source: Startup.pss

#region Source: MainForm.psf
function Show-MainForm_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('PresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35')
	[void][reflection.assembly]::Load('PresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$Jumplist_Browser = New-Object 'System.Windows.Forms.Form'
	$splitcontainer1 = New-Object 'System.Windows.Forms.SplitContainer'
	$menustrip1 = New-Object 'System.Windows.Forms.MenuStrip'
	$statusstrip1 = New-Object 'System.Windows.Forms.StatusStrip'
	$fileToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$OpenFolder = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolStripSeparator = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$exitToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$folderbrowserdialog1 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$Status = New-Object 'System.Windows.Forms.ToolStripStatusLabel'
	$treeview1 = New-Object 'System.Windows.Forms.TreeView'
	$treeview2 = New-Object 'System.Windows.Forms.TreeView'
	$contextmenustrip1 = New-Object 'System.Windows.Forms.ContextMenuStrip'
	$CopyNode1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator6 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$toolstripseparator7 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$Exit1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$Process1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator8 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$contextmenustrip2 = New-Object 'System.Windows.Forms.ContextMenuStrip'
	$CopyNode2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$CopyAll2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator9 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$Expand2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator10 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$Exit2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$Open = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$About = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$Expand1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$Collapse1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator5 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$ExpandAll1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$CollapseAll1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$Collapse2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator4 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$ExpandAll2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$CollapseAll2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$SaveNodestoTxt = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator3 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$savefiledialog1 = New-Object 'System.Windows.Forms.SaveFileDialog'
	$OpenFileWith = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$CopyFullFilePath = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$CopyNode2Tag = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$SaveStreamToFile = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripRefresh = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$GetMRUlist = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator2 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$imagelist1 = New-Object 'System.Windows.Forms.ImageList'
	$imagelist2 = New-Object 'System.Windows.Forms.ImageList'
	$toolstripseparator1 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$SaveLnkToJson = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator11 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$SaveStream = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$notifyicon1 = New-Object 'System.Windows.Forms.NotifyIcon'
	$contextmenustrip3 = New-Object 'System.Windows.Forms.ContextMenuStrip'
	$toolstrip3_About = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstrip3_Exit = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator12 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$toolstripseparator13 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$toolstrip3_GitHub = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$TreeSearch = New-Object 'System.Windows.Forms.ToolStripTextBox'
	$Tree1Search = New-Object 'System.Windows.Forms.ToolStripComboBox'
	$GetNavPane = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$MinimizeWindow = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$RestoreWindow = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator14 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$GetTaskBand = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$GetStartPage2 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$GetLockScreen = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$GetSearchMRU = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/16cb4ca1-9339-4d0c-a68d-bf1d6cc0f943
	$Jumplist_Browser_Load = {
		
		# Check .Net version
		# https://learn.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed
		$netversion = Get-ItemPropertyValue -LiteralPath 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release
		if ($netversion -lt 528040)
		{
			$ErrorMessage = ".NET Framework Version 4.8 (Windows 10 May 2019) or later was not detected"
			[void][System.Windows.Forms.MessageBox]::Show($Jumplist_Browser, "$($ErrorMessage)", "LNK & Jumplist Browser", "OK", "Error")
			$Jumplist_Browser.Close()
		}
		
		# Get MainWindowHandle Handle
		$handle = [System.Diagnostics.Process]::GetCurrentProcess().MainWindowHandle
		# [System.Windows.Application]::Current
		
		# Set Culture Parameters
		$Culture = [System.Globalization.CultureInfo]::CreateSpecificCulture([System.Globalization.CultureInfo]::CurrentCulture.Name)
		$Culture.NumberFormat.NumberDecimalSeparator = ","
		$Culture.NumberFormat.NumberGroupSeparator = "."
		$Culture.DateTimeFormat.ShortDatePattern = 'd/M/yyyy' # For DOS Date Conversion
		$Culture.DateTimeFormat.ShortTimePattern = 'h:mm tt'  # For DOS Time Conversion
		[System.Threading.Thread]::CurrentThread.CurrentCulture = $Culture
		
		function Get-DPI
		{
			[OutputType([single])]
			param
			(
				[IntPtr]$Handle = [IntPtr]::Zero
			)
			
			$g = [System.Drawing.Graphics]::FromHwnd($Handle)
			$dpi = $g.DpiX
			$g.Dispose()
			
			return $dpi
		}
		
		$splitcontainer1.AutoScroll = $true
		$script:dpi = Get-DPI $Jumplist_Browser.Handle
		$Status.Text = "DPI: $($script:dpi)"
		if ($script:dpi -gt 96)
		{
			$treeview1.ImageList = $imagelist1 # HighDPI (24*24)
			$statusstrip1.ImageScalingSize = New-Object System.Drawing.Size (24, 24)
			$menustrip1.ImageScalingSize = New-Object System.Drawing.Size (24, 24)
			for ($i = 1; $i -lt 4; $i++)
			{
				(Get-Variable contextmenustrip$i -ValueOnly).ImageScalingSize = New-Object System.Drawing.Size (24, 24)
			}
		}
		else
		{
			$treeview1.ImageList = $imagelist2 # Regular (16 * 16)
			$statusstrip1.ImageScalingSize = New-Object System.Drawing.Size (16, 16)
			$menustrip1.ImageScalingSize = New-Object System.Drawing.Size (16, 16)
			for ($i = 1; $i -lt 4; $i++)
			{
				(Get-Variable contextmenustrip$i -ValueOnly).ImageScalingSize = New-Object System.Drawing.Size (16, 16)
			}
		}
		
		$Status.ToolTipText = "Click to copy the Status text"
		# Get current user access level & check if user is Administrator
		# $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
		# $IsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
		$key0 = 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage2'
		$key1 = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\NavPane'
		$key2 = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband'
		$key3 = 'Software\Microsoft\Windows\CurrentVersion\Search\RecentApps'
		$key4 = 'Software\Microsoft\Windows\CurrentVersion\Search\JumplistData'
		$val0 = Test-Path "HKCU:$($key0)" -ErrorAction SilentlyContinue
		$val1 = Test-Path "HKCU:$($key1)" -ErrorAction SilentlyContinue
		$val2 = Test-Path "HKCU:$($key2)" -ErrorAction SilentlyContinue
		$val3 = Test-Path "HKCU:$($key3)" -ErrorAction SilentlyContinue
		$val4 = Test-Path "HKCU:$($key4)" -ErrorAction SilentlyContinue
		if (!!$val0) { $GetStartPage2.Visible = $true }
		if (!!$val1) { $GetNavPane.Visible = $true }
		if (!!$val2) { $GetTaskBand.Visible = $true }
		if (!!$val3 -or !!$val4) { $GetSearchMRU.Visible = $true }
		# $JumplistBrowserPath = [System.Windows.Forms.Application]::ExecutablePath
	}
	
	#region Control Helper Functions
	function Update-ToolStripComboBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ToolStripComboBox.
		
		.DESCRIPTION
			Use this function to dynamically load items into the ToolStripComboBox control.
		
		.PARAMETER ToolStripComboBox
			The ToolStripComboBox control you want to add items to.
		
		.PARAMETER Items
			The object or objects you wish to load into the ToolStripComboBox's Items collection.
		
		.PARAMETER Append
			Adds the item(s) to the ToolStripComboBox without clearing the Items collection.
		
		.EXAMPLE
			Update-ToolStripComboBox $toolStripComboBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Update-ToolStripComboBox $toolStripComboBox1 "Red" -Append
			Update-ToolStripComboBox $toolStripComboBox1 "White" -Append
			Update-ToolStripComboBox $toolStripComboBox1 "Blue" -Append
		
		.NOTES
			Additional information about the function.
	#>
		
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ToolStripComboBox]$ToolStripComboBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[switch]$Append
		)
		
		if (-not $Append)
		{
			$ToolStripComboBox.Items.Clear()
		}
		
		if ($Items -is [Object[]])
		{
			$ToolStripComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$ToolStripComboBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ToolStripComboBox.Items.Add($obj)
			}
			$ToolStripComboBox.EndUpdate()
		}
		else
		{
			$ToolStripComboBox.Items.Add($Items)
		}
	}
	
	function Show-NotifyIcon
	{
	<#
		.SYNOPSIS
			Displays a NotifyIcon's balloon tip message in the taskbar's notification area.
		
		.DESCRIPTION
			Displays a NotifyIcon's a balloon tip message in the taskbar's notification area.
			
		.PARAMETER NotifyIcon
	     	The NotifyIcon control that will be displayed.
		
		.PARAMETER BalloonTipText
	     	Sets the text to display in the balloon tip.
		
		.PARAMETER BalloonTipTitle
			Sets the Title to display in the balloon tip.
		
		.PARAMETER BalloonTipIcon	
			The icon to display in the ballon tip.
		
		.PARAMETER Timeout	
			The time the ToolTip Balloon will remain visible in milliseconds. 
			Default: 0 - Uses windows default.
	#>
		param (
			[Parameter(Mandatory = $true, Position = 0)]
			[ValidateNotNull()]
			[System.Windows.Forms.NotifyIcon]$NotifyIcon,
			[Parameter(Mandatory = $true, Position = 1)]
			[ValidateNotNullOrEmpty()]
			[String]$BalloonTipText,
			[Parameter(Position = 2)]
			[String]$BalloonTipTitle = '',
			[Parameter(Position = 3)]
			[System.Windows.Forms.ToolTipIcon]$BalloonTipIcon = 'None',
			[Parameter(Position = 4)]
			[int]$Timeout = 0
		)
		
		if ($null -eq $NotifyIcon.Icon)
		{
			#Set a Default Icon otherwise the balloon will not show
			$NotifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Windows.Forms.Application]::ExecutablePath)
		}
		
		$NotifyIcon.ShowBalloonTip($Timeout, $BalloonTipTitle, $BalloonTipText, $BalloonTipIcon)
	}
	
	# https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes?view=net-7.0
	# https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants 
	# C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\winnt.h
	$FileAttributesEnum = [Ordered]@{
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
	}
	
	# https://learn.microsoft.com/en-us/windows/win32/shell/sfgao
	# ..Include\10.0.22621.0\um\ShObjIdl_core.h
	$SFGAOflags = [Ordered]@{
		'0x00000001' = 'Can be Copied'
		'0x00000002' = 'Can be Moved'
		'0x00000004' = 'Can be Linked'
		'0x00000008' = 'Supports BindToObject' # supports BindToObject(IID_IStorage)
		'0x00000010' = 'Can be Renamed' # Objects can be renamed
		'0x00000020' = 'Can be Deleted'
		'0x00000040' = 'Has Property Sheet'
		'0x00000100' = 'Is DropTarget' # Objects are drop target
		#'0x00000177' = 'Capability Mask' # This flag is a mask for the capability attributes: SFGAO_CANCOPY, SFGAO_CANMOVE, SFGAO_CANLINK, SFGAO_CANRENAME, SFGAO_CANDELETE, SFGAO_HASPROPSHEET, and SFGAO_DROPTARGET. Callers normally do not use this value.
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
	}
	
	# Sources:
	# https://github.com/EricZimmerman/ExtensionBlocks/blob/e0cef99c81776641e68a3f436bfcde21f6807334/ExtensionBlocks/Utils.cs
	# 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\propkey.h'
	# 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\um\functiondiscoverykeys.h' 
	# 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared\hidclass.h'
	# 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22000.0\shared\ntddser.h'
	$formatIDHashTable = [Ordered]@{
		"46588ae2-4cbc-4338-bbfc-139326986dce\4"	 = "SID"
		"DABD30ED-0043-4789-A7F8-D013A4736622\100"   = "ItemFolderPathDisplayNarrow"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\0"	 = "FindData"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\1"	 = "Network Resource"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\2"	 = "DescriptionID"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\3"	 = "Which Folder"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\4"	 = "Network Location"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\5"	 = "ComputerName"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\6"	 = "NamespaceCLSID"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\8"	 = "ItemPathDisplayNarrow"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\9"	 = "PerceivedType"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\10"    = "Computer Simple Name"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\11"    = "ItemType"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\12"    = "FileCount"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\14"    = "TotalFileSize"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\22"    = "Max Stack Count"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\23"    = "List Description"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\24"    = "ParsingName"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\25"    = "SFGAOFlags"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\26"    = "Order"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\27"    = "Computer Description"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\29"    = "ContainedItems"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\30"    = "ParsingPath"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\31"    = "Network Provider"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\32"    = "Delegate ID List"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\33"    = "IsSendToTarget"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\34"    = "Hide On Desktop"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\35"    = "Network Places Default Name"
		"28636aa6-953d-11d2-b5d6-00c04fd918d0\36"    = "Storage System Type"
		"28636AA6-953D-11D2-B5D6-00C04FD918D0\37"    = "ItemSubType"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\2"	 = "AppUserModel RelaunchCommand"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\3"	 = "AppUserModel RelaunchIconResource"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\4"	 = "AppUserModel RelaunchDisplayNameResource"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\5"	 = "AppUserModel ID"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\6"	 = "AppUserModel IsDestListSeparator"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\7"	 = "App User Model Is DestList Link"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\8"	 = "AppUserModel ExcludeFromShowInNewInstall"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\9"	 = "AppUserModel PreventPinning"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\10"    = "App User Model Best Shortcut"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\11"    = "AppUserModel IsDualMode"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\12"    = "AppUserModel StartPinOption"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\13"    = "App User Model Relevance"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\14"    = "App User Model Host Environment"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\15"    = "App User Model Package Install Path"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\16"    = "App User Model Record State"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\17"    = "App User Model Package Family Name"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\18"    = "App User Model Installed By"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\19"    = "App User Model Parent ID"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\20"    = "App User Model Activation Context"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\21"    = "App User Model Package Full Name"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\22"    = "App User Model Package Relative Application ID"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\23"    = "App User Model Excluded From Launcher"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\24"    = "App User Model AppCompat ID"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\25"    = "App User Model Run Flags"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\26"    = "AppUserModel ToastActivatorCLSID"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\27"    = "App User Model DestList Provided Title"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\28"    = "App User Model DestList Provided Description"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\29"    = "App User Model DestList Logo Uri"
		"9f4c2855-9f79-4b39-a8d0-e1d42de1d5f3\30"    = "App User Model DestList Provided Group Name"
		"446D16B1-8DAD-4870-A748-402EA43D788C\100"   = "ThumbnailCacheId"
		"446D16B1-8DAD-4870-A748-402EA43D788C\104"   = "VolumeId"
		"446d16b1-8dad-4870-a748-402ea43d788c\105"   = "Tooltip Thumbnail Stream"
		"fb8d2d7b-90d1-4e34-bf60-6eac09922bbf\2"	 = "WinX Hash"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\3"	 = "Subject"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\4"	 = "Author"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\5"	 = "Keywords"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\6"	 = "Comment"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\7"	 = "Document Template"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\8"	 = "Document LastAuthor"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\9"	 = "Document RevisionNumber"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\10"    = "Document TotalEditingTime"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\11"    = "Document DatePrinted"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\12"    = "Document DateCreated"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\13"    = "Document DateSaved"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\14"    = "Document PageCount"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\15"    = "Document WordCount"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\16"    = "Document CharacterCount"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\17"    = "Thumbnail"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\18"    = "ApplicationName"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\19"    = "Document Security"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\24"    = "HighKeywords"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\25"    = "LowKeywords"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\26"    = "MediumKeywords"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\27"    = "ThumbnailStream"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\2"	 = "Publisher Display Name"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\3"	 = "Software Registered Owner"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\4"	 = "Software Registered Company"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\5"	 = "Software AppId"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\6"	 = "Software Support Url"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\7"	 = "Software Support Telephone"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\8"	 = "Software Help Link"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\9"	 = "Software Install Location"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\10"    = "Software Install Source"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\11"    = "Software Date Installed"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\12"    = "Software Support Contact Name"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\13"    = "Software ReadMe Url"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\14"    = "Software Update Info Url"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\15"    = "Software Times Used"
		"841E4F90-FF59-4D16-8947-E81BBFFAB36D\16"    = "Software DateLastUsed"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\17"    = "Software Tasks File Url"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\18"    = "Software Parent Name"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\19"    = "Software Product ID"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\20"    = "Software Comments"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\997"   = "Software Null Preview Total Size"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\998"   = "Software Null Preview Subtitle"
		"841e4f90-ff59-4d16-8947-e81bbffab36d\999"   = "Software Null Preview Title"
		"86d40b4d-9069-443c-819a-2a54090dccec\2"	 = "Tile Small Image Location"
		"86d40b4d-9069-443c-819a-2a54090dccec\4"	 = "Tile Background Color"
		"86d40b4d-9069-443c-819a-2a54090dccec\5"	 = "Tile Foreground Color"
		"86d40b4d-9069-443c-819a-2a54090dccec\11"    = "Tile Display Name"
		"86d40b4d-9069-443c-819a-2a54090dccec\12"    = "Tile Image Location"
		"86d40b4d-9069-443c-819a-2a54090dccec\13"    = "Tile Wide 310x150 Logo Path"
		"86d40b4d-9069-443c-819a-2a54090dccec\14"    = "Tile Unknown Flags"
		"86d40b4d-9069-443c-819a-2a54090dccec\15"    = "Tile Badge Logo Path"
		"86d40b4d-9069-443c-819a-2a54090dccec\16"    = "Tile Suite Display Name"
		"86d40b4d-9069-443c-819a-2a54090dccec\17"    = "Tile Suite Sor tName"
		"86d40b4d-9069-443c-819a-2a54090dccec\18"    = "Tile Display Name Language"
		"86d40b4d-9069-443c-819a-2a54090dccec\19"    = "Tile Square 310x310 Logo Path"
		"86d40b4d-9069-443c-819a-2a54090dccec\20"    = "Tile Square 70x70 Logo Path"
		"86d40b4d-9069-443c-819a-2a54090dccec\21"    = "Tile Fence Post"
		"86d40b4d-9069-443c-819a-2a54090dccec\22"    = "Tile Install Progress"
		"86d40b4d-9069-443c-819a-2a54090dccec\23"    = "Tile Encoded Target Path"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\2"	 = "ItemFolderNameDisplay"
		"b725f130-47ef-101a-a5f1-02608c9eebac\3"	 = "Search ClassID"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\4"	 = "ItemTypeText"
		"b725f130-47ef-101a-a5f1-02608c9eebac\8"	 = "File Index"
		"b725f130-47ef-101a-a5f1-02608c9eebac\9"	 = "Search Last Change USN"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\10"    = "ItemNameDisplay"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\12"    = "Size"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\13"    = "FileAttributes"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\14"    = "DateModified"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\15"    = "DateCreated"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\16"    = "DateAccessed"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\18"    = "FileAllocationSize"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\19"    = "Search Contents"
		"b725f130-47ef-101a-a5f1-02608c9eebac\20"    = "Search ShortName"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\21"    = "FileFRN"
		"b725f130-47ef-101a-a5f1-02608c9eebac\22"    = "Search Scope"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\23"    = "ItemNameSortOverride"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\24"    = "ItemNameDisplayWithoutExtension"
		"B725F130-47EF-101A-A5F1-02608C9EEBAC\25"    = "FolderNameDisplay"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\2"	 = "Message BccAddress"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\3"	 = "Message BccName"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\4"	 = "Message CcAddress"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\5"	 = "Message CcName"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\6"	 = "ItemFolderPathDisplay"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\7"	 = "ItemPathDisplay"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\9"	 = "Communication AccountName"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\10"    = "IsRead"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\11"    = "Importance"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\12"    = "FlagStatus"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\13"    = "Message FromAddress"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\14"    = "Message FromName"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\15"    = "Message Store"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\16"    = "Message ToAddress"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\17"    = "Message ToName"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\18"    = "Contact WebPage"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\19"    = "Message DateSent"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\20"    = "Message DateReceived"
		"E3E0584C-B788-4A5A-BB20-7F5A44C9ACDD\21"    = "Message AttachmentNames"
		"00000000-0000-0000-0000-000000000000\0"	 = "Null"
		"000214a1-0000-0000-c000-000000000046}\9"    = "Status"
		"00BC20A3-BD48-4085-872C-A88D77F5097E\105"   = "Music ComposerSortOverride"
		"00F58A38-C54B-4C40-8696-97235980EAE1\100"   = "Calendar Resources"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\101"   = "Contact JobInfo1YomiCompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\102"   = "Contact JobInfo1CompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\103"   = "Contact JobInfo1Title"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\104"   = "Contact JobInfo1OfficeLocation"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\105"   = "Contact JobInfo1Manager"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\106"   = "Contact JobInfo1Department"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\107"   = "Contact JobInfo2YomiCompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\108"   = "Contact JobInfo2CompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\109"   = "Contact JobInfo2Title"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\110"   = "Contact JobInfo2OfficeLocation"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\112"   = "Contact JobInfo2Manager"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\113"   = "Contact JobInfo2Department"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\114"   = "Contact JobInfo3YomiCompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\115"   = "Contact JobInfo3CompanyName"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\116"   = "Contact JobInfo3Title"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\117"   = "Contact JobInfo3OfficeLocation"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\118"   = "Contact JobInfo3Manager"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\119"   = "Contact JobInfo3Department"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\120"   = "Contact JobInfo1CompanyAddress"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\121"   = "Contact JobInfo2CompanyAddress"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\123"   = "Contact JobInfo3CompanyAddress"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\124"   = "Contact Webpage2"
		"00F63DD8-22BD-4A5D-BA34-5CB0B9BDCB03\125"   = "Contact Webpage3"
		"026E516E-B814-414B-83CD-856D6FEF4822\3"	 = "Devices InterfaceEnabled"
		"026E516E-B814-414B-83CD-856D6FEF4822\4"	 = "Devices InterfaceClassGuid"
		"026E516E-B814-414B-83CD-856D6FEF4822\6"	 = "Devices RestrictedInterface"
		"029C0252-5B86-46C7-ACA0-2769FFC8E3D4\100"   = "GPS LatitudeRef"
		"02B0F689-A914-4E45-821D-1DDA452ED2C4\100"   = "GPS LongitudeNumerator"
		"03089873-8EE8-4191-BD60-D31F72B7900B\100"   = "Contact DisplayOtherPhoneNumbers"
		"0337ECEC-39FB-4581-A0BD-4C4CC51E9914\100"   = "Photo ApertureNumerator"
		"048658AD-2DB8-41A4-BBB6-AC1EF1207EB1\100"   = "ItemClassType"
		"05e932b1-7ca2-491f-bd69-99b4cb266cbb\2"	 = "Connected Search Disambiguation Text"
		"06704B0C-E830-4C81-9178-91E4E95A80A0\2"	 = "Devices NotificationStore"
		"06704B0C-E830-4C81-9178-91E4E95A80A0\3"	 = "Devices Notification"
		"084D8A0A-E6D5-40DE-BF1F-C8820E7C877C\100"   = "Task CompletionStatus"
		"08A65AA1-F4C9-43DD-9DDF-A33D8E7EAD85\100"   = "Contact HomeAddressCountry"
		"08C7CC5F-60F2-4494-AD75-55E3E0B5ADD0\100"   = "Task Owner"
		"08F6D7C2-E3F2-44FC-AF1E-5AA5C81A2D3E\100"   = "Photo MaxAperture"
		"09329b74-40a3-4c68-bf07-af9a572f607c\100"   = "Is Folder"
		"0933F3F5-4786-4F46-A8E8-D64DD37FA521\100"   = "Photo FocalPlaneXResolutionDenominator"
		"09429607-582D-437F-84C3-DE93A2B24C3C\100"   = "Calendar OptionalAttendeeNames"
		"09736039-456b-4219-ba3e-ec573b58cf97\2"	 = "Secondary Tile Is Uninstalled"
		"09EDD5B6-B301-43C5-9990-D00302EFFD46\100"   = "Media AverageLevel"
		"0A7B84EF-0C27-463F-84EF-06C5070001BE\10"    = "DeviceInterface PrinterName"
		"0abe4d16-9384-426b-b41a-eac3c8e0f147\2"	 = "Search Content Snippet"
		"0ADEF160-DB3F-4308-9A21-06237B16FA2A\100"   = "Contact HomeAddressStreet"
		"0B48F35A-BE6E-4F17-B108-3C4073D1669A\15"    = "Device PrinterURL"
		"0B63E343-9CCC-11D0-BCDB-00805FCCCE04\2"	 = "Search UrlToIndex"
		"0B63E343-9CCC-11D0-BCDB-00805FCCCE04\12"    = "Search UrlToIndexWithModificationTime"
		"0B63E343-9CCC-11D0-BCDB-00805FCCCE04\23"    = "Search IsClosedDirectory"
		"0B63E343-9CCC-11D0-BCDB-00805FCCCE04\24"    = "Search IsFullyContained"
		"0b63e343-9ccc-11d0-bcdb-00805fccce04\25"    = "Search Provider Class"
		"0b63e343-9ccc-11d0-bcdb-00805fccce04\26"    = "Search Provider Web Domain"
		"0b63e343-9ccc-11d0-bcdb-00805fccce04\27"    = "Search Provider Result Limit"
		"0B63E350-9CCC-11D0-BCDB-00805FCCCE04\5"	 = "MIMEType"
		"0B63E350-9CCC-11D0-BCDB-00805FCCCE04\8"	 = "Search GatherTime"
		"0b63e350-9ccc-11d0-bcdb-00805fccce04\9"	 = "Search Access Count"
		"0b63e350-9ccc-11d0-bcdb-00805fccce04\11"    = "Search Last Indexed Total Time"
		"0B8BB018-2725-4B44-92BA-7933AEB2DDE7\2"	 = "Contact AccountPictureDynamicVideo"
		"0B8BB018-2725-4B44-92BA-7933AEB2DDE7\3"	 = "Contact AccountPictureLarge"
		"0B8BB018-2725-4B44-92BA-7933AEB2DDE7\4"	 = "Contact AccountPictureSmall"
		"0BA7D6C3-568D-4159-AB91-781A91FB71E5\100"   = "Calendar RequiredAttendeeAddresses"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\2"	 = "Devices AepContainer Children"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\3"	 = "Devices AepContainer CanPair"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\4"	 = "Devices AepContainer IsPaired"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\6"	 = "Devices AepContainer Manufacturer"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\7"	 = "Devices AepContainer ModelName"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\8"	 = "Devices AepContainer ModelIds"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\9"	 = "Devices AepContainer Categories"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\11"    = "Devices AepContainer IsPresent"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\12"    = "Devices AepContainer ContainerId"
		"0BBA1EDE-7566-4F47-90EC-25FC567CED2A\13"    = "Devices AepContainer ProtocolIds"
		"0BE1C8E7-1981-4676-AE14-FDD78F05A6E7\100"   = "Message SenderAddress"
		"0be3fd71-3f87-40e0-aead-0294cf674635\2"	 = "Shell Is Dav Resource"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\2"	 = "Supplemental AlbumID"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\3"	 = "Supplemental ResourceId"
		"0C840A88-B043-466D-9766-D4B26DA3FA77\100"   = "Photo SubjectDistanceDenominator"
		"0CB2BF5A-9EE7-4A86-8222-F01E07FDADAF\100"   = "PropGroup PhotoAdvanced"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\3"	 = "FileDescription"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\4"	 = "FileVersion"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\5"	 = "InternalName"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\6"	 = "OriginalFileName"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\7"	 = "Software ProductName"
		"0cef7d53-fa64-11d1-a203-0000f81fedee\8"	 = "Software Product Version"
		"0CEF7D53-FA64-11D1-A203-0000F81FEDEE\9"	 = "Trademarks"
		"0cef7d53-fa64-11d1-a203-0000f81fedee\11"    = "Platform"
		"0CF8FB02-1837-42F1-A697-A7017AA289B9\100"   = "GPS DOP"
		"0DA41CFA-D224-4A18-AE2F-596158DB4B3A\100"   = "Message SenderName"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\2"	 = "Launcher Order"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\3"	 = "Launcher Group ID"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\6"	 = "Launcher View ID"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\7"	 = "Launcher App State"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\8"	 = "Launcher Tile Size"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\9"	 = "Launcher Group Name"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\10"    = "Launcher Splash Screen Image"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\11"    = "Launcher TileSize Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\12"    = "Launcher ItemPosition Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\13"    = "Launcher View ID Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\14"    = "Launcher Group Membership Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\15"    = "Launcher Group Name Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\16"    = "Launcher Default Tile Size"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\17"    = "Launcher Placeholder Expiry Candidate"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\18"    = "Launcher Placeholder Expiry Candidate Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\19"    = "Launcher Item Flags"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\20"    = "Launcher Group Position Timestamp"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\21"    = "Launcher Store Category"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\22"    = "Launcher Win Store Category Name"
		"0ded77b3-c614-456c-ae5b-285b38d7b01b\23"    = "Launcher SubgroupID"
		"0F55CDE2-4F49-450D-92C1-DCD16301B1B7\100"   = "GPS LatitudeDecimal"
		"10984E0A-F9F2-4321-B7EF-BAF195AF4319\100"   = "ParentalRatingReason"
		"10B24595-41A2-4E20-93C2-5761C1395F32\100"   = "GPS ImgDirectionDenominator"
		"10DABE05-32AA-4C29-BF1A-63E2D220587F\100"   = "Image ImageID"
		"1173f62a-2a55-4f62-aed6-8c7112e0f7a3\5"	 = "Force Full Text"
		"11D6336B-38C4-4EC9-84D6-EB38D0B150AF\100"   = "Contact OtherEmailAddresses"
		"125491F4-818F-46B2-91B5-D537753617B2\100"   = "GPS Status"
		"12ea418f-d8cd-4cdf-9b23-457eaac7ff0d\100"   = "Communication Directory Server"
		"12fa14f5-c6fe-4545-bce2-1ed6cb6b8422\2"	 = "Connected Search Link Text"
		"13673F42-A3D6-49F6-B4DA-AE46E0C5237C\2"	 = "Devices DevObjectType"
		"13EB7FFC-EC89-4346-B19D-CCC6F1784223\101"   = "Music AlbumTitleSortOverride"
		"14977844-6B49-4AAD-A714-A4513BF60460\100"   = "Contact FirstName"
		"149C0B69-2C2D-48FC-808F-D318D78C4636\2"	 = "Volume IsMappedDrive"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\259"   = "Image Compression"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\271"   = "Photo CameraManufacturer"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\272"   = "Photo CameraModel"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\273"   = "Photo CameraSerialNumber"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\274"   = "Photo Orientation"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\305"   = "SoftwareUsed"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\18248" = "Photo Event"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\18258" = "DateImported"
		"14b81da1-0135-4d31-96d9-6cbfc9671a99\33432" = "Image Copyright"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\33434" = "Photo ExposureTime"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\33437" = "Photo FNumber"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\34850" = "Photo ExposureProgram"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\34855" = "Photo ISOSpeed"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\36867" = "Photo DateTaken"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37377" = "Photo ShutterSpeed"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37378" = "Photo Aperture"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37380" = "Photo ExposureBias"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37382" = "Photo SubjectDistance"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37383" = "Photo MeteringMode"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37384" = "Photo LightSource"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37385" = "Photo Flash"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\37386" = "Photo FocalLength"
		"14b81da1-0135-4d31-96d9-6cbfc9671a99\40096" = "Image Property Bag"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\40961" = "Image ColorSpace"
		"14B81DA1-0135-4D31-96D9-6CBFC9671A99\41483" = "Photo FlashEnergy"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\2"	 = "Devices WiFiDirect InterfaceAddress"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\3"	 = "Devices WiFiDirect InterfaceGuid"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\4"	 = "Devices WiFiDirect GroupId"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\5"	 = "Devices WiFiDirect IsConnected"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\6"	 = "Devices WiFiDirect IsVisible"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\7"	 = "Devices WiFiDirect IsLegacyDevice"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\8"	 = "Devices WiFiDirect MiracastVersion"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\9"	 = "Devices WiFiDirect IsMiracastLcpSupported"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\10"    = "Devices WiFiDirect Services"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\11"    = "Devices WiFiDirect SupportedChannelList"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\12"    = "Devices WiFiDirect InformationElements"
		"1506935D-E3E7-450F-8637-82233EBE5F6E\13"    = "Devices WiFiDirect DeviceAddress"
		"16473C91-D017-4ED9-BA4D-B6BAA55DBCF8\100"   = "GPS ImgDirection"
		"16CBB924-6500-473B-A5BE-F1599BCBE413\100"   = "Photo DigitalZoomNumerator"
		"16E634EE-2BFF-497B-BD8A-4341AD39EEB9\100"   = "GPS LatitudeDenominator"
		"16EA4042-D6F4-4BCA-8349-7C78D30FB333\100"   = "Photo ShutterSpeedNumerator"
		"176DC63C-2688-4E89-8143-A347800F25E9\6"	 = "Contact JobTitle"
		"176DC63C-2688-4E89-8143-A347800F25E9\7"	 = "Contact OfficeLocation"
		"176DC63C-2688-4E89-8143-A347800F25E9\20"    = "Contact HomeTelephone"
		"176DC63C-2688-4E89-8143-A347800F25E9\25"    = "Contact PrimaryTelephone"
		"176DC63C-2688-4E89-8143-A347800F25E9\35"    = "Contact MobileTelephone"
		"176DC63C-2688-4E89-8143-A347800F25E9\47"    = "Contact Birthday"
		"176DC63C-2688-4E89-8143-A347800F25E9\48"    = "Contact PrimaryEmailAddress"
		"176DC63C-2688-4E89-8143-A347800F25E9\65"    = "Contact HomeAddressCity"
		"176DC63C-2688-4E89-8143-A347800F25E9\69"    = "Contact PersonalTitle"
		"176dc63c-2688-4e89-8143-a347800f25e9\70"    = "Contact Given Name"
		"176DC63C-2688-4E89-8143-A347800F25E9\71"    = "Contact MiddleName"
		"176DC63C-2688-4E89-8143-A347800F25E9\73"    = "Contact Suffix"
		"176DC63C-2688-4E89-8143-A347800F25E9\74"    = "Contact NickName"
		"176DC63C-2688-4E89-8143-A347800F25E9\75"    = "Contact Prefix"
		"1804d1fb-9fa4-441d-a536-76468ac43307\100"   = "WebDav Path"
		"182C1EA6-7C1C-4083-AB4B-AC6C9F4ED128\100"   = "GPS DestLongitudeRef"
		"188C1F91-3C40-4132-9EC5-D8B03B72A8A2\100"   = "Calendar ResponseStatus"
		"18BBD425-ECFD-46EF-B612-7B4A6034EDA0\100"   = "Contact PrimaryAddressPostalCode"
		"19B51FA6-1F92-4A5C-AB48-7DF0ABD67444\100"   = "Image ResolutionUnit"
		"1A701BF6-478C-4361-83AB-3701BB053C58\100"   = "Photo Brightness"
		"1A9BA605-8E7C-4D11-AD7D-A50ADA18BA1B\2"	 = "Message Participants"
		"1B5439E7-EBA1-4AF8-BDD7-7AF1D4549493\100"   = "RecordedTV StationName"
		"1B97738A-FDFC-462F-9D93-1957E08BE90C\100"   = "Photo FNumberNumerator"
		"30c8eef4-a832-41e2-ab32-e3c3ca28fd29\2"	 = "Home Grouping"
		"30c8eef4-a832-41e2-ab32-e3c3ca28fd29\3"	 = "Home Sort Order"
		"30c8eef4-a832-41e2-ab32-e3c3ca28fd29\4"	 = "Home Is Pinned"
		"30c8eef4-a832-41e2-ab32-e3c3ca28fd29\5"	 = "Home PropList Sort"
		"30c8eef4-a832-41e2-ab32-e3c3ca28fd29\6"	 = "Home Item Folder Path Display"
		"3143BF7C-80A8-4854-8880-E2E40189BDD0\100"   = "Message AttachmentContents"
		"315B9C8D-80A9-4EF9-AE16-8E746DA51D70\100"   = "Calendar IsRecurring"
		"318A6B45-087F-4DC2-B8CC-05359551FC9E\100"   = "Photo RelatedSoundFile"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\2"	 = "Devices WiFiDirectServices ServiceAddress"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\3"	 = "Devices WiFiDirectServices ServiceName"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\4"	 = "Devices WiFiDirectServices ServiceInformation"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\5"	 = "Devices WiFiDirectServices AdvertisementId"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\6"	 = "Devices WiFiDirectServices ServiceConfigMethods"
		"31B37743-7C5E-4005-93E6-E953F92B82E9\7"	 = "Devices WiFiDirectServices RequestServiceInformation"
		"328d8b21-7729-4bfc-954c-902b329d56b0\2"	 = "Sync Copy In"
		"32bcb03c-7f34-4e3f-bbb2-ebe63629f5e4\100"   = "Is Simple Item"
		"33DCF22B-28D5-464C-8035-1EE9EFD25278\100"   = "GPS LongitudeRef"
		"341796F1-1DF9-4B1C-A564-91BDEFA43877\100"   = "Photo PhotometricInterpretation"
		"346C8BD1-2E6A-4C45-89A4-61B78E8E700F\100"   = "IsIncomplete"
		"35DBE6FE-44C3-4400-AAAE-D2C799C407E8\100"   = "GPS TrackRef"
		"3602C812-0F3B-45F0-85AD-603468D69423\100"   = "GPS Date"
		"3633DE59-6825-4381-A49B-9F6BA13A1471\2"	 = "Devices PlaybackState"
		"3633DE59-6825-4381-A49B-9F6BA13A1471\3"	 = "Devices PlaybackTitle"
		"3633DE59-6825-4381-A49B-9F6BA13A1471\4"	 = "Devices RemainingDuration"
		"3633DE59-6825-4381-A49B-9F6BA13A1471\5"	 = "Devices PlaybackPositionPercent"
		"364028DA-D895-41FE-A584-302B1BB70A76\100"   = "Contact DisplayBusinessPhoneNumbers"
		"364B6FA9-37AB-482A-BE2B-AE02F60D4318\100"   = "Image CompressedBitsPerPixel"
		"37ebd11f-7e72-4ebc-9d4c-c790f8c277c2\2"	 = "Device Interface Spb Controller Friendly Name"
		"38965063-EDC8-4268-8491-B7723172CF29\100"   = "Contact EmailAddress2"
		"38D43380-D418-4830-84D5-46935A81C5C6\32"    = "Security AllowedEnterpriseDataProtectionIdentities"
		"39A7F922-477C-48DE-8BC8-B28441E342E3\100"   = "Project"
		"39B77F4F-A104-4863-B395-2DB2AD8F7BC1\100"   = "Contact ConnectedServiceDisplayName"
		"3A372292-7FCA-49A7-99D5-E47BB2D4E7AB\100"   = "GPS DestLatitudeDenominator"
		"3B2CE006-5E61-4FDE-BAB8-9B8AAC9B26DF\5"	 = "Devices Aep ProtocolId"
		"3B2CE006-5E61-4FDE-BAB8-9B8AAC9B26DF\8"	 = "Devices Aep AepId"
		"3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD\100"   = "Contact Gender"
		"3C8CEE58-D4F0-4CF9-B756-4E5D24447BCD\101"   = "Contact GenderValue"
		"3d658d4d-bc38-464a-b555-418d554a8df8\100"   = "Fonts Description"
		"3d75e4f5-a391-4952-81f7-c7072fe53025\100"   = "File Reparse Point Tag"
		"3F08E66F-2F44-4BB9-A682-AC35D2562322\100"   = "Image CompressionText"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\2"	 = "Extensions Type"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\3"	 = "Extensions Date Last Used"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\4"	 = "Extensions Used Count"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\5"	 = "Extensions Blocked Count"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\6"	 = "Extensions CLSID"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\7"	 = "Extensions Status"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\8"	 = "Check State"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\9"	 = "Extensions Suspect"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\10"    = "Extensions File Name"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\11"    = "Extensions File Path"
		"3f5d9b45-5e9f-4d5c-8a5e-403181bf177b\12"    = "Extensions Flags"
		"3F8472B5-E0AF-4DB2-8071-C53FE76AE7CE\100"   = "DueDate"
		"402B5934-EC5A-48C3-93E6-85E86A2D934E\100"   = "Contact BusinessAddressCity"
		"41CF5AE0-F75A-4806-BD87-59C7D9248EB9\100"   = "FileName"
		"425D69E5-48AD-4900-8D80-6EB6B8D0AC86\100"   = "GPS DestLongitudeDenominator"
		"428040AC-A177-4C8A-9760-F6F761227F9A\100"   = "Communication DateItemExpires"
		"42864DFD-9DA4-4F77-BDED-4AAD7B256735\100"   = "Photo GainControlDenominator"
		"4340A6C5-93FA-4706-972C-7B648008A5A7\8"	 = "Devices Parent"
		"4340A6C5-93FA-4706-972C-7B648008A5A7\9"	 = "Devices Children"
		"436F2667-14E2-4FEB-B30A-146C53B5B674\100"   = "Link Arguments"
		"43F8D7B7-A444-4F87-9383-52271C9B915C\100"   = "DateArchived"
		"446F787F-10C4-41CB-A6C4-4D0343551597\100"   = "Contact BusinessAddressState"
		"4530d076-b598-4a81-8813-9b11286ef6ea\2"	 = "Fonts Font Embeddability"
		"4530d076-b598-4a81-8813-9b11286ef6ea\5"	 = "Fonts Type"
		"4530d076-b598-4a81-8813-9b11286ef6ea\7"	 = "Fonts File Names"
		"4596208c-32fa-41d2-9695-af0cb9e8dcfe\100"   = "Stack Thumbnail Cache Ids"
		"45EAE747-8E2A-40AE-8CBF-CA52ABA6152A\100"   = "FlagColorText"
		"4679C1B5-844D-4590-BAF5-F322231F1B81\100"   = "GPS LongitudeDecimal"
		"467EE575-1F25-4557-AD4E-B8B58B0D9C15\100"   = "GPS Satellites"
		"4684FE97-8765-4842-9C13-F006447B178C\100"   = "RecordedTV OriginalBroadcastDate"
		"46AC629D-75EA-4515-867F-6DC4321C5844\100"   = "GPS AltitudeRef"
		"46B4E8DE-CDB2-440D-885C-1658EB65B914\100"   = "Note ColorText"
		"47166B16-364F-4AA0-9F31-E2AB3DF449C3\100"   = "GPS DOPNumerator"
		"4776CAFA-BCE4-4CB1-A23E-265E76D8EB11\100"   = "Note Color"
		"47A96261-CB4C-4807-8AD3-40B9D9DBC6BC\100"   = "GPS DestLongitude"
		"48FD6EC8-8A12-4CDF-A03E-4EC5A511EDDE\100"   = "StartDate"
		"49237325-A95A-4F67-B211-816B2D45D2E0\100"   = "Photo Saturation"
		"49691c90-7e17-101a-a91c-08002b2ecda9\2"	 = "Search Results Rank"
		"49691C90-7E17-101A-A91C-08002B2ECDA9\3"	 = "Search Rank"
		"49691C90-7E17-101A-A91C-08002B2ECDA9\4"	 = "Search HitCount"
		"49691C90-7E17-101A-A91C-08002B2ECDA9\5"	 = "Search EntryID"
		"49691c90-7e17-101a-a91c-08002b2ecda9\8"	 = "Search Reverse File Name"
		"49691C90-7E17-101A-A91C-08002B2ECDA9\9"	 = "ItemUrl"
		"49691c90-7e17-101a-a91c-08002b2ecda9\10"    = "Content Url"
		"49691c90-7e17-101a-a91c-08002b2ecda9\15"    = "Search Row Id"
		"49691C90-7E17-101A-A91C-08002B2ECDA9\21"    = "Search QueryPropertyHits"
		"49691c90-7e17-101a-a91c-08002b2ecda9\22"    = "Search Completion"
		"49691c90-7e17-101a-a91c-08002b2ecda9\28"    = "Search Result Set Aggregate Attributes"
		"49753869-849c-4323-a41f-26d73f28b53b\100"   = "Fonts Vendors"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\2"	 = "Devices SignalStrength"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\3"	 = "Devices TextMessages"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\4"	 = "Devices NewPictures"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\5"	 = "Devices MissedCalls"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\6"	 = "Devices Voicemail"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\7"	 = "Devices NetworkName"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\8"	 = "Devices NetworkType"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\9"	 = "Devices Roaming"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\10"    = "Devices BatteryLife"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\11"    = "Devices ChargingState"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\12"    = "Devices StorageCapacity"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\13"    = "Devices StorageFreeSpace"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\14"    = "Devices StorageFreeSpacePercent"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\22"    = "Devices BatteryPlusCharging"
		"49CD1F76-5626-4B17-A4E8-18B4AA1A2213\23"    = "Devices BatteryPlusChargingText"
		"49D1091F-082E-493F-B23F-D2308AA9668C\100"   = "PropList NonPersonal"
		"49eb6558-c09c-46dc-8668-1f848c290d0b\1"	 = "Shell Exclusion"
		"49eb6558-c09c-46dc-8668-1f848c290d0b\3"	 = "Shell Item Offline Status"
		"4ac903f8-e780-4e4b-b7b8-4d00a99804fc\100"   = "Home Group Sharing Status"
		"4b486401-5468-4381-9b5a-42df4cb49f53\100"   = "Fonts Category"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\100"   = "Start Menu Group"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\101"   = "Start Menu Run Command"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\102"   = "Start Menu Query"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\103"   = "Start Menu Group Item"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\104"   = "Start Menu Include In Scope"
		"4bd13b3d-e68b-44ec-89ee-7611789d4070\105"   = "Start Menu Result Source Id"
		"4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4\2"	 = "DeviceInterface Serial UsbVendorId"
		"4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4\3"	 = "DeviceInterface Serial UsbProductId"
		"4C6BF15C-4C03-4AAC-91F5-64C0F852BCF4\4"	 = "DeviceInterface Serial PortName"
		"4D1EBEE8-0803-4774-9842-B77DB50265E9\2"	 = "Storage Portable"
		"4D1EBEE8-0803-4774-9842-B77DB50265E9\3"	 = "Storage RemovableMedia"
		"4D1EBEE8-0803-4774-9842-B77DB50265E9\4"	 = "Storage SystemCritical"
		"4e9cfc01-5d36-406a-83cd-4e7423923604\2"	 = "Offline Sync Time"
		"4f289a46-2bbb-4ae8-9eda-e5e034707a71\2"	 = "Lzh Folder Compressed Size"
		"4f289a46-2bbb-4ae8-9eda-e5e034707a71\3"	 = "Lzh Folder CRC16"
		"4f289a46-2bbb-4ae8-9eda-e5e034707a71\4"	 = "Lzh Folder Method"
		"4f289a46-2bbb-4ae8-9eda-e5e034707a71\5"	 = "Lzh Folder Ratio"
		"4FFFE4D0-914F-4AC4-8D6F-C9C61DE169B1\100"   = "Photo FocalPlaneYResolution"
		"502CFEAB-47EB-459C-B960-E6D8728F7701\100"   = "ZoneIdentifier"
		"502CFEAB-47EB-459C-B960-E6D8728F7701\101"   = "LastWriterPackageFamilyName"
		"502CFEAB-47EB-459C-B960-E6D8728F7701\102"   = "AppZoneIdentifier"
		"5068BCDF-D697-4D85-8C53-1F1CDAB01763\100"   = "Contact DisplayHomePhoneNumbers"
		"508161FA-313B-43D5-83A1-C1ACCF68622C\100"   = "Contact OtherAddress"
		"51236583-0C4A-4FE8-B81F-166AEC13F510\100"   = "Devices AppPackageFamilyName"
		"51236583-0C4A-4FE8-B81F-166AEC13F510\123"   = "Devices GlyphIcon"
		"51EC3F47-DD50-421D-8769-334F50424B1E\100"   = "Photo SharpnessText"
		"53DA57CF-62C0-45C4-81DE-7610BCEFD7F5\100"   = "Calendar ShowTimeAsText"
		"540B947E-8B40-45BC-A8A2-6A0B894CBDA2\5"	 = "Devices Present"
		"540B947E-8B40-45BC-A8A2-6A0B894CBDA2\6"	 = "Devices DeviceHasProblem"
		"540B947E-8B40-45BC-A8A2-6A0B894CBDA2\9"	 = "Devices PhysicalDeviceLocation"
		"54b3a473-59aa-445b-aecd-77541ba8b7c9\2"	 = "User Name"
		"54b3a473-59aa-445b-aecd-77541ba8b7c9\3"	 = "User Display Name"
		"54b3a473-59aa-445b-aecd-77541ba8b7c9\5"	 = "User Profile Path"
		"5567bf77-2be2-4222-befa-d0c9c9cc4b6e\2"	 = "Velocity Feature Id"
		"55E98597-AD16-42E0-B624-21599A199838\100"   = "Photo ExposureTimeDenominator"
		"560C36C0-503A-11CF-BAA1-00004C752A9A\2"	 = "Search AutoSummary"
		"560C36C0-503A-11CF-BAA1-00004C752A9A\3"	 = "Search QueryFocusedSummary"
		"560C36C0-503A-11CF-BAA1-00004C752A9A\4"	 = "Search QueryFocusedSummaryWithFallback"
		"56310920-2491-4919-99CE-EADB06FAFDB2\100"   = "Contact BusinessHomePage"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\2"	 = "Music Artist"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\4"	 = "Music AlbumTitle"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\5"	 = "Media Year"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\7"	 = "Music TrackNumber"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\11"    = "Music Genre"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\12"    = "Music Lyrics"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\13"    = "Music AlbumArtist"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\33"    = "Music ContentGroupDescription"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\34"    = "Music InitialKey"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\35"    = "Music BeatsPerMinute"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\36"    = "Music Conductor"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\37"    = "Music PartOfSet"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\38"    = "Media SubTitle"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\39"    = "Music Mood"
		"56A3372E-CE9C-11D2-9F0E-006097C686F6\100"   = "Music AlbumID"
		"56C90E9D-9D46-4963-886F-2E1CD9A694EF\100"   = "Contact HomeEmailAddresses"
		"57086c23-86c6-478f-afb2-236188c8f47f\2"	 = "Taskbar Tab Active"
		"57086c23-86c6-478f-afb2-236188c8f47f\3"	 = "Taskbar Tab List"
		"5741cf9c-56fe-485b-8901-4786449e188d\100"   = "Fonts Designed For"
		"59569556-0A08-4212-95B9-FAE2AD6413DB\2"	 = "Devices Notifications NewVoicemail"
		"596fd41b-af9b-4ba8-9b49-33b16f16678c\100"   = "Fonts Styles"
		"59D49E61-840F-4AA9-A939-E2099B7F6399\100"   = "GPS ProcessingMethod"
		"59DDE9F2-5253-40EA-9A8B-479E96C6249A\100"   = "Photo ContrastText"
		"5ab5c75f-15e1-4d65-924a-04754567243c\2"	 = "Setting Host Id"
		"5ab5c75f-15e1-4d65-924a-04754567243c\3"	 = "Setting Setting Id"
		"5ab5c75f-15e1-4d65-924a-04754567243c\4"	 = "Setting Page Id"
		"5ab5c75f-15e1-4d65-924a-04754567243c\5"	 = "Setting Group Id"
		"5ab5c75f-15e1-4d65-924a-04754567243c\6"	 = "Setting Condition"
		"5ab5c75f-15e1-4d65-924a-04754567243c\7"	 = "Setting Glyph"
		"5ab5c75f-15e1-4d65-924a-04754567243c\8"	 = "Setting Glyph Rtl"
		"5BF396D4-5EB2-466F-BDE9-2FB3F2361D6E\100"   = "Calendar ShowTimeAs"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\1"	 = "History Url Hash"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\2"	 = "Link Target Url"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\3"	 = "Url Scheme"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\4"	 = "Url HostName"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\5"	 = "History Url Extra Info"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\6"	 = "History Code Page"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\7"	 = "History Visit Count"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\8"	 = "History Is History"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\9"	 = "History I sDownload"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\10"    = "History Download Location"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\11"    = "History Download Size"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\12"    = "History Favorite IconKey"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\13"    = "History Is Favorite"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\14"    = "History Is Offline Favorite"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\15"    = "History Is Pinned Favorite"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\16"    = "History Is Typed Url"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\17"    = "History Is Top Level"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\18"    = "History Is Feed"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\19"    = "History Keywords"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\20"    = "History User Keywords"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\21"    = "Link Description"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\22"    = "History User Description"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\23"    = "Link Date Visited"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\24"    = "History Icon Bits"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\25"    = "Icon Path"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\26"    = "Icon Index"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\27"    = "History Icon Date"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\28"    = "History Points"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\29"    = "History Sessions"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\33"    = "History Subscription Cookie"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\34"    = "History Tracking"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\35"    = "Link Working Folder Path"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\36"    = "Link Hot Key"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\37"    = "Link Show Cmd"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\38"    = "Link Whats New"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\39"    = "History Date Changed"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\40"    = "History Flags"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\41"    = "History Watch"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\42"    = "History Favorite Icon Hash"
		"5cbf2787-48cf-4208-b90e-ee5e5d420294\43"    = "Icon Secondary Stream Name"
		"5CDA5FC8-33EE-4FF3-9094-AE7BD8868C4D\100"   = "IsDeleted"
		"5cde9f0e-1de4-4453-96a9-56e8832efa3d\1"	 = "Computer Domain Name"
		"5cde9f0e-1de4-4453-96a9-56e8832efa3d\2"	 = "Computer Workgroup"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\2"	 = "IsPinnedToNameSpaceTree"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\3"	 = "IsDefaultSaveLocation"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\4"	 = "IsSearchOnlyItem"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\5"	 = "IsDefaultNonOwnerSaveLocation"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\6"	 = "OwnerSID"
		"5d76b67f-9b3d-44bb-b6ae-25da4f638a67\7"	 = "Is Default Save Location For Display"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\8"	 = "IsLocationSupported"
		"5d76b67f-9b3d-44bb-b6ae-25da4f638a67\9"	 = "Library Location Support Status"
		"5D76B67F-9B3D-44BB-B6AE-25DA4F638A67\10"    = "DefaultSaveLocationDisplay"
		"5d76b67f-9b3d-44bb-b6ae-25da4f638a67\11"    = "Default Save Location Icon Container"
		"5DA84765-E3FF-4278-86B0-A27967FBDD03\100"   = "IsFlagged"
		"5DC2253F-5E11-4ADF-9CFE-910DD01E3E70\100"   = "Contact Hobbies"
		"5F5AFF6A-37E5-4780-97EA-80C7565CF535\34"    = "Security EncryptionOwners"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\2"	 = "Devices Aep Bluetooth Cod Major"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\3"	 = "Devices Aep Bluetooth Cod Minor"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\4"	 = "Devices Aep Bluetooth Cod Services LimitedDiscovery"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\5"	 = "Devices Aep Bluetooth Cod Services Positioning"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\6"	 = "Devices Aep Bluetooth Cod Services Networking"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\7"	 = "Devices Aep Bluetooth Cod Services Rendering"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\8"	 = "Devices Aep Bluetooth Cod Services Capturing"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\9"	 = "Devices Aep Bluetooth Cod Services ObjectXfer"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\10"    = "Devices Aep Bluetooth Cod Services Audio"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\11"    = "Devices Aep Bluetooth Cod Services Telephony"
		"5FBD34CD-561A-412E-BA98-478A6B0FEF1D\12"    = "Devices Aep Bluetooth Cod Services Information"
		"61478C08-B600-4A84-BBE4-E99C45F0A072\100"   = "Photo SaturationText"
		"61872CF7-6B5E-4B4B-AC2D-59DA84459248\100"   = "PropGroup Media"
		"62d2d9ab-8b64-498d-b865-402d4796f865\3"	 = "Location Empty String"
		"6336B95E-C7A7-426D-86FD-7AE3D39C84B4\100"   = "Photo WhiteBalanceText"
		"635E9051-50A5-4BA2-B9DB-4ED056C77296\100"   = "Contact FullName"
		"63C25B20-96BE-488F-8788-C09C407AD812\100"   = "Contact PrimaryAddressStreet"
		"641064ba-9329-47e6-8f36-5fa81aa461a0\2"	 = "OneNote Page Edit History"
		"641064ba-9329-47e6-8f36-5fa81aa461a0\3"	 = "OneNote Tagged Notes"
		"641064ba-9329-47e6-8f36-5fa81aa461a0\4"	 = "OneNote Linked Note Uri"
		"6444048F-4C8B-11D1-8B70-080036B11A03\3"	 = "Image HorizontalSize"
		"6444048F-4C8B-11D1-8B70-080036B11A03\4"	 = "Image VerticalSize"
		"6444048F-4C8B-11D1-8B70-080036B11A03\5"	 = "Image HorizontalResolution"
		"6444048F-4C8B-11D1-8B70-080036B11A03\6"	 = "Image VerticalResolution"
		"6444048F-4C8B-11D1-8B70-080036B11A03\7"	 = "Image BitDepth"
		"6444048F-4C8B-11D1-8B70-080036B11A03\12"    = "Media FrameCount"
		"6444048F-4C8B-11D1-8B70-080036B11A03\13"    = "Image Dimensions"
		"64440490-4C8B-11D1-8B70-080036B11A03\2"	 = "Audio Format"
		"64440490-4C8B-11D1-8B70-080036B11A03\3"	 = "Media Duration"
		"64440490-4C8B-11D1-8B70-080036B11A03\4"	 = "Audio EncodingBitrate"
		"64440490-4C8B-11D1-8B70-080036B11A03\5"	 = "Audio SampleRate"
		"64440490-4C8B-11D1-8B70-080036B11A03\6"	 = "Audio SampleSize"
		"64440490-4C8B-11D1-8B70-080036B11A03\7"	 = "Audio ChannelCount"
		"64440490-4C8B-11D1-8B70-080036B11A03\8"	 = "Audio StreamNumber"
		"64440490-4C8B-11D1-8B70-080036B11A03\9"	 = "Audio StreamName"
		"64440490-4C8B-11D1-8B70-080036B11A03\10"    = "Audio Compression"
		"64440491-4C8B-11D1-8B70-080036B11A03\2"	 = "Video StreamName"
		"64440491-4C8B-11D1-8B70-080036B11A03\3"	 = "Video FrameWidth"
		"64440491-4C8B-11D1-8B70-080036B11A03\4"	 = "Video FrameHeight"
		"64440491-4C8B-11D1-8B70-080036B11A03\6"	 = "Video FrameRate"
		"64440491-4C8B-11D1-8B70-080036B11A03\8"	 = "Video EncodingBitrate"
		"64440491-4C8B-11D1-8B70-080036B11A03\9"	 = "Video SampleSize"
		"64440491-4C8B-11D1-8B70-080036B11A03\10"    = "Video Compression"
		"64440491-4C8B-11D1-8B70-080036B11A03\11"    = "Video StreamNumber"
		"64440491-4C8B-11D1-8B70-080036B11A03\42"    = "Video HorizontalAspectRatio"
		"64440491-4C8B-11D1-8B70-080036B11A03\43"    = "Video TotalBitrate"
		"64440491-4C8B-11D1-8B70-080036B11A03\44"    = "Video FourCC"
		"64440491-4C8B-11D1-8B70-080036B11A03\45"    = "Video VerticalAspectRatio"
		"64440491-4C8B-11D1-8B70-080036B11A03\46"    = "Video TranscodedForSync"
		"64440491-4C8B-11D1-8B70-080036B11A03\98"    = "Video IsStereo"
		"64440491-4C8B-11D1-8B70-080036B11A03\99"    = "Video Orientation"
		"64440491-4C8B-11D1-8B70-080036B11A03\100"   = "Video IsSpherical"
		"64440492-4c8b-11d1-8b70-080036b11a03\7"	 = "Media Status"
		"64440492-4C8B-11D1-8B70-080036B11A03\9"	 = "Rating"
		"64440492-4C8B-11D1-8B70-080036B11A03\11"    = "Copyright"
		"64440492-4C8B-11D1-8B70-080036B11A03\12"    = "ShareUserRating"
		"64440492-4C8B-11D1-8B70-080036B11A03\13"    = "Media ClassPrimaryID"
		"64440492-4C8B-11D1-8B70-080036B11A03\14"    = "Media ClassSecondaryID"
		"64440492-4C8B-11D1-8B70-080036B11A03\15"    = "Media DVDID"
		"64440492-4C8B-11D1-8B70-080036B11A03\16"    = "Media MCDI"
		"64440492-4C8B-11D1-8B70-080036B11A03\17"    = "Media MetadataContentProvider"
		"64440492-4C8B-11D1-8B70-080036B11A03\18"    = "Media ContentDistributor"
		"64440492-4C8B-11D1-8B70-080036B11A03\19"    = "Music Composer"
		"64440492-4C8B-11D1-8B70-080036B11A03\20"    = "Video Director"
		"64440492-4C8B-11D1-8B70-080036B11A03\21"    = "ParentalRating"
		"64440492-4C8B-11D1-8B70-080036B11A03\22"    = "Media Producer"
		"64440492-4C8B-11D1-8B70-080036B11A03\23"    = "Media Writer"
		"64440492-4C8B-11D1-8B70-080036B11A03\24"    = "Media CollectionGroupID"
		"64440492-4C8B-11D1-8B70-080036B11A03\25"    = "Media CollectionID"
		"64440492-4C8B-11D1-8B70-080036B11A03\26"    = "Media ContentID"
		"64440492-4C8B-11D1-8B70-080036B11A03\27"    = "Media CreatorApplication"
		"64440492-4C8B-11D1-8B70-080036B11A03\28"    = "Media CreatorApplicationVersion"
		"64440492-4C8B-11D1-8B70-080036B11A03\30"    = "Media Publisher"
		"64440492-4C8B-11D1-8B70-080036B11A03\31"    = "Music Period"
		"64440492-4C8B-11D1-8B70-080036B11A03\32"    = "Media AuthorUrl"
		"64440492-4C8B-11D1-8B70-080036B11A03\33"    = "Media PromotionUrl"
		"64440492-4C8B-11D1-8B70-080036B11A03\34"    = "Media UserWebUrl"
		"64440492-4C8B-11D1-8B70-080036B11A03\35"    = "Media UniqueFileIdentifier"
		"64440492-4C8B-11D1-8B70-080036B11A03\36"    = "Media EncodedBy"
		"64440492-4C8B-11D1-8B70-080036B11A03\37"    = "Media EncodingSettings"
		"64440492-4C8B-11D1-8B70-080036B11A03\38"    = "Media ProtectionType"
		"64440492-4C8B-11D1-8B70-080036B11A03\39"    = "Media ProviderRating"
		"64440492-4C8B-11D1-8B70-080036B11A03\40"    = "Media ProviderStyle"
		"64440492-4C8B-11D1-8B70-080036B11A03\41"    = "Media UserNoAutoInfo"
		"64440492-4C8B-11D1-8B70-080036B11A03\42"    = "Media SeriesName"
		"64440492-4C8B-11D1-8B70-080036B11A03\47"    = "Media ThumbnailLargePath"
		"64440492-4C8B-11D1-8B70-080036B11A03\48"    = "Media ThumbnailLargeUri"
		"64440492-4C8B-11D1-8B70-080036B11A03\49"    = "Media ThumbnailSmallPath"
		"64440492-4C8B-11D1-8B70-080036B11A03\50"    = "Media ThumbnailSmallUri"
		"64440492-4C8B-11D1-8B70-080036B11A03\100"   = "Media EpisodeNumber"
		"64440492-4C8B-11D1-8B70-080036B11A03\101"   = "Media SeasonNumber"
		"644D37B4-E1B3-4BAD-B099-7E7C04966ACA\100"   = "Contact EmailAddress3"
		"EAEE7F1D-6A33-44D1-9441-5F46DEF23198\9"	 = "Device BIOSVersion"
		"92506491-FF95-4724-A05A-5B81885A7C92\1"	 = "WSD Metadata Clean"
		"92506491-FF95-4724-A05A-5B81885A7C92\2"	 = "WSD Service Info"
		"92506491-FF95-4724-A05A-5B81885A7C92\4096"  = "WSD AddressURI"
		"92506491-FF95-4724-A05A-5B81885A7C92\4097"  = "WSD Types"
		"92506491-FF95-4724-A05A-5B81885A7C92\4098"  = "WSD Scopes"
		"92506491-FF95-4724-A05A-5B81885A7C92\4099"  = "WSD MetadataVersion"
		"92506491-FF95-4724-A05A-5B81885A7C92\4100"  = "WSD App Seq InstanceID"
		"92506491-FF95-4724-A05A-5B81885A7C92\4101"  = "WSD App Seq SessionID"
		"92506491-FF95-4724-A05A-5B81885A7C92\4102"  = "WSD App Seq Message Number"
		"92506491-FF95-4724-A05A-5B81885A7C92\8192"  = "WSD XAddrs"
		"904b03a2-471d-423c-a584-f3483238a146\1"	 = "Device Visibility Flags"
		"904b03a2-471d-423c-a584-f3483238a146\2"	 = "Device Not Present"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\36"    = "Device QueueSize"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\37"    = "Device Status"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\38"    = "Device Comment"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\39"    = "Device Model"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\51"    = "DeviceDisplay Address"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\52"    = "Devices DiscoveryMethod"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\53"    = "DeviceDisplay IsEncrypted"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\54"    = "DeviceDisplay IsAuthenticated"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\55"    = "Devices Connected"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\56"    = "Devices Paired"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\57"    = "Devices Icon"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\65"    = "DeviceDisplay Version"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\66"    = "DeviceDisplay Last_Seen"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\67"    = "DeviceDisplay Last_Connected"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\68"    = "DeviceDisplay IsShowInDisconnectedState"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\70"    = "Devices LocalMachine"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\71"    = "Devices MetadataPath"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\72"    = "DeviceDisplay IsMetadataSearchInProgress"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\73"    = "DeviceDisplay MetadataChecksum"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\74"    = "DeviceDisplay IsNotInterestingForDisplay"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\76"    = "DeviceDisplay LaunchDeviceStageOnDeviceConnect"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\77"    = "Devices LaunchDeviceStageFromExplorer"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\78"    = "DeviceDisplay BaselineExperienceId"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\79"    = "DeviceDisplay IsDeviceUniquelyIdentifiable"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\80"    = "DeviceDisplay AssociationArray"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\81"    = "Devices DeviceDescription1"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\82"    = "Devices DeviceDescription2"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\83"    = "Devices NotWorkingProperly"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\84"    = "Devices IsShared"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\85"    = "Devices IsNetworkConnected"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\86"    = "Devices IsDefault"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\87"    = "DeviceDisplay MetadataCabinet"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\88"    = "DeviceDisplay RequiresPairingElevation"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\89"    = "DeviceDisplay ExperienceId"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\90"    = "Devices CategoryIds"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\91"    = "Devices Category"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\92"    = "Devices CategoryPlural"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\93"    = "DeviceDisplay Category_Icon"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\94"    = "Devices CategoryGroup"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\95"    = "DeviceDisplay CategoryGroup_Icon"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\97"    = "DeviceDisplay PrimaryCategory"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\98"    = "DeviceDisplay UnpairUninstall"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\99"    = "DeviceDisplay RequiresUninstallElevation"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\100"   = "DeviceDisplay DeviceFunctionSubRank"
		"78C34FC8-104A-4aca-9EA4-524D52996E57\101"   = "DeviceDisplay AlwaysShowDeviceAsConnected"
		"78C34FC8-104A-4ACA-9EA4-524D52996E57\256"   = "Devices DeviceInstanceId"
		"53808008-07BB-4661-BC3C-B5953E708560\1"	 = "DeviceInterface Device Path"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\1"	 = "Devnode, PnPXDevNode"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\2"	 = "AssociationState"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\3"	 = "AssociatedInstanceId"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4"	 = "LastNotificationTime"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4096"  = "Devices GlobalIdentity"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4097"  = "Devices Types"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4098"  = "Devices Scopes"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4099"  = "Devices XAddrs"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4100"  = "Devices MetadataVersion"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4101"  = "Devices ID"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\4102"  = "Devices RootProxy/RemoteAddress"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\8192"  = "Devices Manufacturer"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\8194"  = "Devices ModelName"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\8195"  = "Devices ModelNumber"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\8198"  = "Devices PresentationUrl"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288" = "Devices FriendlyName"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12289" = "Devices Firmware Version"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12290" = "Devices Serial Number"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12292" = "Devices Category"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12293" = "Devices Category Description"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12294" = "Devices PhysicalAddress"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12295" = "Devices NetworkInterfaceLuid"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12296" = "Devices NetworkInterfaceGuid"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12297" = "Devices IpAddress"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\12304" = "Devices Category Descrtiption NonPlural"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\16384" = "Devices ServiceAddress"
		"656A3BB3-ECC0-43FD-8477-4AE0404A96CD\16385" = "Devices ServiceId"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\16386" = "Devices Service Types"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\16388" = "Devices Service Control Url"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\16389" = "Devices Service Desc Url"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\16390" = "Devices Service Event Sub Url"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\20480" = "Devices DomainName"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\20482" = "Devices ShareName"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\24576" = "Devices Alt Location Info"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\24577" = "Devices LifeTime"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\24578" = "Devices NetworkInterface"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\28672" = "Devices Removable"
		"656a3bb3-ecc0-43fd-8477-4ae0404a96cd\28688" = "Devices IP Bus Enumerated"
		"8807CAE6-7DB6-4f10-8EE4-435EAA1392BC\1"	 = "Pairing ListItemText"
		"8807CAE6-7DB6-4f10-8EE4-435EAA1392BC\2"	 = "Pairing ListItemDescription"
		"8807CAE6-7DB6-4f10-8EE4-435EAA1392BC\3"	 = "Pairing ListItemIcon"
		"8807CAE6-7DB6-4f10-8EE4-435EAA1392BC\4"	 = "Pairing ListItemDefault"
		"8807CAE6-7DB6-4f10-8EE4-435EAA1392BC\16"    = "Pairing IsWifiOnlyDevice"
		"65A98875-3C80-40AB-ABBC-EFDAF77DBEE2\100"   = "AcquisitionID"
		"660E04D6-81AB-4977-A09F-82313113AB26\100"   = "Contact HomeFaxNumber"
		"6614EF48-4EFE-4424-9EDA-C79F404EDF3E\2"	 = "Devices Notifications MissedCall"
		"668CDFA5-7A1B-4323-AE4B-E527393A1D81\100"   = "SourceItem"
		"67DF94DE-0CA7-4D6F-B792-053A3E4F03CF\100"   = "FlagColor"
		"6845CC72-1B71-48C3-AF86-B09171A19B14\3"	 = "Devices DialProtocol InstalledApplications"
		"68DD6094-7216-40F1-A029-43FE7127043F\100"   = "PropGroup Music"
		"6A15E5A0-0A1E-4CD7-BB8C-D2F1B0C929BC\100"   = "Contact BusinessTelephone"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\2"	 = "Devices AepContainer SupportsAudio"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\3"	 = "Devices AepContainer SupportsVideo"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\4"	 = "Devices AepContainer SupportsImages"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\5"	 = "Devices AepContainer SupportedUriSchemes"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\6"	 = "Devices AepContainer DialProtocol InstalledApplications"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\7"	 = "Devices AepContainer SupportsLimitedDiscovery"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\8"	 = "Devices AepContainer SupportsPositioning"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\9"	 = "Devices AepContainer SupportsNetworking"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\10"    = "Devices AepContainer SupportsRendering"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\11"    = "Devices AepContainer SupportsCapturing"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\12"    = "Devices AepContainer SupportsObjectTransfer"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\13"    = "Devices AepContainer SupportsTelephony"
		"6AF55D45-38DB-4495-ACB0-D4728A3B8314\14"    = "Devices AepContainer SupportsInformation"
		"6AFE7437-9BCD-49C7-80FE-4A5C65FA5874\104"   = "Music DiscNumber"
		"6B223B6A-162E-4AA9-B39F-05D678FC6D77\100"   = "Music SynchronizedLyrics"
		"6B8B68F6-200B-47EA-8D25-D8050F57339F\100"   = "Photo FlashText"
		"6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100"   = "ItemName"
		"6BDD1FC6-810F-11D0-BEC7-08002BE2092F\2"	 = "Devices WiaDeviceType"
		"6ccd0131-c397-4744-b2d8-d2c13f457026\80"    = "Game Type"
		"6D217F6D-3F6A-4825-B470-5F03CA2FBE9B\100"   = "Photo ProgramMode"
		"6D24888F-4718-4BDA-AFED-EA0FB4386CD8\100"   = "OfflineStatus"
		"6D6D5D49-265D-4688-9F4E-1FDD33E7CC83\100"   = "Identity InternetSid"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\2"	 = "RecordedTV EpisodeName"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\3"	 = "RecordedTV ProgramDescription"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\4"	 = "RecordedTV Credits"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\5"	 = "RecordedTV StationCallSign"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\7"	 = "RecordedTV ChannelNumber"
		"6d748de2-8d38-4cc3-ac60-f009b057c557\10"    = "RecordedTV Video Quality"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\12"    = "RecordedTV IsClosedCaptioningAvailable"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\13"    = "RecordedTV IsRepeatBroadcast"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\14"    = "RecordedTV IsSAP"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\15"    = "RecordedTV DateContentExpires"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\16"    = "RecordedTV IsATSCContent"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\17"    = "RecordedTV IsDTVContent"
		"6D748DE2-8D38-4CC3-AC60-F009B057C557\18"    = "RecordedTV IsHDContent"
		"6E682923-7F7B-4F0C-A337-CFCA296687BF\100"   = "Contact OtherAddressCity"
		"6EBE6946-2321-440A-90F0-C043EFD32476\100"   = "Photo BrightnessDenominator"
		"6FA20DE6-D11C-4D9D-A154-64317628C12D\100"   = "ExpandoProperties"
		"702926F4-44A6-43E1-AE71-45627116893B\100"   = "GPS TrackNumerator"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\102"   = "Structured Query Before"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\103"   = "Structured Query After"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\104"   = "Structured Query File"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\105"   = "Structured Query Custom Property Boolean"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\106"   = "Structured Query Custom Property Integer"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\107"   = "Structured Query Custom Property Floating Point"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\108"   = "Structured Query Custom Property String"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\109"   = "Structured Query Custom Property DateTime"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\110"   = "Structured Query Has"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\111"   = "Structured Query Is"
		"7036dcfc-69ab-4316-b5ac-50de702447b0\112"   = "Structured Query Null"
		"705ccb0f-5a0d-41ea-b2ca-2c9b5cc7db41\100"   = "Verb Restrictions"
		"705d8364-7547-468c-8c88-84860bcbed4c\2"	 = "SAM Name"
		"705d8364-7547-468c-8c88-84860bcbed4c\3"	 = "SAM Version"
		"705d8364-7547-468c-8c88-84860bcbed4c\4"	 = "SAM Date Changed"
		"705d8364-7547-468c-8c88-84860bcbed4c\5"	 = "SAM Password Last Set"
		"705d8364-7547-468c-8c88-84860bcbed4c\6"	 = "SAM Date Account Expires"
		"705d8364-7547-468c-8c88-84860bcbed4c\7"	 = "SAM Password Can Change"
		"705d8364-7547-468c-8c88-84860bcbed4c\8"	 = "SAM Password Must Change"
		"705d8364-7547-468c-8c88-84860bcbed4c\9"	 = "SAM Full Name"
		"705d8364-7547-468c-8c88-84860bcbed4c\10"    = "SAM Home Directory"
		"705d8364-7547-468c-8c88-84860bcbed4c\11"    = "SAM Home Directory Drive"
		"705d8364-7547-468c-8c88-84860bcbed4c\12"    = "SAM Script Path"
		"705d8364-7547-468c-8c88-84860bcbed4c\13"    = "SAM Profile Path"
		"705d8364-7547-468c-8c88-84860bcbed4c\14"    = "SAM Admin Comment"
		"705d8364-7547-468c-8c88-84860bcbed4c\15"    = "SAM Workstations"
		"705d8364-7547-468c-8c88-84860bcbed4c\16"    = "SAM User Comment"
		"705d8364-7547-468c-8c88-84860bcbed4c\17"    = "SAM Password"
		"705d8364-7547-468c-8c88-84860bcbed4c\18"    = "SAM Security Id"
		"705d8364-7547-468c-8c88-84860bcbed4c\19"    = "SAM User Account Control"
		"705d8364-7547-468c-8c88-84860bcbed4c\20"    = "SAM Logon Hours"
		"705d8364-7547-468c-8c88-84860bcbed4c\21"    = "SAM Country Code"
		"705d8364-7547-468c-8c88-84860bcbed4c\22"    = "SAM Code Page"
		"705d8364-7547-468c-8c88-84860bcbed4c\23"    = "SAM Password Expired"
		"705d8364-7547-468c-8c88-84860bcbed4c\24"    = "SAM User Picture"
		"705d8364-7547-468c-8c88-84860bcbed4c\25"    = "SAM Password Hint"
		"705d8364-7547-468c-8c88-84860bcbed4c\26"    = "SAM Domain"
		"705d8364-7547-468c-8c88-84860bcbed4c\31"    = "SAM Groups"
		"705d8364-7547-468c-8c88-84860bcbed4c\32"    = "SAM Type"
		"705d8364-7547-468c-8c88-84860bcbed4c\36"    = "SAM Interactive Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\37"    = "SAM Network Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\38"    = "SAM Batch Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\39"    = "SAM Service Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\40"    = "SAM Remote Interactive Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\41"    = "SAM Deny Interactive Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\42"    = "SAM Deny Network Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\43"    = "SAM Deny Batch Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\44"    = "SAM Deny Service Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\45"    = "SAM Deny Remote Interactive Login"
		"705d8364-7547-468c-8c88-84860bcbed4c\46"    = "SAM Dont Show In Logon UI"
		"705d8364-7547-468c-8c88-84860bcbed4c\47"    = "SAM Shell Admin Object Props"
		"705d8364-7547-468c-8c88-84860bcbed4c\50"    = "SAM Password Is Empty"
		"705d8364-7547-468c-8c88-84860bcbed4c\102"   = "SAM Group Members"
		"705d8364-7547-468c-8c88-84860bcbed4c\103"   = "SAM Residual Id"
		"705d8364-7547-468c-8c88-84860bcbed4c\200"   = "LOGON LU Id"
		"705d8364-7547-468c-8c88-84860bcbed4c\201"   = "LOGON Authentication Package"
		"705d8364-7547-468c-8c88-84860bcbed4c\202"   = "LOGON TS Session"
		"705d8364-7547-468c-8c88-84860bcbed4c\203"   = "LOGON Logon Time"
		"705d8364-7547-468c-8c88-84860bcbed4c\204"   = "LOGON Logon Server"
		"705d8364-7547-468c-8c88-84860bcbed4c\205"   = "LOGON Dns Domain Name"
		"705d8364-7547-468c-8c88-84860bcbed4c\206"   = "LOGON UPN"
		"705d8364-7547-468c-8c88-84860bcbed4c\207"   = "LOGON Client Name"
		"705d8364-7547-468c-8c88-84860bcbed4c\208"   = "LOGON WinS tation Name"
		"705d8364-7547-468c-8c88-84860bcbed4c\209"   = "LOGON Status"
		"705d8364-7547-468c-8c88-84860bcbed4c\500"   = "PROFILE Path"
		"705d8364-7547-468c-8c88-84860bcbed4c\501"   = "PROFILE GUID"
		"71724756-3E74-4432-9B59-E7B2F668A593\2"	 = "Devices AepService FriendlyName"
		"71724756-3E74-4432-9B59-E7B2F668A593\3"	 = "Devices AepService ServiceClassId"
		"71724756-3E74-4432-9B59-E7B2F668A593\4"	 = "Devices AepService ContainerId"
		"71B377D6-E570-425F-A170-809FAE73E54E\100"   = "Contact OtherAddressState"
		"720eb626-dbe4-4113-835c-9315e1e2ff77\2"	 = "Actions Action Name"
		"720eb626-dbe4-4113-835c-9315e1e2ff77\3"	 = "Actions Activation Context"
		"7268AF55-1CE4-4F6E-A41F-B6E4EF10E4A9\100"   = "Contact Profession"
		"72FAB781-ACDA-43E5-B155-B2434F85E678\100"   = "DateCompleted"
		"72FC5BA4-24F9-4011-9F3F-ADD27AFAD818\100"   = "Calendar ReminderTime"
		"730FB6DD-CF7C-426B-A03F-BD166CC9EE24\100"   = "Contact BusinessAddress"
		"73389854-0b42-4ea6-bc67-847d430899fd\2"	 = "Connected Search Require Template"
		"733cb147-8b1f-4c48-9966-192fde353c75\100"   = "Music Stack Thumbnail Cache Ids"
		"738BF284-1D87-420B-92CF-5834BF6EF9ED\100"   = "Photo ExposureBiasNumerator"
		"744C8242-4DF5-456C-AB9E-014EFB9021E3\100"   = "Calendar OrganizerAddress"
		"745BAF0E-E5C1-4CFB-8A1B-D031A0A52393\100"   = "Photo DigitalZoomDenominator"
		"74A7DE49-FA11-4D3D-A006-DB7E08675916\100"   = "Identity ProviderID"
		"75ee72ae-7d5f-482f-9487-f1c46ca819c1\100"   = "Camera Roll Deduplication Id"
		"76C09943-7C33-49E3-9E7E-CDBA872CFADA\100"   = "GPS Track"
		"776B6B3B-1E3D-4B0C-9A0E-8FBAF2A8492A\100"   = "Photo FocalLengthNumerator"
		"78342DCB-E358-4145-AE9A-6BFE4E0F9F51\100"   = "GPS AltitudeDenominator"
		"79486778-4c6f-4dde-bc53-cd594311af99\2"	 = "Connected Search Local Weights"
		"79D94E82-4D79-45AA-821A-74858B4E4CA6\2"	 = "Devices AepService IoT ServiceInterfaces"
		"7a55582b-bd8c-4475-b94c-b87a388a7899\100"   = "Status Icons"
		"7A7D76F4-B630-4BD7-95FF-37CC51A975C9\2"	 = "Link TargetExtension"
		"7ABCF4F8-7C3F-4988-AC91-8D2C2E97ECA5\100"   = "GPS DestBearingDenominator"
		"7B9F6399-0A3F-4B12-89BD-4ADC51C918AF\100"   = "Contact HomeAddressPostOfficeBox"
		"7ba3535d-69aa-4525-a938-f3ec79485377\2"	 = "SAM Allowed Logon"
		"7ba3535d-69aa-4525-a938-f3ec79485377\3"	 = "SAM Dont Enumerate For Logon"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\2"	 = "Sync HandlerCollectionID"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\3"	 = "Sync HandlerID"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\4"	 = "Sync Event Description"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\5"	 = "Sync Progress"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\6"	 = "Sync ItemID"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\7"	 = "Sync Date Synchronized"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\8"	 = "Sync HandlerType"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\9"	 = "Sync HandlerTypeLabel"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\10"    = "Sync Status"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\11"    = "Sync Conflict Count"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\12"    = "Sync Error Count"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\13"    = "Sync Comments"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\14"    = "Sync Enabled"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\15"    = "Sync Hidden"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\16"    = "Sync Connected"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\17"    = "Sync Link"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\19"    = "Sync Context"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\20"    = "Sync Event Level"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\21"    = "Sync Event Flags"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\22"    = "Sync Sync Results"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\23"    = "Sync ProgressPercentage"
		"7BD5533E-AF15-44DB-B8C8-BD6624E1D032\24"    = "Sync State"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\25"    = "Sync Item State"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\26"    = "Sync Item Status Text"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\27"    = "Sync Item Status Description"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\28"    = "Sync Item Status Action"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\29"    = "Sync Global Activity Message"
		"7bd5533e-af15-44db-b8c8-bd6624e1d032\30"    = "Sync Last Synced Message"
		"7D122D5A-AE5E-4335-8841-D71E7CE72F53\100"   = "GPS SpeedDenominator"
		"7D683FC9-D155-45A8-BB1F-89D19BCB792F\100"   = "Identity DisplayName"
		"7DDAAAD1-CCC8-41AE-B750-B2CB8031AEA2\100"   = "GPS LatitudeNumerator"
		"7FD7259D-16B4-4135-9F97-7C96ECD2FA9E\100"   = "PropGroup Message"
		"7FE3AA27-2648-42F3-89B0-454E5CB150C3\100"   = "Photo ProgramModeText"
		"807B653A-9E91-43EF-8F97-11CE04EE20C5\100"   = "Communication Suffix"
		"80D81EA6-7473-4B0C-8216-EFC11A2C4C8B\2"	 = "Devices ModelId"
		"80F41EB8-AFC4-4208-AA5F-CCE21A627281\100"   = "Contact ConnectedServiceIdentities"
		"813F4124-34E6-4D17-AB3E-6B1F3C2247A1\100"   = "Photo MakerNoteOffset"
		"821437D6-9EAB-4765-A589-3B1CBBD22A61\100"   = "Photo PhotometricInterpretationText"
		"827EDB4F-5B73-44A7-891D-FDFFABEA35CA\100"   = "GPS Altitude"
		"83914d1a-c270-48bf-b00d-1c4e451b0150\100"   = "Default Group Order"
		"83A6347E-6FE4-4F40-BA9C-C4865240D1F4\100"   = "Communication FollowupIconIndex"
		"83DA6326-97A6-4088-9453-A1923F573B29\9"	 = "Devices IsSoftwareInstalling"
		"847C66DE-B8D6-4AF9-ABC3-6F4F926BC039\14"    = "DeviceInterface PrinterDriverDirectory"
		"84D8F337-981D-44B3-9615-C7596DBA17E3\100"   = "Contact EmailAddresses"
		"8589E481-6040-473D-B171-7FA89C2708ED\100"   = "Contact CompanyMainTelephone"
		"8619A4B6-9F4D-4429-8C0F-B996CA59E335\100"   = "Communication SecurityFlags"
		"86407db8-9df7-48cd-b986-f999adc19731\2"	 = "Share Target Description"
		"8727CFFF-4868-4EC6-AD5B-81B98521D1AB\100"   = "GPS Latitude"
		"880F70A2-6082-47AC-8AAB-A739D1A300C3\151"   = "Devices SharedTooltip"
		"880F70A2-6082-47AC-8AAB-A739D1A300C3\152"   = "Devices NetworkedTooltip"
		"880F70A2-6082-47AC-8AAB-A739D1A300C3\153"   = "Devices DefaultTooltip"
		"8859A284-DE7E-4642-99BA-D431D044B1EC\100"   = "PropGroup MediaAdvanced"
		"8943B373-388C-4395-B557-BC6DBAFFAFDB\2"	 = "Devices AudioDevice RawProcessingSupported"
		"8943B373-388C-4395-B557-BC6DBAFFAFDB\3"	 = "Devices AudioDevice Microphone SensitivityInDbfs"
		"8943B373-388C-4395-B557-BC6DBAFFAFDB\4"	 = "Devices AudioDevice Microphone SignalToNoiseRatioInDb"
		"8969B275-9475-4E00-A887-FF93B8B41E44\100"   = "PropGroup Description"
		"897B3694-FE9E-43E6-8066-260F590C0100\2"	 = "Contact JA CompanyNamePhonetic"
		"897B3694-FE9E-43E6-8066-260F590C0100\3"	 = "Contact JA FirstNamePhonetic"
		"897B3694-FE9E-43E6-8066-260F590C0100\4"	 = "Contact JA LastNamePhonetic"
		"8A2F99F9-3C37-465D-A8D7-69777A246D0C\2"	 = "Link FeedItemLocalId"
		"8A2F99F9-3C37-465D-A8D7-69777A246D0C\5"	 = "Link TargetUrlHostName"
		"8A2F99F9-3C37-465D-A8D7-69777A246D0C\6"	 = "Link TargetUrlPath"
		"8AF4961C-F526-43E5-AA81-DB768219178D\100"   = "Photo SubjectDistanceNumerator"
		"8AFCC170-8A46-4B53-9EEE-90BAE7151E62\100"   = "Contact HomeAddressPostalCode"
		"8B26EA41-058F-43F6-AECC-4035681CE977\100"   = "Contact OtherAddressPostOfficeBox"
		"8bf6b9f6-b4f5-482f-a2c2-44bdad2fcfa9\51"    = "SAM Account Is Disabled For Logon UI"
		"8C3B93A4-BAED-1A83-9A32-102EE313F6EB\100"   = "Identity Blob"
		"8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C\2"	 = "Devices ContainerId"
		"8C7ED206-3F8A-4827-B3AB-AE9E1FAEFC6C\4"	 = "Devices InLocalMachineContainer"
		"8d72aca1-0716-419a-9ac1-acb07b18dc32\2"	 = "File Attributes Display"
		"8E531030-B960-4346-AE0D-66BC9A86FB94\100"   = "Communication Direction"
		"8E8ECF7C-B7B8-4EB8-A63F-0EE715C96F9E\100"   = "Photo GainControlNumerator"
		"8F167568-0AAE-4322-8ED9-6055B7B0E398\100"   = "Contact OtherAddressCountry"
		"8F367200-C270-457C-B1D4-E07C5BCD90C7\100"   = "Contact LastName"
		"8FDC6DEA-B929-412B-BA90-397A257465FE\100"   = "Contact CarTelephone"
		"900A403B-097B-4B95-8AE2-071FDAEEB118\100"   = "PropGroup Advanced"
		"90197CA7-FD8F-4E8C-9DA3-B57E1E609295\100"   = "RatingText"
		"908696C7-8F87-44F2-80ED-A8C1C6894575\2"	 = "LibraryLocationsCount"
		"908696c7-8f87-44f2-80ed-a8c1c6894575\4"	 = "Library Locations List"
		"9098F33C-9A7D-48A8-8DE5-2E1227A64E91\100"   = "Message ProofInProgress"
		"90E5E14E-648B-4826-B2AA-ACAF790E3513\10"    = "IsEncrypted"
		"916d17ac-8a97-48af-85b7-867a88fad542\2"	 = "Connected Search Auto Complete"
		"91EFF6F3-2E27-42CA-933E-7C999FBE310B\100"   = "Contact BusinessFaxNumber"
		"93112F89-C28B-492F-8A9D-4BE2062CEE8A\100"   = "Photo ExposureIndexDenominator"
		"95BEB1FC-326D-4644-B396-CD3ED90E6DDF\100"   = "Journal EntryType"
		"95C656C1-2ABF-4148-9ED3-9EC602E3B7CD\100"   = "Contact OtherAddressPostalCode"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\2"	 = "DeviceInterface WinUsb UsbVendorId"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\3"	 = "DeviceInterface WinUsb UsbProductId"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\4"	 = "DeviceInterface WinUsb UsbClass"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\5"	 = "DeviceInterface WinUsb UsbSubClass"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\6"	 = "DeviceInterface WinUsb UsbProtocol"
		"95E127B5-79CC-4E83-9C9E-8422187B3E0E\7"	 = "DeviceInterface WinUsb DeviceInterfaceClasses"
		"9660C283-FC3A-4A08-A096-EED3AAC46DA2\100"   = "Contact DataSuppliers"
		"967B5AF8-995A-46ED-9E11-35B3C5B9782D\100"   = "Photo ExposureIndex"
		"972E333E-AC7E-49F1-8ADF-A70D07A9BCAB\100"   = "GPS AreaInformation"
		"9744311e-7951-4b2e-b6f0-ecb293cac119\1"	 = "Devices Aep Bluetooth Issue Inquiry"
		"9744311e-7951-4b2e-b6f0-ecb293cac119\2"	 = "Devices Aep Bluetooth Le Active Scanning"
		"9744311e-7951-4b2e-b6f0-ecb293cac119\3"	 = "Devices Aep Bluetooth Le Scan Interval"
		"9744311e-7951-4b2e-b6f0-ecb293cac119\4"	 = "Devices Aep Bluetooth Le Scan Window"
		"9744311E-7951-4B2E-B6F0-ECB293CAC119\5"	 = "Devices AepService Bluetooth CacheMode"
		"9744311E-7951-4B2E-B6F0-ECB293CAC119\6"	 = "Devices AepService Bluetooth TargetDevice"
		"97B0AD89-DF49-49CC-834E-660974FD755B\100"   = "Contact Label"
		"98f920d1-51e2-4722-9069-3c4b5cff5165\100"   = "Is Barricade Page"
		"98F98354-617A-46B8-8560-5B1B64BF1F89\100"   = "Contact HomeAddress"
		"995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69\1"	 = "Devices Aep Bluetooth Le Appearance"
		"995ef0b0-7eb3-4a8b-b9ce-068bb3f4af69\2"	 = "Devices Aep Bluetooth Le Advertisement"
		"995ef0b0-7eb3-4a8b-b9ce-068bb3f4af69\3"	 = "Devices Aep Bluetooth Le Scan Response"
		"995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69\4"	 = "Devices Aep Bluetooth Le AddressType"
		"995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69\5"	 = "Devices Aep Bluetooth Le Appearance Category"
		"995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69\6"	 = "Devices Aep Bluetooth Le Appearance Subcategory"
		"995EF0B0-7EB3-4A8B-B9CE-068BB3F4AF69\8"	 = "Devices Aep Bluetooth Le IsConnectable"
		"9973D2B5-BFD8-438A-BA94-5349B293181A\100"   = "PropGroup Calendar"
		"9A8EBB75-6458-4E82-BACB-35C0095B03BB\100"   = "Photo TranscodedForSync"
		"9A93244D-A7AD-4FF8-9B99-45EE4CC09AF6\100"   = "Contact AssistantTelephone"
		"9A9BC088-4F6D-469E-9919-E705412040F9\100"   = "Message IsFwdOrReply"
		"9AB84393-2A0F-4B75-BB22-7279786977CB\100"   = "GPS DestBearingRef"
		"9AD5BADB-CEA7-4470-A03D-B84E51B9949E\100"   = "Contact Anniversary"
		"9AEBAE7A-9644-487D-A92C-657585ED751A\100"   = "Media SubscriptionContentId"
		"9b174b33-40ff-11d2-a27e-00c04fc30871\2"	 = "Recycle Deleted From"
		"9b174b33-40ff-11d2-a27e-00c04fc30871\3"	 = "Recycle Date Deleted"
		"9B174B34-40FF-11D2-A27E-00C04FC30871\4"	 = "FileOwner"
		"9b174b34-40ff-11d2-a27e-00c04fc30871\8"	 = "New Menu Preferred Types"
		"9b174b34-40ff-11d2-a27e-00c04fc30871\10"    = "New Menu Allowed Types"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\2"	 = "FreeSpace"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\3"	 = "Capacity"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\4"	 = "Volume FileSystem"
		"9b174b35-40ff-11d2-a27e-00c04fc30871\5"	 = "Percent Full"
		"9b174b35-40ff-11d2-a27e-00c04fc30871\7"	 = "Computer Decorated FreeSpace"
		"9b174b35-40ff-11d2-a27e-00c04fc30871\10"    = "Volume Is Root"
		"9b34bbb9-949c-488d-9a6d-eeb47c847a2f\2"	 = "Wireless Profile Name"
		"9b34bbb9-949c-488d-9a6d-eeb47c847a2f\4"	 = "Wireless Security"
		"9b34bbb9-949c-488d-9a6d-eeb47c847a2f\5"	 = "Wireless Radio Type"
		"9b34bbb9-949c-488d-9a6d-eeb47c847a2f\9"	 = "Wireless Connection Mode"
		"9BC2C99B-AC71-4127-9D1C-2596D0D7DCB7\100"   = "GPS DestDistanceDenominator"
		"9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4\5"	 = "Priority"
		"9c1fcf74-2d97-41ba-b4ae-cb2e3661a6e4\7"	 = "Communication Newsgroup Name"
		"9C1FCF74-2D97-41BA-B4AE-CB2E3661A6E4\8"	 = "Message HasAttachments"
		"9c1fcf74-2d97-41ba-b4ae-cb2e3661a6e4\10"    = "SAM Account Name"
		"9c1fcf74-2d97-41ba-b4ae-cb2e3661a6e4\13"    = "Message Type"
		"9c1fcf74-2d97-41ba-b4ae-cb2e3661a6e4\17"    = "Message Received"
		"9CB0C358-9D7A-46B1-B466-DCC6F1A3D93D\100"   = "Contact DisplayMobilePhoneNumbers"
		"9D1D7CC5-5C39-451C-86B3-928E2D18CC47\100"   = "GPS DestLatitude"
		"9D2408B6-3167-422B-82B0-F583B7A7CFE3\100"   = "Contact SpouseName"
		"9E7D118F-B314-45A0-8CFB-D654B917C9E9\100"   = "Photo BrightnessNumerator"
		"A00742A1-CD8C-4B37-95AB-70755587767A\3"	 = "DeviceInterface PrinterEnumerationFlag"
		"A015ED5D-AAEA-4D58-8A86-3C586920EA0B\100"   = "GPS MeasureMode"
		"A06992B3-8CAF-4ED7-A547-B259E32AC9FC\100"   = "Search Store"
		"A09F084E-AD41-489F-8076-AA5BE3082BCA\100"   = "SimpleRating"
		"A0BE94C5-50BA-487B-BD35-0654BE8881ED\100"   = "GPS DOPDenominator"
		"A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0\2"	 = "Devices Notifications StorageFull"
		"A0E00EE1-F0C7-4D41-B8E7-26A7BD8D38B0\3"	 = "Devices Notifications StorageFullLinkText"
		"A0E74609-B84D-4F49-B860-462BD9971F98\100"   = "Photo FocalLengthInFilm"
		"a11c005a-ff95-4785-8617-beaf92399c3c\100"   = "HasLeafContainers"
		"A1829EA2-27EB-459E-935D-B2FAD7B07762\2"	 = "Devices MicrophoneArray Geometry"
		"A19FB7A9-024B-4371-A8BF-4D29C3E4E9C9\100"   = "Contact ConnectedServiceSupportedActions"
		"A26F4AFC-7346-4299-BE47-EB1AE613139F\16"    = "Identity KeyProviderName"
		"A26F4AFC-7346-4299-BE47-EB1AE613139F\17"    = "Identity KeyProviderContext"
		"A26F4AFC-7346-4299-BE47-EB1AE613139F\100"   = "Identity"
		"A2E541C5-4440-4BA8-867E-75CFC06828CD\100"   = "Photo FocalPlaneYResolutionNumerator"
		"A3250282-FB6D-48D5-9A89-DBCACE75CCCF\100"   = "GPS DestLongitudeNumerator"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\3"	 = "Devices Aep ModelName"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\4"	 = "Devices Aep ModelId"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\5"	 = "Devices Aep Manufacturer"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\6"	 = "Devices Aep SignalStrength"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\7"	 = "Devices Aep IsConnected"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\9"	 = "Devices Aep IsPresent"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\12"    = "Devices Aep DeviceAddress"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\16"    = "Devices Aep IsPaired"
		"A35996AB-11CF-4935-8B61-A6761081ECDF\17"    = "Devices Aep Category"
		"A399AAC7-C265-474E-B073-FFCE57721716\2"	 = "Devices AepService Bluetooth ServiceGuid"
		"A3B29791-7713-4E1D-BB40-17DB85F01831\100"   = "ImportanceText"
		"a40294ef-d2b1-40ed-9512-dd3853b431f5\2"	 = "Connected Search Defer Image Prefetch"
		"A4108708-09DF-4377-9DFC-6D99986D5A67\100"   = "Identity IsMeIdentity"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\3"	 = "Devices HardwareIds"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\4"	 = "Devices CompatibleIds"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\10"    = "Devices ClassGuid"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\13"    = "Devices DeviceManufacturer"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\17"    = "Devices DeviceCapabilities"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\29"    = "Devices DeviceCharacteristics"
		"A45C254E-DF1C-4EFD-8020-67D146A850E0\37"    = "Devices LocationPaths"
		"a4790b72-7113-4348-97ea-292bbc1f6770\5"	 = "Visio Masters Keywords"
		"a4790b72-7113-4348-97ea-292bbc1f6770\6"	 = "Visio Masters Details"
		"A4AAA5B7-1AD0-445F-811A-0F8F6E67F6B5\100"   = "GPS ImgDirectionRef"
		"A5477F61-7A82-4ECA-9DDE-98B69B2479B3\100"   = "RecordedTV RecordingTime"
		"a63b464f-2ace-4d83-87ae-abaf011cc6ac\1720"  = "Volume BitLocker Can Change Passphrase By Proxy"
		"A6744477-C237-475B-A075-54F34498292A\100"   = "Communication TaskStatusText"
		"A6F360D2-55F9-48DE-B909-620E090A647C\100"   = "IsFlaggedComplete"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\101"   = "Contact HomeAddress1Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\102"   = "Contact HomeAddress1Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\103"   = "Contact HomeAddress1Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\104"   = "Contact HomeAddress1Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\105"   = "Contact HomeAddress1PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\106"   = "Contact HomeAddress2Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\107"   = "Contact HomeAddress2Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\108"   = "Contact HomeAddress2Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\109"   = "Contact HomeAddress2Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\110"   = "Contact HomeAddress2PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\111"   = "Contact HomeAddress3Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\112"   = "Contact HomeAddress3Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\113"   = "Contact HomeAddress3Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\114"   = "Contact HomeAddress3Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\115"   = "Contact HomeAddress3PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\116"   = "Contact BusinessAddress1Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\117"   = "Contact BusinessAddress1Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\118"   = "Contact BusinessAddress1Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\119"   = "Contact BusinessAddress1Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\120"   = "Contact BusinessAddress1PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\121"   = "Contact BusinessAddress2Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\122"   = "Contact BusinessAddress2Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\123"   = "Contact BusinessAddress2Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\124"   = "Contact BusinessAddress2Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\125"   = "Contact BusinessAddress2PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\126"   = "Contact BusinessAddress3Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\127"   = "Contact BusinessAddress3Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\128"   = "Contact BusinessAddress3Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\129"   = "Contact BusinessAddress3Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\130"   = "Contact BusinessAddress3PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\131"   = "Contact OtherAddress1Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\132"   = "Contact OtherAddress1Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\133"   = "Contact OtherAddress1Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\134"   = "Contact OtherAddress1Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\135"   = "Contact OtherAddress1PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\136"   = "Contact OtherAddress2Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\137"   = "Contact OtherAddress2Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\138"   = "Contact OtherAddress2Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\139"   = "Contact OtherAddress2Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\140"   = "Contact OtherAddress2PostalCode"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\141"   = "Contact OtherAddress3Street"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\142"   = "Contact OtherAddress3Locality"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\143"   = "Contact OtherAddress3Region"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\144"   = "Contact OtherAddress3Country"
		"A7B6F596-D678-4BC1-B05F-0203D27E8AA1\145"   = "Contact OtherAddress3PostalCode"
		"A7FE0840-1344-46F0-8D37-52ED712A4BF9\100"   = "ParentalRatingsOrganization"
		"A82D9EE7-CA67-4312-965E-226BCEA85023\100"   = "Message Flags"
		"A8A74B92-361B-4E9A-B722-7C4A7330A312\100"   = "Identity ProviderData"
		"a8a7a412-1927-4a34-b1d4-45f67cc672fb\2"	 = "Connected Search Referrer Id"
		"A93EAE04-6804-4F24-AC81-09B266452118\100"   = "GPS DestDistance"
		"A94688B6-7D9F-4570-A648-E3DFC0AB2B3F\100"   = "OfflineAvailability"
		"A9EA193C-C511-498A-A06B-58E2776DCC28\100"   = "Photo OrientationText"
		"AAA660F9-9865-458E-B484-01BC7FE3973E\100"   = "Calendar OrganizerName"
		"AABAF6C9-E0C5-4719-8585-57B103E584FE\100"   = "Photo FlashManufacturer"
		"AAF16BAC-2B55-45E6-9F6D-415EB94910DF\100"   = "Contact TTYTDDTelephone"
		"AAF4EE25-BD3B-4DD7-BFC4-47F77BB00F6D\100"   = "GPS Differential"
		"AB205E50-04B7-461C-A18C-2F233836E627\100"   = "Photo ExposureBiasDenominator"
		"ACC9CE3D-C213-4942-8B48-6D0820F21C6D\100"   = "GPS SpeedNumerator"
		"ad763ac7-f1ed-4039-9fb4-b7b84ef33cef\2"	 = "Search Provider Attributes"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\2"	 = "DRM IsProtected"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\3"	 = "DRM Description"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\4"	 = "DRM PlayCount"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\5"	 = "DRM DatePlayStarts"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\6"	 = "DRM DatePlayExpires"
		"AEAC19E4-89AE-4508-B9B7-BB867ABEE2ED\7"	 = "DRM IsDisabled"
		"AFC47170-14F5-498C-8F30-B0D19BE449C6\11"    = "DeviceInterface PrinterDriverName"
		"AFD97640-86A3-4210-B67C-289C41AABE55\2"	 = "Devices SafeRemovalRequired"
		"B0B87314-FCF6-4FEB-8DFF-A50DA6AF561C\100"   = "Contact BusinessAddressCountry"
		"b180ad60-ed3f-4d16-bd43-f5b4fcf325a9\2"	 = "Sync Conflict ItemS hort Location"
		"b180ad60-ed3f-4d16-bd43-f5b4fcf325a9\3"	 = "Sync Conflict Item Full Location"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\2"	 = "FilePlaceholderStatus"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\3"	 = "StorageProviderFileIdentifier"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\4"	 = "StorageProviderFileVersion"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\5"	 = "StorageProviderFileChecksum"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\6"	 = "StorageProviderFileVersionWaterline"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\7"	 = "StorageProviderCallerVersionInformation"
		"B33AF30B-F552-4584-936C-CB93E5CDA29F\100"   = "Calendar RequiredAttendeeNames"
		"B5C84C9E-5927-46B5-A3CC-933C21B78469\100"   = "Contact ConnectedServiceName"
		"b769d0fe-bc33-421a-8ce6-45add82ec756\2"	 = "Connected Search Suppress Local Hero"
		"b771b352-8692-42e6-ac33-cc7b062ad950\100"   = "Game Win SPR Recommended"
		"B7B4D61C-5A64-4187-A52E-B1539F359099\2"	 = "Devices WinPhone8CameraFlags"
		"B812F15D-C2D8-4BBF-BACD-79744346113F\100"   = "Photo TagViewAggregate"
		"B96EFF7B-35CA-4A35-8607-29E3A54C46EA\100"   = "IdentityProvider Name"
		"B9B4B3FC-2B51-4A42-B5D8-324146AFCF25\2"	 = "Link TargetParsingPath"
		"B9B4B3FC-2B51-4A42-B5D8-324146AFCF25\3"	 = "Link Status"
		"B9B4B3FC-2B51-4A42-B5D8-324146AFCF25\5"	 = "Link Comment"
		"b9b4b3fc-2b51-4a42-b5d8-324146afcf25\6"	 = "Item After"
		"B9B4B3FC-2B51-4A42-B5D8-324146AFCF25\8"	 = "Link TargetSFGAOFlags"
		"BA3B1DA9-86EE-4B5D-A2A4-A271A429F0CF\100"   = "GPS DestBearingNumerator"
		"bb44403b-1399-4650-95eb-03c53a57c2cf\60"    = "Game Int Update Status"
		"BC4E71CE-17F9-48D5-BEE9-021DF0EA5409\100"   = "Contact BusinessAddressPostOfficeBox"
		"BCCC8A3C-8CEF-42E5-9B1C-C69079398BC7\100"   = "Message ToDoTitle"
		"BCEEE283-35DF-4D53-826A-F36A3EEFC6BE\100"   = "Search ContainerHash"
		"BE1A72C6-9A1D-46B7-AFE7-AFAF8CEF4999\100"   = "Communication TaskStatus"
		"BE6E176C-4534-4D2C-ACE5-31DEDAC1606B\100"   = "GPS LongitudeDenominator"
		"BEBE0920-7671-4C54-A3EB-49FDDFC191EE\100"   = "PropGroup Video"
		"BF53D1C3-49E0-4F7F-8567-5A821D8AC542\100"   = "Contact CallbackTelephone"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\2"	 = "Devices Dnssd ServiceName"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\3"	 = "Devices Dnssd Domain"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\4"	 = "Devices Dnssd InstanceName"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\5"	 = "Devices Dnssd FullName"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\6"	 = "Devices Dnssd TextAttributes"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\7"	 = "Devices Dnssd HostName"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\8"	 = "Devices Dnssd Weight"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\9"	 = "Devices Dnssd Priority"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\10"    = "Devices Dnssd Ttl"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\11"    = "Devices Dnssd NetworkAdapterId"
		"BF79C0AB-BB74-4CEE-B070-470B5AE202EA\12"    = "Devices Dnssd PortNumber"
		"BFEE9149-E3E2-49A7-A862-C05988145CEC\100"   = "Calendar IsOnline"
		"C06238B2-0BF9-4279-A723-25856715CB9D\100"   = "Photo GainControlText"
		"C0AC206A-827E-4650-95AE-77E2BB74FCC9\100"   = "Contact MailingAddress"
		"C107E191-A459-44C5-9AE6-B952AD4B906D\100"   = "Photo MaxApertureNumerator"
		"C2EA046E-033C-4E91-BD5B-D4942F6BBE49\2"	 = "CreatorAppId"
		"C2EA046E-033C-4E91-BD5B-D4942F6BBE49\3"	 = "CreatorOpenWithUIOptions"
		"C4322503-78CA-49C6-9ACC-A68E2AFD7B6B\100"   = "Identity UserName"
		"C449D5CB-9EA4-4809-82E8-AF9D59DED6D1\100"   = "Music IsCompilation"
		"C4C07F2B-8524-4E66-AE3A-A6235F103BEB\2"	 = "Devices Notifications LowBattery"
		"C4C4DBB2-B593-466B-BBDA-D03D27D5E43A\100"   = "GPS Longitude"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\600"   = "Activity App Display Name"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\601"   = "Activity App Image Uri"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\602"   = "Activity Background Color"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\603"   = "Activity Content Image Uri"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\604"   = "Activity Content Uri"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\605"   = "Activity Description"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\606"   = "Activity Display Text"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\607"   = "Activity Tilexml"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\608"   = "Activity History Active Days"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\609"   = "Activity History Active Duration"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\610"   = "Activity History Active Hours"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\611"   = "Activity History App Activity Id"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\612"   = "Activity History App Id"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\613"   = "Activity History Device Display Name"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\614"   = "Activity History Device Id"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\615"   = "Activity History Display Text"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\616"   = "Activity History End Time"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\617"   = "Activity History Id"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\618"   = "Activity History Start Time"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\619"   = "Activity History Type"
		"c5043536-932e-219e-5fb9-1c2807d7b03e\620"   = "Activity Activity Id"
		"c53e42a9-db3c-4bc7-b0f3-83a524adf0ec\1719"  = "Volume BitLocker Can Change Pin"
		"C554493C-C1F7-40C1-A76C-EF8C0614003E\100"   = "Contact TelexNumber"
		"c64a866e-41ae-4c8c-b3d5-dd6dbf70c9c1\100"   = "Is Group"
		"C66D4B3C-E888-47CC-B99F-9DCA3EE34DEA\100"   = "GPS DestBearing"
		"c6f039e7-f6a4-4185-ae48-07938262c274\100"   = "Hide In Grep Search"
		"C75FAA05-96FD-49E7-9CB4-9F601082D553\100"   = "EndDate"
		"C77724D4-601F-46C5-9B89-C53F93BCEB77\100"   = "Photo MaxApertureDenominator"
		"C89A23D0-7D6D-4EB8-87D4-776A82D493E5\100"   = "Contact HomeAddressState"
		"C8D1920C-01F6-40C0-AC86-2F3A4AD00770\100"   = "GPS TrackDenominator"
		"C8EA94F0-A9E3-4969-A94B-9C62A95324E0\100"   = "Contact PrimaryAddressCity"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\2"	 = "PropList FullDetails"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\3"	 = "PropList TileInfo"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\4"	 = "PropList InfoTip"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\5"	 = "PropList QuickTip"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\6"	 = "PropList PreviewTitle"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\8"	 = "PropList PreviewDetails"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\9"	 = "PropList ExtendedTileInfo"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\10"    = "PropList FileOperationPrompt"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\11"    = "PropList ConflictPrompt"
		"c9944a21-a406-48fe-8225-aec7e24c211b\12"    = "PropList Set Defaults For"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\13"    = "PropList ContentViewModeForBrowse"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\14"    = "PropList ContentViewModeForSearch"
		"c9944a21-a406-48fe-8225-aec7e24c211b\16"    = "PropList Status Icons"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\17"    = "InfoTipText"
		"c9944a21-a406-48fe-8225-aec7e24c211b\18"    = "PropList Status Icons Display Flag"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\500"   = "LayoutPattern ContentViewModeForBrowse"
		"C9944A21-A406-48FE-8225-AEC7E24C211B\501"   = "LayoutPattern ContentViewModeForSearch"
		"c9944a21-a406-48fe-8225-aec7e24c211b\502"   = "Layout Pattern Place Holder"
		"c9944a21-a406-48fe-8225-aec7e24c211b\503"   = "Layout Pattern Tiles View Mode"
		"c9944a21-a406-48fe-8225-aec7e24c211b\504"   = "Layout Pattern Group"
		"c9944a21-a406-48fe-8225-aec7e24c211b\510"   = "PropList Details Pane Null Select"
		"c9944a21-a406-48fe-8225-aec7e24c211b\511"   = "PropList Details Pane Null Select Title"
		"c9b88dba-04db-4887-a200-cf0d3afe1146\99"    = "Game Update Status"
		"C9C141A9-1B4C-4F17-A9D1-F298538CADB8\2"	 = "Devices AepService ServiceId"
		"C9C141A9-1B4C-4F17-A9D1-F298538CADB8\5"	 = "Devices AepService ProtocolId"
		"C9C141A9-1B4C-4F17-A9D1-F298538CADB8\6"	 = "Devices AepService AepId"
		"C9C141A9-1B4C-4F17-A9D1-F298538CADB8\7"	 = "Devices AepService ParentAepIsPaired"
		"C9C34F84-2241-4401-B607-BD20ED75AE7F\100"   = "Communication HeaderItem"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\2"	 = "DeviceInterface Hid UsagePage"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\3"	 = "DeviceInterface Hid UsageId"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\4"	 = "DeviceInterface Hid IsReadOnly"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\5"	 = "DeviceInterface Hid VendorId"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\6"	 = "DeviceInterface Hid ProductId"
		"cbf38310-4a17-4310-a1eb-247f0b67593b\7"	 = "Device Interface Hid Version Number"
		"cc158e89-6581-4311-9637-a8da9002f118\2"	 = "Connected Search Require Install"
		"CC301630-B192-4C22-B372-9F4C6D338E07\100"   = "PropGroup General"
		"CC6F4F24-6083-4BD4-8754-674D0DE87AB8\100"   = "Contact EmailName"
		"CD102C9C-5540-4A88-A6F6-64E4981C8CD1\100"   = "Contact AssistantName"
		"CD9ED458-08CE-418F-A70E-F912C7BB9C5C\103"   = "Message MessageClass"
		"CDBFC167-337E-41D8-AF7C-8C09205429C7\100"   = "ApplicationDefinedProperties"
		"CDEDCF30-8919-44DF-8F4C-4EB2FFDB8D89\100"   = "Photo ExposureIndexNumerator"
		"CE50C159-2FB8-41FD-BE68-D3E042E274BC\2"	 = "Sync HandlerName"
		"CE50C159-2FB8-41FD-BE68-D3E042E274BC\3"	 = "Sync ItemName"
		"CE50C159-2FB8-41FD-BE68-D3E042E274BC\4"	 = "Sync ConflictDescription"
		"CE50C159-2FB8-41FD-BE68-D3E042E274BC\6"	 = "Sync ConflictFirstLocation"
		"CE50C159-2FB8-41FD-BE68-D3E042E274BC\7"	 = "Sync ConflictSecondLocation"
		"ce50c159-2fb8-41fd-be68-d3e042e274bc\10"    = "Sync Conflict Unresolvable"
		"CEA820B9-CE61-4885-A128-005D9087C192\100"   = "GPS DestLatitudeRef"
		"cebf9b37-26ae-466b-9fe9-c7550c4b0ce8\100"   = "Transfer Path"
		"cf5751fd-f4b3-443d-b31c-9a34740759ec\100"   = "Search Scope"
		"CFA31B45-525D-4998-BB44-3F7D81542FA4\100"   = "Media DlnaProfileID"
		"CFC08D97-C6F7-4484-89DD-EBEF4356FE76\100"   = "Photo FocalPlaneXResolution"
		"D042D2A1-927E-40B5-A503-6EDBD42A517E\100"   = "Contact PhoneNumbersCanonical"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\2"	 = "Devices InterfacePaths"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\3"	 = "Devices FunctionPaths"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\10"    = "Devices PrimaryCategory"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\257"   = "Devices Status1"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\258"   = "Devices Status2"
		"D08DD4C0-3A9E-462E-8290-7B636B2576B9\259"   = "Devices Status"
		"D0A04F0A-462A-48A4-BB2F-3706E88DBD7D\100"   = "ItemAuthors"
		"D0C7F054-3F72-4725-8527-129A577CB269\100"   = "SensitivityText"
		"D0DAB0BA-368A-4050-A882-6C010FD19A4F\100"   = "PropGroup Content"
		"D21A7148-D32C-4624-8900-277210F79C0F\100"   = "Image CompressedBitsPerPixelNumerator"
		"D35F743A-EB2E-47F2-A286-844132CB1427\100"   = "Photo EXIFVersion"
		"D37D52C6-261C-4303-82B3-08B926AC6F12\100"   = "Task BillingInformation"
		"D4729704-8EF1-43EF-9024-2BD381187FD5\100"   = "Contact Children"
		"D4BF61B3-442E-4ADA-882D-FA7B70C832D9\6"	 = "Devices Aep PointOfService ConnectionTypes"
		"D4D0AA16-9948-41A4-AA85-D97FF9646993\100"   = "ItemParticipants"
		"D55BAE5A-3892-417A-A649-C6AC5AAAEAB3\100"   = "Calendar OptionalAttendeeAddresses"
		"d5cdd502-2e9c-101b-9397-08002b2cf9ae\1"	 = "Codepage"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\2"	 = "Category"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\3"	 = "Document PresentationFormat"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\4"	 = "Document ByteCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\5"	 = "Document LineCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\6"	 = "Document ParagraphCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\7"	 = "Document SlideCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\8"	 = "Document NoteCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\9"	 = "Document HiddenSlideCount"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\10"    = "Document MultimediaClipCount"
		"d5cdd502-2e9c-101b-9397-08002b2cf9ae\11"    = "Scale"
		"d5cdd502-2e9c-101b-9397-08002b2cf9ae\12"    = "Headingpair"
		"d5cdd502-2e9c-101b-9397-08002b2cf9ae\13"    = "Document Parts"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\14"    = "Document Manager"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\15"    = "Company"
		"d5cdd502-2e9c-101b-9397-08002b2cf9ae\16"    = "Document Links Dirty"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\26"    = "ContentType"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\27"    = "ContentStatus"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\28"    = "Language"
		"D5CDD502-2E9C-101B-9397-08002B2CF9AE\29"    = "Document Version"
		"D6304E01-F8F5-4F45-8B15-D024A6296789\100"   = "Contact PagerTelephone"
		"D68DBD8A-3374-4B81-9972-3EC30682DB3D\100"   = "Contact IMAddress"
		"D6942081-D53B-443D-AD47-5E059D9CD27A\2"	 = "Shell SFGAOFlagsStrings"
		"D6942081-D53B-443D-AD47-5E059D9CD27A\3"	 = "Link TargetSFGAOFlagsStrings"
		"D6B5B883-18BD-4B4D-B2EC-9E38AFFEDA82\2"	 = "Devices SmartCards ReaderKind"
		"d6cf9145-d365-471b-bcb8-f0b4a96b891c\100"   = "Fonts ActiveStatus"
		"D7313FF1-A77A-401C-8C99-3DBDD68ADD36\100"   = "ItemNamePrefix"
		"d76e7ba8-dfa6-48e7-9670-d62dfb07206b\2"	 = "Connected Search Contract Id"
		"d76e7ba8-dfa6-48e7-9670-d62dfb07206b\3"	 = "Connected Search App Min Version"
		"d76e7ba8-dfa6-48e7-9670-d62dfb07206b\4"	 = "Connected Search App Installed State"
		"D7750EE0-C6A4-48EC-B53E-B87B52E6D073\100"   = "ImageParsingName"
		"D7B61C70-6323-49CD-A5FC-C84277162C97\100"   = "Photo FlashEnergyDenominator"
		"D98BE98B-B86B-4095-BF52-9D23B2E0A752\100"   = "PriorityText"
		"d9c22960-532c-4bc6-9876-7b12b52593d7\2"	 = "Protocol Name"
		"DA520E51-F4E9-4739-AC82-02E0A95C9030\100"   = "Identity QualifiedUserName"
		"DA5D0862-6E76-4E1B-BABD-70021BD25494\100"   = "GPS Speed"
		"DC54FD2E-189D-4871-AA01-08C2F57A4ABC\100"   = "FlagStatusText"
		"DC5877C7-225F-45F7-BAC7-E81334B6130A\100"   = "GPS ImgDirectionNumerator"
		"DC8F80BD-AF1E-4289-85B6-3DFC1B493992\100"   = "Message ConversationID"
		"DC8F80BD-AF1E-4289-85B6-3DFC1B493992\101"   = "Message ConversationIndex"
		"DCCB10AF-B4E2-4B88-95F9-031B4D5AB490\100"   = "Photo FocalPlaneXResolutionNumerator"
		"dce33a78-aa18-4b3d-b1df-a6621ac8bdd2\2"	 = "Connected Search Bypass View Action"
		"dd141766-313a-4a30-90f0-056a7c968437\2"	 = "Print Status Document Count"
		"dd141766-313a-4a30-90f0-056a7c968437\3"	 = "Print Status Error Status"
		"dd141766-313a-4a30-90f0-056a7c968437\4"	 = "Print Status Location"
		"dd141766-313a-4a30-90f0-056a7c968437\5"	 = "Print Status Comment"
		"dd141766-313a-4a30-90f0-056a7c968437\6"	 = "Print Status Preferences"
		"dd141766-313a-4a30-90f0-056a7c968437\7"	 = "Print Status Warning Status"
		"dd141766-313a-4a30-90f0-056a7c968437\8"	 = "Print Status Info Status"
		"dd141766-313a-4a30-90f0-056a7c968437\9"	 = "Scan Status Profile"
		"DDD1460F-C0BF-4553-8CE4-10433C908FB0\100"   = "Contact BusinessAddressStreet"
		"DE00DE32-547E-4981-AD4B-542F2E9007D8\100"   = "PropGroup Camera"
		"DE35258C-C695-4CBC-B982-38B0AD24CED0\2"	 = "Shell OmitFromView"
		"DE41CC29-6971-4290-B472-F59F2E2F31E2\100"   = "Media DateReleased"
		"DE5EF3C7-46E1-484E-9999-62C5308394C1\100"   = "Contact PrimaryAddressPostOfficeBox"
		"DE621B8F-E125-43A3-A32D-5665446D632A\25"    = "Security EncryptionOwnersDisplay"
		"de9e220b-41d4-4690-8b6b-3d89e231eef1\100"   = "Fonts Family Name"
		"DEA7C82C-1D89-4A66-9427-A4E3DEBABCB1\100"   = "Journal Contacts"
		"debda43a-37b3-4383-91e7-4498da2995ab\1"	 = "WNET Scope"
		"debda43a-37b3-4383-91e7-4498da2995ab\2"	 = "WNET Type"
		"debda43a-37b3-4383-91e7-4498da2995ab\3"	 = "WNET DisplayType"
		"debda43a-37b3-4383-91e7-4498da2995ab\4"	 = "WNET Usage"
		"debda43a-37b3-4383-91e7-4498da2995ab\5"	 = "WNET Local Name"
		"debda43a-37b3-4383-91e7-4498da2995ab\6"	 = "WNET Remote Name"
		"debda43a-37b3-4383-91e7-4498da2995ab\7"	 = "WNET Comment"
		"debda43a-37b3-4383-91e7-4498da2995ab\8"	 = "WNET Provider"
		"DEEB2DB5-0696-4CE0-94FE-A01F77A45FB5\102"   = "Music ArtistSortOverride"
		"DF975FD3-250A-4004-858F-34E29A3E37AA\100"   = "PropGroup Contact"
		"DFB9A04D-362F-4CA3-B30B-0254B17B5B84\100"   = "ParsingBindContext"
		"E08805C8-E395-40DF-80D2-54F0D6C43154\100"   = "Document DocumentID"
		"E1277516-2B5F-4869-89B1-2E585BD38B7A\100"   = "Photo LensModel"
		"E13D8975-81C7-4948-AE3F-37CAE11E8FF7\100"   = "Photo ShutterSpeedDenominator"
		"E1A9A38B-6685-46BD-875E-570DC7AD7320\100"   = "Photo ApertureDenominator"
		"e1ad4953-a752-443c-93bf-80c7525566c2\2"	 = "Connected Search Type"
		"e1ad4953-a752-443c-93bf-80c7525566c2\3"	 = "Connected Search Rendering Template"
		"e1ad4953-a752-443c-93bf-80c7525566c2\4"	 = "Connected Search Fallback Template"
		"e1ad4953-a752-443c-93bf-80c7525566c2\5"	 = "Connected Search Telemetry Id"
		"e1ad4953-a752-443c-93bf-80c7525566c2\6"	 = "Connected Search Impression Id"
		"e1ad4953-a752-443c-93bf-80c7525566c2\7"	 = "Connected Search Is Visibility Tracked"
		"e1ad4953-a752-443c-93bf-80c7525566c2\8"	 = "Connected Search Telemetry Data"
		"e1ad4953-a752-443c-93bf-80c7525566c2\9"	 = "Connected Search Application Search Scope"
		"e1ad4953-a752-443c-93bf-80c7525566c2\10"    = "Connected Search Parent Id"
		"e1ad4953-a752-443c-93bf-80c7525566c2\11"    = "Connected Search Child Count"
		"e1ad4953-a752-443c-93bf-80c7525566c2\12"    = "Connected Search Top Level Id"
		"e1ad4953-a752-443c-93bf-80c7525566c2\13"    = "Connected Search Is Visible By Default"
		"e1ad4953-a752-443c-93bf-80c7525566c2\14"    = "Connected Search Is Activatable"
		"e1ad4953-a752-443c-93bf-80c7525566c2\15"    = "Connected Search Suggestion Context"
		"e1ad4953-a752-443c-93bf-80c7525566c2\16"    = "Connected Search Region Id"
		"e1ad4953-a752-443c-93bf-80c7525566c2\17"    = "Connected Search Item Source"
		"e1ad4953-a752-443c-93bf-80c7525566c2\18"    = "Connected Search Activation Command"
		"e1ad4953-a752-443c-93bf-80c7525566c2\19"    = "Connected Search Is History Item"
		"e1ad4953-a752-443c-93bf-80c7525566c2\20"    = "Connected Search Is App Available"
		"e1ad4953-a752-443c-93bf-80c7525566c2\21"    = "Connected Search History Title"
		"e1ad4953-a752-443c-93bf-80c7525566c2\22"    = "Connected Search History Description"
		"e1ad4953-a752-443c-93bf-80c7525566c2\23"    = "Connected Search History Glyph"
		"e1ad4953-a752-443c-93bf-80c7525566c2\27"    = "Connected Search Requires Consent"
		"e1ad4953-a752-443c-93bf-80c7525566c2\28"    = "Connected Search Copy Text"
		"e1ad4953-a752-443c-93bf-80c7525566c2\29"    = "Connected Search Add Open In Browser Command"
		"e1ad4953-a752-443c-93bf-80c7525566c2\30"    = "Connected Search Image Url"
		"e1ad4953-a752-443c-93bf-80c7525566c2\31"    = "Connected Search Image Prefetch Stage"
		"e1ad4953-a752-443c-93bf-80c7525566c2\32"    = "Connected Search Is Local Item"
		"E1D4A09E-D758-4CD1-B6EC-34A8B5A73F80\100"   = "Contact BusinessAddressPostalCode"
		"e2d40928-632c-4280-a202-e0c2ad1ea0f4\2"	 = "Connected Search Qs Code"
		"e2d40928-632c-4280-a202-e0c2ad1ea0f4\3"	 = "Connected Search Jump List"
		"e2d40928-632c-4280-a202-e0c2ad1ea0f4\4"	 = "Connected Search Voice Command Examples"
		"e32596b0-1163-4e02-867a-12132db4ba06\2"	 = "IE FeedItem Local Id"
		"E3690A87-0FA8-4A2A-9A9F-FCE8827055AC\100"   = "PropGroup Image"
		"E3A7D2C1-80FC-4B40-8F34-30EA111BDC2E\100"   = "PropGroup FileSystem"
		"E4F10A3C-49E6-405D-8288-A23BD4EEAA6C\100"   = "FileExtension"
		"E53D799D-0F3F-466E-B2FF-74634A3CB7A4\100"   = "Contact PrimaryAddressCountry"
		"e5473742-4611-4aaf-9c49-a3417748cbc8\100"   = "Invalid Path Value"
		"E55FC3B0-2B60-4220-918E-B21E8BF16016\100"   = "Identity UniqueID"
		"E6822FEE-8C17-4D62-823C-8E9CFCBD1D5C\100"   = "Audio IsVariableBitRate"
		"e6c3d9ad-7b32-4efe-a167-0a868ffdf3af\100"   = "Game WinSPR Minimum"
		"E6DDCAF7-29C5-4F0A-9A68-D19412EC7090\100"   = "Photo LensManufacturer"
		"e77e90df-6271-4f5b-834f-2dd1f245dda4\2"	 = "Storage Provider UI Status"
		"e77e90df-6271-4f5b-834f-2dd1f245dda4\3"	 = "Storage Provider State"
		"e77e90df-6271-4f5b-834f-2dd1f245dda4\4"	 = "Storage Provider Transfer Progress"
		"E7B33238-6584-4170-A5C0-AC25EFD9DA56\100"   = "PropGroup RecordedTV"
		"E7C3FB29-CAA7-4F47-8C8B-BE59B330D4C5\2"	 = "Devices Aep ContainerId"
		"E7C3FB29-CAA7-4F47-8C8B-BE59B330D4C5\3"	 = "Devices Aep CanPair"
		"E8309B6E-084C-49B4-B1FC-90A80331B638\100"   = "Photo PeopleNames"
		"e88dcce0-b7b3-11d1-a9f0-00aa0060fa31\2"	 = "Zip Folder Encrypted"
		"e88dcce0-b7b3-11d1-a9f0-00aa0060fa31\3"	 = "Zip Folder Method"
		"e88dcce0-b7b3-11d1-a9f0-00aa0060fa31\4"	 = "Zip Folder Ratio"
		"e88dcce0-b7b3-11d1-a9f0-00aa0060fa31\5"	 = "Zip Folder CRC32"
		"e88dcce0-b7b3-11d1-a9f0-00aa0060fa31\6"	 = "Zip Folder Compressed Size"
		"E92A2496-223B-4463-A4E3-30EABBA79D80\100"   = "Photo FNumberDenominator"
		"e9641eff-af25-4db7-947b-4128929f8ef5\2"	 = "Connected Search Suggestion Detail Text"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\102"   = "Structured Query Virtual Bcc"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\103"   = "Structured Query Virtual Cc"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\104"   = "Structured Query Virtual From"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\105"   = "Structured Query Virtual To"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\106"   = "Structured Query Virtual Organizer"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\107"   = "Structured Query Virtual Required Attendees"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\108"   = "Structured Query Virtual Optional Attendees"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\109"   = "Structured Query Virtual Resources"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\110"   = "Structured Query Virtual Date Created"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\111"   = "Structured Query Virtual Phone"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\112"   = "Structured Query Virtual Message Size"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\113"   = "Structured Query Virtual About"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\114"   = "Structured Query Virtual Is Read"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\115"   = "Structured Query Virtual Journal Duration"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\116"   = "Structured Query Virtual Is Encrypted"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\117"   = "Structured Query Virtual Type"
		"e9edd392-0b4c-4cf2-82c0-b0d139666245\118"   = "Structured Query Virtual Artist"
		"ea810849-87ff-4b54-abd6-5b71adf466f8\1"	 = "Dui Control Resource"
		"EC0B4191-AB0B-4C66-90B6-C6637CDEBBAB\100"   = "Communication PolicyTag"
		"ECF4B6F6-D5A6-433C-BB92-4076650FC890\100"   = "GPS DestLatitudeNumerator"
		"ECF7F4C9-544F-4D6D-9D98-8AD79ADAF453\100"   = "GPS SpeedRef"
		"ED4DF2D3-8695-450B-856F-F5C1C53ACB66\100"   = "GPS DestDistanceRef"
		"ee31306c-fb9b-4d62-8621-3575d972a9f9\1718"  = "Volume BitLocker Requires Admin"
		"EE3D3D8A-5381-4CFA-B13B-AAF66B5F4EC9\100"   = "Photo WhiteBalance"
		"EEC7B761-6F94-41B1-949F-C729720DD13C\12"    = "DeviceInterface PrinterPortName"
		"EF1167EB-CBFC-4341-A568-A7C91A68982C\2"	 = "Devices WiFi InterfaceGuid"
		"EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902\100"   = "IsShared"
		"EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902\200"   = "SharedWith"
		"EF884C5B-2BFE-41BB-AAE5-76EEDF4F9902\300"   = "SharingStatus"
		"ef884c5b-2bfe-41bb-aae5-76eedf4f9902\400"   = "Share Scope"
		"F04BEF95-C585-4197-A2B7-DF46FDC9EE6D\100"   = "KindText"
		"F0F7984D-222E-4AD2-82AB-1DD8EA40E57E\300"   = "TitleSortOverride"
		"F1176DFE-7138-4640-8B4C-AE375DC70A6D\100"   = "Contact PrimaryAddressState"
		"F18DEDF3-337F-42C0-9E03-CEE08708A8C3\100"   = "Identity LogonStatusString"
		"F1A24AA7-9CA7-40F6-89EC-97DEF9FFE8DB\100"   = "Contact FileAsName"
		"F1FDB4AF-F78C-466C-BB05-56E92DB0B8EC\103"   = "Music AlbumArtistSortOverride"
		"F21D9941-81F0-471A-ADEE-4E74B49217ED\100"   = "ProviderItemID"
		"F2275480-F782-4291-BD94-F13693513AEC\0"	 = "PropList XPDetailsPanel"
		"F23F425C-71A1-4FA8-922F-678EA4A60408\100"   = "IsAttachment"
		"F271C659-7E5E-471F-BA25-7F77B286F836\100"   = "Contact BusinessEmailAddresses"
		"f27abe3a-7111-4dda-8cb2-29222ae23566\2"	 = "Connected Search Disambiguation Id"
		"F334115E-DA1B-4509-9B3D-119504DC7ABB\100"   = "Document Contributor"
		"F3713ADA-90E3-4E11-AAE5-FDC17685B9BE\100"   = "PropGroup GPS"
		"f3aecac4-5b8d-436a-ad0c-64ab194fdaf3\100"   = "Fonts Collection Name"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\2"	 = "App Contract Pinned"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\3"	 = "App Contract Hidden"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\4"	 = "App Contract Pinned Order"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\5"	 = "App Contract Relevance"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\6"	 = "App Contract Category"
		"f3c9b698-be85-47ce-888f-83874d9abcb4\7"	 = "App Contract Supported File Types"
		"F3D8F40D-50CB-44A2-9718-40CB9119495D\100"   = "Contact Initials"
		"f50d2f5d-dda0-48d4-8d2b-e83729fb69a4\100"   = "Item Query Condition"
		"F6272D18-CECC-40B1-B26A-3911717AA7BD\100"   = "Calendar Location"
		"F628FD8C-7BA8-465A-A65B-C5AA79263A9E\100"   = "Photo MeteringModeText"
		"F7DB74B4-4287-4103-AFBA-F1B13DCD75CF\100"   = "ItemDate"
		"f8245476-2ec6-44be-b2f7-82ec2537fa2e\100"   = "Condition"
		"f8245476-2ec6-44be-b2f7-82ec2537fa2e\101"   = "Condition Key"
		"F85BF840-A925-4BC2-B0C4-8E36B598679E\100"   = "Photo DigitalZoom"
		"F8D3F6AC-4874-42CB-BE59-AB454B30716A\100"   = "Sensitivity"
		"F8FA7FA3-D12B-4785-8A4E-691A94F7A3E7\100"   = "Contact EmailAddress"
		"FA303353-B659-4052-85E9-BCAC79549B84\100"   = "Photo MakerNote"
		"FA304789-00C7-4D80-904A-1E4DCC7265AA\100"   = "Photo GainControl"
		"FB1DE864-E06D-47F4-82A6-8A0AEF44493C\2"	 = "Devices AudioDevice SpeechProcessingSupported"
		"FB3842CD-9E2A-4F83-8FCC-4B0761139AE9\2"	 = "DeviceInterface Proximity SupportsNfc"
		"FC6976DB-8349-4970-AE97-B3C5316A08F0\100"   = "Photo Sharpness"
		"FC9F7306-FF8F-4D49-9FB6-3FFE5C0951EC\100"   = "Contact Department"
		"FCAD3D3D-0858-400F-AAA3-2F66CCE2A6BC\100"   = "Photo FlashEnergyNumerator"
		"FCC16823-BAED-4F24-9B32-A0982117F7FA\100"   = "Identity PrimaryEmailAddress"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\100"   = "FileOfflineAvailabilityStatus"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\101"   = "FolderKind"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\103"   = "SyncTransferStatus"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\104"   = "TransferPosition"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\105"   = "TransferSize"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\106"   = "TransferOrder"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\107"   = "LastSyncError"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\108"   = "StorageProviderId"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\109"   = "StorageProviderError"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\110"   = "StorageProviderStatus"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\111"   = "StorageProviderShareStatuses"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\112"   = "StorageProviderFileRemoteUri"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\113"   = "CachedFileUpdaterContentIdForStream"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\114"   = "CachedFileUpdaterContentIdForConflictResolution"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\115"   = "RemoteConflictingFile"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\116"   = "Storage Provider Thumbnail Dimensions"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\117"   = "StorageProviderSharingStatus"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\118"   = "Storage Provider Descendant Sharing Status"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\119"   = "Storage Provider Fully Qualified Id"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\120"   = "Storage Provider Custom States"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\121"   = "Item Custom State State List"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\122"   = "Item Custom State Values"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\123"   = "Item Custom State Icon References"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\124"   = "Storage Provider Aggregated Custom States"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\125"   = "Storage Provider Network Connected"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\126"   = "Storage Provider Warning Error State"
		"fceff153-e839-4cf3-a9e7-ea22832094b8\127"   = "Storage Provider Protection Mode"
		"fcfb52aa-c1e5-4cd8-88bc-f80fd7390f20\100"   = "Not User Content"
		"FD122953-FA93-4EF7-92C3-04C946B2F7C8\100"   = "Music DisplayArtist"
		"fd9d9fc7-38ec-436d-8fc6-ec39bad301e6\100"   = "Computer Processor"
		"fd9d9fc7-38ec-436d-8fc6-ec39bad301e6\101"   = "Computer Memory"
		"FDF84370-031A-4ADD-9E91-0D775F1C6605\100"   = "MileageInformation"
		"FE83BB35-4D1A-42E2-916B-06F3E1AF719E\100"   = "Photo FlashModel"
		"fe9e4c12-aacb-4aa3-966d-91a29e6128b5\3"	 = "Printer Default"
		"fe9e4c12-aacb-4aa3-966d-91a29e6128b5\4"	 = "Printer Location"
		"fe9e4c12-aacb-4aa3-966d-91a29e6128b5\5"	 = "Printer Model"
		"fe9e4c12-aacb-4aa3-966d-91a29e6128b5\6"	 = "Printer Queue Size"
		"fe9e4c12-aacb-4aa3-966d-91a29e6128b5\7"	 = "Printer Status"
		"FEC690B7-5F30-4646-AE47-4CAAFBA884A3\100"   = "Photo ExposureProgramText"
		"fec7952b-4bf0-4c03-b6e1-2796818b7ca9\100"   = "Fonts Version"
		"FF1167EB-CBFC-4341-A568-A7C91A68982C\2"	 = "Devices Wwan InterfaceGuid"
		"FF962609-B7D6-4999-862D-95180D529AEA\100"   = "Contact OtherAddressStreet"
		"FFAE9DB7-1C8D-43FF-818C-84403AA3732D\100"   = "SourcePackageFamilyName"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\2"	 = "System FilterInfo"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\3"	 = "Kind"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\5"	 = "System WordWheel"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\6"	 = "FullText"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\7"	 = "System ItemsInStack"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\8"	 = "System ItemId"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\9"	 = "System DelegationFlags"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\10"    = "System ItemSourceCLSID"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\11"    = "System DelegateSourceId"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\12"    = "System Generic_String"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\13"    = "System Generic_Integer"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\14"    = "System Generic_DateTime"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\15"    = "System Generic_Boolean"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\16"    = "System Generic_FloatingPoint"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\17"    = "System ResultSourceId"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\19"    = "System ChapterId"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\20"    = "System ResultType"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\23"    = "System WebPreviewUrl"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\24"    = "System ThumbnailCacheIdParts"
		"1E3EE840-BC2B-476C-8237-2ACD1A839B22\25"    = "System ItemContext"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\5"	 = "DeviceInterface Bluetooth ModelNumber"
		"2DAD1EB7-816D-40D3-9EC3-C9773BE2AADE\100"   = "GPS AltitudeNumerator"
		"2CBAA8F5-D81F-47CA-B17A-F8D822300131\100"   = "DateAcquired"
		"2BDA47DA-08C6-4FE1-80BC-A72FC517C5D0\100"   = "GPS DestDistanceNumerator"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\9"	 = "StorageProviderFileHasConflict"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\4"	 = "DeviceInterface Bluetooth Manufacturer"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\6"	 = "Hardware Manufacturer"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\1"	 = "DeviceInterface Bluetooth DeviceAddress"
		"2BE9260A-2012-4742-A555-F41B638B7DCB\2"	 = "Devices Notifications NewMessage"
		"C07B4199-E1DF-4493-B1E1-DE5946FB58F8\100"   = "Address Country"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\37"    = "AppUserModel UninstallCommand"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\7 "    = "Computer DecoratedFreeSpace"
		"F29F85E0-4FF9-1068-AB91-08002B27B3D9\2"	 = "Title"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\12"    = "Devices Aep Bluetooth LastSeenTime"
		"26DC287C-6E3D-4BD3-B2B0-6A26BA2E346D\3"	 = "StatusBarSelectedItemCount"
		"2425166F-5642-4864-992F-98FD98F294C3\100"   = "IdentityProvider Picture"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\9"	 = "Hardware DriverVersion"
		"1D6179A6-A876-4031-B013-3347B2B64DC8\100"   = "Photo FocalPlaneYResolutionDenominator"
		"5CBF2787-48CF-4208-B90E-EE5E5D420294\2 "    = "Link TargetUrl"
		"22704DA4-C6B2-4A99-8E56-F16DF8C92599\100"   = "GPS VersionID"
		"000214A1-0000-0000-C000-000000000046\9"	 = "Status"
		"276D7BB0-5B34-4FB0-AA4B-158ED12A1809\100"   = "Document ClientID"
		"8943B373-388C-4395-B557-BC6DBAFFAFDB\6"	 = "Devices AudioDevice Microphone IsFarField"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\8"	 = "DeviceInterface Bluetooth ProductId"
		"2598D2FB-5569-4367-95DF-5CD3A177E1A5\100"   = "PropGroup Origin"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\6"	 = "Supplemental Album"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\10"    = "Hardware DriverProvider"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\11"    = "Hardware DriverDate"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\2"	 = "Hardware Name"
		"8DBC9C86-97A9-4BFF-9BC6-BFE95D3E6DAD\2"	 = "Devices Panel PanelId"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\4096"  = "Hardware Status"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\4098"  = "Hardware Image"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\4099"  = "Hardware Function"
		"2B1B801E-C0C1-4987-9EC5-72FA89814787\100"   = "Identity PrimarySid"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\128"   = "LastSyncWarning"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\5 "    = "PercentFull"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\11"    = "DeviceInterface Bluetooth LastConnectedTime"
		"C07B4199-E1DF-4493-B1E1-DE5946FB58F8\101"   = "Address CountryCode"
		"2A785BA9-8D23-4DED-82E6-60A350C86A10\100"   = "Photo Contrast"
		"2579E5D0-1116-4084-BD9A-9B4F7CB4DF5E\100"   = "Audio PeakValue"
		"32CE38B2-2C9A-41B1-9BC5-B3784394AA44\2"	 = "EdgeGesture DisableTouchWhenFullscreen"
		"5CBF2787-48CF-4208-B90E-EE5E5D420294\21 "   = "Link Description"
		"5CBF2787-48CF-4208-B90E-EE5E5D420294\23 "   = "Link DateVisited"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\6"	 = "DeviceInterface Bluetooth VendorIdSource"
		"AECF2FE8-1D00-4FEE-8A6D-A70D719B772B\2"	 = "Devices PhoneLineTransportDevice Connected"
		"0774315E-B714-48EC-8DE8-8125C077AC11\2"	 = "Devices ChallengeAep"
		"CBF38310-4A17-4310-A1EB-247F0B67593B\9"	 = "DeviceInterface Hid VersionNumber"
		"257E44E2-9031-4323-AC38-85C552871B2E\100"   = "Photo ExposureTimeNumerator"
		"2C53C813-FB63-4E22-A1AB-0B331CA1E273\100"   = "RecordedTV NetworkAffiliation"
		"9B174B35-40FF-11D2-A27E-00C04FC30871\10 "   = "Volume IsRoot"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\5"	 = "Hardware DisplayAttribute"
		"7B03B546-FA4F-4A52-A2FE-03D5311E5865\100"   = "Search ExtendedProperties"
		"1CE0D6BC-536C-4600-B0DD-7E0C66B350D5\8"	 = "History SelectionCount"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\2"	 = "DeviceInterface Bluetooth ServiceGuid"
		"C07B4199-E1DF-4493-B1E1-DE5946FB58F8\102"   = "Address Region"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\7"	 = "Supplemental Person"
		"1CE0D6BC-536C-4600-B0DD-7E0C66B350D5\9"	 = "History TargetUrlHostName"
		"026E516E-B814-414B-83CD-856D6FEF4822\9"	 = "Devices SchematicName"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\31"    = "AppUserModel VisualElementsManifestHintPath"
		"2CA2DAE6-EDDC-407D-BEF1-773942ABFA95\100"   = "GPS MapDatum"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\3"	 = "Hardware Icon"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\131"   = "ContentUri"
		"2E4B640D-5019-46D8-8881-55414CC5CAA0\100"   = "Media DateEncoded"
		"305BC615-DCA1-44A5-9FD4-10C0BA79412E\100"   = "Photo FocalLengthDenominator"
		"B2F9B9D6-FEC4-4DD5-94D7-8957488C807B\8"	 = "StorageProviderFileFlags"
		"293CA35A-09AA-4DD2-B180-1FE245728A52\100"   = "Calendar Duration"
		"8DBC9C86-97A9-4BFF-9BC6-BFE95D3E6DAD\3"	 = "Devices Panel PanelGroup"
		"8943B373-388C-4395-B557-BC6DBAFFAFDB\5"	 = "Devices AudioDevice Microphone SensitivityInDbfs2"
		"1E81A3F8-A30F-4247-B9EE-1D0368A9425C\2"	 = "DataObjectFormat"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\7"	 = "DeviceInterface Bluetooth VendorId"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\5"	 = "Supplemental Location"
		"FCEFF153-E839-4CF3-A9E7-EA22832094B8\132"   = "ContentId"
		"26DC287C-6E3D-4BD3-B2B0-6A26BA2E346D\2"	 = "StatusBarViewItemCount"
		"1F8844E1-24AD-4508-9DFD-5326A415CE02\100"   = "Image CompressedBitsPerPixelDenominator"
		"9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3\38"    = "AppUserModel SettingsCommand"
		"C07B4199-E1DF-4493-B1E1-DE5946FB58F8\103"   = "Address RegionCode"
		"1E005EE6-BF27-428B-B01C-79676ACD2870\100"   = "Document Division"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\9"	 = "DeviceInterface Bluetooth ProductVersion"
		"2BD67D8B-8BEB-48D5-87E0-6CDA3428040A\3"	 = "DeviceInterface Bluetooth Flags"
		"C07B4199-E1DF-4493-B1E1-DE5946FB58F8\104"   = "Address Town"
		"1F856A9F-6900-4ABA-9505-2D5F1B4D66CB\100"   = "Message ToDoFlags"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\4100"  = "Hardware ShellAttributes"
		"2804D469-788F-48AA-8570-71B9C187E138\100"   = "PropGroup Audio"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\8"	 = "Hardware SerialNumber"
		"0C73B141-39D6-4653-A683-CAB291EAF95B\4"	 = "Supplemental Tag"
		"5EAF3EF2-E0CA-4598-BF06-71ED1D9DD953\7"	 = "Hardware Model"
		"5CBF2787-48CF-4208-B90E-EE5E5D420294\7 "    = "History VisitCount"
	}
	
	# This also the Filename offset 
	$Host_OS = [Ordered]@{
		'46' = 'Windows 8.1/10/11'
		'42' = 'Windows 2000/7/8'
		'38' = 'Windows Vista'
		'20' = 'Windows XP/2003'
	}
	
	$CPitems = [ordered]@{
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
	}
	
	# ..\10.0.22621.0\um\shellapi.h
	$StockIconIDs = [ordered]@{
		'-1'  = "Invalid SHSTOCKICONID "
		'0'   = 'Document with no associated application'
		'1'   = 'Document with an associated application'
		'2'   = 'Generic application'
		'3'   = 'Generic Folder'
		'4'   = 'Folder (open)'
		'5'   = '5.25-inch disk drive'
		'6'   = '3.5-inch disk drive'
		'7'   = 'Removable drive'
		'8'   = 'Fixed drive (hard disk)'
		'9'   = 'Network drive (connected)'
		'10'  = 'Network drive (disconnected)'
		'11'  = 'CD drive'
		'12'  = 'RAM disk drive'
		'13'  = 'The entire network'
		'15'  = 'A computer on the network'
		'16'  = 'A local printer or print destination'
		'17'  = 'The Network virtual folder'
		'22'  = 'The Search feature'
		'23'  = 'The Help and Support feature'
		'27'  = 'Power-Off icon'
		'28'  = 'Overlay for a shared item'
		'29'  = 'Overlay for a shortcut'
		'30'  = 'Overlay for items that are expected to be slow to access'
		'31'  = 'The Recycle Bin (empty)'
		'32'  = 'The Recycle Bin (not empty)'
		'40'  = 'Audio CD media'
		'47'  = 'Security lock'
		'49'  = '(Autolist) A virtual folder that contains the results of a search'
		'50'  = 'A network printer'
		'51'  = 'A server shared on a network'
		'52'  = 'A local fax printer'
		'53'  = 'A network fax printer'
		'54'  = 'A file that receives the output of a Print to file operation'
		'55'  = 'A category that results from a Stack by command to organize the contents of a folder'
		'56'  = 'Super Video CD (SVCD) media'
		'57'  = 'A folder that contains only subfolders as child items'
		'58'  = 'Unknown drive type'
		'59'  = 'DVD drive'
		'60'  = 'DVD media'
		'61'  = 'DVD-RAM media'
		'62'  = 'DVD-RW media'
		'63'  = 'DVD-R media'
		'64'  = 'DVD-ROM media'
		'65'  = 'CD+ (enhanced audio CD) media'
		'66'  = 'CD-RW media'
		'67'  = 'CD-R media'
		'68'  = 'A writable CD in the process of being burned'
		'69'  = 'Blank writable CD media'
		'70'  = 'CD-ROM media'
		'71'  = 'An audio file'
		'72'  = 'An image file'
		'73'  = 'A video file'
		'74'  = 'A mixed file'
		'75'  = 'Folder back'
		'76'  = 'Folder front'
		'77'  = 'Security shield (UAC)'
		'78'  = 'Warning'
		'79'  = 'Informational'
		'80'  = 'Error'
		'81'  = 'Key'
		'82'  = 'Software'
		'83'  = 'A UI item, such as a button, that issues a rename command'
		'84'  = 'A UI item, such as a button, that issues a delete command'
		'85'  = 'Audio DVD media'
		'86'  = 'Movie DVD media'
		'87'  = 'Enhanced CD media'
		'88'  = 'Enhanced DVD media'
		'89'  = 'HD-DVD media'
		'90'  = 'Blu-ray Disc media'
		'91'  = 'Video CD (VCD) media'
		'92'  = 'DVD+R media'
		'93'  = 'DVD+RW media'
		'94'  = 'A desktop computer'
		'95'  = 'A mobile computer (laptop)'
		'96'  = 'The User Accounts Control Panel item'
		'97'  = 'Smart media'
		'98'  = 'CompactFlash media'
		'99'  = 'A cell phone'
		'100' = 'A digital camera'
		'101' = 'A digital video camera'
		'102' = 'An audio player'
		'103' = 'Connect to network'
		'104' = 'The Network and Internet Control Panel item'
		'105' = 'A compressed file with a .zip file name extension'
		'106' = 'The Additional Options Control Panel item'
		'107' = 'internal Vista RTM icon'
		'108' = 'internal Vista RTM icon'
		'109' = 'internal Vista RTM icon'
		'110' = 'internal Vista RTM icon'
		'111' = 'internal Vista RTM icon'
		'112' = 'internal Vista RTM icon'
		'113' = 'internal Vista RTM icon'
		'114' = 'internal Vista RTM icon'
		'115' = 'internal Vista RTM icon'
		'116' = 'internal Vista RTM icon'
		'117' = 'internal Vista RTM icon'
		'118' = 'internal Vista RTM icon'
		'119' = 'internal Vista RTM icon'
		'120' = 'internal Vista RTM icon'
		'121' = 'internal Vista RTM icon'
		'122' = 'internal Vista RTM icon'
		'123' = 'internal Vista RTM icon'
		'124' = 'internal Vista RTM icon'
		'125' = 'internal Vista RTM icon'
		'126' = 'internal Vista RTM icon'
		'127' = 'internal Vista RTM icon'
		'128' = 'internal Vista RTM icon'
		'129' = 'internal Vista RTM icon'
		'130' = 'internal Vista RTM icon'
		'131' = 'internal Vista RTM icon'
		'132' = 'High definition DVD drive'
		'133' = 'High definition Blu-ray drive'
		'134' = 'High definition DVD-ROM media'
		'135' = 'High definition DVD-R media'
		'136' = 'High definition DVD-RAM media'
		'137' = 'High definition DVD-ROM media'
		'138' = 'High definition write-once media'
		'139' = 'High definition Blu-ray R/W media'
		'140' = 'A cluster disk array'
		'141' = 'Internal Vista SP1 icon'
		'142' = 'Internal Vista SP1 icon'
		'143' = 'Internal Vista SP1 icon'
		'144' = 'Internal Vista SP1 icon'
		'145' = 'Internal Vista SP1 icon'
		'146' = 'Internal Vista SP1 icon'
		'147' = 'Internal Vista SP1 icon'
		'148' = 'Internal Vista SP1 icon'
		'149' = 'Internal Vista SP1 icon'
		'150' = 'Internal Vista SP1 icon'
		'151' = 'Internal Vista SP1 icon'
		'152' = 'Internal Vista SP1 icon'
		'153' = 'Internal Vista SP1 icon'
		'154' = 'Internal Vista SP1 icon'
		'155' = 'Internal Vista SP1 icon'
		'156' = 'Internal Vista SP1 icon'
		'157' = 'Internal Vista SP1 icon'
		'158' = 'Internal Vista SP1 icon'
		'159' = 'Internal Vista SP1 icon'
		'160' = 'Internal Windows 7/8/10/11 icon'
		'161' = 'Internal Windows 7/8/10/11 icon'
		'162' = 'Internal Windows 7/8/10/11 icon'
		'163' = 'Internal Windows 7/8/10/11 icon'
		'164' = 'Internal Windows 7/8/10/11 icon'
		'165' = 'Internal Windows 7/8/10/11 icon'
		'166' = 'Internal Windows 7/8/10/11 icon'
		'167' = 'Internal Windows 7/8/10/11 icon'
		'168' = 'Internal Windows 7/8/10/11 icon'
		'169' = 'Internal Windows 7/8/10/11 icon'
		'170' = 'Internal Windows 7/8/10/11 icon'
		'171' = 'Internal Windows 7/8/10/11 icon'
		'172' = 'Internal Windows 7/8/10/11 icon'
		'173' = 'Internal Windows 7/8/10/11 icon'
		'174' = 'Internal Windows 7/8/10/11 icon'
		'175' = 'Internal Windows 7/8/10/11 icon'
		'176' = 'Right Arrow (White on Green)'
		'177' = 'Internal Windows 7/8/10/11 icon'
		'178' = 'Internal Windows 7/8/10/11 icon'
		'179' = 'Internal Windows 7/8/10/11 icon'
		'180' = 'Internal Windows 7/8/10/11 icon'
		'181' = 'SIID_MAX_ICONS'
	}
	
	# https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/ms775141(v=vs.85)
	$UriEntryTypes = [ordered]@{
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
	}
	
	$SortOrderIndex = [Ordered]@{
		'00' = "Shell User's Folder" # ThisPCDesktopRegFolder
		#	'20' = 'Box'
		#	'29' = "ThisPCDocumentsRegFolder"
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
		#	'29' = 'Full Details'
		'77' = 'Linux'
		'78' = 'Recycle Bin'
		'80' = 'All Tasks'
		# '1000' = 'Frequent Places Folder'
	}
	
	# Replaced:
	# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/23bb5877-e3dd-4799-9f50-79f05f938537
	# with these:
	# https://learn.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase-file_remote_protocol_info
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
	$AppIDs = @{
		"E103A1975A1E4D3E" = "JetBrains dotPeek"
		"24607EA4355976C4" = "JetBrains dotPeek"
		"883C2D2F4CD4330E" = "JumplistBrowser"
		"E5E8D6A9806E3122" = "Microsoft Paint (AppX)"
		"48E4D97E866A670A" = "Camtasia CamRecorder"
		"CD812C50F6838125" = "Microsoft Edge (msedgewebview2.exe)"
		"2A2E0412B8AD04A2" = "Microsoft Edge (msedgewebview2.exe)"
		"D7A7AF45CF5068CE" = "PowerISO"
		"C4F3892D2FAA7F4F" = "Perception Liteserve"
		"E4C48386CB92583B" = "Microsoft Windows Parental Controls"
		"3B473B20C18A8521" = "NCH ideoPad Video Editor"
		"96461A9B26BAE85D" = "Microsoft Visual Studio"
		"9CBE1F78CE75B93" = "Electron Twitch" # Chat (UI)
		"E918330A2C118508" = "Google Chrome"
		"26C8E4B9A90483D" = "Rockstar Games Launcher"
		"301F0A7C79F72156" = "Opera GX Gaming Browser"
		"92586431A03F316D" = "Hash Suite (x64)"
		"AA28770954EAEAAA" = "Tor Browser (firefox)"
		"53C3B9E96BDFDA93" = "Mozilla Firefox"
		"82D9DE05E6B6EA92" = "Cyberlink PowerDVD 12"
		"4CC9BCFF1A772A63" = "Microsoft PowerPoint 12"
		"47BB2136FDA3F1ED" = "Microsoft Word 12"
		"5AFE4DE1B92FC382" = "Getting Started"
		"7B641BD20D39D248" = "Box Desktop"
		"60522820A2D53A23" = "OneDrive"
		"2B9265D0BBA6331D" = "Axialis IconWorkshop 6"
		"41F23BB65D5A09DF" = "Telegram"
		"DB53B23FD1EDBD46" = "WinZip (x64)"
		"C9533998E1308D73" = "Microsoft PhotoManager"
		"D67EEC451F4B0A17" = "MS Teams (x64)"
		"E1529BD958616FC"  = "PKZIP for Windows (PKZIP.DropTarget)"
		"E0F5DF85162B2E74" = "Opera"
		"B4866339A794AFCF" = "Paint.Net"
		"39CE6EDE51235EDE" = "Notepad++"
		"9EAE1DD4F073BF2E" = "MiTeC JSON Viewer"
		"82DE7B745170A7A7" = "Microsoft.DesktopAppInstaller_1.21.3421.0_x64__8wekyb3d8bbwe"
		"6FAC1B1908485D3"  = "Windows Font Viewer (fontview.exe)"
		"437ED96A251C0A4E" = "IDA Home (PC) (x64)"
		"187AFBEE4F000AF7" = "WinSCP"
		"B6E75277D637AF45" = "WinSCP"
		"E58F281BBBF7DB50" = "WinSCP"
		"FB5DC9A49DB30CBC" = "IDA Home (PC) (x64)"
		"BB0EB8DC691DC2CB" = "Meridian Audio's MConfig.exe"
		"6D86A7EB1FE36DB5" = "Corel PhotoPaint Home"
		"43DEA41143485508" = "Microsoft Clipchamp"
		"3C9CB00791B6B84C" = "Autodesk DWGTrueView"
		"19E29B56DBA3D8F1" = "FocusMagic"
		"282D650714E18E4E" = "FocusMagic"
		"D7ED28CFC8A00882" = "Windows Subsystem For Android (WsaClient)"
		"D9A573AF9F133B48" = "Windows Subsystem For Android (WsaClient)"
		"8B6C636E68DB7D6F" = "RoonEssentials"
		"362773986BAFAA68" = "MicrosoftTeams"
		"90E73CD9D2BF8B73" = "IsoBuster"
		"0006F647F9488D7A" = "Arsenal Image Mounter"
		"01B29F0DC90366BB" = "Arsenal Image Mounter"
		"044A50E6C87BC012" = "Classic FTP Plus 2.15"
		"06059DF4B02360AF" = "Kadu"
		"0A1D19AFE5A80F80" = "FileZilla"
		"0A79A7CE3C45D781" = "CuteFTP"
		"0CFAB0EC14B6F953" = "Express NewsPictures"
		"0EF606B196796EBB" = "HP MediaSmart Photo"
		"1A89D1BEFE8E90E3" = "Adobe Acrobat Distiller Pro XI (x86)"
		"1B29F0DC90366BB"  = "Arsenal Image Mounter"
		"1CF97C38A5881255" = "MediaPortal"
		"1CFFBE973A437C74" = "DSPlayer Lite"
		"1EB796D87C32EFF9" = "Firefox 5"
		"2D61CCCB4338DFC8" = "BitTorrent"
		"2DB8E25112AB4453" = "Deluge"
		"2FF9DC8FB7E11F39" = "I2P (no window)"
		"3C93A049A30E25E6" = "J. River Media Center 16"
		"3DC02B55E44D6697" = "7-Zip"
		"3E9850346F375D41" = "Foxit Phantom PDF"
		"3ED70EF3495535F7" = "Gravity"
		"3EDF100B207E2199" = "digiKam"
		"4FC234E682FA0FFF" = "Fineprint pdfFactory"
		"4A7E4F6A181D3D08" = "broolzShare"
		"4A49906D074A3AD3" = "Media Go"
		"4AA2A5710DA3EFE0" = "DCSharpHub"
		"4AC866364817F10C" = "Microsoft Edge"
		"4B8A4727AA452343" = "Firefox 56"
		"4B6925EFC53A3C08" = "BCWipe Task Manager"
		"4C58CF9096EF3EFD" = "Kindle for PC"
		"4CB9C5750D51C07F" = "Microsoft Movies & TV (Microsoft.ZuneVideo)"
		"4CDF7858C6673F4B" = "Bullet Proof FTP"
		"4DD48F858B1A6BA7" = "Free Download Manager"
		"4FCEEC8E021AC978" = "CoffeeCup Free FTP"
		"4FD44F9938892CAA" = "CDBurnerXP"
		"5E877DB63DEC2F8"  = "JetBrains dotPeek"
		"5B186FC4A0B40504" = "Dtella (Purdue network only)"
		"5BB830F67194431A" = "7-Zip (x64)"
		"5C450709F7AE4396" = "Firefox (x86)"
		"5D6F13ED567AA2DA" = "Microsoft Office Outlook 2010 (x64)"
		"5DA8F997FD5F9428" = "Internet Explorer (x64)"
		"5DF4765359170E26" = "Firefox 4"
		"6DED8E6DAA05CB0C" = "Cyberlink PhotoDirector 8"
		"6A316AA67A46820B" = "Core FTP LE"
		"6B3A5CE7AD4AF9E4" = "IceChat 9 RC2"
		"6BB98FB8CDC26D69" = "Microsoft Windows Calculator"
		"6BC3383CB68A3E37" = "Apple iTunes"
		"6E855C85DE07BC6A" = "Microsoft Office Excel 2010 (x64)"
		"6F647F9488D7A"    = "Arsenal Image Mounter"
		"7A4BA998575FF2A4" = "FreeCommander XE 2016 (x86)"
		"7B7F65AAECA20A8C" = "Dropbox App"
		"7C2916AFD6F116A6" = "LibreOffice 5 Base"
		"7CB0735D45243070" = "CDisplay"
		"7DCA40FD2A5A971F" = "LibreOffice 5"
		"7E4DCA80246863E3" = "Windows Control Panel"
		"8A461F82E9EB4102" = "Foxit Reader 7"
		"8BD5C6433CA967E9" = "ACDSee Photo Manager 2009"
		"8DCCA8B24A5E822E" = "CDBurnerXP"
		"8DEB27DFA31C5C2A" = "CoffeeCup Free FTP"
		"8F3D7202AA5D4C01" = "ImgBurn"
		"8F852307189803B8" = "Far Manager 2"
		"8FD1364019DC2115" = "Calibre E-Book Manager"
		"9A464053CD82DE6D" = "LINE Messenger"
		"9AD1EC169BF2DA7F" = "FlylinkDC++"
		"9AD84C52EFEAE190" = "1Password"
		"9C32E2313792E6E8" = "Microsoft Windows Disk Cleanup"
		"9CE6555426F54B46" = "HxD"
		"9D1F905CE5044AEE" = "Edge Browser"
		"9D78513A8998829C" = "Microsoft Windows Run Dialog"
		"9E0B3F677A26BBC4" = "BitKinex"
		"9EDAFE4BA4B22CE7" = "Eclipse IDE Oxygen"
		"9FDB10E18CDD0101" = "Cisco AnyConnect Secure Mobility Client"
		"13EB0E5D9A49EAEF" = "Binjet"
		"19E6043495A5B4DA" = "Edit Pad Pro"
		"20EF367747C22564" = "Bullet Proof FTP 2010"
		"22C4D315E96389E0" = "FastCopy 3"
		"22CEFA022402327D" = "Meca Messenger 5"
		"27ECECD8D89B6767" = "Arsenal Image Mounter"
		"28C8B86DEAB549A1" = "Internet Explorer (x86)"
		"28EFB5B6D2E28389" = "EA Origin"
		"30D23723BDD5D908" = "Digsby"
		"31E8AC6B0784ED7D" = "Foxit Reader"
		"36F6BC3EFE1D99E0" = "Alt.Binz"
		"44A50E6C87BC012"  = "Classic FTP Plus"
		"44A398496ACC926D" = "Adobe Premiere Pro CS5 (64-bit)"
		"49DB7ED4F2703C22" = "LogMeIn Client"
		"50C5E019818564E3" = "Microsoft Excel Viewer"
		"59E86071B87AC1C3" = "CuteFTP"
		"59F56184C796CFD4" = "ACDSee Photo Manager 10"
		"65F7DD884B016AB2" = "LimeChat"
		"70D9ADA92108D731" = "IrfanView (x64)"
		"70FFD305907C983B" = "7-Zip"
		"73C6A317412687C2" = "Google Talk"
		"75FDACD8330BAC18" = "AnyDesk"
		"76F6F1BD18C19698" = "aMule"
		"78F0AFB5BD4BB278" = "Microsoft Lync 2016 (x64) (Skype for Business)"
		"83B03B46DCD30A0E" = "Apple iTunes"
		"83DD64E7FA560BD5" = "LibreOffice Calc"
		"84F066768A22CC4F" = "Adobe Photoshop CS5 (x64)"
		"89B0D939F117F75C" = "Adobe Acrobat 9 Pro Extended (x86)"
		"169B3BE0BC43D592" = "FastPictureViewer Professional"
		"174C2C811C286C58" = "InfraRecorder (x64)"
		"177AEB41DEB606AE" = "Adobe Photoshop CS6 (x64)"
		"188F5EC9D11DED56" = "Microsoft Edge"
		"223BF0F360C6FEA5" = "I2P (restartable)"
		"271E609288E1210A" = "Microsoft Office Access 2010 (x86)"
		"319F01BF9FE00F2D" = "Microsoft Access 2013/2016 (x64)"
		"353E9052CCCBEC5D" = "Kindle for PC"
		"386A2F6AA7967F36" = "EyeBrowse"
		"454EF7DCA3BB16B2" = "Exodus"
		"558C5BD9F906860A" = "BearShare Lite"
		"560D789A6A42AD5A" = "DC++ "
		"606A33F5A27B57D4" = "Microsoft Windows Computer Management "
		"714B179E552596DF" = "Bullet Proof FTP"
		"817E5AD5BE351574" = "Microsoft Windows Services"
		"905C98E216107AA1" = "Microsoft Lync 2013 (Skype for Business)"
		"930CF1DD2266E2CB" = "DB Browser for SQLite"
		"966FA7C312D9B10"  = "Eraser"
		"977A5D147AA093F4" = "Lphant"
		"989D7545C2B2E7B2" = "IMVU"
		"1110D9896DCEDDB3" = "imgSeek"
		"1434D6D62D64857D" = "BitLord"
		"2417CAA1F2A881D4" = "ICQ"
		"2437D4D14B056114" = "EiskaltDC++"
		"3094CDB43BF5E9C2" = "Microsoft Office OneNote 2010 (x86)"
		"3198E37206F28DC7" = "CuteFTP Professional"
		"3353B940C074FD0C" = "Microsoft Windows Snipping Tool"
		"3917DD550D7DF9A8" = "Konvertor"
		"4975D6798A8BDF66" = "7-Zip"
		"6059DF4B02360AF"  = "Kadu"
		"6824F4A902C78FBD" = "Firefox (x64)"
		"7010C278903C2B0F" = "Adobe Acrobat XI Pro (x86)"
		"7111C0CE965B7246" = "Battle.net"
		"7494A606A9EEF18E" = "Crystal Player"
		"7526DE4A8B5914D9" = "Forte Agent 6.00"
		"8628E76FD9020E81" = "Fling File Transfer Plus"
		"8904A5FD2D98B546" = "IceChat"
		"9077B9C9CF187CC2" = "KeePass"
		"9749CEA96D411F37" = "HexChat (x64)"
		"9839AEC31243A928" = "Microsoft Office Excel 2010 (x86)"
		"26753C97EA000ECD" = "LibreOffice Math"
		"43886BA3395ACDCC" = "Easy Post"
		"58170C92FA4B91A1" = "MediaMonkey"
		"76689FF502A1FD9E" = "Imagine Image and Animation Viewer"
		"86781FE8437DB23E" = "Messenger Pro"
		"96252DAFF039437A" = "Lphant"
		"689319B6547CDA85" = "emesene"
		"1461132E553E2E6C" = "Firefox 6"
		"2519133D6D830F7E" = "IMatch"
		"3643905FCEAB2635" = "Cyberlink PowerDVD 16"
		"6224453D9701A612" = "BinTube"
		"8172865A9D5185CB" = "Binreader"
		"9560577FD87CF573" = "LeechFTP"
		"23646679AACCFAE0" = "Adobe Reader 9 (x64)"
		"26717493B25AA6E1" = "Adobe Dreamweaver CS5 (x86)"
		"36801066F71B73C5" = "Binbot"
		"65009083BFA6A094" = "(app launched via XPMode)"
		"728008617BC3E34B" = "eM Client"
		"780732558F827A42" = "AutoPix"
		"784182360DE0C5B6" = "Kazaa Lite"
		"226400522157FE8B" = "FileZilla Server"
		"BE2FD48BE71F4560" = "Autodesk DWG TrueView"
		"C88C76A215679365" = "Axialis IconWorkshop 6"
		"D1D9B843A81139C6" = "KeePass"
		"D4E1769E47FFDE26" = "Cyberlink PhotoDirector 9"
		"E4EA035065B5789A" = "HxD Hex Editor"
		"E353DE90C46ECF50" = "Hex-Rays IDA Pro"
		"A1D19AFE5A80F80"  = "FileZilla"
		"A3E0D98F5653B539" = "Instantbird"
		"A5DB18F617E28A51" = "ICQ"
		"A7BA40025DAC9A67" = "Microsoft Office Hub"
		"A8DF13A46D66F6B5" = "Kommute (Calypso)"
		"A31EC95FDD5F350F" = "BitComet"
		"A75B276F6E72CF2A" = "Kazaa Lite Tools K++ / WinMX"
		"A79A7CE3C45D781"  = "CuteFTP"
		"A746F9625F7695E8" = "HeXHub"
		"A777AD264B54ABAB" = "JetVideo"
		"AC3A63B839AC9D3A" = "Azureus Vuze Bittorrent Client"
		"AC8920ED05001800" = "DMDirc"
		"ACCCA100973EF8DC" = "Azureus"
		"ACE8715529916D31" = "40tude Dialog"
		"AE6DF75DF512BD06" = "Microsoft Groove Music (Microsoft.ZuneMusic)"
		"B7CB1D1C1991ACCF" = "FlashFXP"
		"B8AB77100DF80AB2" = "Microsoft Office Excel 2016 (x64)"
		"B8C29862D9F95832" = "Microsoft Office InfoPath 2010 (x86)"
		"B39C5F226977725D" = "ACDSee Pro"
		"B223C3FFBC0A7A42" = "Bersirc"
		"B0236D03C0627AC4" = "ICQ / ICQLite"
		"B868D9201B866D96" = "Microsoft Lync (Skype for Business)"
		"B3016B8DA2077262" = "eMule"
		"B3965C840BF28EF4" = "Arsenal Image Mounter"
		"B7173093B23B9A6A" = "Beyond Compare"
		"BA3A45F7FD2583E1" = "Blubster"
		"BA132E702C0147EF" = "KCeasy"
		"BAEA31EACD87186B" = "BinaryBoy"
		"BBA8A4896F0D26F"  = "Ares Chat Client"
		"BC2F88ECCD3461B4" = "Microsoft Event Viewer (Win10)"
		"BC03160EE1A59FC1" = "Foxit PDF Reader"
		"BCC705F705D8132B" = "Instan-t "
		"BCD7BA75303ACBCF" = "BitLord"
		"BE4875BB3E0C158F" = "CrossFTP"
		"BF483B423EBBD327" = "Binary Vortex"
		"BFC1D76F16FA778F" = "Ares (Galaxy)"
		"C01D68E40226892B" = "ClicksAndWhistles"
		"C02BAF50D02056FC" = "FotoVac"
		"C2D349A0E756411B" = "Adobe Acrobat Reader"
		"C04F69101C131440" = "CuteFTP"
		"C5EF839D8D1C76F4" = "LimeWire"
		"C6F7B5BF1B9675E4" = "BitWise"
		"C8E4C10E5460B00C" = "iMesh"
		"C312E260E424AE76" = "Mail.Ru Agent"
		"C845F3A6022D647C" = "Another File"
		"C997D2E1A0F0929"  = "BCWipe"
		"C8112AC53C5ED250" = "Jetico Log Viewer"
		"C634153E7F5FCE9C" = "IrfanView (x86)"
		"C765823D986857BA" = "Adobe Illustrator CS5 (32-bit)"
		"C9374251EDB4C1A8" = "BitTornado"
		"CA942805559495E9" = "aMSN"
		"CB5250EAEF7E3213" = "ApexDC++"
		"CBBE886ECA4BFC2D" = "ExoSee"
		"CC76755E0F925CE6" = "AllPicturez"
		"CCB36FF8A8C03B4B" = "Azureus"
		"CCBA5A5986C77E43" = "Microsoft Edge"
		"CCC0FA1B9F86F7B3" = "CCleaner (x64)"
		"CD2ACD4089508507" = "AbsoluteTelnet Lite"
		"CDF30B95C55FD785" = "Microsoft Office Excel 2007"
		"CF6379A9A987366E" = "Digibin"
		"CFAB0EC14B6F953"  = "Express NewsPictures"
		"D2D0FC95675FB2C8" = "Microsoft Windows Print Management"
		"D5C3931CAAD5F793" = "Adobe Soundbooth CS5 (x86)"
		"D22AD6D9D20E6857" = "ALLPlayer"
		"D28EE773B2CEA9B2" = "3D-FTP"
		"D38A3EA7EC79FBED" = "LibreOffice Writer"
		"D38ADEC6953449BA" = "Microsoft Office OneNote 2010 (x64)"
		"D53B52FB65BDE78C" = "Android Newsgroup Downloader"
		"D64D36B238C843A3" = "Microsoft Office InfoPath 2010 (x86)"
		"D97EFDF3888FE7EB" = "KeePass"
		"D838AAC097ABECE7" = "ACDSee Photo Manager 12"
		"D3530C5294441522" = "HydraIRC"
		"D8081F151F4BD8A5" = "CuteFTP 8.3 Lite"
		"D78150E0484A4E1D" = "Evernote"
		"D460280B17628695" = "Java Binary"
		"DB3B8D985F0668E"  = "FreeFileSync"
		"DC64DE6C91C18300" = "Brosix Communicator"
		"DD7C3B1ADB1C168B" = "Microsoft Game Bar"
		"DE48A32EDCBE79E4" = "Adobe Acrobat Reader"
		"E0F7A40340179171" = "imule"
		"E1D47CB031DAFB9F" = "BearShare"
		"E2A593822E01AED3" = "Adobe Flash CS5 (x86)"
		"E6EF42224B845020" = "ALFTP"
		"E9A39DFBA105EA23" = "Faststone Image Viewer"
		"E31A6A8A7506F733" = "Image AXS Pro"
		"E73D9F534ED5618A" = "BitSpirit"
		"E76A4EF13FBF2BB1" = "Manolito"
		"E107946BB682CE47" = "Filezilla"
		"EA83017CDD24374D" = "IrfanView Thumbnails"
		"EAB25958DBDDBAA4" = "Binary News Reaper"
		"EBD8C95D87F25154" = "Carrier"
		"ECD1A5E2C3AF9C46" = "LibreOffice Press"
		"ED7A5CC3CCA8D52A" = "CCleaner"
		"EDC786643819316C" = "HoneyView3"
		"EE0C103672A7A2B9" = "ManyCam"
		"EE462C3B81ABB6F6" = "Adobe Acrobat Reader X"
		"EF606B196796EBB"  = "HP MediaSmart Photo"
		"EFBB2BF3C1D06466" = "Auslogics Disk Defrag"
		"F0C7BD3E0584A65A" = "InfraRecorder (x86)"
		"F1A4C04EEBEF2906" = "[i2p] Robert Preferences"
		"F001EA668C0AA916" = "Cabos"
		"F5E4E50707BCD215" = "Microsoft Message Analyzer"
		"F6FD5D99E2B6E178" = "LibreOffice Draw"
		"F09B920BFB781142" = "Camfrog"
		"F61B65550A84027E" = "iMesh"
		"F91FD0C57C4FE449" = "ExpanDrive"
		"F214CA2DD40C59C1" = "FrostWire"
		"F0275E8685D95486" = "Microsoft Office Excel 2013 (x86)"
		"F0468CE1AE57883D" = "Adobe Acrobat Reader"
		"F82607A219AF2999" = "Cyberduck"
		"F784591FF7F60F76" = "Microsoft Windows Defragment and Optimize Drives"
		"FA02AA2C575837A6" = "Microsoft Windows Task Scheduler"
		"FA496FE13DD62EDF" = "KVIrc"
		"FA7144034D7D083D" = "Directory Opus"
		"FAC3AA4105C6C466" = "Microsoft Windows System Restore"
		"FB1F39D1F230480A" = "Bopup Messenger"
		"FC98C00F85D4CE77" = "EditPad Pro 8"
		"FE5E840511621941" = "JetAudio"
		"FF103E2CC310D0D"  = "Adobe Reader XI"
		"6274FF22C2061C60" = "Google PhotoViewer (Picasa)"
		"00098B0EF1C84088" = "fulDC"
		"03D877EC11607FE4" = "Thunderbird"
		"05E01ECAF82F7D8E" = "Scour Exchange"
		"070B52CF73249257" = "Sococo"
		"0B3F13480C2785AE" = "Microsoft Paint"
		"0B48CE76EDA60B97" = "Shareaza"
		"1A60B1067913516A" = "Psi"
		"1B4DD67F29CB1962" = "Windows Explorer"
		"1BC9BBBE61F14501" = "OneNote"
		"1BC392B8E104A00E" = "Remote Desktop Connection"
		"1C7A9BE1B15A03BA" = "Microsoft Snip & Sketch"
		"1C30573BDFCE4155" = "Zenmap GUI"
		"1CED32D74A95C7BC" = "Microsoft Visual Studio Code"
		"1D12F965B876DC87" = "Snagit 2021"
		"1DA3C90A72BF5527" = "Apple Safari"
		"2A5A615382A84729" = "X-Chat"
		"2AA756186E21B320" = "RealTimeQuery"
		"2B53C4DDF69195FC" = "Microsoft Zune (x64)"
		"2B164F512891AE37" = "NewsWolf NSListGen"
		"2B5841989B3857DA" = "RealVNC Server(x64) (Chat)"
		"2CA2A1A69DC5465F" = "UltraVNC Server Property Page"
		"2D1658D5DC3CBE2D" = "MySpaceIM"
		"2FA14C7753239E4C" = "Paint.NET"
		"3C355482CB54F75B" = "Microsoft.GetHelp"
		"3E4D62CF2C569BDF" = "MPC-HC (Media Player Classic - Home Cinema)"
		"3A5148BF2288A434" = "Secure FTP"
		"3B94415067DD2C5D" = "GOG Galaxy"
		"3BE7B307DFCCB58F" = "NiouzeFire"
		"3C0022D9DE573095" = "QuteCom"
		"3C309C17F7E8FFE1" = "GIMP"
		"3C3871276E149215" = "PowerShell 7"
		"3CF13D83B0BD3867" = "RevConnect"
		"3D877EC11607FE4"  = "Thunderbird"
		"3DF22B7648CEC4C1" = "TeamViewer 11"
		"3F2CD46691BBEE90" = "GOIM"
		"3F97341A65BAC63A" = "Ozum"
		"4ACAE695C73A28C7" = "VLC"
		"4B632CF2CECEAC35" = "Robo-FTP Server"
		"4D7BDAEA55AD352"  = "PeaZip"
		"4D8BDACF5265A04F" = "The KMPlayer"
		"4D72CFA1D0A67418" = "Newsgroup Image Collector"
		"4E0AC37DB19CBA15" = "Xfire"
		"4E538FDE985A3C01" = "Torch Browser (x86)"
		"4F24A7B84A7DE5A6" = "Palringo"
		"5E852F5F576F812C" = "MiTec JSON Viewer (JSONView.exe)"
		"5B7F3287093C1623" = "Total Commander (x64)"
		"5B72F67ADCCE9045" = "UltraVNC"
		"5D7B4175AFDCC260" = "Shareaza"
		"5D696D521DE238C3" = "Google Chrome"
		"5E01ECAF82F7D8E"  = "Scour Exchange"
		"5EA2A50C7979FBDC" = "TrustyFiles"
		"5F6E7BC0FB699772" = "Microsoft Office PowerPoint 2010 (x64)"
		"5F7B5F1E01B83767" = "Quick Access"
		"5F218922E0901EBF" = "MusicBee"
		"5FB817CD5A8CAD21" = "Google Drive"
		"5FD959F6FE6B8AE7" = "PuTTY (x64)"
		"6DC04F5CCC522861" = "Microsoft.Windows.ShellExperienceHost"
		"6A8B377D0F5CB666" = "WinSCP"
		"6AA18A60024620AE" = "GCN"
		"6BB54D82FA42128D" = "WinSCP"
		"6D2BAC8F1EDF6668" = "Microsoft Outlook 2013/2016/365"
		"6E9A79992DA9EA2"  = "Nokia PC Suite"
		"6E9D40A4C63BB562" = "Real Player Alternative (Media Player Classic)"
		"6FEE01BD55A634FE" = "Smuxi"
		"7A7C60EFD66817A2" = "Spotnet"
		"7A8DB574299C8568" = "Windows Movie Maker 2012"
		"7B2B4F995B54387D" = "News Reactor"
		"7B4D500E147E4391" = "Tor Browser (x64)"
		"7FD04185AF357BD5" = "UltraLeeacher"
		"8F4AE1DF7D39F816" = "X-Ways WinHex (x64)"
		"8A1C1C7C389A5320" = "Apple Safari"
		"8B87640A40EC9FC"  = "Snagit 2020"
		"8BCE06A9E923E1F9" = "Slack 4"
		"8C816C711D66A6B5" = "MSN Messenger"
		"8E4E81D9ADC545B8" = "Microsoft YourPhone"
		"8EAFBD04EC8631CE" = "VMware Workstation (x64)"
		"8FB5CE5E2B049CE"  = "Microsoft Windows Defender"
		"8FDB062F1E486CAC" = "Microsoft Powerpoint 2013 (x86)"
		"9A3BDAE86D5576EE" = "WinSCP"
		"9A165F62EDBFA161" = "Microsoft Windows Store"
		"9C7CC110FF56D1BD" = "Microsoft Office PowerPoint 2010 (x86)"
		"9C08AD74AD8708DF" = "Microsoft Publisher 2016 64-bit"
		"9D91276B0BE3E46B" = "Windows Help and Support"
		"9DACEBAA9AC8CA4E" = "TLNews Newsreader"
		"9EFF0B23D51FE003" = "XMind"
		"9F03AE476AD461FA" = "GroupsAloud 1.0"
		"9F5C7755804B850A" = "Windows Scripting Host - wscript.exe (x64)"
		"9FDA41B86DDCF1DB" = "VLC Media Player"
		"10F5A20C21466E85" = "FTP Voyager"
		"12DC1EA8E34B5A6"  = "Microsoft Paint"
		"13D1F3EA8D0E7308" = "Tracker Software PDF-Xchange Viewer"
		"16D71406474462B5" = "Snagit Editor"
		"16EC093B8F51508F" = "Opera"
		"16F2F0042DDBE0E8" = "Windows Terminal"
		"17D3EB086439F0D7" = "TrueCrypt (x64)"
		"19CCEE0274976DA8" = "mIRC"
		"23EF200CA6364EFF" = "Oracle VM VirtualBox"
		"23F08DAB0F6AAF30" = "SoMud"
		"27DA120D7E75CF1F" = "pbFTPClient"
		"36C36598B08891BF" = "Vovox"
		"40F2ACA05D8A33F2" = "Minitab 16"
		"44A3621B32122D64" = "Microsoft Office Word 2010 (x64)"
		"46E77B87767B92"   = "Opera Browser"
		"46F433176BC0B3D2" = "WinRAR (x64)"
		"49B5EDBD92D8CD58" = "FTP Commander"
		"51DCEBA79099D8D2" = "Sapien PowerShell Studio"
		"54C803DFC87B52BA" = "Nettalk"
		"56C5204009D2B915" = "uTorrent"
		"62BFF50B969C2575" = "Quintessential Media Player 5"
		"62DBA7FB39BB0ADC" = "Yahoo Messenger"
		"70B52CF73249257"  = "Sococo"
		"73CE3745A843C0A4" = "FrostWire"
		"74D7F43C1561FC1E" = "Windows Media Player 12"
		"74EA779831912E30" = "Skype 7"
		"86B804F7A28A3C17" = "Miranda"
		"90E5E8B21D7E7924" = "Winamp"
		"92F1D5DB021CD876" = "NewsLeecher"
		"93B18ADF1D948FA3" = "qutIM"
		"98AAEA517363A6FA" = "Microsoft Diagnostic Data Viewer"
		"98B0EF1C84088"    = "fulDC"
		"99C15CF3E6D52B61" = "mldonkey"
		"135DF2A440ABE9BB" = "SoulSeek"
		"186B5CCADA1D986B" = "NewsGrabber"
		"292A746334889A7E" = "SQLiteSpy"
		"315E29A36E961336" = "Roboform"
		"337ED59AF273C758" = "Microsoft Sticky Notes"
		"352FD027C0E8F0E5" = "Zoom"
		"387D72EB9C9AA960" = "UltraVNC Launcher"
		"409B67100697BCC0" = "Revo Uninstaller Pro"
		"431A5B43435CC60B" = "Python (.pyc)"
		"435A2F986B404EB7" = "SmartFTP"
		"447E6AA2BBDFBC8A" = "Slack"
		"466D339D8F21CFBF" = "Microsoft Snip & Sketch"
		"469E4A7982CEA4D4" = "Microsoft Windows WordPad"
		"490C000889535727" = "WinMX"
		"497F749B9F1A5D16" = "Microsoft.GamingApp"
		"497B42680F564128" = "Zoner PhotoStudio 13"
		"500B8C1D5302FC9C" = "Python (.pyw)"
		"521A29E5D22C13B4" = "Skype"
		"550ABC1CB58EB92C" = "VeraCrypt (x64)"
		"590AEE7BDD69B59B" = "Windows Powershell ISE (x64)"
		"624C8EB4922C2308" = "Modern CSV"
		"770ECEBB12DFF1CA" = "Microsoft Windows CloudExperienceHost"
		"776BEB1FCFC6DFA5" = "Thunderbird"
		"817BB211C92FD254" = "GOM Player"
		"884FD37E05659F3A" = "VZOchat"
		"888F2FA044591EDA" = "Twitter"
		"918E0ECB43D17E23" = "Notepad (x86)"
		"939C10C2C101C1B0" = "Stickies"
		"954EA5F70258B502" = "Windows Scripting Host - wscript.exe (x86)"
		"971CC6AD207F36CB" = "PaintShopPro X9"
		"2544FF74641B639D" = "WiseFTP"
		"3168CC975B354A01" = "Slypheed"
		"3461E4D1EB393C9C" = "WTW"
		"3594AAB44BCA414B" = "Windows Photo Viewer"
		"3866FF352D7719E1" = "Paint.NET"
		"4278D3DC044FC88A" = "Gaim"
		"4700FF5AE80A6713" = "PDFCreator"
		"6728DD69A3088F97" = "Windows Command Processor - cmd.exe (x64)"
		"7192F2DE78FD9E96" = "TIFNY"
		"7593AF37134FD767" = "RealPlayer"
		"7937DF3C65790919" = "FTP Explorer"
		"9027FE24326910D2" = "Thunderbird"
		"9149D0F5EBF7F710" = "Microsoft Outlook 15"
		"9390EE5B658E96E"  = "PuTTY"
		"14354E216395983A" = "Remote Desktop Manager"
		"18434D518C3A61EB" = "Minitab"
		"20513CDF29D09C0E" = "Hex Editor Neo"
		"23709F6439B9F03D" = "Hex Editor Neo"
		"28493D9D08E13AA6" = "UltraVNC Viewer"
		"50620FE75EE0093"  = "VMware Player"
		"67730E20CF5D43F7" = "MiTec JSON Viewer (JSONView.exe)"
		"69639DF789022856" = "Google Chrome"
		"79370F660AB51725" = "UploadFTP"
		"411447F7DE177C68" = "Windows DVD Maker (x64) (Win7)"
		"669967F27AFDEBEC" = "NirSoft PstPassword (x86)"
		"777483D3CDAC1727" = "Gajim"
		"792699A1373F1386" = "Piolet"
		"959668A81D4F220E" = "Sublime Text"
		"969252CE11249FDD" = "Mozilla Firefox"
		"7904145AF324576E" = "Total Commander (x86)"
		"8211531A7918B389" = "Newsbin Pro"
		"43578521D78096C6" = "Windows Media Player Classic Home Cinema (x86)"
		"573770283DC3D854" = "Microsoft Windows SecHealthUI (Defender)"
		"37392221756DE927" = "RealPlayer"
		"134620458666CCB0" = "TeraCopy (x64)"
		"290532160612E071" = "WinRAR (x64)"
		"A61657A5E5DFBDC"  = "Microsoft Windows Notepad"
		"CF02284227526D80" = "Powershell ISE"
		"DFE3790E91D3A22F" = "Tracker Software PDF-XChange Editor"
		"F1DFE90245A04467" = "MPC-BE 64 (Media Player Classic - Black Edition)"
		"F7699CF2EED599AC" = "Microsoft.SecHealthUI"
		"F039446000B1B829" = "SweetScape 010 Editor"
		"FBB3E7490BA71A30" = "SQLite Expert"
		"A0D6B1B874C6E9D2" = "TOR Browser"
		"A2B95CA27B6C33D9" = "Windows Live Photo Gallery"
		"A2C73C383525F1BB" = "RealVNC Viewer (x64)"
		"A4A5324453625195" = "Microsoft Office Word 2013 (x86)"
		"A4DEF57EE99D77E9" = "Nomad New"
		"A6D4DFEC09C69409" = "Microsoft Word Viewer"
		"A7BD71699CD38D1C" = "Microsoft Office Word 2010 (x86)"
		"A8C43EF36DA523B1" = "Microsoft Office Word 2003"
		"A10B45ADB36C1D27" = "PST Walker"
		"A18DF73203B0340E" = "Microsoft Word 2016"
		"A028C9DB28AA15A3" = "Piriform Defraggler (x64)"
		"A52B0784BD667468" = "Microsoft Windows Photos"
		"A55ED4FBB973AEFB" = "Microsoft Teams"
		"A581B8002A6EB671" = "WiseFTP"
		"AA11F575087B3BDC" = "Unzbin"
		"AD57BD0F4825CCE"  = "WinRAR (x64)"
		"ADECFB853D77462A" = "Microsoft Office Word 2007"
		"AE3F2ACD395B622E" = "QuickTime Player"
		"AE069D21DF1C57DF" = "mIRC"
		"AEDD2DE3901A77F4" = "Pidgin"
		"AF0FDD562E3F275B" = "Snagit 2020"
		"B3F13480C2785AE"  = "Microsoft Paint"
		"B06A975B62567622" = "Windows Live Messenger"
		"B8C13A5DD8C455A2" = "Titan FTP Server"
		"B17D3D0C9CA7E29"  = "Google Picasa"
		"B39BC6B590F53961" = "HexChat (x86)"
		"B48CE76EDA60B97"  = "Shareaza"
		"B50EE40805BD280F" = "QuickTime Alternative (Media Player Classic)"
		"B77EF7F3FC946302" = "Pale Moon Browser (x86)"
		"B0459DE4674AAB56" = "Windows Virtual PC - vmwindow.exe"
		"B6267F3FCB700B60" = "WiseFTP"
		"B08971C77377BDE3" = "Microsoft Visual Studio Community/Enterprise 2015"
		"B74736C2BD8CC8A5" = "WinZip"
		"B91050D8B077A4E8" = "Windows Media Center"
		"BAACB5294867B833" = "Notepad++"
		"BAC8A6B507360131" = "Remote Desktop Connection Manager"
		"BC0C37E84E063727" = "Windows Command Processor - cmd.exe (x86)"
		"BD050AC447F6CD65" = "Microsoft Xbox App"
		"BD249197A6FAEFF2" = "Windows Live Messenger 2011"
		"BE71009FF8BB02A2" = "Microsoft Office Outlook (x86)"
		"BEC10D3AAF939FFA" = "Pale Moon Browser (x64)"
		"BF9AE1F46BD9C491" = "Nimbuzz"
		"BFE841F4D35C92B1" = "QuadSucker/News"
		"C1EECE5026414C64" = "Recuva (x64)"
		"C5C24A503B1727DF" = "XnView"
		"C7A4093872176C74" = "Paint Shop Pro"
		"C8AA3EAEE3D4343D" = "Trillian"
		"C31B3D36438B5E2C" = "Visual Studio Enterprise 2017"
		"C54B96F328BDC28D" = "WiseFTP"
		"C71EF2C372D322D7" = "PGP Desktop 10"
		"C91D08DCFC39A506" = "SM Player"
		"C98AB5CCF25DDA79" = "NewsShark"
		"C99DDDE925D26DF3" = "Robo-FTP CronMaker"
		"C01827D56FF89056" = "Microsoft Sticky Notes"
		"C5236FD5824C9545" = "PlayXpert"
		"C9950C443027C765" = "WinZip"
		"CA1EB46544793057" = "RetroShare"
		"CAEA34D2E74F5C8"  = "uTorrent"
		"CB1D97ACA3FB7E6B" = "Newz Crawler"
		"CB984E3BC7FAF234" = "NewsRover"
		"CB996A858D7F15C"  = "PDF Architect (x64)"
		"CBEB786F0132005D" = "VLC"
		"CC4B36FBFB69A757" = "gtk-gnutella"
		"CCA6383A507BAC64" = "Gadu-Gadu"
		"CD8CAFB0FB6AFDAB" = "uTorrent"
		"CD40EAD0B1EB15AB" = "NNTPGrab"
		"CDB6F0C373F2DA0F" = "stunnel"
		"CFB56C56FA0F0A54" = "Mozilla"
		"D1FC019238236806" = "Newsgroup Commander Pro"
		"D3C5CF21E86B28AF" = "SeaMonkey"
		"D4A589CAB4F573F7" = "Microsoft Project 2010 (x86)"
		"D5C02FC7AFBB3FD4" = "NNTPGrab Server"
		"D7D647C92CD5D1E6" = "uTalk"
		"D7DB75DB9CDD7C5D" = "Xnews"
		"D33ECF70F0B74A77" = "Google Picasa"
		"D93F411851D7C929" = "Windows Powershell 5.0 (x86)"
		"D249D9DDD424B688" = "Google Chrome"
		"D0261ED6E16B200B" = "News File Grabber"
		"D00655D2AA12FF6D" = "Microsoft Office PowerPoint 2016 (x64)"
		"D7666C416CBA240C" = "NewsMan Pro"
		"D8671C1ED93C75C8" = "Tor Browser"
		"D41746B133D17456" = "Tkabber"
		"D356105FAC5527EF" = "Steam"
		"D7528034B5BD6F28" = "Windows Live Mail Pinned and Recent."
		"DA7E8DE5B8273A0F" = "Yahoo Messenger"
		"DBA909A61476CCEC" = "NewsWolf"
		"DD658A07478B46C2" = "PIRCH98"
		"DE76415E0060CE13" = "Noworyta News Reader"
		"DEE18F19C7E3A2EC" = "PopNote"
		"E4BD2558BFAB368D" = "UltraDefrag"
		"E6EA77A1D4553872" = "Gnucleus"
		"E6EE34AC9913C0A9" = "VLC"
		"E26F61AFB0824F2E" = "Photoshop CC 2015"
		"E30BBEA3E1642660" = "Neebly"
		"E36BFC8972E5AB1D" = "XPS Viewer"
		"E40CB5A291AD1A5B" = "Songbird"
		"E42A8E0F4D9B8DCF" = "Sysax FTP Automation"
		"E57CFC995BDC1D98" = "Snagit"
		"E70D383B15687E37" = "Notepad++"
		"E93DBDCEDE8623F2" = "Pandion"
		"E0532B20AA26A0C9" = "QQ International"
		"E0246018261A9CCC" = "qutIM"
		"EB7E629258D326A1" = "WindowWasher"
		"EB3300E672136BC7" = "Stream Reactor"
		"EC3E36AF0CDCB3E1" = "Steam"
		"ECD21B58C2F65A2F" = "StealthNet"
		"ECDD9154E84D5544" = "Wickr Top Secret Messenger Desktop"
		"ED49E1E6CCDBA2F5" = "GNUnet"
		"EF473FAB8120B354" = "uTorrent"
		"EFB08D4E11E21ECE" = "Paltalk Messenger"
		"F01B4D95CF55D32A" = "Microsoft Windows Explorer"
		"F2CB1C38AB948F58" = "X-Chat"
		"F5AC5390B9115FDB" = "Microsoft Office PowerPoint 2007"
		"F64DE962764B9B0F" = "FTPRush"
		"F92E607F9DE02413" = "RealPlayer"
		"F674C3A77CFE39D0" = "Winamp"
		"F18460FDED109990" = "Windows Windows ms-settings"
		"F920768FE275F7F4" = "Grabit"
		"FAEF7DEF55A1D4B"  = "VLC"
		"FB3B0DBFEE58FAC8" = "Microsoft Office Word 2016/365 (x64)"
		"FB7CA8059B8F2123" = "ooVoo"
		"FB230A9FE81E71A8" = "Yahoo Messenger"
		"FC999F29BC5C3560" = "Robo-FTP"
		"FD1AD55E472F20E0" = "Google Earth Pro"
		"FDBACA0A1FCE6055" = "MozBackup"
		"FDBD48D45512DFFC" = "Photoshop 7"
		"FE8BB4692DE7B989" = "Smart Defrag"
		"FE9E0F7260000A12" = "RealVNC Server (x64)"
		"FE57F5DF17B45FE"  = "Wireshark"
		"FF99BA2FB2E34B73" = "Microsoft Windows Calculator"
		"FF224628F0E8103C" = "Morpheus"
		"14A48FBE3D43239A" = "Windows System Information (msinfo32.exe)"
		"9B9CDC69C1C24E2B" = "Windows Notepad (x64) (Notepad.exe)"
		"47592B67DD97A119" = "Windows Notepad (x86) (Notepad.exe)"
		"122C907C4DC5911F" = "Mozilla Firefox (x86)"
		"18FA158A64C9508A" = "Mozilla Firefox (x86)"
		"33A00252C0FA56DE" = "Mozilla Firefox (x86)"
		"6B8904E2B6864F0F" = "Mozilla Firefox (x86)"
		"31B6EBFFF794EF0D" = "Opera Browser (Opera.exe)"
		"A712C324879904B1" = "Malwarebytes (assistant.exe)"
		"B916037C1E115FE0" = "Microsoft Skype 15"
		"647853318C96DFA5" = "Microsoft Windows Cortana"
		"4B5F45DE9912DE53" = "Microsoft Office Desktop Access 16"
		"1F1F846F76251EA8" = "Microsoft Office Desktop Word 16"
		"3FE28476179FF940" = "Turnipsoft Freda (ebook reader)"
		"40371339AD31A7E6" = "Mozilla Firefox (x64)"
		"58BEE77C49899591" = "Apple iTunes 12 (x64)"
		"59FE1486D27AA9D0" = "Electronic Arts Origin"
		"607258D66273FF4D" = "Microsoft Edge"
		"6DA48F37C95D6E1"  = "Google Chrome"
		"6F4D358E50595AC1" = "Emsisoft Anti-Malware (a2start.exe)"
		"95962CD8E90977CA" = "Emsisoft Anti-Malware (a2start.exe)"
		"78AA210563284496" = "Windows Performance Toolkit (wpa.exe)"
		"8DE2636CECD37184" = "MusicBee"
		"D014C0BE50851F63" = "MusicBee (x86)"
		"C08DDE8C94C16B10" = "Cyberlink PowerDVD 18"
		"D788E8BC973B89E9" = "PKWARE PKZIP for Windows 14"
		"EA64CE14E5470C33" = "Microsoft PowerShell 7 (x64)"
		"F2D2624B34821C85" = "Opera Browser"
		"69BACC0499D41C4"  = "Microsoft Excel 12"
		"B50F4A1D866B4B05" = "Microsoft Office Word 16 (x64)"
		"CE0E7345DE1F1E26" = "Microsoft.Windows.PrintQueueActionCenter"
		"CF0C5B2C9773BFA4" = "IDA Pro (x64)"
		"DFC4675A96730EDE" = "Microsoft Windows Feedback Hub (x64)"
		"399FB4899502F372" = "Mozilla Firefox"
		"3476342AAB319002" = "Mozilla Firefox"
		"4D202CABC6786CF7" = "Opera Browser"
		"2A64B26BD99F0D16" = "Shareaza"
		"A850D8ED37504C7C" = "Microsoft Windows Cortana"
		"B2A0DF3F22CEC7E0" = "Microsoft People 10"
		"A97085EBDC30067F" = "Microsoft windowscommunicationsapps"
		"4DDE7D7A7DFC5F29" = "VSCodium"
		"F8F05350C84C9D76" = "Mozilla Thunderbird"
		"4D939776340F1D18" = "LibreOffice Writer"
		"E7F34DEE82980C52" = "LibreOffice Calc"
		"14A989D191548BBC" = "Cyberlink PowerDVD16"
		"2BCEF060ACE5A6DB" = "NordVPN"
		"B8A48BFB1F2F0C8D" = "NordVPN"
		"9E312F4ADEE9107"  = "Opera Browser"
		"43929AE4535C8DEA" = "Microsoft SkypeApp 15 (x86)"
		"69D97CDC8D4D5043" = "Microsoft windowscommunicationsapps"
		"34B9A7AD69FF9C1B" = "Microsoft Access"
		"436EB6EB1BD9F03F" = "Microsoft Visio 15"
		"53F58609D680CDBC" = "Isobuster"
		"58A5AF636F485FF2" = "RegistryExplorer"
		"603EAABE372FB7EE" = "CorelDraw 17"
		"60536F49B49E4689" = "Microsoft XmlNotepad 2007"
		"D992BCC31B3E5727" = "Opera Browser"
		"22E699DDC3928886" = "Fineprint PdfFactory"
		"3EBCDFA8943CC8B8" = "SAPIEN SnippetEditor"
		"DAA1194A2BD88BD7" = "SAPIEN Packager"
		"92A0E470EECC63D3" = "RegistryExplorer"
		"A968ADCD5F3991CD" = "CorelDraw Home 20"
		"6518D6AE55CB5B8E" = "CorelDraw Home 20"
		"EA5AF8CE5AEB5617" = "Notepad++"
		"3FCB7925BE48C6D4" = "JSONBuddyApp"
		"6B81D0477F64E02F" = "JSONBuddyApp"
		"1AB724316049531"  = "NordVPN"
		"72B0317636C8DBC0" = "FSPro Event Log Explorer"
		"75FDABDC3F4B24FC" = "Microsoft Windows Event Viewer (eventvwr.exe)"
		"9303DE56D0685AF1" = "plist Editor Pro for Windows"
		"56BD4EFC8F2E1F9C" = "XnSoft XnViewMP"
		"70A4C8CFD9C64000" = "Programmer's Notepad (pn.exe)"
		"ACB8CD11364E2DE8" = "VisualStudio"
		"C343543D4EE31DE7" = "Microsoft Access"
		"5E4713EB935BE0B1" = "foobar2000"
		"254995F62CC3531A" = "Sanderson Forensics BPLister"
		"68A0DBFB7D0781D5" = "Corel Photo Paint Home"
		"24728462B60C215D" = "Microsoft Windows Maps (x64)"
		"70202C58F1BC64FE" = "JeticoSoftware BCArchive"
		"BD6F833ECE9F9890" = "Microsoft Sticky Notes"
		"6F39A16F693777F6" = "Microsoft.MSPaint_8wekyb3d8bbwe"
		"556353BEBA95157C" = "7-Zip"
		"C45108AA42339506" = "PowerPoint Show 8"
		"25CFC5224E58D5D9" = "Corel Photo Paint Home"
		"F2A9149D1C88D093" = "Tor Browser (Firefox)"
		"7C8ADB9F2028B7D4" = "SAPIEN Packager"
		"B37A182B9A7A8098" = "SAPIEN.Packager"
		"D1CC3F047E70A200" = "SAPIEN SnippetEditor"
		"A6744F520B56975C" = "SAPIEN SnippetEditor"
		"B06BC47EDD036329" = "SAPIEN PowerShell Studio"
		"7FA8BDD163836F0C" = "WinRAR"
		"D57380F96FCFDE2F" = "RegistryExplorer"
		"F065AC336ABCAA3E" = "Adobe Acrobat DC"
		"9501E18D7C2AB92E" = "Google Chrome"
		"6DCAD003123A22FE" = "Android Studio"
		"F203793BF9D14FF"  = "Razer Central"
		"21982DADE69F78D8" = "Opera Browser"
		"7FF0B18F1611DAA4" = "Opera Browser"
		"EE6D1F704CDEB7F9" = "Opera Browser"
		"9645F58513B1A821" = "Windows Live Mail (wlmail.exe)"
		"D27FF2AECE1FD1BF" = "Epic Privacy Browser"
		"18AE7CDA503D746E" = "Advanced System Optimizer 3"
		"265142389B98FCB1" = "DVDFab 9 (x86)"
		"5E86FBBFFAE5937B" = "Waterfox Browser"
		"A7500EE83F4868AB" = "DVBViewer"
		# DestList & DestListPropertyStore streams have Serialized Property Store (1SPS ) extensions
		"5A2098E080CF7AC4" = "OneDrive (ClassicMru)"
		"95597E2F40DBD9AA" = "PotPlayerMini64 (potplayer.daum.net)"
		"CB83010E2BF88AD0" = "PowerShell ISE (x64)"
		"5433B9CEC1DF1B"   = "Windows Subsystem For Android"
		"F5096E40DCC7BFAF" = "Microsoft Windows Subsystem For Android"
		"FD36C431D6130A56" = "Roon"
		"339621474FE0442E" = "MicrosoftWindows.Client.CBS_cw5n1h2txyewy (ncpa.cpl)"
		"42F16A31D9A2EC4"  = "Diagnostic.Cabinet"
		"58FBE05CDDD02D66" = "MicrosoftWindows.Client.CBS_1000.22662.1000.0_x64__cw5n1h2txyewy"
		"7A8FBED55E9C2E1"  = "REW (Room Eq Wizard)"
		"7E7199497E7A9AD7" = "iliumsoft eWallet"
		"8161663B649F159A" = "MS Windows Remote Assistance"
		"96863E64B7418EB6" = "MS Visual Studio"
		"98789845387A0EF0" = "Dropbox Vault"
		"A4CE39A7CAC7D8DF" = "MS Windows Sandbox"
	}
	$versions = [Ordered]@{
		"1" = "Windows 7/8"
		"3" = "Windows 10"
		"4" = "Windows 10"
		"5" = "Windows 10"
		"6" = "Windows 11"
	}
	$lengths = [Ordered]@{
		"1" = "114"
		"3" = "130"
		"4" = "130"
		"5" = "130"
		"6" = "130"
	}
	$LinkFlagsTT = [Ordered]@{
		"HasLinkTargetIDList"		  = "ShellLinkHeader is followed by a LinkTargetIDList structure"
		"HasLinkInfo"				  = "LinkInfo in file"
		"HasName"					  = "NAME_String in file"
		"HasRelativePath"			  = "RELATIVE_PATH in file"
		"HasWorkingDir"			      = "WORKING_DIR in file"
		"HasArguments"			      = "COMMAND_LINE_ARGUMENTS"
		"HasIconLocation"			  = "ICON_LOCATION"
		"IsUnicode"				      = "Strings are in unicode"
		"ForceNoLinkInfo"			  = "LinkInfo is ignored"
		"HasExpString"			      = "The shell link is saved with an EnvironmentVariableDataBlock"
		"RunInSeparateProcess"	      = "Target runs in a 16-bit virtual machine"
		"HasDarwinID"				  = "The shell link is saved with a DarwinDataBlock"
		"RunAsUser"				      = "The application is run as a different user when the target of the shell link is activated"
		"HasExpIcon"				  = "The shell link is saved with an IconEnvironmentDataBlock"
		"NoPidlAlias"				  = "The file system location is represented in the shell namespace when the path to an item is parsed into an IDList"
		"RunWithShimLayer"		      = "The shell link is saved with a ShimDataBlock"
		"ForceNoLinkTrack"		      = "The TrackerDataBlock is ignored"
		"EnableTargetMetadata"	      = "The shell link attempts to collect target properties and store them in the PropertyStoreDataBlock when the link target is set"
		"DisableLinkPathTracking"	  = "The EnvironmentVariableDataBlock is ignored"
		"DisableKnownFolderTracking"  = "The SpecialFolderDataBlock and the KnownFolderDataBlock are ignored when loading the shell link"
		"DisableKnownFolderAlias"	  = "If the link has a KnownFolderDataBlock, the unaliased form of the known folder IDList SHOULD be used when translating the target IDList at the time that the link is loaded"
		"AllowLinkToLink"			  = "Creating a link that references another link is enabled"
		"UnaliasOnSave"			      = "When saving a link for which the target IDList is under a known folder, either the unaliased form of that known folder or the target IDList SHOULD be used"
		"PreferEnvironmentPath"	      = "The target IDList SHOULD NOT be stored; instead, the path specified in the EnvironmentVariableDataBlock SHOULD be used to refer to the target"
		"KeepLocalIDListForUNCTarget" = "When the target is a UNC name that refers to a location on a local machine, the local path IDList in the PropertyStoreDataBlock SHOULD be stored, so it can be used when the link is loaded on the local machine"
	}
	$DriveTypes = [Ordered]@{
		"UNKNOWN"	  = "The drive type cannot be determined."
		"NO_ROOT_DIR" = "The root path is invalid; for example, there is no volume mounted at the path"
		"REMOVABLE"   = "The drive has removable media, such as a floppy drive, thumb drive, or flash card reader."
		"FIXED"	      = "The drive has fixed media, such as a hard drive or flash drive."
		"REMOTE"	  = "The drive is a remote (network) drive."
		"CDROM"	      = "The drive is a CD-ROM drive."
		"RAMDISK"	  = "The drive is a RAM disk."
	}
	# https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow
	$ShowCommands = [Ordered]@{
		'0'  = '[SW_HIDE] Hides the window and activates another window.'
		'1'  = '[SW_SHOWNORMAL] Window is activated and restored to its original size and position.'
		'2'  = '[SW_SHOWMINIMIZED] Window is minimized and activated.'
		'3'  = '[SW_SHOWMAXIMIZED] Window is maximized and activated.'
		'4'  = '[SW_SHOWNOACTIVATE] Window in its most recent size and position. The window is NOT activated.'
		'5'  = '[SW_SHOW] Activates the window and displays it in its current size and position.'
		'6'  = '[SW_MINIMIZE] Minimizes the specified window and activates the next top-level window in the Z order'
		'7'  = '[SW_SHOWMINNOACTIVE] Window is minimized and NOT activated.'
		'8'  = '[SW_SHOWNA] Displays the window in its current size and position. The window is NOT activated.'
		'9'  = '[SW_RESTORE] Displays the window in its current size and position. The window is activated.'
		'10' = '[SW_SHOWDEFAULT] Sets the show state to the default used by the program that started the application.'
		'11' = '[SW_FORCEMINIMIZE] Minimizes a window, even if the thread that owns the window is not responding.'
	}
	
	$reparsefilter = [Ordered]@{
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
		"80000023" = "IO_REPARSE_TAG_AF_UNIX"
		# Windows Subsystem for Linux
		"80000024" = "IO_REPARSE_TAG_LX_FIFO"
		"80000025" = "IO_REPARSE_TAG_LX_CHR"
		"80000026" = "IO_REPARSE_TAG_LX_BLK"
		#
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
	}
	
	function Show-ErrorMessage
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[string]$ErrorMessage
		)
		[void][System.Windows.Forms.MessageBox]::Show($Jumplist_Browser, "$($ErrorMessage)", "LNK & Jumplist Browser", "OK", "Error")
	}
	
	function Show-InfoMessage
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[string]$InfoMessage
		)
		[void][System.Windows.Forms.MessageBox]::Show($Jumplist_Browser, "$($InfoMessage)", "LNK & Jumplist Browser", "OK", "Information")
	}
	
	function Show-WarningMessage
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[string]$WarningMessage
		)
		[void][System.Windows.Forms.MessageBox]::Show($Jumplist_Browser, "$($WarningMessage)", "LNK & Jumplist Browser", "OK", "Warning")
	}
	
	function Open-File
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$Filename
		)
		
		# $extension = [System.IO.FileInfo]::new($Filename).Extension
		
		$toolstripRefreshState = $toolstripRefresh.Visible
		if (!!$FileName -and [System.IO.FileInfo]::New($FileName).Exists)
		{
			$Folder = Split-Path -Path $FileName -Parent
			if ($treeview1.Nodes) { $treeview1.Nodes.Clear() }
			else { }
			if ($treeview2.Nodes) { $treeview2.Nodes.Clear() }
			else { }
			$treeview2.ImageList = $null
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$fname = Split-Path -Path $FileName -leaf
			$file = @([PSCustomObject][Ordered]@{
					'FileName'	      = $FileName
					'Name'		      = $fname
					'Parent'		  = $folder
					'CreationTimeUtc' = [system.IO.File]::GetCreationTimeUtc("$($FileName)")
					'LastAccessTimeUtc' = [system.IO.File]::GetLastAccessTimeUtc("$($FileName)")
					'LastWriteTimeUtc' = [system.IO.File]::GetLastWriteTimeUtc("$($FileName)")
					'Attributes'	  = [system.IO.File]::GetAttributes("$($FileName)")
					'Size'		      = [System.IO.FileInfo]::new("$($FileName)").Length
				})
			$Status.Text = "Selected File: $($FileName) "
			[System.GC]::Collect()
			Add-fileNodes -Files $file -RootFolder "$($Folder)"
			$toolstripRefresh.Visible = $true
		}
		else
		{
			$toolstripRefresh.Visible = $toolstripRefreshState
			[System.Console]::Beep(500, 150)
		}
	}
	
	function Open-Folder
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$Folder
		)
		
		if ([System.IO.DirectoryInfo]::new($Folder).Exists)
		{
			$script:recentfolder = $folder
			if ($treeview1.Nodes) { $treeview1.Nodes.Clear() }
			else { }
			if ($treeview2.Nodes) { $treeview2.Nodes.Clear() }
			else { }
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$Status.Text = $null
			[System.GC]::Collect()
			try
			{
				$Status.Text = "Selected Folder: $($recentfolder) "
				if (!!(Get-Files -Folder "$($recentfolder)"))
				{
					$toolstripRefresh.Visible = $true
					[System.Console]::Beep(2500, 300)
				}
				else
				{
					$toolstripRefresh.Visible = $false
					[System.Console]::Beep(500, 150)
				}
			}
			catch
			{
				$toolstripRefresh.Visible = $false
				[System.Console]::Beep(500, 150)
				return
			}
		}
		
	}
	
	function Get-ShellFolders
	{
		try
		{
			$ShellFolders = @(
				"HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" # User/Roaming
				"HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" # User
				"HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" # Public
				"HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" # Public/Common
			)
			
			$shellf = @{ }
			Foreach ($ShellFolder in $ShellFolders)
			{
				
				$folders = Get-Item -Path $ShellFolder
				Foreach ($s in ($folders.GetValueNames() | sort))
				{
					if ($s -eq "!Do not use this registry key") { continue }
					$name = if ($s.StartsWith('{') -and ($s -in $Special.guid)) { $Special.where{ $_.guid -eq $s }.name }
					else { $s }
					
					$shellf[$Name] = "$($Folders.GetValue($s))"
				}
			}
			$knownFolders = [enum]::GetNames([System.Environment+SpecialFolder])
			foreach ($knownfolder in $knownFolders)
			{
				if (![String]::IsNullOrEmpty([environment]::getfolderpath($knownfolder)))
				{
					$shellf[$knownfolder] = "$([environment]::getfolderpath($knownfolder))"
				}
			}
			
			$shellf.GetEnumerator() | sort -Property Value -Descending -Unique
		}
		catch
		{
			$shellf = @{ }
			$knownFolders = [enum]::GetNames([System.Environment+SpecialFolder])
			foreach ($knownfolder in $knownFolders)
			{
				if (![String]::IsNullOrEmpty([environment]::getfolderpath($knownfolder)))
				{
					$shellf[$knownfolder] = "$([environment]::getfolderpath($knownfolder))"
				}
			}
			
			$shellf.GetEnumerator() | sort -Property Value -Descending -Unique
		}
	}
	
	function Get-KnownFolderProperties
	{
		try
		{
			$ShellFolders = @(
				"HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions"
				"HKLM:SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\"
			)
			
			$shellf = @{ }
			$FolderProps = Foreach ($ShellFolder in $ShellFolders)
			{
				
				$folders = Get-ChildItem -Path $ShellFolder
				Foreach ($folder in $folders)
				{
					if ($folder.SubKeyCount -gt 1 -or $folder.ValueCount -lt 2) { continue }
					$GUID = split-path $folder -leaf
					$folderproperties = Get-ItemProperty "$((split-path $folder.Name -NoQualifier).replace('HKEY_LOCAL_MACHINE', 'HKLM:'))"
					
					[PsCustomObject]@{
						'GUID'		   = $GUID
						'Name'		   = $folderproperties.Name
						'ParentFolder' = if (!!$folderproperties.ParentFolder) { $folderproperties.ParentFolder }else{ $null }
						'RelativePath' = if (!!$folderproperties.RelativePath) { $folderproperties.RelativePath }else{ $null }
					}
				}
			}
			$FolderProps = ($FolderProps | sort -Property GUID -Unique)
			
			$knownFolders = foreach ($prop in $FolderProps)
			{
				
				$parent = if ($prop.ParentFolder -in $FolderProps.GUID)
				{
					$FolderProps.Where{ $_.GUID -eq $prop.ParentFolder }.Name
				}
				else { $null }
				
				[PsCustomObject]@{
					'GUID'		   = $prop.GUID
					'Name'		   = $prop.Name
					# 'ParentFolder' = $prop.ParentFolder
					'Parent'	   = $parent
					'RelativePath' = $prop.RelativePath
				}
			}
			return $knownFolders
		}
		catch { $null }
	}
	
	function Get-KnownFolders
	{
		try
		{
			$knownFolders = Get-KnownFolderProperties
			
			$ShellFolders = Get-ShellFolders
			$CompleteShell = @{ }
			
			foreach ($shell in $ShellFolders.GetEnumerator())
			{
				
				if ($shell.key -in $knownFolders.GUID)
				{
					$CompleteShell["$($knownFolders.Where{ $_.GUID -eq $shell.key }.Name)"] = "$($shell.Value)"
				}
				else { $CompleteShell[$shell.key] = "$($shell.Value)" }
			}
			$CompleteShell.GetEnumerator() | sort -Property Value -Descending -Unique
		}
		catch
		{
			$ShellFolders
		}
	}
	
	function Get-Attributes
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[Byte[]]$Bytes,
			[switch]$NoNumber
		)
		
		$attr = [System.Collections.ArrayList]::new()
		$attrINt = if ($bytes.Count -eq 2) { [System.BitConverter]::ToUInt16($Bytes, 0) }
		elseif ($bytes.Count -eq 4) { [System.BitConverter]::ToUInt32($Bytes, 0) }
		else { return }
		$FileAttributesEnum.GetEnumerator().foreach{ if (($attrINt -band $_.key) -eq $_.key) { $null = $attr.Add($FileAttributesEnum[$_.key]) } }
		if (!$NoNumber)
		{
			[System.Array]::Reverse($bytes)
			$attrhx = "0x$([System.BitConverter]::ToString($Bytes) -replace '-', '')"
			Return "$($attr -join ', ') ($($attrhx<#$attrINt#>))"
		}
		else
		{
			Return "$($attr -join ', ')"
		}
	} # End Get-Attributes
	
	function Get-SFGAOflags
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$Flags,
			[System.Boolean]$Single = $False
		)
		try
		{
			$SFGAO = [System.Collections.Hashtable]@{ }
			$SFGAOflags.GetEnumerator().foreach{ if (($Flags -band $_.key) -eq $_.key) { $SFGAO[$_.key] = $SFGAOflags[$_.key] } }
			
			$SFGAO = [System.Collections.ArrayList]::new()
			$SFGAOflags.GetEnumerator().foreach{ if (($Flags -band $_.key) -eq $_.key) { $null = $SFGAO.Add($SFGAOflags[$_.key]) } }
			if (!!$Single)
			{
				Return "$($SFGAO -join ', ') ($($Flags))" # Single Line 
			}
			else
			{
				return $SFGAO
			}
		}
		catch { $null }
		
	} # End Get-SFGAOflags
	
	# Guid database
	# https://uuid.pirate-server.com
	function Get-CLSID
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.String]$CLSIDstring
		)
		
		if (!$CLSIDstring -or $CLSIDstring.Length -ne 36)
		{
			return $false
		}
		
		# Validate GUID
		try
		{
			# If GUID is not valid it will through an error
			[System.Guid]::Parse($CLSIDstring).Guid | Out-Null
		}
		catch
		{
			return $false
		}
		
		$Name = $null
		
		try
		{
			if ($CLSIDstring -eq 'B4FB3F98-C1EA-428D-A78A-D1F5659CBA93')
			{
				$Name = "Microsoft.NetworkAndSharingCenter /ShareMedia [$($CLSIDstring)]"
			}
			elseif ($CLSIDstring -eq '018D5C66-4533-4307-9B53-224DE2ED1FE6')
			{
				$Name = "CLSID_OneDrivePersonal [$($CLSIDstring)]"
			}
			elseif ($CLSIDstring -eq '184E877F-522E-4F52-B483-7681678F1722') # In SyncRootManager
			{
				$Name = "Dropbox [$($CLSIDstring)]"
			}
			elseif ($CLSIDstring -eq '68284FAA-6A48-11D0-8C78-00C04FD918B4') # TaskBand
			{
				$Name = "CLSID_TaskBand {68284FAA-6A48-11D0-8C78-00C04FD918B4}"
				# https://www.geoffchappell.com/studies/windows/shell/explorer/classes/taskband.htm
			}
			else
			{
				$RegistryKeys = @(
					'Software\Classes\CLSID'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\DelegateFolders'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_36354489'
					'Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_36354489\DelegateFolders'
				)
				foreach ($registrykey in $RegistryKeys)
				{
					$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Default)
					if (!$Registry.Handle.IsClosed) { $Registry.Close() }
					$registrySubkey = $Registry.OpenSubKey($registrykey)
					if (!!$registrySubkey)
					{
						$registrySubKeyNames = $registrySubkey.GetSubKeyNames()
						$registrySubkey.Close()
						$registrySubkey.Dispose()
					}
					else { continue }
					$CLSID = $registrySubKeyNames.Where{ $_ -match $CLSIDstring }
					if (!!$CLSID)
					{
						$registrySubkey = $Registry.OpenSubKey("$($registrykey)\$($CLSID)")
						$Value = $registrySubkey.GetValue('')
						$registrySubkey.Close()
						$registrySubkey.Dispose()
						
						if (!!$Value)
						{
							$Name = "$($Value) [$($CLSIDstring)]"
							$registry.Close()
							$registry.Dispose()
							break
						} # End if
					} # End if
					else { continue }
				} # End Foreach
				$registry.Close()
				$registry.Dispose()
			} # End else
			
			if (!!$Name) { return $Name }
			else
			{
				try
				{
					$FolderDescription = Get-FolderDescription -CLSIDstring $CLSIDstring
					if ($FolderDescription -ne $CLSIDstring) { return $FolderDescription }
					else { return "[$($CLSIDstring)]" }
				}
				catch
				{
					return "[$($CLSIDstring)]"
				}
			}
		}
		catch
		{
			return "[$($CLSIDstring)]"
		}
	} # End Get-CLSID
	
	function ConvertFrom-SID
	{
		[CmdletBinding()]
		[OutputType([string])]
		param
		(
			[Parameter(Mandatory = $true,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true)]
			[Alias('Value')]
			$Sid
		)
		
		process
		{
			try
			{
				$objSID = New-Object System.Security.Principal.SecurityIdentifier($sid)
				$objUser = $objSID.Translate([System.Security.Principal.NTAccount])
				$objUser.Value
			}
			catch { $null }
		}
	} # ConvertFrom-SID
	
	function Get-FolderDescription
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateLength(36, 36)]
			[System.String]$CLSIDstring
		)
		
		
			if ($CLSIDstring -eq '5E591A74-DF96-48D3-8D67-1733BCEE28BA')
			{
				$Name = "Delegate Folder [$($CLSIDstring)]"
			}
			else
			{
				try
				{
					$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Default)
					$registrykey = $Registry.OpenSubKey('Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes')
					
					$registrySubKeyNames = $registrykey.GetSubKeyNames()
					$registrykey.Close()
					$registrykey.Dispose()
					$CLSID = $registrySubKeyNames.Where{ $_ -match $CLSIDstring }
					if (!!$CLSID)
					{
						$registrykey = $Registry.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\$($CLSID)")
						$Name = "$($registrykey.GetValue('CanonicalName')) [$($CLSIDstring)]"
						$registrykey.Close()
						$registrykey.Dispose()
					}
					else
					{
						$registrykey = $Registry.OpenSubKey('Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions')
						$registrySubKeyNames = $registrykey.GetSubKeyNames()
						$registrykey.Close()
						$registrykey.Dispose()
						$CLSID = $registrySubKeyNames.Where{ $_ -match $CLSIDstring }
						
						if (!!$CLSID)
						{
							$registrykey = $Registry.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\$($CLSID)")
							$Name = "$($registrykey.GetValue('Name')) [$($CLSIDstring)]"
							$registrykey.Close()
							$registrykey.Dispose()
						}
						else
						{
							$Name = $CLSIDstring
						}
					}
				}
				catch
				{
					$Registry.Close()
					$Registry.Dispose()
					$Name = $CLSIDstring
				}
		}
		return $Name
		
	} # End Get-FolderDescription
	
	function Get-XAppName
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$XAppName
		)
		
		try
		{
			$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Default)
			$registrykey = $Registry.OpenSubKey('Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs')
			$registrySubKeyNames = $registrykey.GetSubKeyNames()
			$registrykey.Close()
			$registrykey.Dispose()
			$XApp = $registrySubKeyNames.Where{ $_ -eq $XAppName }
			if (!!$XApp)
			{
				$registrykey = $Registry.OpenSubKey("Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\$($XApp)")
				$ValueNames = $registrykey.GetValueNames()
				$name = if ($ValueNames.count -ge 1)
				{
					# "$($ValueNames[($ValueNames.count - 1)].Split('_')[0])" # Get the Short version ie just the App Name
					"$($ValueNames[($ValueNames.count - 1)])" # - [$($XAppName)]" # Get the (latest version) name string
				}
				else { "$($XAppName)" }
				$registrykey.Close()
				$registrykey.Dispose()
			}
			else { $Name = "$($XAppName)" }
		}
		catch
		{
			$Name = "$($XAppName)"
			if (!$Registrykey.Handle.IsClosed)
			{
				$Registry.Close()
				$Registry.Dispose()
			}
		}
		return $Name
	} # End Get-XAppName
	
	# Preload the Shell Folders
	$ShellFolders = Get-KnownFolders
	$Knownfolders = Get-KnownFolderProperties
	
	function Get-Nodes
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$nodes
		)
		
		$DefaultColor = [System.Drawing.Color]::Black
		foreach ($node in $nodes)
		{
			[System.Windows.Forms.Application]::DoEvents()
			$node.Backcolor = $DefaultColor
			$node
			Get-Nodes -nodes $node.Nodes
		}
	} # End Get-Nodes
	
	#=============================================#
	# Load PropertyStore .Net lib into memory     #
	# --------------------------------------------#
	# Author => @securifybv/@yorickkoster         #
	# https://github.com/securifybv/PropertyStore #
	# --------------------------------------------#
	# .Net Framework Compat: 4.0+                 #
	#=============================================#
	try { !![System.Reflection.Assembly]::GetAssembly('PropertyStore.SerializedPropertyStore, PropertyStore, Version=0.1.0.0, Culture=neutral, PublicKeyToken=null') | Out-Null }
	catch [System.Management.Automation.MethodException]
	{
		$EncodedCompressedFile = @'
		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
'@
		$DeflatedStream = New-Object IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String($EncodedCompressedFile), [IO.Compression.CompressionMode]::Decompress)
		$UncompressedFileBytes = New-Object Byte[](13312)
		$null = $DeflatedStream.Read($UncompressedFileBytes, 0, 13312)
		$null = [System.Reflection.Assembly]::Load($UncompressedFileBytes)
	}
	catch { return }
	#=========================================#
	# Load ShellLink .Net lib into memory     #
	# ----------------------------------------#
	# Author => @securifybv/@yorickkoster     #
	# https://github.com/securifybv/ShellLink #
	# ----------------------------------------#
	# .Net Framework Compat: 4.0+             #
	#=========================================#
	try { !![Reflection.Assembly]::GetAssembly('ShellLink.Shortcut, ShellLink, Version=0.9.2.0, Culture=neutral, PublicKeyToken=null') | Out-Null }
	catch [System.Management.Automation.MethodException]
	{
		$EncodedCompressedFile = @'
		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
'@
		$DeflatedStream = New-Object IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String($EncodedCompressedFile), [IO.Compression.CompressionMode]::Decompress)
		$UncompressedFileBytes = New-Object Byte[](80384)
		$null = $DeflatedStream.Read($UncompressedFileBytes, 0, 80384)
		$null = [System.Reflection.Assembly]::Load($UncompressedFileBytes)
	}
	catch { return }
	
	function Get-DelegateIDlist
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray,
			[Int]$idx = 4
		)
		try
		{
			# $DelegateIDListsize = [System.BitConverter]::ToUInt32($ByteArray[0 .. 3], 0)
			$DelegateIDListsize = $ByteArray.count
			$DelegateIDs = [System.Collections.ArrayList]::new()
			
			while ($idx -lt ($DelegateIDListsize - 1))
			{
				$itemSize = [Bitconverter]::ToUInt16($ByteArray[($idx) .. ($idx + 1)], 0)
				if ($itemSize -eq 0 -or ($idx + $itemSize) -gt ($DelegateIDListsize - 1)) { break }
				$null = $DelegateIDs.Add([ShellLink.Structures.ItemID]::FromByteArray($ByteArray[$idx .. ($idx + $itemSize - 1)]))
				$idx = $idx + $itemSize
				if ($idx -ge ($DelegateIDListsize - 1)) { break }
			}
			
			if ($DelegateIDs.Count -ge 1)
			{
				$DelegateIDList = [System.Collections.ArrayList]::new()
				foreach ($DelegateID in $DelegateIDs)
				{
					$linkItem = Get-LinkTargetIDList -ItemIdListItem $DelegateID
					$null = $DelegateIDList.Add($linkItem)
				}
			}
		}
		catch
		{
			$DelegateIDList = $null
		}
		Return $DelegateIDList
	} # End Get-DelegateIDlist
	
	function Get-EmbeddedIDList
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowNull()]
			[AllowEmptyString()]
			[System.Byte[]]$ByteArray,
			[Int]$Index = 4
		)
		
		try
		{
			$ShellinkSize = $ByteArray.Count
			$EmbeddedItemIDs = [System.Collections.ArrayList]::new()
			$idx = $Index
			while ($idx -lt $ShellinkSize)
			{
				$itemSize = [Bitconverter]::ToUInt16($ByteArray[($idx) .. ($idx + 1)], 0)
				if ($itemSize -eq 0 -or $itemSize -gt ($ShellinkSize - $idx)) { break }
				$null = $EmbeddedItemIDs.Add([ShellLink.Structures.ItemID]::FromByteArray($ByteArray[$idx .. ($idx + $itemSize - 1)]))
				$idx = $idx + $itemSize
				if ($idx -ge $ShellinkSize) { break }
			} # End while
			
			if ($EmbeddedItemIDs.Count -ge 1)
			{
				$EmbeddedIdList = [System.Collections.ArrayList]::new()
				foreach ($EmbeddedItemID in $EmbeddedItemIDs)
				{
					$linkItem = Get-LinkTargetIDList -ItemIdListItem $EmbeddedItemID
					$null = $EmbeddedIdList.Add($linkItem)
				}
			}
		}
		catch
		{
			$EmbeddedIdList = $null
		}
		Return $EmbeddedIdList
	} # End Get-EmbeddedIDList
	
	function Populate-SPS1
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Node,
			[Parameter(Mandatory = $true)]
			$SPS1properties
		)
		try
		{
			if ($SPS1properties.Count -ge 1)
			{
				for ($ps = 0; $ps -lt $SPS1properties.Count; $ps++)
				{
					# Add Serialised Property Node
					if ($SPS1properties.Count -gt 1) # Add counter if more than 1
					{
						$SPS1Node = $Node.Nodes.Add("Entension$($ps)", "Serialized Property #$($ps)")
					}
					else # No counter
					{
						$SPS1Node = $Node.Nodes.Add("Entension$($ps)", "Serialized Property")
					}
					$SPS1Node.ForeColor = 'Gold'
					
					# Add SPS1 entry info
					$null = $SPS1Node.Nodes.Add("Storage Size", "Storage Size: $($SPS1properties[$ps].'Storage Size')")
					$null = $SPS1Node.Nodes.Add("FormatID", "FormatID: $($SPS1properties[$ps].FormatID)")
					if ($formatIDHashTable.keys.Where{ $_ -match $SPS1properties[$ps].FormatID }.count -eq 0)
					{
						$SPS1Node.Nodes["FormatID"].ForeColor = 'LavenderBlush'
						if ($SPS1properties[$ps].FormatID -eq 'D5CDD505-2E9C-101B-9397-08002B2CF9AE')
						{
							$SPS1Node.Nodes["FormatID"].Text = "FormatID: UserDefinedProperties [D5CDD505-2E9C-101B-9397-08002B2CF9AE]"
						}
					}
					else
					{
						$SPS1Node.Nodes["FormatID"].ForeColor = 'Gainsboro'
					}
					# Add the TypedProperties
					if ($SPS1properties[$ps].TypedProperty.count -ge 1)
					{
						for ($t = 0; $t -lt $SPS1properties[$ps].TypedProperty.count; $t++)
						{
							if ($SPS1properties[$ps].TypedProperty.count -gt 1) # Add counter if more than 1
							{
								$TypedPropertyNodes = $SPS1Node.Nodes.Add("TypedProperty$($t)", "TypedProperty Entry #$($t)")
							}
							else # No counter
							{
								$TypedPropertyNodes = $SPS1Node.Nodes.Add("TypedProperty$($t)", "TypedProperty Entry")
							}
							$TypedPropertyNodes.ForeColor = 'Plum'
							# ID
							if ($null -ne $SPS1properties[$ps].TypedProperty[$t].ID)
							{
								$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyTypeID$($t)", "PropertyID: $($SPS1properties[$ps].TypedProperty[$t].ID)")
							}
							# Value Size
							$null = $TypedPropertyNodes.Nodes.Add("ValueSize$($t)", "ValueSize: $($SPS1properties[$ps].TypedProperty[$t].ValueSize)")
							# Name
							if ($SPS1properties[$ps].TypedProperty[$t].NameSize -gt 0)
							{
								$null = $TypedPropertyNodes.Nodes.Add("NameSize$($t)", "NameSize: $($SPS1properties[$ps].TypedProperty[$t].NameSize)")
								$null = $TypedPropertyNodes.Nodes.Add("Name$($t)", "Name: $($SPS1properties[$ps].TypedProperty[$t].Name)")
								$TypedPropertyNodes.Nodes["Name$($t)"].ForeColor = 'LimeGreen'
							}
							# Type
							$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyType$($t)", "Type: $($SPS1properties[$ps].TypedProperty[$t].TypedProp.Type)")
							# Description
							$Description = $SPS1properties[$ps].TypedProperty[$t].Description
							
							# BLOB stuff
							if (!!$SPS1properties[$ps].TypedProperty[$t].NameSize -gt 0)
							{
								if (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes -and $SPS1properties[$ps].TypedProperty[$t].Name -in ('ViewItemsFolder', 'PubItemFolder.ShellItem'))
								{
									$BlobIDList = @(Get-EmbeddedIDList -ByteArray $SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes)
									if ($BlobIDList.count -ge 1)
									{
										$EmbeddedIDListNode = $TypedPropertyNodes.Nodes.Add("EmbeddedIDList$($t)", "$($SPS1properties[$ps].TypedProperty[$t].Name) ItemIDList")
										$EmbeddedIDListNode.ForeColor = 'GreenYellow'
										Populate-ItemIdListItems -ItemIDListNode $EmbeddedIDListNode -ItemIdList @($BlobIDList)
									}
								}
								elseif (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes -and $SPS1properties[$ps].TypedProperty[$t].Name -in ('AutoList', 'Condition', 'Sort', 'ColInfo', 'GroupView', 'GroupByKey:PID'))
								{
									$b = $SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes
									try
									{
										$StringSize = [System.BitConverter]::ToUInt32($b[4 .. 7], 0)
										if ($b.count -gt 8)
										{
											$Type = [System.Text.Encoding]::Unicode.GetString($b[8 .. (8 + $StringSize - 3)])
											$embeddedItemsSize = [System.BitConverter]::ToUInt32($b[(8 + $StringSize + 2) .. (8 + $StringSize + 2 + 3)], 0)
											
											$EmbeddedIDListNode = $TypedPropertyNodes.Nodes.Add("EmbeddedIDList$($t)", "$($SPS1properties[$ps].TypedProperty[$t].Name) Contents")
											$EmbeddedIDListNode.ForeColor = 'GreenYellow'
											$null = $EmbeddedIDListNode.Nodes.Add("TypeSize", "Type Name Size: $($StringSize)")
											$null = $EmbeddedIDListNode.Nodes.Add("Type", "Type Name: $($Type)")
											$EmbeddedIDListNode.Nodes["Type"].ForeColor = 'Honeydew'
											$null = $EmbeddedIDListNode.Nodes.Add("embeddedItemsSize", "$($SPS1properties[$ps].TypedProperty[$t].Name) Property Size: $($embeddedItemsSize)")
											
											if ($SPS1properties[$ps].TypedProperty[$t].Name -in ('AutoList', 'Condition'))
											{
												$CLSID = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($b[(8 + $StringSize + 2 + 4) .. (8 + $StringSize + 2 + 4 + 15)]))"
												$GUID = Get-CLSID -CLSIDstring $CLSID
												$NumberOfAttributes = [System.BitConverter]::ToUInt16($b[(8 + $StringSize + 2 + 4 + 16) .. (8 + $StringSize + 2 + 4 + 17)], 0)
												
												$null = $EmbeddedIDListNode.Nodes.Add("GUID", "GUID: $($GUID)")
												$EmbeddedIDListNode.Nodes["GUID"].ForeColor = 'LightGreen'
												
												if ($CLSID -eq '384EA5AE-ADE1-4E8A-8A9B-7BEA78FFF1E9') # BinaryAutoList
												{
													try
													{
														# skip 36 unknown bytes
														$LinkItemIDList = [ShellLink.Structures.LinkTargetIDList]::FromByteArray($b[96 .. ($b.Count - 1)])
														$EmbeddedIdList = [System.Collections.ArrayList]::new()
														foreach ($EmbeddedItemID in $LinkItemIDList.ItemIDList)
														{
															$linkItem = Get-LinkTargetIDList -ItemIdListItem $EmbeddedItemID
															$null = $EmbeddedIdList.Add($linkItem)
														}
														
														if ($EmbeddedIdList.count -ge 1)
														{
															Populate-ItemIdListItems -ItemIDListNode $EmbeddedIDListNode -ItemIdList @($EmbeddedIdList)
														}
													}
													catch { }
												}
												elseif ($CLSID -eq '116F8D13-101E-4fa5-84D4-FF8279381935') { $null } # CompoundCondition
												elseif ($CLSID -eq '52F15C89-5A17-48e1-BBCD-46A3F89C7CC2') { $null } # LeafCondition
												elseif ($CLSID -eq '8DE9C74C-605A-4acd-BEE3-2B222AA2D23D') { $null } # NegationCondition
												# C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\structuredquery.h
												# https://www.thezdi.com/blog/2020/3/25/cve-2020-0729-remote-code-execution-through-lnk-files
												else { $null }
											}
										}
										else
										{
											$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($StringSize)")
											$TypedPropertyNodes.Nodes["TypedPropertyValue$($t)"].ForeColor = 'LightGreen'
										}
									}
									catch { $null }
								}
							}
							
							if ($null -ne $Description)
							{
								if ($Description.Split('[').count -eq 2)
								{
									$DescriptionName = $Description.Split('[')[0]
									$DescriptionFI = "[$($Description.Split('[')[1])"
									$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyDescription$($t)", "Description: $($DescriptionName)")
									$null = $TypedPropertyNodes.Nodes["TypedPropertyDescription$($t)"].Nodes.Add("Desc", "$($DescriptionFI)")
								}
								else
								{
									$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyDescription$($t)", "Description: $($Description)")
								}
								
								if (!$Description.StartsWith('['))
								{
									$TypedPropertyNodes.Nodes["TypedPropertyDescription$($t)"].ForeColor = 'LimeGreen'
								}
								if (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes -and $Description -eq 'Delegate ID List [28636AA6-953D-11D2-B5D6-00C04FD918D0\32]')
								{
									$DelegateIDList = Get-DelegateIDlist -ByteArray $SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes
									if ($DelegateIDList.count -ge 1)
									{
										$DelegateNode = $TypedPropertyNodes.Nodes.Add("DelegateIDList$($t)", "Delegate ID List")
										$DelegateNode.ForeColor = 'GreenYellow'
										Populate-ItemIdListItems -ItemIDListNode $DelegateNode -ItemIdList @($DelegateIDList)
									}
								}
								elseif (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes -and $Description -eq 'System FilterInfo [1E3EE840-BC2B-476C-8237-2ACD1A839B22\2]')
								{
									try
									{
										# https://www.thezdi.com/blog/2020/3/25/cve-2020-0729-remote-code-execution-through-lnk-files
										$bytes = $SPS1properties[$ps].TypedProperty[$t].TypedProp.TBytes
										$UnicodeStingLength = [System.BitConverter]::ToInt32($bytes[0 .. 3], 0)
										$UnicodeSting = [System.Text.Encoding]::Unicode.GetString($bytes[4 .. ($UnicodeStingLength - 1)]).TrimEnd()
										$extralength = [System.BitConverter]::ToInt32($bytes[(4 + $UnicodeStingLength + 2) .. (4 + $UnicodeStingLength + 2 + 3)], 0)
										$eidx = 4 + $UnicodeStingLength + 2 + 4
										$FilterInfo = Get-Ext_SPS1 -ByteArray $bytes[$eidx..($bytes.count - 1)]
										if (!!$FilterInfo)
										{
											$FilterInfoNode = $TypedPropertyNodes.Nodes.Add("FilterInfo$($t)", "FilterInfo")
											$FilterInfoNode.ForeColor = 'GreenYellow'
											$null = $FilterInfoNode.Nodes.Add("UnicodeString", "Name: $($UnicodeSting)")
											$null = $FilterInfoNode.Nodes.Add("SPSdataSize", "Content Size: $($extralength)")
											$PropertyStoreEntries = [System.Collections.ArrayList]::new()
											foreach ($property in $FilterInfo)
											{
												$PropertyStoreEntry = [PSCustomObject]::new()
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
												$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
											}
											if (!!$PropertyStoreEntry)
											{
												Populate-SPS1 -Node $FilterInfoNode -SPS1properties @($PropertyStoreEntries)
											}
										}
									}
									catch { $null }
								}
							}
							# Raw Bytes and/or Value
							if (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.Value)
							{
								if ([System.String]$Description -eq 'SFGAOFlags [28636AA6-953D-11D2-B5D6-00C04FD918D0\25]') # $SFGAOflags
								{
									$sfflags = $SPS1properties[$ps].TypedProperty[$t].TypedProp.Value/1
									if ($null -ne $sfflags)
									{
										$sfgaovalue = Get-SFGAOflags -Flags $sfflags -Single $false
										$sfgaoNode = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: SFGAO Flags [0x$([System.String]$sfflags.ToString('X'))]")
										if (!!$sfgaovalue)
										{
											foreach ($sflag in $sfgaovalue.GetEnumerator())
											{
												$fkey = $SFGAOflags.GetEnumerator().where{ $_.value -eq $sflag }.key
												$null = $sfgaoNode.Nodes.Add("$($fkey)", "[$($fkey)]: $($sflag)")
											}
										}
										# $null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($sfgaovalue)")
									}
									
								}
								elseif ([System.String]$Description -eq 'FileAttributes [B725F130-47EF-101A-A5F1-02608C9EEBAC\13]') # Attributes
								{
									$attr_bytes = [System.BitConverter]::GetBytes(($SPS1properties[$ps].TypedProperty[$t].TypedProp.Value/1))
									$FileAttributes = Get-Attributes -Bytes $attr_bytes
									$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($FileAttributes)")
								}
								elseif ([System.String]$Description -eq 'SID [46588AE2-4CBC-4338-BBFC-139326986DCE\4]') # SID
								{
									try
									{
										$Sid = ConvertFrom-SID -Sid $SPS1properties[$ps].TypedProperty[$t].TypedProp.Value
										if (!!$Sid)
										{
											$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($Sid) [$($SPS1properties[$ps].TypedProperty[$t].TypedProp.Value)]")
										}
										else
										{
											$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($SPS1properties[$ps].TypedProperty[$t].TypedProp.Value)")
										}
									}
									catch
									{
										$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($SPS1properties[$ps].TypedProperty[$t].TypedProp.Value)")
									}
									
								}
								else # Value
								{
									$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyValue$($t)", "Value: $($SPS1properties[$ps].TypedProperty[$t].TypedProp.Value)")
								}
								if ([System.String]$SPS1properties[$ps].TypedProperty[$t].Name -in ('AutolistCacheTime') -or ([System.String]$SPS1properties[$ps].TypedProperty[$t].Name).Contains('Time') -or ([System.String]$SPS1properties[$ps].TypedProperty[$t].Name).Contains('timestamp'))
								{
									$TypedPropertyNodes.Nodes["TypedPropertyValue$($t)"].ForeColor = 'Cyan'
								}
								elseif (([System.String]$SPS1properties[$ps].TypedProperty[$t].Description).Contains('Date'))
								{
									$TypedPropertyNodes.Nodes["TypedPropertyValue$($t)"].ForeColor = 'Cyan'
								}
								else
								{
									$TypedPropertyNodes.Nodes["TypedPropertyValue$($t)"].ForeColor = 'LightGreen'
								}
							}
							if (!!$SPS1properties[$ps].TypedProperty[$t].TypedProp.Raw)
							{
								$null = $TypedPropertyNodes.Nodes.Add("TypedPropertyRawValue$($t)", "Raw (Hex) Value")
								$TypedPropertyNodes.Nodes["TypedPropertyRawValue$($t)"].Tag = @($SPS1properties[$ps].TypedProperty[$t].TypedProp.Raw)
								$TypedPropertyNodes.Nodes["TypedPropertyRawValue$($t)"].ToolTipText = "Right click to copy the raw (Hex) data ($($SPS1properties[$ps].TypedProperty[$t].TypedProp.Raw.length/2))"
								$TypedPropertyNodes.Nodes["TypedPropertyRawValue$($t)"].ForeColor = 'Peru'
							}
						}
					}
					else
					{
						continue
						# Show-WarningMessage -WarningMessage ($SPS1properties[$ps].TypedProperty|Out-String)
					}
				} #end for each SPS entry
			}
		}
		catch { $null }
	} # end Populate-SPS1
	
	function Populate-ItemIdListItems
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$ItemIDListNode,
			[Parameter(Mandatory = $true)]
			$ItemIdList
		)
		
		if (!!$ItemIdList)
		{
			$IDListItemsNode = $ItemIDListNode.Nodes.Add("$('IDList Items')", "IDList Items")
			$IDListItemsNode.ForeColor = 'Violet'
			for ($ic = 0; $ic -lt $ItemIdList.count; $ic++)
			{
				$IDListEntry = $IDListItemsNode.Nodes.Add("IDListItem$($ic)", "IDList Entry #$($ic.ToString('D3')) [$($ItemIdList[$ic].ItemIDType)]")
				$IDListEntry.ForeColor = 'Red'
				$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Size", "ItemID Size: $($ItemIdList[$ic].ItemIDSize)")
				$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ItemIDType", "ItemID Type: $($ItemIdList[$ic].ItemIDType)")
				$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["ItemIDType"].ForeColor = 'Violet'
				if ($null -ne $ItemIdList[$ic].DisplayName)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("DisplayName", "ItemID Display Name: $($ItemIdList[$ic].DisplayName)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["DisplayName"].ToolTipText = [System.Text.RegularExpressions.Regex]::Replace($ItemIdList[$ic].DisplayName, '(.){100}', "$('$0')`n")
				}
				if ($null -ne $ItemIdList[$ic].Signature)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Signature", "Signature: $($ItemIdList[$ic].Signature)")
				}
				if ($null -ne $ItemIdList[$ic].CPcategory)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("CPcategory", "Control Panel Category: $($ItemIdList[$ic].CPcategory)")
				}
				if ($null -ne $ItemIdList[$ic].DriveLetter)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("DriveLetter", "Drive Letter: $($ItemIdList[$ic].DriveLetter)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["DriveLetter"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].Timestamp)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Timestamp", "Timestamp: $($ItemIdList[$ic].Timestamp)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Timestamp"].ForeColor = 'Cyan'
				}
				if ($null -ne $ItemIdList[$ic].Port)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Port", "Port: $($ItemIdList[$ic].Port)")
				}
				if ($null -ne $ItemIdList[$ic].UriSize)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("UriSize", "Uri length: $($ItemIdList[$ic].UriSize)")
				}
				if ($null -ne $ItemIdList[$ic].URI)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("URI", "URI: $($ItemIdList[$ic].URI)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["URI"].ForeColor = 'LightGreen'
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["URI"].ToolTipText = [System.Text.RegularExpressions.Regex]::Replace($ItemIdList[$ic].URI, '(.){100}', "$('$0')`n")
				}
				if ($null -ne $ItemIdList[$ic].UserSize)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("UserSize", "Username size: $($ItemIdList[$ic].UserSize)")
				}
				if ($null -ne $ItemIdList[$ic].Username)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Username", "Username: $($ItemIdList[$ic].Username)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Username"].ForeColor = 'GreenYellow'
				}
				if ($null -ne $ItemIdList[$ic].PassSize)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("PassSize", "Password size: $($ItemIdList[$ic].PassSize)")
				}
				if ($null -ne $ItemIdList[$ic].Password)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Password", "Password: $($ItemIdList[$ic].Password)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Password"].ForeColor = 'GreenYellow'
				}
				if ($null -ne $ItemIdList[$ic].'Subfolder Ansi')
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Subfolder Ansi", "Subfolder Ansi: $($ItemIdList[$ic].'Subfolder Ansi')")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Subfolder Ansi"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].'Subfolder Unicode')
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Subfolder Unicode", "Subfolder Unicode: $($ItemIdList[$ic].'Subfolder Unicode')")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Subfolder Unicode"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].Flags)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Flags", "Flags: $($ItemIdList[$ic].Flags)")
				}
				if ($null -ne $ItemIdList[$ic].Path)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Path", "Path: $($ItemIdList[$ic].Path)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Path"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].Name)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Name", "Name: $($ItemIdList[$ic].Name)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Name"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].Description)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Description", "Description: $($ItemIdList[$ic].Description)")
				}
				if ($null -ne $ItemIdList[$ic].PathUnicode)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("PathUnicode", "Path (Unicode): $($ItemIdList[$ic].PathUnicode)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["PathUnicode"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].NameUnicode)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("NameUnicode", "Name (Unicode): $($ItemIdList[$ic].NameUnicode)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["NameUnicode"].ForeColor = 'LightGreen'
				}
				if ($null -ne $ItemIdList[$ic].DescriptionUnicode)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("DescriptionUnicode", "Description Unicode: $($ItemIdList[$ic].DescriptionUnicode)")
				}
				if ($null -ne $ItemIdList[$ic].NetworkProviderSize)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("NetworkProviderSize", "Network Provider Size: $($ItemIdList[$ic].NetworkProviderSize)")
				}
				if ($null -ne $ItemIdList[$ic].NetworkProvider)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("NetworkProvider", "Network Provider: $($ItemIdList[$ic].NetworkProvider)")
				}
				if (!!$ItemIdList[$ic].NetworkType -and $null -ne $ItemIdList[$ic].NetworkType)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("NetworkType", "Network Type: $($ItemIdList[$ic].NetworkType)")
				}
				if (!!$ItemIdList[$ic].Device -and $null -ne $ItemIdList[$ic].Device)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Device", "Device: $($ItemIdList[$ic].Device)")
				}
				if ($null -ne $ItemIdList[$ic].'SortOrderIndex')
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("SortOrderIndex", "Sort Order Index: $($ItemIdList[$ic].'SortOrderIndex')")
				}
				if ($null -ne $ItemIdList[$ic].FolderType)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("FolderTypeGUID", "Folder CLSID: $($ItemIdList[$ic].FolderType)")
				}
				if ($null -ne $ItemIdList[$ic].GUID)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("GUID", "GUID: $($ItemIdList[$ic].GUID)")
				}
				if ($null -ne $ItemIdList[$ic].CLSID)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("CLSID", "CLSID: $($ItemIdList[$ic].CLSID)")
				}
				if ($null -ne $ItemIdList[$ic].ShellName)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ShellName", "Shell Name: $($ItemIdList[$ic].ShellName)")
				}
				if ($null -ne $ItemIdList[$ic].Filesize)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Filesize", "File Size: $($ItemIdList[$ic].Filesize)")
				}
				if ($null -ne $ItemIdList[$ic].Attributes)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Attributes", "Attributes: $($ItemIdList[$ic].Attributes)")
				}
				if ($null -ne $ItemIdList[$ic].TargetAttributes)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("TargetAttributes", "Target Attributes: $($ItemIdList[$ic].TargetAttributes)")
				}
				if ($null -ne $ItemIdList[$ic].Ansi_Name)
				{
					$Ansi_Name = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Ansi_Name", "Ansi Name: $($ItemIdList[$ic].Ansi_Name)")
					$Ansi_Name.ForeColor = 'PaleGreen'
				}
				if ($null -ne $ItemIdList[$ic].Ansi_8_3_Name)
				{
					$Ansi_Name.Text = "Long Name: $($ItemIdList[$ic].Ansi_Name)"
					$Short_Name = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Ansi_8_3_Name", "Short Name: $($ItemIdList[$ic].Ansi_8_3_Name)")
					$Short_Name.ForeColor = 'PaleGreen'
				}
				if ($null -ne $ItemIdList[$ic].w32Modified -and $ItemIdList[$ic].w32Modified -ne '')
				{
					$w32Modifiednode = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("w32Modified", "Modified: $($ItemIdList[$ic].w32Modified)")
					$w32Modifiednode.ForeColor = 'Cyan'
				}
				if ($null -ne $ItemIdList[$ic].PropertyStoreEntries)
				{
					Populate-SPS1 -Node $IDListItemsNode.Nodes["IDListItem$($ic)"] -SPS1properties @($ItemIdList[$ic].PropertyStoreEntries)
				}
				if (!!$ItemIdList[$ic].ItemIdExtensions) # <==
				{
					$x = 0
					Foreach ($extension in $ItemIdList[$ic].ItemIdExtensions)
					{
						if (!!$extension.itemIdExtType)
						{
							$extensionNode = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("itemIdExtType$($x)", "Extension #$($x) Type: [$($extension.itemIdExtType)]")
							if ($extension.NewExtension -eq $true)
							{
								$extensionNode.BackColor = 'Yellow'
								$extensionNode.ForeColor = 'Black'
							}
						}
						else
						{
							$extensionNode = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("itemIdExtType$($x)", "Extension #$($x)")
						}
						$extensionNode.ForeColor = 'Tomato'
						if ($null -ne $extension.extLength)
						{
							$null = $extensionNode.Nodes.Add("ExtentionSize", "Extension Size: $($extension.extLength)")
						}
						if ($null -ne $extension.extversion)
						{
							$null = $extensionNode.Nodes.Add("ExtentionVersion", "Extension Version: $($extension.extversion)")
						}
						if ($null -ne $extension.Host)
						{
							$fsoffsetnode = $extensionNode.Nodes.Add("HostOS", "Host OS Hint: $($extension.Host) [$($extension.os)]")
							$fsoffsetnode.ToolTipText = "This is actually the Filename string offset from the start of the extension"
						}
						if ($null -ne $extension.Filesystem)
						{
							$null = $extensionNode.Nodes.Add("Filesystem", "FS Hint: $($extension.Filesystem)")
						}
						if ($null -ne $extension.GUID)
						{
							$null = $extensionNode.Nodes.Add("GUID", "GUID: $($extension.GUID)")
						}
						if ($null -ne $extension.CLSID)
						{
							$null = $extensionNode.Nodes.Add("CLSID", "CLSID: $($extension.CLSID)")
						}
						if ($null -ne $extension.UriEntries)
						{
							foreach ($uri_entry in $extension.UriEntries.PSobject.Properties)
							{
								$null = $extensionNode.Nodes.Add("$($uri_entry.Name)", "$($uri_entry.Name): $($uri_entry.Value)")
							}
						}
						if ($null -ne $extension.TargetPath)
						{
							$null = $extensionNode.Nodes.Add("TargetPath", "Link TargetParsingPath: $($extension.TargetPath)")
						}
						if ($null -ne $extension.Darwin)
						{
							$null = $extensionNode.Nodes.Add("Darwin", "Darwin Data Unicode: $($extension.Darwin)")
						}
						if ($null -ne $extension.AppUserModelID)
						{
							$null = $extensionNode.Nodes.Add("AUMID", "AppUserModel ID: $($extension.AppUserModelID)")
							$extensionNode.Nodes["AUMID"].ForeColor = 'LightGreen'
							$extensionNode.Nodes["AUMID"].ToolTipText = "[AUMID] https://learn.microsoft.com/en-us/windows/win32/shell/appids"
						}
						if ($null -ne $extension.AppParameters)
						{
							$null = $extensionNode.Nodes.Add("AppParameters", "Link Arguments : $($extension.AppParameters)")
						}
						if ($null -ne $extension.UserName)
						{
							$null = $extensionNode.Nodes.Add("UserName", "UserName: $($extension.UserName)")
							$extensionNode.Nodes["UserName"].ForeColor = 'PaleTurquoise'
						}
						if ($null -ne $extension.Unicode_Name)
						{
							$Unicode_Name = $extensionNode.Nodes.Add("Unicode_Name", "Unicode Name: $($extension.Unicode_Name)")
							$Unicode_Name.ForeColor = 'PaleGreen'
						}
						if ($null -ne $extension.Ansi_Name)
						{
							$Unicode_Name = $extensionNode.Nodes.Add("Ansi_Name", "Ansi Name: $($extension.Ansi_Name)")
							$Unicode_Name.ForeColor = 'PaleGreen'
						}
						if ($null -ne $extension.Localized_Name -and $extension.Localized_Name -ne '')
						{
							$Localized_Name = $extensionNode.Nodes.Add("Localized_Name", "Localized Name: $($extension.Localized_Name)")
							$Localized_Name.ForeColor = 'PaleGreen'
						}
						if ($null -ne $extension.Application)
						{
							$null = $extensionNode.Nodes.Add("Application", "Application: $($extension.Application)")
							$extensionNode.Nodes["Application"].ForeColor = 'LightGreen'
						}
						if ($null -ne $extension.DocumentType)
						{
							$null = $extensionNode.Nodes.Add("DocumentType", "Document Type: $($extension.DocumentType)")
							$extensionNode.Nodes["DocumentType"].ForeColor = 'LightGreen'
							if ($extension.itemIdExtType -eq 'BEEF001A' -and $extension.DocType.StartsWith('AppX'))
							{
								$TooltipText = "[SOFTWARE] Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\$($extension.DocType)"
								$extensionNode.Nodes["DocumentType"].ToolTipText = $extension.DocType
								$extensionNode.ToolTipText = [System.Text.RegularExpressions.Regex]::Replace($TooltipText, '(.){100}', "$('$0')`n")
							}
						}
						if ($null -ne $extension.PinStatus)
						{
							$null = $extensionNode.Nodes.Add("PinStatus", "Status: $($extension.PinStatus)")
							$extensionNode.Nodes["PinStatus"].ForeColor = 'LightGreen'
						}
						if ($null -ne $extension.Selection)
						{
							$null = $extensionNode.Nodes.Add("Selection", "Selection: $($extension.Selection)")
							$extensionNode.Nodes["Selection"].ForeColor = 'LightGreen'
						}
						if ($null -ne $extension.Attributes)
						{
							$null = $extensionNode.Nodes.Add("Attributes", "Attributes: $($extension.Attributes)")
						}
						if ($null -ne $extension.TargetCreated)
						{
							$null = $extensionNode.Nodes.Add("TargetCreated", "Target Created: $($extension.TargetCreated)")
							$extensionNode.Nodes["TargetCreated"].ForeColor = 'Cyan'
						}
						if ($null -ne $extension.TargetAccessed)
						{
							$null = $extensionNode.Nodes.Add("TargetAccessed", "Target Accessed: $($extension.TargetAccessed)")
							$extensionNode.Nodes["TargetAccessed"].ForeColor = 'Cyan'
						}
						if ($null -ne $extension.ShortCutCreated)
						{
							$null = $extensionNode.Nodes.Add("ShortCutCreated", "Link Created: $($extension.ShortCutCreated)")
							$extensionNode.Nodes["ShortCutCreated"].ForeColor = 'Cyan'
						}
						if ($null -ne $extension.ExtraPath)
						{
							$null = $extensionNode.Nodes.Add("ExtraPath", "App Path: $($extension.ExtraPath)")
						}
						if ($null -ne $extension.Created)
						{
							$CreatedNode = $extensionNode.Nodes.Add("Created", "Created (UTC): $($extension.Created)")
							$CreatedNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.Modified)
						{
							$ModifiedNode = $extensionNode.Nodes.Add("Modified", "Modified (UTC): $($extension.Modified)")
							$ModifiedNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.Accessed)
						{
							$AccessedNode = $extensionNode.Nodes.Add("Accessed", "Accessed (UTC): $($extension.Accessed)")
							$AccessedNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.LastWriteTime)
						{
							$LaestWriteTimeNode = $extensionNode.Nodes.Add("LastWriteTime", "LastWriteTime (UTC): $($extension.LastWriteTime)")
							$LaestWriteTimeNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.LastAccessed)
						{
							$LaestWriteTimeNode = $extensionNode.Nodes.Add("LastAccessed", "LastAccessed (UTC): $($extension.LastAccessed)")
							$LaestWriteTimeNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.w32Created)
						{
							$w32CreatedNode = $extensionNode.Nodes.Add("w32Created", "Created: $($extension.w32Created)")
							$w32CreatedNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.w32Accessed)
						{
							$w32AccessedNode = $extensionNode.Nodes.Add("w32Accessed", "Accessed: $($extension.w32Accessed)")
							$w32AccessedNode.ForeColor = 'Cyan'
						}
						if ($null -ne $extension.MFTRecordNr)
						{
							$MFTRecordNrNode = $extensionNode.Nodes.Add("MFTRecordNr", "MFT Record Nr: $($extension.MFTRecordNr)")
							$MFTRecordNrNode.ForeColor = 'Orange'
							$MFTRecordSeqNr = $extensionNode.Nodes.Add("MFTRecordSeqNr", "MFT Record Sequence Nr: $($extension.MFTRecordSeqNr)")
							$MFTRecordSeqNr.ForeColor = 'Orange'
						}
						if ($null -ne $extension.ReparsePointTag -and $ItemIdList[$ic].Attributes -match "Reparse_Point" <#$extension.ReparsePointTag -ne '00000000'#>)
						{
							
							if (!!$reparsefilter["$($extension.ReparsePointTag)"])
							{
								$null = $extensionNode.Nodes.Add("ReparsePointTag", "Reparse Point Tag: 0x$($extension.ReparsePointTag) => $($reparsefilter[$extension.ReparsePointTag])")
								# $null = $extensionNode.Nodes.Add("ReparseFilter", "Reparse Point Filter: $($reparsefilter["$($extension.ReparsePointTag)"])")
							}
							else { $null = $extensionNode.Nodes.Add("ReparsePointTag", "Reparse Point Tag: 0x$($extension.ReparsePointTag)") }
							$extensionNode.Nodes["ReparsePointTag"].ForeColor = 'LimeGreen'
						}
						if ($null -ne $extension.Unknown -and $extension.Unknown -notin ('0x00000000', '0x0000'))
						{
							$null = $extensionNode.Nodes.Add("Unknown", "Unknown value: $($extension.Unknown)")
						}
						elseif ($null -ne $extension.Reparse_Tag_Unknown)
						{
							$null = $extensionNode.Nodes.Add("Unknown", "Unknown value: $($extension.Reparse_Tag_Unknown)")
						}
						if ($null -ne $extension.Unknown_1 -and $extension.Unknown_1 -ne '0x00000000')
						{
							$null = $extensionNode.Nodes.Add("Unknown_1", "Unknown value #1: $($extension.Unknown_1)")
						}
						if ($null -ne $extension.fsraw -and !!$ItemIdList[$ic].RawFilesize -and $extension.itemIdExtType -eq 'BEEF0004') # get 64bit Filesize
						{
							try
							{
								$newFSraw = $ItemIdList[$ic].RawFilesize + $extension.fsraw
								$newFS = [System.BitConverter]::ToUInt64($newFSraw, 0)
								if ($newFS -gt 4294967295) # draw attention to the size if greater than 0xFFFFFFFF
								{
									$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Filesize"].Text = "File Size (64bit): $($newFS.ToString('N0'))"
									# $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Filesize"].BackColor = 'DarkGreen' #'Yellow'
									$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Filesize"].ForeColor = 'Yellow' #'Black'
								}
								else
								{
									$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Filesize"].Text = "File Size (64bit): $($newFS.ToString('N0'))"
								}
							}
							catch { }
						}
						if ($null -ne $extension.Unknown_2 -and $extension.Unknown_2 -ne '0x000000000000')
						{
							$null = $extensionNode.Nodes.Add("Unknown_2", "Unknown value #2: $($extension.Unknown_2)")
						}
						if ($null -ne $extension.Unknown_3 -and $extension.Unknown_3 -ne '0x00000000')
						{
							$null = $extensionNode.Nodes.Add("Unknown_3", "Unknown value #3: $($extension.Unknown_3)")
						}
						if ($null -ne $extension.EntryNr)
						{
							$null = $extensionNode.Nodes.Add("EntryNr", "Entry Nr: #$($extension.EntryNr)")
						}
						if ($null -ne $extension.PropertyStoreEntries)
						{
							Populate-SPS1 -Node $extensionNode -SPS1properties @($extension.PropertyStoreEntries)
						}
						if ($null -ne $extension.EmbeddedIdList)
						{
							Populate-ItemIdListItems -ItemIDListNode $extensionNode -ItemIdList @($extension.EmbeddedIdList)
						}
						if ($null -ne $extension.extData)
						{
							$rawext = $extensionNode.Nodes.Add("extData", "Extension Data")
							$rawext.Tag = @($extension.extData)
							$rawext.ToolTipText = "Right click to copy the raw (Hex) data ($($extension.extData.length))"
							$rawext.ForeColor = 'Peru'
						}
						$x++
					}
				}
				if ($null -ne $ItemIdList[$ic].EmbeddedIdList)
				{
					Populate-ItemIdListItems -ItemIDListNode $IDListItemsNode.Nodes["IDListItem$($ic)"] -ItemIdList @($ItemIdList[$ic].EmbeddedIdList)
				}
				if ($null -ne $ItemIdList[$ic].ExtType)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ExtType", "Extension Type: $($ItemIdList[$ic].ExtType)")
				}
				if ($null -ne $ItemIdList[$ic].TargetCreated)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("TargetCreated", "Target Created: $($ItemIdList[$ic].TargetCreated)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["TargetCreated"].ForeColor = 'Cyan'
				}
				if ($null -ne $ItemIdList[$ic].TargetAccessed)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("TargetAccessed", "Target Accessed: $($ItemIdList[$ic].TargetAccessed)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["TargetAccessed"].ForeColor = 'Cyan'
				}
				if ($null -ne $ItemIdList[$ic].ShortCutCreated)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ShortCutCreated", "LNK Created: $($ItemIdList[$ic].ShortCutCreated)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["ShortCutCreated"].ForeColor = 'Cyan'
				}
				if ($null -ne $ItemIdList[$ic].ZipIndex)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ZipIndex", "ZipIndex: $($ItemIdList[$ic].ZipIndex)")
				}
				if ($null -ne $ItemIdList[$ic].NameLength -and $ItemIdList[$ic].NameLength -gt 0)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("NameLength", "Name Length: $($ItemIdList[$ic].NameLength)")
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Name", "Name: $($ItemIdList[$ic].Name)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Name"].ForeColor = 'Yellow'
				}
				if ($null -ne $ItemIdList[$ic].ParentLength -and $ItemIdList[$ic].ParentLength -gt 0)
				{
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("ParentLength", "Parent Name Length: $($ItemIdList[$ic].ParentLength)")
					$null = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("Parent", "Parent Name: $($ItemIdList[$ic].Parent)")
					$IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes["Parent"].ForeColor = 'PaleGreen'
				}
				if (!!$ItemIdList[$ic].EmbeddedItems -and $ItemIdList[$ic].EmbeddedItems.count -ge 1)
				{
					$e = 0
					foreach ($embeddeditem in $ItemIdList[$ic].EmbeddedItems)
					{
						$embedded = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("EmbeddedItem$($e)", "Embedded Item: #$($e) Type: [$($embeddeditem.ItemIDType)]")
						$embedded.ForeColor = 'Violet'
						foreach ($embeddedproperty in $embeddeditem.psobject.Properties)
						{
							if ($embeddedproperty.Name -eq 'ItemIdExtensions')
							{
								$x = 0
								Foreach ($extension in $embeddedproperty.Value)
								{
									$extensionNode = $embedded.Nodes.Add("itemIdExtType", "Extension #$($x) Type: [$($extension.itemIdExtType)]")
									$extensionNode.ForeColor = 'Plum'
									if ($extension.NewExtension -eq $true)
									{
										$extensionNode.BackColor = 'Yellow'
										$extensionNode.ForeColor = 'Black'
									}
									$null = $extensionNode.Nodes.Add("ExtentionSize", "Extension Size: $($extension.extLength)")
									$null = $extensionNode.Nodes.Add("ExtentionVersion", "Extension Version: $($extension.extversion)")
									if ($null -ne $extension.Unicode_Name)
									{
										$Unicode_Name = $extensionNode.Nodes.Add("Unicode_Name", "Unicode Name: $($extension.Unicode_Name)")
										$Unicode_Name.ForeColor = 'PaleGreen'
									}
									if ($null -ne $extension.DocumentType)
									{
										$null = $extensionNode.Nodes.Add("DocumentType", "Document Type: $($extension.DocumentType)")
									}
									if ($null -ne $extension.w32Created)
									{
										$w32CreatedNode = $extensionNode.Nodes.Add("w32Created", "Created: $($extension.w32Created)")
										$w32CreatedNode.ForeColor = 'Cyan'
									}
									if ($null -ne $extension.w32Accessed)
									{
										$w32AccessedNode = $extensionNode.Nodes.Add("w32Accessed", "Accessed: $($extension.w32Accessed)")
										$w32AccessedNode.ForeColor = 'Cyan'
									}
									if ($null -ne $extension.MFTRecordNr)
									{
										$MFTRecordNrNode = $extensionNode.Nodes.Add("MFTRecordNr", "MFT Record Nr: $($extension.MFTRecordNr)")
										$MFTRecordNrNode.ForeColor = 'Orange'
										$MFTRecordSeqNr = $extensionNode.Nodes.Add("MFTRecordSeqNr", "MFT Record Sequence Nr: $($extension.MFTRecordSeqNr)")
										$MFTRecordSeqNr.ForeColor = 'Orange'
									}
									if ($null -ne $extension.ReparsePointTag -and !!$reparsefilter["$($extension.ReparsePointTag)"] <#$ItemIdList[$ic].Attributes -match "Reparse_Point" <#$extension.ReparsePointTag -ne '00000000'#>)
									{
										$null = $extensionNode.Nodes.Add("ReparsePointTag", "Reparse Point Tag: 0x$($extension.ReparsePointTag) => $($reparsefilter[$extension.ReparsePointTag])")
										$extensionNode.Nodes["ReparsePointTag"].ForeColor = 'LimeGreen'
									}
									if ($null -ne $extension.Unknown -and $extension.Unknown -ne '0x00000000')
									{
										$null = $extensionNode.Nodes.Add("Unknown", "Unknown value: $($extension.Unknown)")
									}
									elseif ($null -ne $extension.Reparse_Tag_Unknown)
									{
										$null = $extensionNode.Nodes.Add("Unknown", "Unknown value: $($extension.Reparse_Tag_Unknown)")
									}
									if ($null -ne $extension.Unknown_1 -and $extension.Unknown_1 -ne '0x00000000')
									{
										$null = $extensionNode.Nodes.Add("Unknown_1", "Unknown value #1: $($extension.Unknown_1)")
									}
									if ($null -ne $extension.Unknown_2 -and $extension.Unknown_2 -ne '0x000000000000')
									{
										$null = $extensionNode.Nodes.Add("Unknown_2", "Unknown value #2: $($extension.Unknown_2)")
									}
									if ($null -ne $extension.Unknown_3 -and $extension.Unknown_3 -ne '0x00000000')
									{
										$null = $extensionNode.Nodes.Add("Unknown_3", "Unknown value #3: $($extension.Unknown_3)")
									}
									$x++
								}
							}
							elseif ($embeddedproperty.Name -eq 'Timestamp')
							{
								$null = $embedded.Nodes.Add("$($embeddedproperty.Name)", "$($embeddedproperty.Name): $($embeddedproperty.Value)")
								$embedded.Nodes["$($embeddedproperty.Name)"].ForeColor = 'Cyan'
							}
							elseif ($embeddedproperty.Name -eq 'Parent')
							{
								$null = $embedded.Nodes.Add("$($embeddedproperty.Name)", "$($embeddedproperty.Name): $($embeddedproperty.Value)")
								$embedded.Nodes["$($embeddedproperty.Name)"].ForeColor = 'PaleGreen'
							}
							elseif ($embeddedproperty.Name -eq 'Name')
							{
								$null = $embedded.Nodes.Add("$($embeddedproperty.Name)", "$($embeddedproperty.Name): $($embeddedproperty.Value)")
								$embedded.Nodes["$($embeddedproperty.Name)"].ForeColor = 'Yellow'
							}
							elseif ($embeddedproperty.Name -eq 'w32Modified' -and $null -ne $embeddedproperty.Value)
							{
								$w32Modifiednode = $embedded.Nodes.Add("w32Modified", "Modified): $($embeddedproperty.Value)")
								$w32Modifiednode.ForeColor = 'Cyan'
							}
							elseif ($embeddedproperty.Name -eq 'Data')
							{
								$null = $embedded.Nodes.Add("$($embeddedproperty.Name)", "Embedded Item $($embeddedproperty.Name)")
								$embedded.Nodes["$($embeddedproperty.Name)"].ForeColor = 'Peru'
								$embedded.Nodes["$($embeddedproperty.Name)"].Tag = @($embeddedproperty.Value)
								$embedded.Nodes["$($embeddedproperty.Name)"].ToolTipText = "Right click to copy the raw (Hex) data ($($embeddedproperty.Value.length))"
							}
							elseif ($embeddedproperty.Name -eq 'Filesize' -and $embeddedproperty.Value -eq $null)
							{
								continue
							}
							else
							{
								$null = $embedded.Nodes.Add("$($embeddedproperty.Name)", "$($embeddedproperty.Name): $($embeddedproperty.Value)")
								if ($embeddedproperty.Name -eq 'Ansi_Name') { $embedded.Nodes["$($embeddedproperty.Name)"].ForeColor = 'PaleGreen' }
							}
						}
						$e++
					}
				}
				$raw = $IDListItemsNode.Nodes["IDListItem$($ic)"].Nodes.Add("RawHexData", "ItemID Data")
				$raw.Tag = @($ItemIdList[$ic].Data)
				$raw.ToolTipText = "Right click to copy the raw (Hex) data ($($ItemIdList[$ic].Data.length/2))"
				$raw.ForeColor = 'Peru'
			}
		}
	} # Populate-ItemIdListItems
	
	<#
		.SYNOPSIS
			Decodes an ObjectID GUID
		
		.DESCRIPTION
			Decodes an ObjectID GUID to:
			
			- Formatted ObjectID GUID
			- Version
			- Variant
			- Sequence Nr
			- Created Timestamp (UTC)
			- MAC Address
		
		.PARAMETER Hex
			A description of the Hex parameter.
		
		.EXAMPLE
			PS C:\> Get-ObjectIdFromHex
		
		.OUTPUTS
			System.Management.Automation.PSObject
		
		.NOTES
			Additional information about the function.
	#>
	function Get-ObjectIdFromHex
	{
		[CmdletBinding()]
		[OutputType([pscustomobject])]
		param
		(
			[Parameter(Mandatory = $true)]
			[string]$Hex
		)
		
		try
		{
			# remove 0x and extra spaces
			$Hex = $Hex -replace " ", ""
			$Hex = $Hex.trim() -replace '\s', ''
			
			# check length
			if ($hex.length -ne 32) { return }
			
			# prepare output pscustomobject	
			$PS_ObjectID = [PSCustomObject]@{ }
			
			# Object ID
			$objid = $Hex -replace '(..)(..)(..)(..)(..)(..)(..)(..)(..)(..)', '$4$3$2$1-$6$5-$8$7-$9$10-'
			$ObjectID = [System.GUID]::Parse($objid).Guid.ToUpper()
			
			# Add to pscustomobject			
			$PS_ObjectID | Add-Member -Type NoteProperty -Name 'ObjectID' -Value $ObjectID
			
			$version = [Convert]::ToUInt64("0x$($hex.Substring(14, 1))", 16)
			$vs = [convert]::ToString("0x$($objid.Substring(19, 4))", 2).PadLeft(16, '0')
			$variant = [Convert]::ToInt16($vs.Substring(0, 2), 2)
			$Sequence = [Convert]::ToInt16($vs.Substring(2, 14), 2)
			
			# Add to pscustomobject		
			$PS_ObjectID | Add-Member -Type NoteProperty -Name 'Version' -Value $version
			$PS_ObjectID | Add-Member -Type NoteProperty -Name 'Variant' -Value $variant
			$PS_ObjectID | Add-Member -Type NoteProperty -Name 'Sequence' -Value $Sequence
			
			# Get MAC address & Timestamp
			if ($objid.Substring(14, 1) -eq 1)
			{
				# Get the Date
				# Get the first 16 bytes 
				$tm = $hex.Substring(0, 16)
				# Replace the Version nimble (14) with 0
				$tm = $tm.Remove(14, 1).Insert(14, '0')
				# Reverse Endianess
				$tm = $tm -split "(..)" -ne ""
				[Array]::Reverse($tm)
				$tm = $tm -join ""
				# Convert to Decimal
				$timedec = [Convert]::ToUInt64("0x$($tm)", 16)
				# Get offsets from 1582 & 1601
				$1582offset = (New-Object DateTime(1582, 10, 15, 0, 0, 0)).Ticks
				$1601offset = (New-Object DateTime(1601, 1, 1, 0, 0, 0)).Ticks
				# Calculate the Date after substracting the two Date offsets
				$ObjectIdCreated = [datetime]::FromFileTimeUtc($timedec - ($1601offset - $1582offset)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
				
				# Add to pscustomobject	
				$PS_ObjectID | Add-Member -Type NoteProperty -Name 'Created' -Value $ObjectIdCreated
				
				# Format MAC
				$mac = ($hex.Substring(20, 12) -split "(..)" -ne "") -join ":"
				
				# Add to pscustomobject	
				$PS_ObjectID | Add-Member -Type NoteProperty -Name 'MAC' -Value $mac
			}
			# output
			$PS_ObjectID
		}
		catch { $null }
	} # End Get-ObjectIdFromHex
	
	# Create MAC address/Company Cache
	$script:MAC_Collection = [System.Collections.Hashtable]::New()
	
	function Get-MACManufacturer
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$MacAddress
		)
		$check = [System.Text.RegularExpressions.Regex]::IsMatch($MacAddress, '^[0-9a-fA-F]{2}(((:[0-9a-fA-F]{2}){5})|((-[0-9a-fA-F]{2}){5}))$')
		if (!!$MacAddress -and !!$check)
		{
			# $MacLookup = "https://api.macvendors.com/$($MacAddress)"
			$MacLookup = "https://api.maclookup.app/v2/macs/$($MacAddress)/company/name"
			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
			if (!!$script:MAC_Collection["$($MacAddress)"]) # Check cache first
			{
				return $script:MAC_Collection["$($MacAddress)"]
			}
			elseif (test-connection -ComputerName 8.8.8.8 -Count 1 -Quiet -ErrorAction SilentlyContinue) # Check connection
			{
				try
				{
					$MacManufacturer = (Invoke-RestMethod -Uri $MacLookup -UserAgent 'https://github.com/kacos2000/Jumplist-Browser' -TimeoutSec 30)
					if (!!$MacManufacturer)
					{
						$null = $script:MAC_Collection["$($MacAddress)"] = $MacManufacturer # Add to Cache
						return $MacManufacturer
					}
				}
				catch
				{
					return $null
				}
				
			}
			else
			{
				return $null
			}
		}
		else
		{
			return $null
		}
	} # Get-MACManufacturer
	
	function Get-GUIDfromHexString
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$Hex
		)
		
		if ($Hex.Length -in (32, 47) -and !![System.Text.RegularExpressions.Regex]::IsMatch($Hex, '[a-fA-F1-9]'))
		{
			try
			{
				# remove 0x and extra spaces
				$Hex = $Hex -replace " ", ""
				$Hex = $Hex.trim() -replace '\s', ''
				# Convert Hex String to GUID
				$guidhex = $Hex.Replace('-', '') -replace '(..)(..)(..)(..)(..)(..)(..)(..)(..)(..)', '$4$3$2$1-$6$5-$8$7-$9$10-'
				$GUID = [System.GUID]::Parse($guidhex).Guid.ToUpper()
				Return $GUID
			}
			catch { return $null }
		}
		else { return $null }
	} # Get-GUIDfromHexString
	
	function DosDateTime-FromHex
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$Hex
		)
		
		$hex_time = "0x$(($hex -split "(....)")[1])"
		$hex_date = "0x$(($hex -split "(....)")[3])"
		
		$bin_t = [Convert]::ToString($hex_time, 2).padleft(16, '0')
		$bin_d = [Convert]::ToString($hex_date, 2).padleft(16, '0')
		
		$hour = $bin_t.substring(0, 5)
		$minutes = $bin_t.substring(5, 6)
		$seconds = $bin_t.substring(11, 5)
		$Time = "$([Convert]::toInt32($hour, 2)):$([Convert]::toInt32($minutes, 2)):$([Convert]::toInt32($seconds, 2) * 2)"
		
		$year = $bin_d.substring(0, 7)
		$month = $bin_d.substring(7, 4)
		$day = $bin_d.substring(11, 5)
		$Date = "$([Convert]::toInt32($day, 2))/$([Convert]::toInt32($month, 2))/$([Convert]::toInt32($year, 2) + 1980)"
		try
		{
			$DosDate = [System.DateTime]::Parse("$($Date) $($Time)")
		} 
		catch { $DosDate = $null }
		
		return $DosDate
	} # DosDateTime-FromHex
	
	# Type [00] Removable Storage (eg Canon Camera)
	$unknown_sigs = @(
		"48050520"
		"48050520"
		"B2020620"
		"00000500"
		"70050520"
		"C2020620"
		"7C010620"
		"56040520"
		"DC020620"
		"BC020620"
		"08000000" # TaskbarWinXP
		"B4020620"
		"96040520"
		"C0020620"
		"A8020620"
		"C8020620"
		"A4020620"
		"A8020620"
	)
	
	function Get-Ext_00 # Variants
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$ClassType = [System.BitConverter]::ToString($ByteArray[1])
		$Signature = [System.BitConverter]::ToString($ByteArray[2 .. 5]).Replace('-', '')
		
		try
		{
			$TaskbarXPCLSIDhex = [System.BitConverter]::ToString($ByteArray[14 .. 29]).Replace('-', '')
			$TaskbarXPCLSID = 'AA4F2868486AD0118C7800C04FD918B4'
		}
		catch
		{
			$null = $TaskbarXPCLSIDhex
		}
	        if ($TaskbarXPCLSIDhex -eq $TaskbarXPCLSID) # TaskBand
		{
			$CLSID = Get-GUIDfromHexString -Hex $TaskbarXPCLSIDhex
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'CLSID'	     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
			}
		}
		elseif ($Signature -eq '47465349') # GFSI
		{
			$CLSID = if ($ByteArray -ge 22) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[6 .. 21]))" }
			else { $null }
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'CLSID'	     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
			}
			
			if ($ItemIDSize -ge 38)
			{
				$idx = 30
				$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
			} # end if 
			
		}
		elseif ($Signature -eq '1A00EEBB') # Embedded ITemID items 1 + extensions
		{
			$Attributes = Get-Attributes -Bytes $ByteArray[8 .. 11]
			$CLSID = if ($ItemIDSize -ge 28) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[12 .. 27]))" }
			else { $null }
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'Attributes' = $Attributes
				'CLSID'	     = if ($CLSID) { Get-FolderDescription -CLSIDstring $CLSID }else { $null }
			}
			if ($ItemIDSize -ge 38)
			{
				$idx = 30
				$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
			} # end if 
		}
		elseif ($Signature -eq '4175674D') # Embedded ITemID items 2 # AugM
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
			
			if ($ItemIdListItem.ItemIDSize -ge 18)
			{
				$EmbeddedItemIDs = [System.Collections.ArrayList]::new()
				$idx = 14
				while ($idx -lt ($ItemIdListItem.ItemIDSize - 14))
				{
					$itemSize = [Bitconverter]::ToUInt16($ByteArray[($idx) .. ($idx + 1)], 0)
					if ($itemSize -eq 0) { break }
					$null = $EmbeddedItemIDs.Add([ShellLink.Structures.ItemID]::FromByteArray($ByteArray[$idx .. ($idx + $itemSize - 1)]))
					$idx = $idx + $itemSize + 2
					if ($idx -ge ($ItemIdListItem.ItemIDSize - 14)) { break }
				}
				if ($EmbeddedItemIDs.Count -ge 1)
				{
					$EmbeddedIdList = [System.Collections.ArrayList]::new()
					foreach ($EmbeddedItemID in $EmbeddedItemIDs)
					{
						$linkItem = Get-LinkTargetIDList -ItemIdListItem $EmbeddedItemID
						$null = $EmbeddedIdList.Add($linkItem)
					}
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'EmbeddedIdList' -Value $EmbeddedIdList
				}
			}
			
		}
		elseif ($Signature -eq 'FFFFFFFF') # Path/Description
		{
			try
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
				$Attributes = Get-Attributes -Bytes $ByteArray[6 ..7]
				$pathSize = [System.Bitconverter]::ToUInt16($ByteArray[8 .. 9], 0)
				$Path = [System.Text.Encoding]::UTF8.GetString($ByteArray[10 .. (10 + $pathSize - 1)])
				$Description = [System.Text.Encoding]::UTF8.GetString($ByteArray[(10 + $pathSize) .. ($ItemIDSize - 1)])
				
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Path' -Value $Path
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Attributes' -Value $Attributes
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Description' -Value $Description
			}
			catch
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
			}
		}
		elseif ($Signature -eq '00DBBABE')
		{
			try
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
				
				$Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[10 .. ($ItemIDSize - 1)])
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Name' -Value $Name
			}
			catch
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -eq '338B0123') # PropertyStore 1
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$CLSID = if ($ByteArray -ge 28) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[12 .. 27]))" }
			else { $null }
			$CLSID0 = if ($ByteArray -ge 43) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[28 .. 43]))" }
			else { $null }
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'GUID'	     = if ($CLSID0) { Get-CLSID -CLSIDstring $CLSID0 }else { $null }
				'CLSID'	     = if ($CLSID) { Get-FolderDescription -CLSIDstring $CLSID }else { $null }
			}
			if ($ItemIDSize -ge 56 -and [System.Text.Encoding]::ASCII.GetString($ByteArray[52 .. 55]) -eq '1SPS')
			{
				$ExtraData = $ByteArray[44 .. ($ItemIDSize - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -in ('81191410')) # PropertyStore 2 - may have Delegate ID List
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
			if ($ItemIDSize -gt 48)
			{
				$ExtraData = $ByteArray[40 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$TotalSPSize = $null
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					$TotalSPSize = $TotalSPSize + $property.'Storage Size'
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				
				if (($ExtraData.Count - $TotalSPSize) -ge 8)
				{
					$extData = $ExtraData[$TotalSPSize .. ($ExtraData.count - 1)]
					$idx = $extData.IndexOf($extData.Where{ $_ -ne 0 }[0])
					$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $extData -idx $idx
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
				}
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -eq '1F00A104') # PropertyStore 3 (Autolist)
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
			
			if ($ItemIDSize -ge 27)
			{
				$ExtraData = $ByteArray[16 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$TotalSPSize = $null
				if (!!$Items)
				{
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
						$TotalSPSize = $TotalSPSize + $property.'Storage Size'
					}
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				if (($ExtraData.Count - $TotalSPSize) -ge 8)
				{
					$extData = $ExtraData[$TotalSPSize .. ($ExtraData.count - 1)]
					$idx = $extData.IndexOf($extData.Where{ $_ -ne 0 }[0])
					$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $extData -idx $idx
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
				}
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -in ('00EEEBBE', 'BBAF933B', '26017719', '02087619', '14038719', '99671245')) # PropertyStore 4
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'Attributes' = $Attributes
			}
			
			if ($ItemIDSize -gt 23)
			{
				$ExtraData = $ByteArray[12 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$TotalSPSize = $null
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					$TotalSPSize = $TotalSPSize + $property.'Storage Size'
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				
				if (($ExtraData.Count - $TotalSPSize) -ge 8)
				{
					$extData = $ExtraData[$TotalSPSize .. ($ExtraData.count - 1)]
					$idx = $extData.IndexOf($extData.Where{ $_ -ne 0 }[0])
					$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $extData -idx $idx
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
				}
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -in ('14001F58')) # PropertyStore 5 + Embedded IDlist (offset 0)
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$CLSID = if ($ByteArray -ge 24) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[8 .. 23]))" }
			else { $null }
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'CLSID'	     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
			}
			
			if ($ItemIDSize -gt 46)
			{
				$ExtraData = $ByteArray[38 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$1SPS_StorageSize = [int]$ByteArray[24]
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				
				if (($ByteArray.count - $1SPS_StorageSize - 24) -gt 0)
				{
					$indx = 24 + $1SPS_StorageSize
					#try to add any other ItemIDs
					try
					{
						$EmbeddedIdList = @(Get-EmbeddedIDList -ByteArray $ByteArray[($indx)..($ByteArray.count - 1)] -Index 0)
						# Add the embedded items
						if ($EmbeddedIdList.Count -ge 1)
						{
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "EmbeddedIdList" -Value $EmbeddedIdList
							$extData = [System.BitConverter]::ToString($ByteArray[($indx) .. ($ByteArray.count - 1)]) -replace '-', ''
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						} # end embedded items 
						else
						{
							$extData = [System.BitConverter]::ToString($ByteArray[($indx) .. ($ByteArray.count - 1)]) -replace '-', ''
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						}
					}
					catch { $null }
				}
			}
			
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -in ('41505053', '45740304')) # PropertyStore 6 # APPS => May have extensions
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
			if ($ItemIDSize -gt 28)
			{
				$ExtraData = $ByteArray[16 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$TotalSPSize = $null
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					$TotalSPSize = $TotalSPSize + $property.'Storage Size'
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				
				if (($ExtraData.Count - $TotalSPSize) -ge 8)
				{
					$extData = $ExtraData[$TotalSPSize .. ($ExtraData.count - 1)]
					$idx = $extData.IndexOf($extData.Where{ $_ -ne 0 }[0])
					$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $extData -idx $idx
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
				}
			}
			
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -in ('70190801')) # PropertyStore 7 - Control Panel
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$Attributes = Get-Attributes -Bytes $ByteArray[12 .. 15]
			$CLSID = if ($ByteArray -ge 32) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[16 .. 31]))" }
			else { $null }
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
				'Attributes' = $Attributes
				'CLSID'	     = if ($CLSID) { Get-FolderDescription -CLSIDstring $CLSID }else { $null }
			}
			if ($ItemIDSize -gt 60)
			{
				$ExtraData = $ByteArray[48 .. ($ByteArray.count - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
			}
		}
		elseif (([System.BitConverter]::ToString($ByteArray[4 .. 7]).Replace('-', '')) -eq 'EEBBFE23' <#-and [System.BitConverter]::ToString($ByteArray[2]) -eq 26#>) # '1A'
		{
			$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
			else { $ClassType }
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$Attributes = Get-Attributes -Bytes $ByteArray[10..11]
			$CLSID0 = if ($ItemIdListItem.ItemIDSize -ge 27) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[12 .. 27]))" }
			else { $null }
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'	 = $ItemIDSize
				'ItemIDType'	 = $ItemIDType
				'SortOrderIndex' = $Class
				'Signature'	     = "0x$($Signature)"
				'Atrributes'	 = $Attributes
				'GUID'		     = if ($CLSID0) { Get-FolderDescription -CLSIDstring $CLSID0 }else { $null }
			}
			if ($ItemIDSize -ge 38)
			{
				if ([System.BitConverter]::ToString($ByteArray[32 .. 35]) -eq '31-53-50-53') # 1SPS
				{
					$ExtraData = [System.BitConverter]::GetBytes([uint32]0) + $ByteArray[28 .. ($ItemIDSize - 1)]
					$PropertyStoreEntries = [System.Collections.ArrayList]::new()
					$Items = Get-Ext_SPS1 -ByteArray $ExtraData
					$1SPS_StorageSize = 0
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
						# Get SPS size
						$1SPS_StorageSize = $1SPS_StorageSize + $property.'Storage Size' + 6
					}
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				else
				{
					$idx = 30
					$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'ItemIdExtensions' -Value $ItemIdExtensions
				}
			} # end if 
		} # End of 0x1A
		elseif ([System.BitConverter]::ToString($ByteArray[12 .. 15]).Replace('-', '') -eq '31535053') #1SPS
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
			}
			$PropertyStoreEntries = [System.Collections.ArrayList]::new()
			$ExtraData = [byte[]](0, 0, 0, 0)+$ByteArray[8 .. ($ItemIDSize - 1)]
			$Items = Get-Ext_SPS1 -ByteArray $ExtraData
			foreach ($property in $items)
			{
				$PropertyStoreEntry = [PSCustomObject]::new()
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
				$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
			}
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
		}
		elseif ([System.BitConverter]::ToString($ByteArray[20 .. 23]).Replace('-', '') -eq '31535053') # 1SPS
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'	 = $ItemIDSize
				'ItemIDType'	 = $ItemIDType
				'SortOrderIndex' = $Class
				'CLSID'		     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
			}
			
			if ($ItemIDSize -gt 23)
			{
				
				$ExtraData = $ByteArray[12 .. ($ItemIDSize - 1)]
				$PropertyStoreEntries = [System.Collections.ArrayList]::new()
				$Items = Get-Ext_SPS1 -ByteArray $ExtraData
				$1SPS_StorageSize = 0
				foreach ($property in $items)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					# Get SPS size
					$1SPS_StorageSize = $1SPS_StorageSize + $property.'Storage Size' + 6
				}
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				
				if (($ItemIDSize - $1SPS_StorageSize) -gt 0)
				{
					$indx = $ItemIDSize - $1SPS_StorageSize - 4
					
					#try to add any other ItemIDs
					try
					{
						$EmbeddedIdList = @(Get-EmbeddedIDList -ByteArray $ByteArray[($indx)..($ItemIDSize - 1)])
						
						# Add the embedded items
						if ($EmbeddedIdList.Count -ge 1)
						{
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "EmbeddedIdList" -Value $EmbeddedIdList
							$extData = [System.BitConverter]::ToString($ByteArray[($indx) .. ($ItemIDSize - 1)]) -replace '-', ''
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						} # end embedded items 
						else
						{
							$extData = [System.BitConverter]::ToString($ByteArray[($indx) .. ($ItemIDSize - 1)]) -replace '-', ''
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						}
					}
					catch { $null }
				}
				
			} # end 1SPS
		}
		elseif ($Signature -eq '00000000' -and [System.BitConverter]::ToString($ByteArray[26 .. 29]).Replace('-', '') -eq 'F1F1F1F1') #1SPS in reg Streams
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[26 .. 29]).Replace('-', '')
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
			$size = [System.BitConverter]::ToUInt32($ByteArray[46 .. 49], 0)
			$PropertyStoreEntries = [System.Collections.ArrayList]::new()
			$ExtraData = $ByteArray[46 .. (46 + $size + 4)]
			$Items = Get-Ext_SPS1 -ByteArray $ExtraData
			foreach ($property in $items)
			{
				$PropertyStoreEntry = [PSCustomObject]::new()
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
				$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
				$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
			}
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
		}
		elseif ($Signature -eq '00000000' -and $ByteArray[18 .. 19].Contains([byte]16)) # if Attribute => Directory #Obsolete(?)
		{
			try
			{
				$type = [System.BitConverter]::ToUInt16($ByteArray[18 .. 19], 0)
				$Attributes = Get-Attributes -Bytes $ByteArray[18..21]
				$Timestamp = [System.Text.Encoding]::Unicode.GetString($ByteArray[22 .. 53])
				$ZipIndex = [System.BitConverter]::ToUInt16($ByteArray[54 .. 55], 0)
				$ParentLength = [System.BitConverter]::ToUInt16($ByteArray[62 .. 63], 0)
				$NameLength = [System.BitConverter]::ToUInt16($ByteArray[58 .. 59], 0)
				$Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[66 .. (66 + $NameLength * 2 - 1)])
				$pidx = 66 + $NameLength * 2 + 2
				$Parent = if ($ParentLength -gt 0)
				{
					[System.Text.Encoding]::Unicode.GetString($ByteArray[$pidx .. ($pidx + $ParentLength * 2 - 1)])
				}
				else { $null }
				
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize'   = $ItemIDSize
					'ItemIDType'   = $ItemIDType
					<#'DisplayName'  = $ItemIdListItem.DisplayName#>
					'Type'		   = $type
					'Attributes'   = $Attributes
					'Timestamp'    = $Timestamp
					'ZipIndex'	   = $ZipIndex
					'ParentLength' = $ParentLength
					'NameLength'   = $NameLength
					'Name'		   = $Name
					'Parent'	   = $Parent
				}
				
				$idx = $pidx + $ParentLength * 2 + 2
				if ($ByteArray.Count -gt $idx)
				{
					try
					{
						$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
					}
					catch { $null }
				}
			}
			catch
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
			}
			
		}
		elseif ([System.BitConverter]::ToString($ByteArray[0 .. 15]).Replace('-', '') -ne '00000000000000000000000000000000' -and $Signature -notin $unknown_sigs)
		{
			try
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
				# Get Sizes
				$UriSize = [System.BitConverter]::ToUInt16($ByteArray[18 .. 19], 0)
				$NetworkProviderSize = [System.BitConverter]::ToUInt16($ByteArray[20 .. 21], 0)
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "UriSize" -Value $UriSize
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "NetworkProviderSize" -Value $NetworkProviderSize
				$idx = 22
				
				# Get unicode text
				if ($ItemIDSize -ge ($idx + ($UriSize * 2) + ($NetworkProviderSize * 2)))
				{
					$uri = [System.Text.Encoding]::Unicode.GetString($ByteArray[$idx .. ($idx + ($UriSize * 2) - 1)])
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "URI" -Value $uri
					$idx = 22 + ($UriSize * 2)
					
					if ($NetworkProviderSize -gt 0)
					{
						$NetworkProvider = [System.Text.Encoding]::Unicode.GetString($ByteArray[$idx .. ($idx + ($NetworkProviderSize * 2) - 1)])
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "NetworkProvider" -Value $NetworkProvider
						$idx = 22 + ($UriSize * 2) + ($NetworkProviderSize * 2)
					}
					
					if ($ItemIDSize -gt ($idx + 8))
					{
						try
						{
							$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
						}
						catch { $null }
					}
				}
			}
			catch
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = "0x$($Signature)"
				}
			}
			
		}
		else
		{
			$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Signature'  = "0x$($Signature)"
			}
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		return $ItemIdListProperties
	} # End Get-Ext_00
	
	function Get-Ext_1F # GUID
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ClassType = [System.BitConverter]::ToString($ByteArray[1])
		$ItemIDSize = $ByteArray.count
		
		if ($ItemIDSize -le 18)
		{
			$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }	else { $ClassType }
			$CLSID0 = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))"
			$CLSID = Get-CLSID -CLSIDstring "$($CLSID0)"
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'	 = $ItemIDSize
				'ItemIDType'	 = $ItemIDType
				'SortOrderIndex' = $Class
				'CLSID'		     = $CLSID
			}
		}
		else
		{
			Switch ($ClassType)
			{
				'00'{
					if ([System.BitConverter]::ToString($ByteArray[2]) -eq '2F') # Driveletter
					{
						$Signature = [System.BitConverter]::ToString($ByteArray[4 .. 7]) -replace '-', ''
						$DriveLetter = [System.Text.Encoding]::UTF8.GetString($ByteArray[11 .. 13])
						$idx = 51  # 14 + 37
						$CLSID0 = if ($ByteArray.count -ge 48){ Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[33 .. 48]))" }	else { $null }
						$CLSID1 = if ($ByteArray.count -ge 66){ Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[$idx .. ($idx + 15)]))" } else { $null }
						$CLSID2 = if ($ByteArray.count -ge 83){ Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($idx + 16) .. ($idx + 31)]))" } else { $null }
						
						$ItemIdListProperties = [PSCustomObject]@{
							'ItemIDSize' = $ByteArray.Count
							'ItemIDType' = $ItemIDType
							'Class Type' = $ClassType
							'Signature'  = if ($Signature) { "0x$($Signature)" }else { $null }
							'DriveLetter'= $DriveLetter
							'FolderType' = if (!!$CLSID0) { Get-CLSID -CLSIDstring $CLSID0 }else{ $null }
							'GUID'	     = if (!!$CLSID1) { Get-FolderDescription -CLSIDstring $CLSID1 }else{ $null }
							'CLSID'	     = if (!!$CLSID2) { Get-CLSID -CLSIDstring $CLSID2 }else{ $null }
						}
					} # End of 0x2F
					elseif ([System.BitConverter]::ToString($ByteArray[24 .. 25]) -eq 'EF-BE')
					{
						$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
						else { $ClassType }
						$CLSID = if ($ItemIDSize -ge 18) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))" }
						else { $null }
						$ItemIdListProperties = [PSCustomObject]@{
							'ItemIDSize'	 = $ItemIDSize
							'ItemIDType'	 = $ItemIDType
							'SortOrderIndex' = $Class
							'CLSID'		     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
						}
						$1stextensionlength = [System.BitConverter]::ToUInt16($ByteArray[18 .. 19], 0)
						if ($1stextensionlength -ne 0 -and $1stextensionlength -le ($ItemIDSize - 18))
						{
							$idx = 18
							# Get the extension(s)
							$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
						} # End extentions
					} # End of 0x05
					elseif ([System.BitConverter]::ToString($ByteArray[20 .. 23]).Replace('-', '') -eq '31535053') # 1SPS
					{
						$ItemIdListProperties = [PSCustomObject]@{
							'ItemIDSize'	 = $ItemIDSize
							'ItemIDType'	 = $ItemIDType
							'SortOrderIndex' = $Class
						}
						
						if ($ItemIDSize -gt 23)
						{
							$ExtraData = $ByteArray[12 .. ($ItemIDSize - 1)]
							$PropertyStoreEntries = [System.Collections.ArrayList]::new()
							$Items = Get-Ext_SPS1 -ByteArray $ExtraData
							$TotalSPSize = -2
							foreach ($property in $items)
							{
								$PropertyStoreEntry = [PSCustomObject]::new()
								$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
								$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
								$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
								$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
								$TotalSPSize = $TotalSPSize + $property.'Storage Size'
							}
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
							
							if (($ExtraData.Count - $TotalSPSize) -ge 40)
							{
								$extData = $ExtraData[$TotalSPSize .. ($ExtraData.count - 1)]
								$CLSID = if ($ByteArray.count -ge 66) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($extData[0 .. 15]))" }
								else { $null }
								$CLSID0 = if ($ByteArray.count -ge 83) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($extData[16 .. 31]))" }
								else { $null }
								$gu = if (!!$CLSID0) { Get-CLSID -CLSIDstring $CLSID }
								else { $null }
								$cl = if (!!$CLSID) { Get-CLSID -CLSIDstring $CLSID0 }
								else { $null }
								$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value $gu
								$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'CLSID' -Value $cl
								
								$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $extData -idx 32
							}
						}
						
					} # end 1SPS
				} # End of 00
				{ $_ -in ('41', '42', '44', '46', '47', '48' ,'49', '50', '80') }{
					
					$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
					else { $ClassType }
					$CLSID = if ($ByteArray.Count -ge 18) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))" }
					else { $null }
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ByteArray.count
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
						'CLSID'		     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
					}
					$1stextensionlength = [System.BitConverter]::ToUInt16($ByteArray[18 .. 19], 0)
					if ($1stextensionlength -ne 0 -and $1stextensionlength -le ($ItemIDSize - 18))
					{
						$idx = 18
						# Get the extension(s)
						$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
					} # End extentions
				} # End of 44/48
				default {
					try
					{
						$CLSID = if ($ItemIDSize -ge 18) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))" }
						else { $null }
					}
					catch { $CLSID = $null }
					
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ItemIDSize
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
						'CLSID'		     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
					}
				}
			} # End Switch
		} # end else
		if (!!$ItemIdExtensions)
		{
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		return $ItemIdListProperties
	} # End Get-Ext_1F
	
	function Get-Ext_23_2E_2F # Dates
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$ClassType = [System.BitConverter]::ToString($ByteArray[1])
		
		if ($ItemIDType -eq '23') # Driveletter
		{
			try
			{
				$DriveLetter = [System.Text.Encoding]::UTF8.GetString($ByteArray[1 .. 4])
				$CLSID0 = if ($ItemIDSize -ge 20 -and ![System.Text.RegularExpressions.Regex]::IsMatch(($ByteArray[5 .. 19] -join ''), '[(0){16}]')) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[5 .. 19]))" }
				else { $null }
				$CLSID = if ($ItemIDSize -ge 39) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[23 .. 39]))" }
				else { $null }
				
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize'  = $ItemIDSize
					'ItemIDType'  = $ItemIDType
					'DriveLetter' = $DriveLetter
				}
				if ($null -ne $CLSID0)
				{
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value (Get-FolderDescription -CLSIDstring $CLSID0)
				}
				if ($null -ne $CLSID)
				{
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'CLSID' -Value (Get-FolderDescription -CLSIDstring $CLSID)
				}
			}
			catch { $null }
		}
		elseif ($ItemIDType -eq '2F') # Driveletter + $CLSID
		{
			try
			{
				$DriveLetter = [System.Text.Encoding]::UTF8.GetString($ByteArray[1 .. 4])
				$CLSID0 = if ($ItemIDSize -ge 20 -and ![System.Text.RegularExpressions.Regex]::IsMatch(($ByteArray[5 .. 19] -join ''), '[(0){16}]')) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[5 .. 19]))" }
				else { $null }
				$CLSID = if ($ItemIDSize -ge 39) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[23 .. 39]))" }
				else { $null }
				
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize'  = $ItemIDSize
					'ItemIDType'  = $ItemIDType
					'DriveLetter' = $DriveLetter
				}
				if ($null -ne $CLSID0)
				{
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value (Get-FolderDescription -CLSIDstring $CLSID0)
				}
				if ($null -ne $CLSID)
				{
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'CLSID' -Value (Get-FolderDescription -CLSIDstring $CLSID)
				}
			}
			catch { $null }
		}
		elseif ($ItemIDType -eq '2E') # CLSID etc
		{
			try
			{
				<#$Signature = [System.BitConverter]::ToString($ByteArray[4..7]) -replace '-', ''#>
				<#if ($Signature -eq '06203108') # Shell Ext Volume (Portable Volume) <============= Not Added Yet
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIDSize
						'ItemIDType' = $ItemIDType
					}
				}#>
				if ($ByteArray[1] -eq [Byte]128 -and $ItemIDSize -ge 18) # 0x80
				{
					$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
					else { $ClassType }
					$CLSID = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))"
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ItemIDSize
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
					}
					if ($null -ne $CLSID)
					{
						$CLSIDstring = Get-CLSID -CLSIDstring $CLSID
						$Description = if ($CLSIDstring -ne $CLSID) { $CLSIDstring }
						else { Get-CLSID -CLSIDstring $CLSID }
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value $Description
					}
					if ($ItemIDSize -ge 26)
					{
						# Get the extension(s)
						$idx = 18
						$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value $ItemIdExtensions
					}
				}
				elseif ($ByteArray[2] -eq [byte]12) # 0x0C
				{
					$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
					else { $ClassType }
					$CLSID0 = if ($ItemIDSize -ge 32) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[16 .. 31]))" }
					else { $null }
					$CLSID = if ($ItemIDSize -ge 48) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[32 .. 47]))" }
					else { $null }
					
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ItemIDSize
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
					}
					if ($null -ne $CLSID0)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value (Get-FolderDescription -CLSIDstring $CLSID0)
					}
					if ($null -ne $CLSID)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'CLSID' -Value (Get-CLSID -CLSIDstring $CLSID)
					}
				}
				elseif ([System.BitConverter]::ToString($ByteArray[20 .. 23]) -eq '31-53-50-53') # 1SPS
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ItemIDSize
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
						#	'CLSID'		     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
					}
					
					if ($ItemIDSize -gt 23)
					{
						
						$ExtraData = $ByteArray[12 .. ($ItemIDSize - 1)]
						$PropertyStoreEntries = [System.Collections.ArrayList]::new()
						$Items = Get-Ext_SPS1 -ByteArray $ExtraData
						foreach ($property in $items)
						{
							$PropertyStoreEntry = [PSCustomObject]::new()
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
							$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
						}
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
					}
					
				} # end 1SPS
				else
				{
					$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }
					else { $ClassType }
					$CLSID0 = if ($ItemIDSize -ge 18) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[2 .. 17]))" }
					else { $null }
					$guid = if ($CLSID0) { Get-CLSID -CLSIDstring $CLSID0 }
					else { $null }
					
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	 = $ItemIDSize
						'ItemIDType'	 = $ItemIDType
						'SortOrderIndex' = $Class
					}
					
					if (!!$guid -and $guid -ne $CLSID0) { $ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'GUID' -Value $guid }
					
					if ($ItemIDSize -ge 25)
					{
						# Get the extension(s)
						$idx = 18
						$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value $ItemIdExtensions
					} # end if
				}
			}
			catch
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIDSize
					'ItemIDType' = $ItemIDType
				}
			}
		}
		else
		{
			#	$Class = if ($SortOrderIndex[[String]$ClassType]) { "$($SortOrderIndex[[String]$ClassType]) [$($ClassType)]" }else { $ClassType }
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'	 = $ItemIDSize
				'ItemIDType'	 = $ItemIDType
				'SortOrderIndex' = $Class
			}
		}
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		return $ItemIdListProperties
		
	} # End Get-Ext_2
	
	function Get-Ext_B1
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		
		$w32Modified = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[9 .. 6]) -replace '-', '')
		if (!!$w32Modified) { $w32Modified = $w32Modified.ToString("dd-MMM-yyyy HH:mm:ss") }
		$Attributes = Get-Attributes -Bytes $ByteArray[10..11]
		$idx = $ByteArray[12 .. (12 + $ItemIDSize - 1)].IndexOf([byte]'0')
		$Ansi_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[12 .. ($idx + 12 - 1)])
		
		$idx = 12 + $Ansi_Name.Length + 1
		if ($ByteArray[$idx] -eq [byte]00) { $idx = $idx + 1 }
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDType" -Value $ItemIDType
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDSize" -Value $ItemIDSize
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "w32Modified" -Value $w32Modified
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_Name" -Value $Ansi_Name
		
		# Get the extension(s) if they exist
		if ([System.BitConverter]::ToString($ByteArray[($idx + 6) .. ($idx + 7)]) -eq "EF-BE")
		{
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray).Replace('-', ''))"
		}
		else
		{
			# Get the 8.3 Dos Name
			if (($idx + 2) -lt $ItemIDSize)
			{
				$Ansi_8_3_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[(12 + $Ansi_Name.Length + 1) .. ($ItemIDSize - 1)])
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_8_3_Name" -Value $Ansi_8_3_Name
			}
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray).Replace('-', ''))"
		}
		
		return $ItemIdListProperties
	} # End Get-Ext_B1 
	
	function Get-Ext_C3 # 3 split
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$Description = $null
		$DescriptionUnicode = $null
		
		$Flags = [System.BitConverter]::ToString($ByteArray[2])
		$TargetString = [System.Text.Encoding]::UTF8.GetString($ByteArray[3 .. ($ItemIDSize - 3)])
		$TargetString2 = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[0 .. ($ItemIDSize - 3)])
		$Extents = [System.Text.RegularExpressions.Regex]::Match($TargetString2, '(\x00\xEF\xBE)')
		$String = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')
		$Path = $String[0]
		$Name = $String[1]
		$start = 3 + $TargetString.IndexOf($String[1]) + $String[1].Length + 1
		
		if ($String.count -ge 3 -and $String[2].length -ge 1) # path, name & description in ANSI
		{
			$Description = $String[2]
			$start = 3 + $TargetString.IndexOf($String[2]) + $String[2].Length + 1
		}
		
		if ($Flags -in ('D5', 'C1', 'D1')) # path, name & description in Unicode
		{
			# Get Unicode parts
			if ($String.count -ge 4 -and ($ItemIDSize - $start) -gt 6)
			{
				if ($ByteArray[$start] -eq [byte]00) { $start = $start + 1 }
				$TargetString = [System.Text.Encoding]::Unicode.GetString($ByteArray[$start .. ($ItemIDSize - 3)])
				$String = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')
				
				if ($String.Count -ge 2)
				{
					$PathUnicode = $String[0]
					$NameUnicode = $String[1]
					
					if ($String.count -ge 3 -and $String[2].length -ge 1)
					{
						$DescriptionUnicode = $String[2]
					}
				}
			}
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'		 = $ItemIDSize
				'ItemIDType'		 = $ItemIDType
				'Flags'			     = $Flags
				'Path'			     = $Path
				'Name'			     = $Name
				'Description'	     = $Description
				'PathUnicode'	     = $PathUnicode
				'NameUnicode'	     = $NameUnicode
				'DescriptionUnicode' = $DescriptionUnicode
			}
		}
		else # only path & name
		#	 elseif ($Flags -in 'D1', '81')
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'  = $ItemIDSize
				'ItemIDType'  = $ItemIDType
				'Flags'	      = $Flags
				'Path'	      = $Path
				'Name'	      = $Name
				'Description' = $Description
			}
		}
		
		if ($Extents.count -ge 1)
		{
			# Get the extension(s)
			$idx = $Extents.index[0] - 5
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
			if (!!$ItemIdExtensions)
			{
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
			}
		}
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		$ItemIdListProperties
		
	} # End Get-Ext_C3
	
	function Get-Ext_46 # 2 split
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		
		try
		{
			$Flags = "0x$([System.BitConverter]::ToString($ByteArray[2]))"
			$TargetString = [System.Text.Encoding]::UTF8.GetString($ByteArray[3 .. ($ItemIDSize - 3)])
			$String = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')
			
			$Name = $String[0]
			$Description = $String[1]
			
			if ($String.count -ge 4 -and $String[2].length -ge 1)
			{
				$start = 3 + $TargetString.IndexOf($String[1]) + $String[1].Length + 1
				
				if (($ItemIDSize - $start) -gt 6)
				{
					$TargetString = [System.Text.Encoding]::Unicode.GetString($ByteArray[$start .. ($ItemIDSize - 3)])
					$String = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')
					if ($String.Count -ge 2)
					{
						$NameUnicode = $String[0]
						$DescriptionUnicode = $String[1]
					}
				}
			}
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'		 = $ItemIDSize
				'ItemIDType'		 = $ItemIDType
				'Flags'			     = $Flags
				'Name'			     = $Name
				'Description'	     = $Description
				'NameUnicode'	     = $NameUnicode
				'DescriptionUnicode' = $DescriptionUnicode
			}
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		}
		catch
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Data'	     = [System.BitConverter]::ToString($ByteArray) -replace '-', ''
			}
		}
		
		return $ItemIdListProperties
		
	} # End Get-Ext_46
	
	function Get-Ext_47 # 1 split
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		
		try
		{
			$Flags = "0x$([System.BitConverter]::ToString($ByteArray[2]))"
			$TargetString = [System.Text.Encoding]::UTF8.GetString($ByteArray[3 .. ($ItemIDSize - 3)])
			$String = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')
			
			$Name = $String[0]
			if ($String.count -ge 2 -and $String[1].length -ge 1)
			{
				$start = 3 + $TargetString.IndexOf($String[0]) + $String[0].Length + 1
				
				if (($ItemIDSize - $start) -gt 6)
				{
					$NameUnicode = [System.Text.Encoding]::Unicode.GetString($ByteArray[$start .. ($ItemIDSize - 3)])
				}
			}
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize'  = $ItemIDSize
				'ItemIDType'  = $ItemIDType
				'Flags'	      = $Flags
				'Path'	      = $Path
				'Name'	      = $Name
				'NameUnicode' = $NameUnicode
			}
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		}
		catch
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIDSize
				'ItemIDType' = $ItemIDType
				'Data'	     = [System.BitConverter]::ToString($ByteArray) -replace '-', ''
			}
		}
		
		return $ItemIdListProperties
		
	} # End Get-Ext_47
	
	function Get-Ext_3A # FFile
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$RawFilesize = $null
		if ($ItemIDType -in ('3A')) # File
		{
			$Filesize = [System.BitConverter]::ToUInt32($ByteArray[2 .. 5], 0).ToString('N0')
			$RawFilesize = $ByteArray[2 .. 5]
		}
		$w32Modified = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[9 .. 6]).Replace('-', ''))
		if (!!$w32Modified) { $w32Modified = $w32Modified.ToString("dd-MMM-yyyy HH:mm:ss") }
		$Attributes = Get-Attributes -Bytes $ByteArray[10..11]
		$TargetString = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[12 .. ($ByteArray.Count - 1)])
		$eidx = 12 + [System.Text.RegularExpressions.Regex]::Match($TargetString, "(\x00\xEF\xBE)").index - 5
		$idx = 12 + $ByteArray[12 .. (12 + $ByteArray.Count - 1)].IndexOf([byte]'0')
		if ($eidx -gt 12 -and $idx -gt $eidx) { $idx = $eidx }
		$Ansi_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[12 .. ($idx - 1)])
		$padding = if (($Ansi_Name.Length % 2) -eq 0) { 2 }
		else { 1 }
		
		if ($ByteArray[($idx + 1) .. ($idx + 1 + 8)][0] -ne [byte]0)
		{
			$padding = 0
			$idx = 12 + $Ansi_Name.Length + 1
		}
		else { $idx = 12 + $Ansi_Name.Length + $padding + 2 }
		if ($padding -eq 0) { $idx = $idx }
		else { $idx = $idx - 2 }
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDType" -Value $ItemIDType
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDSize" -Value $ItemIDSize
		if ($null -ne $Filesize)
		{
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Filesize" -Value $Filesize
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "RawFilesize" -Value $RawFilesize
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "w32Modified" -Value $w32Modified
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_Name" -Value $Ansi_Name
		
		# Get the extension(s) if they exist
		if (!!$eidx)
		{
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $eidx
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		}
		else
		{
			# Get the 8.3 Dos Name
			if (($idx + 2) -lt $ItemIDSize)
			{
				$Ansi_8_3_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[(12 + $Ansi_Name.Length + 1) .. ($ItemIDSize - 1)])
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_8_3_Name" -Value $Ansi_8_3_Name
			}
		}
		return $ItemIdListProperties
	} # End Get-Ext_3A
	
	function Get-Ext_31_32 # Folder / File
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$RawFilesize = $null
		if ($ItemIDType -in ('32','3A')) # File
		{
			$Filesize = [System.BitConverter]::ToUInt32($ByteArray[2 .. 5], 0).ToString('N0')
			$RawFilesize = $ByteArray[2 .. 5]
		}
		$w32Modified = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[9 .. 6]).Replace('-', ''))
		if (!!$w32Modified) { $w32Modified = $w32Modified.ToString("dd-MMM-yyyy HH:mm:ss") }
		$Attributes = Get-Attributes -Bytes $ByteArray[10..11]
		$TargetString = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[12 .. ($ByteArray.Count - 1)])
		$eidx = 12 + [System.Text.RegularExpressions.Regex]::Match($TargetString, "(\x00\xEF\xBE)").index - 5
		if (!$eidx -or $eidx -in (0,7)) # No extension (pre WinXP)
		{
			$Ansi_Name = [System.Text.RegularExpressions.Regex]::Split($TargetString, "(\x00)")[0]
			$Ansi_8_3_Name = [System.Text.RegularExpressions.Regex]::Split($TargetString, "(\x00)")[2]
		}
		else
		{
			$idx = 12 + $ByteArray[12 .. (12 + $ByteArray.Count - 1)].IndexOf([byte]'0')
			if ($eidx -gt 12 -and $idx -gt $eidx) { $idx = $eidx }
			$Ansi_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[12 .. ($idx - 1)])
			$padding = if (($Ansi_Name.Length % 2) -eq 0) { 2 }
			else { 1 }
			
			if ($ByteArray[($idx + 1) .. ($idx + 1 + 8)][0] -ne [byte]0)
			{
				$padding = 0
				$idx = 12 + $Ansi_Name.Length + 1
			}
			else { $idx = 12 + $Ansi_Name.Length + $padding + 2 }
			if ($padding -eq 0) { $idx = $idx }
			else { $idx = $idx - 2 }
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDType" -Value $ItemIDType
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDSize" -Value $ItemIDSize
		if ($null -ne $Filesize)
		{
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Filesize" -Value $Filesize
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "RawFilesize" -Value $RawFilesize
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "w32Modified" -Value $w32Modified
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_Name" -Value $Ansi_Name
		if (!!$Ansi_8_3_Name -and $Ansi_8_3_Name.Length -in (2..11))
		{
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_8_3_Name" -Value $Ansi_8_3_Name
		}	
		
		# Get the extension(s) if they exist
		if (!!$eidx)
		{
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $eidx
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		}
		else
		{
			# Get the 8.3 Dos Name
			if (($idx + 2) -lt $ItemIDSize)
			{
				$Ansi_8_3_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[(12 + $Ansi_Name.Length + 1) .. ($ItemIDSize - 1)])
				$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_8_3_Name" -Value $Ansi_8_3_Name
			}
		}
		return $ItemIdListProperties
	} # End Get-Ext_31_32
	
	function Get-Ext_35_36 # Folder / File with Unicode ANSI name
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$RawFilesize = $null
		if ($ItemIDType -eq '36') # File
		{
			$Filesize = [System.BitConverter]::ToUInt32($ByteArray[2 .. 5], 0).ToString('N0')
			$RawFilesize = $ByteArray[2 .. 5]
		}
		$w32Modified = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[9 .. 6]) -replace '-', '')
		if (!!$w32Modified) { $w32Modified = $w32Modified.ToString("dd-MMM-yyyy HH:mm:ss") }
		$Attributes = Get-Attributes -Bytes $ByteArray[10..11]
		$TargetString = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[12 .. ($ByteArray.Count - 1)])
		
		$idx = [System.Text.RegularExpressions.Regex]::Match($TargetString, "(\x00\xEF\xBE)").index
		$Check = [System.Text.Encoding]::Unicode.GetString($ByteArray[12 .. (12 + $idx - 6)])
		$Z = [System.Text.RegularExpressions.Regex]::Split($Check, '\x00').count
		if ($z -gt 1) { $Ansi_Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[12 .. (12 + $idx - 6)]) }
		else { $Ansi_Name = [System.Text.Encoding]::UTF8.GetString($ByteArray[12 .. (12 + $idx - 6)]) }
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDType" -Value $ItemIDType
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIDSize" -Value $ItemIDSize
		if ($null -ne $Filesize)
		{
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Filesize" -Value $Filesize
		}
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "w32Modified" -Value $w32Modified
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_Name" -Value $Ansi_Name
		
		$idx = 12 + $idx - 5
		
		# Get the extension(s)
		$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		return $ItemIdListProperties
	} # End Get-Ext_35_36
	
	function Get-Ext_61
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$Flags = [System.BitConverter]::ToString($ByteArray[1]) -replace '-', ''
		if ($Flags -eq '80') # Unicode string
		{
			$TargetString = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[6 .. ($ByteArray.Count - 1)])
			$end = 6 + [System.Text.RegularExpressions.Regex]::Match($TargetString, "(\x00\x00\x00\x00)").index
			if ($end % 2 -eq 1)
			{
				$idx = $end + 5
			}
			else
			{
				$idx = $end + 4
				$end = $end + 1
			}
			$uri = [System.Text.Encoding]::Unicode.GetString($ByteArray[6 .. $end])
			#	$idx = $end + 5
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ByteArray.Count
				'ItemIDType' = $ItemIDType
				'URI'	     = if ($uri) { $uri }else { $null }
			}
			
			# Get the extension(s)
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		}
		elseif ($Flags -eq '03') #FTP
		{
			try { $Timestamp = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[12 .. 19], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
			catch { $Timestamp = $null }
			$Port = [System.BitConverter]::ToUInt16($ByteArray[36 .. 37], 0)
			$end = $ByteArray[44 .. ($ByteArray.Count - 1)].IndexOf([byte]'0')
			$urilength = [System.BitConverter]::ToUInt16($ByteArray[40 .. 41], 0)
			$Uri = [System.Text.Encoding]::UTF8.GetString($ByteArray[44 .. (44 + $end - 1)])
			$idx = 44 + $end + 1
			try
			{
				$userlength = [System.BitConverter]::ToUInt32($ByteArray[$idx .. ($idx + 3)], 0)
				$username = ([System.Text.Encoding]::GetEncoding(1252).GetString($ByteArray[($idx + 4) .. ($idx + 4 + $userlength - 1)]) -Split '\0')[0]
				# [System.Text.Encoding]::UTF8.GetString($ByteArray[($idx + 4) .. ($idx + 4 + $userlength - 1)])
				try
				{
					$idx = $idx + 4 + $userlength
					$passSize = [System.BitConverter]::ToUInt32($ByteArray[$idx .. ($idx + 3)], 0)
					$Password = ([System.Text.Encoding]::GetEncoding(1252).GetString($ByteArray[($idx + 4) .. ($idx + 4 + $passSize - 1)]) -Split '\0')[0]
					# [System.Text.Encoding]::UTF8.GetString($ByteArray[($idx + 4) .. ($idx + 4 + $passSize - 1)])
				}
				catch { $passSize = $Password = $null }
			}
			catch { $userlength = $username = $null }
			
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ByteArray.Count
				'ItemIDType' = $ItemIDType
				'TimeStamp'  = $Timestamp
				'Port'	     = $Port
				'UriSize'    = $urilength
				'URI'	     = $Uri
				'UserSize'   = $userlength
				'Username'   = $username
				'PassSize'   = $passSize
				'Password'   = $Password
			}
		}
		else
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ByteArray.Count
				'ItemIDType' = $ItemIDType
				'Data'	     = [System.BitConverter]::ToString($ByteArray) -replace '-', ''
			}
		}
		
		return $ItemIdListProperties
	} # End Get-Ext_61
	
	function Get-Ext_71 #Property Store
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIdListProperties = [PSCustomObject]::new()
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		
		$CLSID = if ($ItemIDSize -ge 28) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[12 .. 27]))" }
		else { $null }
		$ItemIdListProperties = [PSCustomObject]@{
			'ItemIDSize' = $ItemIdListItem.ItemIDSize
			'ItemIDType' = $ItemIDType
			'CLSID'	     = if ($CLSID) { Get-CLSID -CLSIDstring $CLSID }else { $null }
		}
		
		if ($ItemIDSize -ge 36)
		{
			$idx = 28
			# Get the extension(s)
			$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $ByteArray -idx $idx
			
			$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
		}
		
		$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($ByteArray) -replace '-', '')"
		
		
		return $ItemIdListProperties
	} # End Get-Ext_71
	
	$TypedPropertiesWithUnicodeValues = @(
		'AutolistCacheKey'
		'item_url'
		'title'
		'category'
		'substrate_id'
		'source_id'
		'resource_id'
		'user_id'
		'web_account_id'
		'location'
		'path'
		'display_path'
		'local_path'
		'kind'
		'type'
		'file_size'
		'is_pinned_synced'
		'sync_attempt_count'
		'creation_timestamp'
		'last_accessed_timestamp'
		'extension'
		'modification_timestamp'
		'activity'
		'activity_json'
		'app'
		'SyncRootIds'
		'Revision'
		'sharepoint_list_item_id'
		'sharepoint_list_item_unique_id'
		'sharepoint_site_id'
		'sharepoint_web_id'
		'sharepoint_site_url'
		'sharepoint_list_id'
		'onedrive_cid'
		'onedrive_drive_type'
		'onedrive_item_id'
		'onedrive_drive_id'
	)
	
	$notunicode = @('ColInfo', 'GroupView', 'GroupByKey:PID')
	
	function Get-Ext_SPS1 # Serialized Property Store
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		# Property types:
		# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-oleps/2a4589eb-9a23-4a8b-adbd-3e368233c099
		# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-propstore/3453fb82-0e4f-4c2c-bc04-64b4bd2c51ec
		try
		{
			$pc = [PropertyStore.SerializedPropertyStore]::FromByteArray($ByteArray)
			$ItemIdExtensions = [System.Collections.ArrayList]::new()
			
			# https://learn.microsoft.com/en-us/windows/win32/stg/predefined-property-set-format-identifiers
			$FormatIdentifiers = [System.Collections.Hashtable]@{
				#	'F29F85E0-4FF9-1068-AB91-08002B27B3D9' = 'SummaryInformation'
				#	'D5CDD502-2E9C-101B-9397-08002B2CF9AE' = 'DocSummaryInformation'
				#	'D5CDD505-2E9C-101B-9397-08002B2CF9AE' = 'UserDefinedProperties'
				'C73F6F30-97A0-4AD1-A08F-540D4E9BC7B9' = "AutoListPropertyStore"
			}
			
			if ($pc.PropertyStorage.Count -ge 1)
			{
				for ($t = 0; $t -lt $pc.PropertyStorage.Count; $t++)
				{
					$SPropertyStore = [System.Collections.ArrayList]::new()
					$formatID = $pc.PropertyStorage[$t].FormatID.Guid.ToUpper()
					
					if ($pc.PropertyStorage[$t].PropertyStorage.Count -ge 1)
					{
						for ($p = 0; $p -lt $pc.PropertyStorage[$t].PropertyStorage.Count; $p++)
						{
							$typed = $pc.PropertyStorage[$t].PropertyStorage[$p].TypedPropertyValue
							$tpbytes = $null
							$tpraw = $null
							$ttype = [System.String]$typed.Type
							$tname = [System.String]$pc.PropertyStorage[$t].PropertyStorage[$p].Name
							$tPid = $pc.PropertyStorage[$t].PropertyStorage[$p].ID
							
							if (([System.String]$typed.Type).Contains('VT_BSTR') -and $null -ne $typed.Value)
							{
								try
								{
									$size = [Bitconverter]::ToUInt32($typed.Value[0 .. 3], 0)
									if (($size + 4) -le $typed.Value.length)
									{
										$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[4 .. (4 + $size - 1)])
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
									else
									{
										$tpvalue = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
										
									}
								}
								catch
								{
									$tpvalue = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
								}
							}
							elseif ($typed.Value -is [System.String])
							{
								$tpvalue = $typed.Value
							}
							elseif ($typed.Value -is [System.DateTime])
							{
								try
								{
									$utc = $typed.Value.ToFileTimeUtc()
									$tpvalue = [datetime]::FromFileTimeUtc($utc).ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
								}
								catch
								{
									$tpvalue = $typed.Value
								}
							}
							elseif ($typed.Value -is [System.Guid] -and $null -ne $typed.Value)
							{
								try
								{
									$tpvalue = $typed.Value.Guid.ToUpper()
								}
								catch
								{
									$tpvalue = $typed.Value
								}
							}
							elseif ($ttype.Contains('VT_I2, VT_VERSIONED_STREAM') -or $ttype.Contains('VT_CY, VT_CLSID') -or ($ttype -eq 'VT_CF' -and $tname -notin $notunicode) -and $null -ne $typed.Value) #FMTID/uint32/Unicode
							{
								try
								{
									$size = [System.Bitconverter]::ToUInt32($typed.Value[4 .. 7], 0)
									if ($size -ge 1 -and (8 + $size) -le $typed.Value.Count)
									{
										$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. (8 + $size - 3)])
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										
										if ($tname.Contains('FMTID') -and $pc.PropertyStorage[$t].PropertyStorage[$p - 2].Name -eq 'Key:PID')
										{
											$fID = $tpvalue.ToUpper().TrimStart('{').Trim('}').TrimEnd(' ')
											$kpid = [System.BitConverter]::ToUInt32($pc.PropertyStorage[$t].PropertyStorage[$p - 2].TypedPropertyValue.Value[4 .. 7], 0)
											$fmid = $formatIDHashTable["$($fID)\$($kpid)"]
											if (!!$fmid)
											{
												$tpvalue = "$($fmid) [$($fID)\$($kpid)])"
											}
											else
											{
												$tpvalue = $fID
											}
										}
									}
									elseif ($size -ge 0)
									{
										$tpvalue = $size.ToString('N0')
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
								}
								catch
								{
									$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
								}
							}
							elseif ($ttype.Contains('VT_BOOL'))
							{
								$tpvalue = ([System.Boolean]$typed.Value).ToString()
							}
							elseif ($tPid -eq 25 -and $formatID -eq '28636AA6-953D-11D2-B5D6-00C04FD918D0') # SFGAO flags
							{
								$tpvalue = $typed.Value
							}
							elseif ($typed.Value -is [System.Byte[]])
							{
								$tpvalue = $null
								# $tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
								# Get Delegate ID List [28636AA6-953D-11D2-B5D6-00C04FD918D0\32] bytes
								if ($tPid -eq 32 -and $formatID -eq '28636AA6-953D-11D2-B5D6-00C04FD918D0')
								{
									$tpbytes = $typed.Value
								}
								elseif ($tPid -eq 2 -and $formatID -eq '1E3EE840-BC2B-476C-8237-2ACD1A839B22') # System FilterInfo
								{
									$tpbytes = $typed.Value
									$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
								}
								elseif ($tname -in ('AutolistCacheTime') -and $typed.Value.count -ge 8)
								{
									try
									{
										# https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/time-time32-time64?view=msvc-170
										$tpb = $typed.Value[4 .. 7]
										$tm = [System.BitConverter]::ToUInt32($tpb, 0)
										$newt = (New-Object DateTime(1970, 1, 1, 0, 0, 0)).AddSeconds($tm)
										if ($newt -is [System.DateTime] -and $newt.Year -le [System.DateTime]::Today.Year)
										{
											$tpvalue = $newt.ToString("dd/MM/yyyy HH:mm:ss")
										}
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
									catch
									{
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
								}
								elseif ($tname -in ('ViewItemsFolder', 'PubItemFolder.ShellItem', 'AutoList', 'Condition', 'Sort', 'ColInfo', 'GroupView', 'GroupByKey:PID'))
								{
									$tpbytes = $typed.Value
									$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
								}
								elseif ($ttype.Contains('VT_VECTOR'))
								{
									if ($typed.Value.count -ge 8)
									{
										try
										{
											$size = [System.Bitconverter]::ToUInt32($typed.Value[4 .. 7], 0)
											if ($size -ge 1 -and ($size * 2 + 8) -le $typed.Value.Count)
											{
												$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. (8 + $size * 2 - 1)])
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											elseif (!!$size)
											{
												$tpvalue = $size.ToString('N0')
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											else
											{
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
										}
										catch
										{
											$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										}
									}
									else
									{
										$tpvalue = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
								}
								elseif ($ttype.Contains('VT_VERSIONED_STREAM') -or $ttype.Contains('VT_CLSID') -or !$ttype.ToString().startswith('VT') -or $tname.StartsWith('Accounts')) # Unicode string
								{
									if ($typed.Value.count -ge 8)
									{
										try
										{
											$size = [System.Bitconverter]::ToUInt32($typed.Value[4 .. 7], 0)
											if ($size -ge 1 -and ($size * 2 + 8) -le $typed.Value.Count)
											{
												$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. (8 + ($size - 1) * 2 - 1)])
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											elseif (!!$size)
											{
												$tpvalue = $size.ToString('N0')
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											else
											{
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
										}
										catch
										{
											$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										}
									}
									else
									{
										$tpvalue = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
								}
								elseif ($tname -in $TypedPropertiesWithUnicodeValues) # Unicode string
								{
									if ($typed.Value.count -ge 8)
									{
										try
										{
											$size = [System.Bitconverter]::ToUInt32($typed.Value[4 .. 7], 0)
											if ($size -gt 1 -and ($size * 2 + 4) -le $typed.Value.Count)
											{
												#$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. (8 + ($size -1) * 2 - 1)])
												$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. (4 + $size * 2 - 1)])
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											elseif (!!$size)
											{
												$tpvalue = $size.ToString('N0')
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
											else
											{
												$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
											}
										}
										catch
										{
											$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										}
									}
									else
									{
										$tpvalue = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
										$tpraw = [System.BitConverter]::ToString($typed.Value).Replace('-', '')
									}
								}
								elseif ($tname.EndsWith('WriteWebLaunchUrl')) # Unicode string
								{
									if ($typed.Value.count -gt 8)
									{
										try
										{
											$tpvalue = [System.Text.Encoding]::Unicode.GetString($typed.Value[8 .. ($typed.Value.count - 1)])
											$tpraw = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
										}
										catch
										{
											$tpvalue = $null
											$tpraw = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
										}
									}
									else
									{
										$tpvalue = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
										$tpraw = $null
									}
								}
								elseif ($tname -eq 'FFlags')
								{
									try
									{
										$tpb = $typed.Value[4 .. 5]
										$tpvalue = Get-Attributes -Bytes $tpb
									}
									catch { $tpvalue = $null }
								}
								else
								{
									$tpraw = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
								}
							}
							elseif ($typed.Value.GetType().FullName.Contains('System.UInt') -or $typed.Value.GetType().FullName.Contains('System.Int'))
							{
								$tpvalue = $typed.Value.ToString('N0')
							}
							else
							{
								$tpvalue = $typed.Value
								$tpraw = [System.BitConverter]::ToString($typed.Value) -replace '-', ''
							}
							
							# Get any other Format Identifier Descriptions
							$Description = if (!!$tPid)
							{
								$fmid = "$($formatID)\$($tPid)"
								if (!!$formatIDHashTable[$fmid]) { "$($formatIDHashTable[$fmid]) [$($fmid)]" }
								else { $null }
							}
							else { $null }
							
							$TProperty = [PSCustomObject]@{
								'Type' = "$($ttype) [0x$($typed.Type.value__.ToString('X4'))]"
								'Value' = $tpvalue
								'TBytes' = $tpbytes
								'Raw'  = $tpraw
							}
							
							# Get the SFGAO flags
							$sfgoflags = if ($Description -eq 'SFGAOFlags [28636AA6-953D-11D2-B5D6-00C04FD918D0\25]')
							{ Get-SFGAOflags -Flags ($tpvalue/1) -Single $true }
							else { $null }
							
							$DelegateIDlist = if ($Description -eq 'Delegate ID List [28636AA6-953D-11D2-B5D6-00C04FD918D0\32]' -or $tname -in ('ViewItemsFolder', 'PubItemFolder.ShellItem', 'AutoList'))
							{
								if (!(Get-DelegateIDlist -ByteArray $tpbytes))
								{
									Get-DelegateIDlist -ByteArray ([bitconverter]::GetBytes([uint32]$tpbytes.count) + $tpbytes[4 .. ($tpbytes.count - 1)])
								}
							}
							else { $null }
							
							$PropertyStoreValues = [PSCustomObject]@{
								'ValueSize'	     = $pc.PropertyStorage[$t].PropertyStorage[$p].ValueSize
								'NameSize'	     = $pc.PropertyStorage[$t].PropertyStorage[$p].NameSize
								'Name'		     = $tname
								'ID'			 = $tPid
								'Description'    = $Description
								'TypedProp'	     = $TProperty
								'DelegateIDlist' = $DelegateIDlist
								'SFGOflags'	     = $sfgoflags
							}
							
							
							
							$null = $SPropertyStore.Add($PropertyStoreValues)
						} # End for PropertyStorage.Count
						
					} # end if PropertyStorage.Count
					
					$ItemIdExtension = [PSCustomObject]@{
						'Storage Size'  = $pc.PropertyStorage[$t].StorageSize
						'FormatID'	    = $formatID
						'PropertyStore' = $SPropertyStore
					}
					$null = $ItemIdExtensions.Add($ItemIdExtension)
				} # end for
			} #end if PC >= 1
		}
		catch { $ItemIdExtensions = [System.Collections.ArrayList]::new() }
		
		return $ItemIdExtensions
		
	} # Get-Ext_SPS1
	
	function Get-Compressed_w32 # Compressed
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[System.Byte[]]$ByteArray
		)
		
		$ItemIDType = [System.BitConverter]::ToString($ByteArray[0])
		$ItemIDSize = $ByteArray.Count
		$type = [System.BitConverter]::ToUInt16($ByteArray[18 .. 19], 0)
		$Attributes = Get-Attributes -Bytes $ByteArray[18..21]
		$Timestamp = [System.Text.Encoding]::Unicode.GetString($ByteArray[22 .. 53])
		$ZipIndex = [System.BitConverter]::ToUInt16($ByteArray[54 .. 55], 0)
		$ParentLength = [System.BitConverter]::ToUInt16($ByteArray[56 .. 57], 0)
		$NameLength = [System.BitConverter]::ToUInt16($ByteArray[58 .. 59], 0)
		$Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[66 .. (66 + $NameLength * 2 - 1)])
		$pidx = 66 + $NameLength * 2 + 2
		$Parent = if ($ParentLength -gt 0)
		{
			[System.Text.Encoding]::Unicode.GetString($ByteArray[$pidx .. ($pidx + $ParentLength * 2 - 1)])
		}
		else { $null }
		
		$ItemIdListProperties = [PSCustomObject]@{
			'ItemIDSize'   = $ItemIDSize
			'ItemIDType'   = $ItemIDType
			'Type'		   = $type
			'Attributes'   = $Attributes
			'Timestamp'    = $Timestamp
			'ZipIndex'	   = $ZipIndex
			'ParentLength' = $ParentLength
			'NameLength'   = $NameLength
			'Name'		   = $Name
			'Parent'	   = $Parent
			'Data'		   = [System.BitConverter]::ToString($ByteArray) -replace '-', ''
		}
		Return $ItemIdListProperties
		
	} # End Get-Compressed_w32
	
	Function Get-ItemIdExtensions
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Byte[]]$ByteArray,
			[Parameter(Mandatory = $true)]
			$idx
		)
		
		# Get the extension(s)
		$ItemIdExtensions = [System.Collections.ArrayList]::new()
		
		While ($ByteArray.Count -gt $idx)
		{
			if ($idx -ge $ByteArray.Count) { break }
			$extStart = $idx
			$extLength = [System.BitConverter]::ToUInt16($ByteArray[($extStart) .. ($extStart + 1)], 0)
			$extversion = [System.BitConverter]::ToUInt16($ByteArray[($extStart + 2) .. ($extStart + 3)], 0)
			$itemIdExtType = [System.BitConverter]::ToString($ByteArray[($extStart + 7) .. ($extStart + 4)]) -replace '-', ''
			
			$ItemIdExtension = [PSCustomObject]::new()
			$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extLength" -Value $extLength
			$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extversion" -Value $extversion
			$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "itemIdExtType" -Value $itemIdExtType
			
			    if ($itemIdExtType -eq 'BEEF0001')
			{
				try
				{
					$Selection = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 10) .. ($extStart + $extLength - 5)])
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Selection" -Value $Selection
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$null
				}
			} # End BEEF0001
			elseif ($itemIdExtType -eq 'BEEF0003')
			{
				try
				{
					$CLSID0 = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8) .. ($extStart + 23)]))"
					$GUID = if ($CLSID0 -eq '0C39A5CF-1A7A-40C8-BA74-8900E6DF5FCD')
							{
								'NoPreviousVersions [0C39A5CF-1A7A-40C8-BA74-8900E6DF5FCD]'
							}
						elseif (!!$CLSID0)
							{
								Get-CLSID -CLSIDstring $CLSID0
							}
						else { $null }
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "GUID" -Value $GUID
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0003
			elseif ($itemIdExtType -eq 'BEEF0004') #File/Folder
			{
				try
				{
					$idx = $extStart + 8
					$w32Created = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[($idx + 3) .. ($idx)]) -replace '-', '')
					if (!!$w32Created) { $w32Created = $w32Created.ToString("dd-MMM-yyyy HH:mm:ss") }
					$w32AccessedDate = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($ByteArray[($idx + 7) .. ($idx + 4)]) -replace '-', '')
					if (!!$w32AccessedDate) { $w32Accessed = $w32AccessedDate.ToString("dd-MMM-yyyy HH:mm:ss") }
					$os = [System.BitConverter]::ToUInt16($ByteArray[($idx + 8) .. ($idx + 9)], 0) # +8 = Offset to Name ($extStart -8)
					$OSHost = if ($Host_OS[[String]$os]) { $Host_OS[[String]$os] }
					else { "Unknown OS [$($os)]" }
					$unknown = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 10) .. ($idx + 11)]) -replace '-', '')"
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "os" -Value $os
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "w32Created" -Value $w32Created
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "w32Accessed" -Value $w32Accessed
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Host" -Value $OSHost
					# $off = $os -8
					if ($extversion -ge 9)
					{
						$MFTrecordNr = [System.BitConverter]::ToUInt64(($ByteArray[($idx + 12) .. ($idx + 17)] + $ByteArray[($idx + 10) .. $($idx + 11)]), 0)
						$MFTrecordSeqNr = [System.BitConverter]::ToUInt16($ByteArray[($idx + 18) .. ($idx + 19)], 0)
						$unknown_1 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 20) .. ($idx + 23)]) -replace '-', '')" # 4 bytes => higher bytes of filesize
						$fsraw = $ByteArray[($idx + 20) .. ($idx + 23)]
						$Reparse_Tag = "$([System.BitConverter]::ToString($ByteArray[($idx + 27) .. ($idx + 24)]) -replace '-', '')" # 4 bytes
						$unknown_2 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 28) .. ($idx + 33)]) -replace '-', '')" # 6 bytes
						$unknown_3 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 34) .. ($idx + 37)]) -replace '-', '')" # 4 bytes
						#	$idx = $idx + 20 + 14 # skip null bytes
						#   $unknownyet = "0x$([System.BitConverter]::ToString($ByteArray[($idx) .. ($idx + 3)]) -replace '-', '')"
						$TargetString = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extstart + 46) .. ($extstart + $extlength - 3)])
						$Unicode_Name = ($TargetString -split '\0')[0]
						if (($TargetString -split '\0')[1].length -gt 1)
						{
							$Localized_Name = ($TargetString -split '\0')[1]
						}
					}
					elseif ($extversion -eq 7)
					{
						$MFTrecordNr = [System.BitConverter]::ToUInt64(($ByteArray[($idx + 12) .. ($idx + 17)] + $ByteArray[($idx + 10) .. $($idx + 11)]), 0)
						$MFTrecordSeqNr = [System.BitConverter]::ToUInt16($ByteArray[($idx + 18) .. ($idx + 19)], 0)
						$idx = $idx + 20 + 10 # skip null bytes
						$TargetString = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($extstart + $extlength - 3)])
						$Unicode_Name = ($TargetString -split '\0')[0]
						if (($TargetString -split '\0')[1].length -gt 1)
						{
							$Localized_Name = ($TargetString -split '\0')[1]
						}
					}
					elseif ($extversion -eq 8)
					{
						# Check if record has FAT/MFT record info
						if ($ByteArray[$extStart + 20] -ne [byte]0)
						{
							$MFTrecordNr = [System.BitConverter]::ToUInt64(($ByteArray[($idx + 12) .. ($idx + 17)] + $ByteArray[($idx + 10) .. $($idx + 11)]), 0)
							$MFTrecordSeqNr = [System.BitConverter]::ToUInt16($ByteArray[($idx + 18) .. ($idx + 19)], 0)
							$unknown_1 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 20) .. ($idx + 23)]) -replace '-', '')" # 4 bytes => higher bytes of filesize
							$fsraw = $ByteArray[($idx + 20) .. ($idx + 23)]
							$Reparse_Tag = "$([System.BitConverter]::ToString($ByteArray[($idx + 27) .. ($idx + 24)]) -replace '-', '')" # 4 bytes
							$unknown_2 = "0x$([System.BitConverter]::ToString($ByteArray[($idx + 28) .. ($idx + 33)]) -replace '-', '')" # 6 bytes
							$idx = $idx + 34
						}
						else
						{
							if (($idx + 34) -ge ($idx + $extlength - 7))
							{
								$idx = $idx + 14
							}
							else { $idx = $idx + 34 }
						}
						$TargetString = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($extstart + $extlength - 3)])
						$Unicode_Name = ($TargetString -split '\0')[0]
						if (($TargetString -split '\0')[1].length -gt 1)
						{
							$Localized_Name = ($TargetString -split '\0')[1]
						}
					}
					elseif ($extversion -eq 3)
					{
						$idx = $idx + 12 # skip null bytes
						#	$Unicode_Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + ($extstart + $extlength - ($idx) - 1))])
						$Unicode_Name = ([System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + ($extstart + $extlength - 1))]) -Split '\0')[0]
						$idx = $idx + ($Unicode_Name.Length * 2) + 2
						if (($extStart + $extLength - 3) -gt $idx)
						{
							$TargetString = [System.Text.Encoding]::UTF8.GetString($ByteArray[($idx) .. ($extstart + $extlength - 3)])
							if (($TargetString -split '\0')[0].length -gt 1)
							{
								$Localized_Name = ($TargetString -split '\0')[0]
							}
						}
					}
					
					# This is not accurate !!
					$FileSystem = if ($MFTrecordNr -gt 0 -and $MFTrecordSeqNr -gt 0) { 'NTFS' }
					elseif ($MFTrecordNr -gt 0 -and ($MFTrecordSeqNr -eq 0 -or $MFTrecordSeqNr -eq $null))
					{
						if (!!$w32AccessedDate)
						{
							if ($w32AccessedDate.Minute -eq 0 -and $w32AccessedDate.Second -eq 0) { 'FAT' }
							elseif ($w32AccessedDate.Minute -gt 0 -and $w32AccessedDate.Second -gt 0) { 'exFAT\Ext\XFS\SMB\NFS' }
							else { $null }
						}
					}
					else { $null }
					
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "FileSystem" -Value $FileSystem
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown" -Value $unknown
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "MFTrecordNr" -Value $MFTrecordNr
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "MFTrecordSeqNr" -Value $MFTrecordSeqNr
					if (!$fsraw)
					{
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_1" -Value $unknown_1
					}
					else
					{
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "fsraw" -Value $fsraw
					}
					if ($Reparse_Tag -in $reparsefilter.Keys)
					{
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "ReparsePointTag" -Value $Reparse_Tag
					}
					else
					{
						$Reparse_Tag_Unknown = $Reparse_Tag
						$Reparse_Tag = $null
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Reparse_Tag_Unknown" -Value $Reparse_Tag_Unknown
					}
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_2" -Value $unknown_2
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_3" -Value $unknown_3
					#	$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown" -Value $unknownyet
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unicode_Name" -Value $Unicode_Name
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Localized_Name" -Value $Localized_Name
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0004
			elseif ($itemIdExtType -eq 'BEEF0005') # Embedded IDlist
			{
				try
				{
					$EmbeddedIdList = @(Get-EmbeddedIDList -ByteArray $ByteArray[($extStart + 20)..($extStart + $extLength - 1)])
					
					# Add the embedded items
					if ($EmbeddedIdList.Count -ge 1)
					{
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "EmbeddedIdList" -Value $EmbeddedIdList
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					} # end embedded items 
					else
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				
			} # End BEEF0005
			elseif ($itemIdExtType -eq 'BEEF0006')
			{
				try
				{
					$UserName = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 8) .. ($extStart + $extLength - 3)])
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "UserName" -Value $UserName
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0006
			elseif ($itemIdExtType -eq 'BEEF0010')
			{
				try
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					
					$ExtraData = [System.Byte[]](1, 0, 0, 0) + $ByteArray[($extStart + 16) .. ($extStart + $extLength - 1)]
					$PropertyStoreEntries = [System.Collections.ArrayList]::new()
					$Items = Get-Ext_SPS1 -ByteArray $ExtraData
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					}
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0010
			elseif ($itemIdExtType -eq 'BEEF0014') # Uri_PROPERTY
			{
				try
				{
					$CLSID = if ($extLength -ge 23) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8) .. ($extStart + 8 + 15)]))" }
					else { $null }
					$GUID = if (!!$CLSID) { Get-CLSID -CLSIDstring $CLSID }
					else { $null }
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "GUID" -Value $GUID
					if ($extLength -ge 55)
					{
						$datalength = [System.BitConverter]::ToUInt32($ByteArray[($extStart + 24) .. ($extStart + 27)], 0)
						$NrOfEntries = [System.BitConverter]::ToUInt32($ByteArray[($extStart + 52) .. ($extStart + 55)], 0)
						
						if ((24 + $datalength) -gt $extLength -or $NrOfEntries -eq 0) { return }
						
						$UriEntries = [PSCustomObject]@{ }
						$ix = $extStart + 56
						$n = 0
						while ($n -lt $NrOfEntries)
						{
							$EntryType = [System.BitConverter]::ToUInt32($ByteArray[$ix .. ($ix + 3)], 0)
							$Type = if (!!$UriEntryTypes[[System.String]$EntryType]) { "$($UriEntryTypes[[System.String]$EntryType]) [$($EntryType)]" }
							else { $EntryType }
							
							$EntryLength = [System.BitConverter]::ToUInt32($ByteArray[($ix + 4) .. ($ix + 7)], 0)
							
							if (($EntryLength -eq 0) -or (($ix + $EntryLength) -gt ($extStart + $extLength))) { break }
							
							$ix = $ix + 8
							$Entry = if ($EntryType -eq 16 -and $EntryLength -eq 4)
							{
								[System.BitConverter]::ToUInt32($ByteArray[($ix) .. ($ix + 3)], 0)
							}
							else
							{
								[System.Text.Encoding]::Unicode.GetString($ByteArray[($ix) .. ($ix + $EntryLength - 3)])
							}
							$UriEntries | Add-Member -MemberType NoteProperty -Name $Type -Value $Entry
							
							# Get the next entry
							$ix = $ix + $EntryLength
							if ($ix -gt ($extStart + $extLength)) { break }
							$n++
						} # End While 
						
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "UriEntries" -Value $UriEntries
					}
					
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0014
			elseif ($itemIdExtType -eq 'BEEF000A')
			{
				try
				{
					$EntryNr = [System.BitConverter]::ToInt32($ByteArray[($extStart + 8) .. ($extStart + 11)], 0)
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "EntryNr" -Value $EntryNr
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF000A
			elseif ($itemIdExtType -eq 'BEEF000B') # Link / ApAUMID info
			{
				try
				{
					# Target Path
					if ($ByteArray[($extStart + 14)] -ne 0) { $idx = 14 }else { $idx = 16 }
					$TargetUnicode = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[($extStart + $idx) .. ($extStart + $extLength - 1)])
					$Matches = [System.Text.RegularExpressions.Regex]::Matches($TargetUnicode, "(\x00\x00)")
					$UnicodeEnd = $Matches[0].index
					if ((($extStart + $idx) .. ($extStart + $idx + $UnicodeEnd)).count % 2 -eq 0)
					{
						$TargetPath = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + $idx) .. ($extStart + $idx + $UnicodeEnd)])
						$idx = $extStart + $idx + $UnicodeEnd + 2 + 1
					}
					else
					{
						$TargetPath = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + $idx) .. ($extStart + $idx + $UnicodeEnd - 1)])
						$idx = $extStart + $idx + $UnicodeEnd + 2
					}
					if ($TargetUnicode.Substring($Matches[0].Index, 4) -eq '')
					{
						$idx = $idx + 4
					}
					else
					{
						$TargetUnicode = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[($idx) .. ($extStart +$extLength - 1)])
						$UnicodeEnd = [System.Text.RegularExpressions.Regex]::Match($TargetUnicode, "(\x00\x00)").index + 1
						if ((($idx) .. ($idx + $UnicodeEnd)).count % 2 -eq 0)
						{
							$Darwin = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx + 2) .. ($idx + $UnicodeEnd)])
							$idx = $idx + $UnicodeEnd + 2 + 1
						}
						else
						{
							$Darwin = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx + 2) .. ($idx + $UnicodeEnd - 1)])
							$idx = $idx + $UnicodeEnd + 2
						}
						$idx = $idx + 4
					}
					# AppID
					# https://learn.microsoft.com/en-us/windows/win32/com/appid-key
					# https://learn.microsoft.com/en-us/windows/configuration/find-the-application-user-model-id-of-an-installed-app
					$TargetUnicode = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[($idx) .. ($extStart + $extLength - 1)])
					$UnicodeEnd = [System.Text.RegularExpressions.Regex]::Match($TargetUnicode, "(\x00\x00)").index + 1
					if ((($idx) .. ($idx + $UnicodeEnd)).count % 2 -eq 0)
					{
						$AUMID = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd)])
						$idx = $idx + $UnicodeEnd + 2 + 1
					}
					else
					{
						$AUMID = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd - 1)])
						$idx = $idx + $UnicodeEnd + 2
					}
									
					# AppID Parameters
					$TargetUnicode = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[($idx) .. ($extStart + $extLength - 1)])
					$UnicodeEnd = [System.Text.RegularExpressions.Regex]::Match($TargetUnicode, "(\x00\x00)").index + 1
					if ($UnicodeEnd -gt 1)
					{
						if ((($idx) .. ($idx + $UnicodeEnd)).count % 2 -eq 0)
						{
							$AppParameters = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd)])
							$idx = $idx + $UnicodeEnd + 2 + 1
						}
						else
						{
							$AppParameters = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd - 1)])
							$idx = $idx + $UnicodeEnd + 2
						}
					}
					else { $idx = $idx + 2 }
					
					try { $TargetCreated = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($idx) .. ($idx + 7)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $TargetCreated = $null }
					if ($TargetCreated -eq '01-Jan-1601 00:00:00.0000000') { $TargetCreated = $null }
					
					try { $ShortCutCreated = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($idx + 8) .. ($idx + 15)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $ShortCutCreated = $null }
					if ($ShortCutCreated -eq '01-Jan-1601 00:00:00.0000000') { $ShortCutCreated = $null }
	
					# Skip 12 unknown bytes / possible descriptions in notes on the right
					$Unknown1 = [System.BitConverter]::ToUInt32($ByteArray[($idx + 16) .. ($idx + 19)], 0) # AppUserModel PreventPinning
					$Unknown2 = [System.BitConverter]::ToUInt32($ByteArray[($idx + 20) .. ($idx + 23)], 0) # App User Model Run Flags
					$Unknown3 = [System.BitConverter]::ToUInt32($ByteArray[($idx + 24) .. ($idx + 27)], 0) # App User Model Installed By
						
					$idx = $idx + 16 + 12 # (16 - (($idx + 16) % 16))
	
					# Extra Path
					$TargetUnicode = [System.Text.Encoding]::GetEncoding(28591).GetString($ByteArray[($idx) .. ($extStart + $extLength - 1)])
					$UnicodeEnd = [System.Text.RegularExpressions.Regex]::Match($TargetUnicode, "(\x00\x00)").index + 1
					if ((($idx) .. ($idx + $UnicodeEnd)).count % 2 -eq 0)
					{
						$ExtraPath = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd)])
						$idx = $idx + $UnicodeEnd + 2 + 1
					}
					else
					{
						$ExtraPath = [System.Text.Encoding]::Unicode.GetString($ByteArray[($idx) .. ($idx + $UnicodeEnd - 1)])
						$idx = $idx + $UnicodeEnd + 2
					}
					
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "TargetPath" -Value $TargetPath
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Darwin" -Value $Darwin
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "AppUserModelID" -Value $AUMID
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "AppParameters" -Value $AppParameters
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "TargetCreated" -Value $TargetCreated
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "ShortCutCreated" -Value $ShortCutCreated
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "ExtraPath" -Value $ExtraPath
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_1" -Value $Unknown1
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_2" -Value $Unknown2
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Unknown_3" -Value $Unknown3
					
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF000B
			elseif ($itemIdExtType -eq 'BEEF001A') # Document Type
			{
				try
				{
					$DocType = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 10) .. ($extStart + $extLength - 5)])
					$DocumentType = if ($DocType.StartsWith('AppX')) { "$(Get-XAppName -XAppName $DocType)" } else { $DocType }
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "DocType" -Value $DocType
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "DocumentType" -Value $DocumentType
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF001A
			elseif ($itemIdExtType -eq 'BEEF001B') # Application Name
			{
				try
				{
					$Application = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 10) .. ($extStart + $extLength - 5)])
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Application" -Value $Application
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF001B
			elseif ($itemIdExtType -eq 'BEEF001E') # Pin Status (?)
			{
				try
				{
					$PinStatus = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 10) .. ($extStart + $extLength - 5)])
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "PinStatus" -Value $PinStatus
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF001E
			elseif ($itemIdExtType -eq 'BEEF0013') # Attribute (and maybe guid ?)
			{
				try
				{
					if ($extLength -le 10)
					{
						$Attributes = Get-Attributes -Bytes $ByteArray[($extStart + 8) .. ($extStart + 8 + 1)]
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
					elseif ($extLength -ge 12 -and $extLength -gt 10)
					{
						$Attributes = Get-Attributes -Bytes $ByteArray[($extStart + 8) .. ($extStart + 8 + 3)]
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
					else
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF001B
			elseif ($itemIdExtType -eq 'BEEF001D') # AppUserModelID 
			{
				try
				{
					$AppUserModelID = [System.Text.Encoding]::Unicode.GetString($ByteArray[($extStart + 10) .. ($extStart + $extLength - 5)])
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "AppUserModelID" -Value $AppUserModelID
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF001B
			elseif ($itemIdExtType -eq 'BEEF0019') # CLSID/GUID
			{
				try
				{
					$CLSID = if ($extLength -ge 23) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8) .. ($extStart + 8 + 15)]))" }
					else { $null }
					$CLSID0 = if ($extLength -ge 39) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8 + 16) .. ($extStart + 8 + 31)]))" }
					else { $null }
					
					$GUID = if (!!$CLSID0) { Get-CLSID -CLSIDstring $CLSID0 }
					else { $null }
					$FolderDesc = if (!!$CLSID) { Get-FolderDescription -CLSIDstring $CLSID }
					else { $null }
					
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "GUID" -Value $GUID
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "CLSID" -Value $FolderDesc
					
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				} # End Try
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				} #end catch
			} # end BEEF0019
			elseif ($itemIdExtType -eq 'BEEF0024') # Serialized Property Store
			{
				try
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					
					$ExtraData = [System.Byte[]](1, 0, 0, 0) + $ByteArray[($extStart + 8) .. ($extStart + $extLength - 1)]
					$PropertyStoreEntries = [System.Collections.ArrayList]::new()
					$Items = Get-Ext_SPS1 -ByteArray $ExtraData
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					}
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0024
			elseif ($itemIdExtType -eq 'BEEF0025') # Timestamps + Attributes
			{
				try
				{
					$eidx = $extStart + 8
					$Attributes = Get-Attributes -Bytes $ByteArray[($eidx) .. ($eidx + 3)]
					try { $Created = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 4) .. ($eidx + 11)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $Created = $null }
					try { $Modified = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 12) .. ($eidx + 19)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $Modified = $null }
					try { $Accessed = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 20) .. ($eidx + 27)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $Accessed = $null }
					
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Created" -Value $Created
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Modified" -Value $Modified
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Accessed" -Value $Accessed
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0025
			elseif ($itemIdExtType -eq 'BEEF0026') # Timestamps + Attributes + 1SPS
			{
				if ([System.Text.Encoding]::UTF8.GetString($ByteArray[($extStart + 12) .. ($extStart + 15)]) -eq '1SPS')
				{
					try
					{
						$ExtraData = [System.Byte[]](1, 0, 0, 0) + $ByteArray[($extStart + 8) .. ($extStart + $extLength - 1)]
						$PropertyStoreEntries = [System.Collections.ArrayList]::new()
						$Items = Get-Ext_SPS1 -ByteArray $ExtraData
						foreach ($property in $items)
						{
							$PropertyStoreEntry = [PSCustomObject]::new()
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
							$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
							$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
						}
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
					}
					catch
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				else
				{
					try
					{
						$eidx = $extStart + 8
						$Attributes = Get-Attributes -Bytes $ByteArray[$eidx .. ($eidx + 3)]
						try { $Created = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 4) .. ($eidx + 11)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
						catch { $Created = $null }
						try { $Modified = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 12) .. ($eidx + 19)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
						catch { $Modified = $null }
						try { $Accessed = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx + 20) .. ($eidx + 27)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
						catch { $Accessed = $null }
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Created" -Value $Created
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Modified" -Value $Modified
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Accessed" -Value $Accessed
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						
					} # end try
					catch
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					} #end catch
				}
				
			} # End BEEF0026
			elseif ($itemIdExtType -eq 'BEEF0027') # Serialized Property Store
			{
				try
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					
					$ExtraData = [System.Byte[]](1, 0, 0, 0) + $ByteArray[($extStart + 8) .. ($extStart + $extLength - 1)]
					$PropertyStoreEntries = [System.Collections.ArrayList]::new()
					$Items = Get-Ext_SPS1 -ByteArray $ExtraData
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					}
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0027
			elseif ($itemIdExtType -eq 'BEEF0029') # File Attributes
			{
				try
				{
					if ($extLength -le 10)
					{
						$Attributes = Get-Attributes -Bytes $ByteArray[($extStart + 8) .. ($extStart + 8 + 1)]
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
					elseif ($extLength -ge 12 -and $extLength -gt 10)
					{
						$Attributes = Get-Attributes -Bytes $ByteArray[($extStart + 8) .. ($extStart + 8 + 3)]
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
					else
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF0029
			elseif ($itemIdExtType -eq 'BEEF002B') # LastWriteTime Timestamp
			{
				try
				{
					$eidx = $extStart + 8
					try { $LastWriteTime = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx) .. ($eidx + 7)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $LastWriteTime = $null }
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "LastWriteTime" -Value $LastWriteTime
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF002B
			elseif ($itemIdExtType -eq 'BEEF002C') # LastAccessed Timestamp
			{
				try
				{
					$eidx = $extStart + 8
					try { $LastAccessed = [datetime]::FromFileTimeUtc([System.BitConverter]::ToUInt64($ByteArray[($eidx) .. ($eidx + 7)], 0)).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
					catch { $LastAccessed = $null }
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "LastAccessed" -Value $LastAccessed
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF002C
			elseif ($itemIdExtType -eq 'BEEF000E') # Embedded IDlist
			{
				try
				{
					$EmbeddedIdList = @(Get-EmbeddedIDList -ByteArray $ByteArray[($extStart + 8)..($extStart + $extLength - 1)])
					
					# Add the embedded items
					if ($EmbeddedIdList.Count -ge 1)
					{
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "EmbeddedIdList" -Value $EmbeddedIdList
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
						
					} # end embedded items 
					else
					{
						$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
			} # End BEEF000E
			elseif ($itemIdExtType -eq 'BEEF0000') # Removed extension
			{
				$ItemIdExtension.itemIdExtType = "Removed Extension $($itemIdExtType)"
				try
				{
					if ($extLength -ge 28)
					{
						$CLSID = if ($extLength -ge 23) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8) .. ($extStart + 8 + 15)]))" }
						else { $null }
						$CLSID0 = if ($extLength -ge 39) { Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ByteArray[($extStart + 8 + 16) .. ($extStart + 8 + 31)]))" }
						else { $null }
						
						$GUID = if (!!$CLSID0) { Get-CLSID -CLSIDstring $CLSID0 }
						else { $null }
						$FolderDesc = if (!!$CLSID) { Get-FolderDescription -CLSIDstring $CLSID }
						else { $null }
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "GUID" -Value $GUID
						$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "CLSID" -Value $FolderDesc
					}
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				} # end try
				catch
				{
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				} # end catch
			} # End BEEF0000
			else
			{
				if ($itemIdExtType.StartsWith('BEEF'))
				{
					$NewExtension = $true
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "NewExtension" -Value $NewExtension
					$extData = [System.BitConverter]::ToString($ByteArray[($extStart) .. ($extStart + $extLength - 1)]) -replace '-', ''
					$ItemIdExtension | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
				}
				else
				{
					break
				}
				
			} # End Else
			
			if (!!$ItemIdExtension)
			{
				$null = $ItemIdExtensions.Add($ItemIdExtension)
			}
			if (($ByteArray.Count - ($extstart + $extLength)) -lt 4) { break }
			$idx = $extStart + $extLength
			
		} # End While
		
		return $ItemIdExtensions
	} # End Get-ItemIdExtensions
	
	function Get-IDList
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowNull()]
			[AllowEmptyString()]
			[System.Byte[]]$ByteArray,
			[Int]$Index = 2
		)
		
		$ShellinkSize = $ByteArray.Count
		$ItemIDs = [System.Collections.ArrayList]::new()
		$idx = $Index
		while ($idx -lt $ShellinkSize)
		{
			$itemSize = [Bitconverter]::ToUInt16($ByteArray[($idx) .. ($idx + 1)], 0)
			if ($itemSize -eq 0 -or $itemSize -gt ($ShellinkSize - $idx)) { break }
			$null = $ItemIDs.Add([ShellLink.Structures.ItemID]::FromByteArray($ByteArray[$idx .. ($idx + $itemSize - 1)]))
			$idx = $idx + $itemSize
			if ($idx -ge $ShellinkSize) { break }
		} # End while
		
		$IdList = [System.Collections.ArrayList]::new()
		if ($ItemIDs.Count -ge 1)
		{
			foreach ($ItemID in $ItemIDs)
			{
				$linkItem = Get-LinkTargetIDList -ItemIdListItem $ItemID
				$null = $IdList.Add($linkItem)
			}
		}
		return $IdList
	} # End Get-IDList
	
	function Get-LinkTargetIdList
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[AllowEmptyString()]
			[AllowNull()]
			[ShellLink.Structures.ItemID]$ItemIdListItem
		)
		
		$ItemIDType = if ($ItemIdListItem.Data) { [System.BitConverter]::ToString($ItemIdListItem.Data[0]) }
		else { $null }
		
		try
		{
			if ($ItemIDType -eq '00') # Variable
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_00 -ByteArray $ItemIdListItem.Data
					
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq '01') # Control Panel Category
			{
				$Signature = if ($ItemIdListItem.Data.length -ge 5) { [System.BitConverter]::ToString($ItemIdListItem.Data[2 .. 5]) -replace '-', '' }
				else { $null }
				$CP = [System.BitConverter]::ToString($ItemIdListItem.Data[6])
				$CPcategory = if (!!$CPitems[[System.String]$CP]) { "$($CPitems[[System.String]$CP]) [$0x$($CP)]" }
				else { "$0x$($CP)" }
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIdListItem.ItemIDSize
					'ItemIDType' = $ItemIDType
					'Signature'  = if ($Signature) { "0x$($Signature)" }else { $null }
					'CPcategory' = $CPcategory
					'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
				}
			}
			elseif ($ItemIDType -eq '1F') # ShellDesktop
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_1F -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'  = $ItemIdListItem.ItemIDSize
						'ItemIDType'  = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	      = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType.Startswith('2')) # -in ('2E', '2F')) # Volume shell item / MyComputer
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_23_2E_2F -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'  = $ItemIdListItem.ItemIDSize
						'ItemIDType'  = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	      = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq 'B1')
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_B1 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -in ('3A')) # File
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_3A -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -in ('31', '32')) # Folder / File
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_31_32 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'  = $ItemIdListItem.ItemIDSize
						'ItemIDType'  = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	      = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -in ('35', '36')) # Folder / File with Unicode ANSI name
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_35_36 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'  = $ItemIdListItem.ItemIDSize
						'ItemIDType'  = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	      = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq '61') # CLSID_Internet - URI shell item
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_61 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq '71') # GUID
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_71 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'  = $ItemIdListItem.ItemIDSize
						'ItemIDType'  = $ItemIDType
						<#'DisplayName' = $ItemIdListItem.DisplayName#>
						'Data'	      = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			# 0x72 	Printers
			# 0x73 	CommonPlacesFolder
			elseif ($ItemIDType -in ('73', '74', '77')) # (73 => Delegate Folder / 74 => Folder/ 77 => File) Delegate folder
			{
				$Signature = [System.BitConverter]::ToString($ItemIdListItem.Data[4 .. 7]) -replace '-', ''
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIdListItem.ItemIDSize
					'ItemIDType' = $ItemIDType
					'$Signature' = [System.Text.Encoding]::UTF8.GetString($ItemIdListItem.Data[4 .. 7])
				}
				
				if ($Signature -eq '43465346') # CFSF
				{
					try
					{
						$data = $ItemIdListItem.Data
						$Guid = $data[4 .. 19]
						$idx = $data[22 .. (22 + $data.Count - 1)].IndexOf([byte]'0')
						$RawFilesize = $null
						if ($ItemIDType -eq '77') # File
						{
							$Filesize = [System.BitConverter]::ToUInt32($data[12 .. 15], 0).ToString('N0')
							$RawFilesize = $data[12 .. 15]
						}
						$w32Modified = DosDateTime-FromHex -Hex ([System.BitConverter]::ToString($data[19 .. 16]) -replace '-', '')
						if (!!$w32Modified) { $w32Modified = $w32Modified.ToString("dd-MMM-yyyy HH:mm:ss") }
						$Attributes = Get-Attributes -Bytes $data[20..21]
						$Ansi_Name = [System.Text.Encoding]::UTF8.GetString($data[22 .. ($idx + 22 - 1)])
						$padding = if (($Ansi_Name.Length % 2) -eq 0) { 2 }
						else { 1 }
						$idx = 22 + $Ansi_Name.Length + $padding
						
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Unknown" -Value "0x$([System.BitConverter]::ToString($data[8 .. 11]).replace('-', ''))"
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "w32Modified" -Value $w32Modified
						if ($null -ne $Filesize)
						{
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Filesize" -Value $Filesize
							$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "RawFilesize" -Value $RawFilesize
						}
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Attributes" -Value $Attributes
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Ansi_Name" -Value $Ansi_Name
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Unknown1" -Value "0x$([System.BitConverter]::ToString($data[($idx) .. ($idx + 1)]).replace('-', ''))"
						
						$GUID1 = Get-CLSID -CLSIDstring (Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($data[($idx + 2) .. ($idx + 17)]))")
						$GUID2 = Get-CLSID -CLSIDstring (Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($data[($idx + 18) .. ($idx + 18 + 15)]))")
						
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Unknown2" -Value "0x$([System.BitConverter]::ToString($data[($idx) .. ($idx + 3)]).replace('-', ''))"
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "GUID" -Value $GUID1
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "CLSID" -Value $GUID2
						
						$idx = $idx + 34
						
						$ItemIdExtensions = Get-ItemIdExtensions -ByteArray $data -idx $idx
						
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "ItemIdExtensions" -Value @($ItemIdExtensions)
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "Data" -Value "$([System.BitConverter]::ToString($data) -replace '-', '')"
					}
					catch
					{
						$extData = [System.BitConverter]::ToString($ItemIdListItem.Data[10 .. ($ItemIdListItem.ItemIDSize - 1)]) -replace '-', ''
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name "extData" -Value $extData
					}
				}
				else
				{
					$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Data' -Value [System.BitConverter]::ToString($ItemIdListItem.Data).replace('-', '')
				}
			}
			elseif ($ItemIDType -in ('0F', '09', '16', '52') -and $ItemIdListItem.Data[8 .. 9].Contains([byte]16))
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Compressed_w32 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -in ('00', '10', '0E', '08') -and $ItemIdListItem.Data[8 .. 9].Contains([byte]144))
			{
				try
				{
					$ByteArray = $ItemIdListItem.Data
					# Find first not null byte index after byte 8
					$bdata = $ByteArray[9 .. ($ByteArray.Count - 1)]
					$idx = $bdata.IndexOf(($bdata -ne [byte]0)[0])
					$end = $ByteArray[(9 + $idx) .. ($ByteArray.Count - 1)].IndexOf([byte]'0')
					$foldernameAnsi = [System.Text.Encoding]::UTF8.GetString($ByteArray[(9 + $idx) .. (9 + $idx + $end - 1)])
					
					$unidx = 9 + $idx + $end
					$bdata = $ByteArray[$unidx .. ($ByteArray.Count - 1)]
					$idx = $bdata.IndexOf(($bdata -ne [byte]0)[0])
					$foldernameunicode = ([System.Text.Encoding]::Unicode.GetString($ByteArray[($unidx + $idx) .. ($ByteArray.Count - 1)]) -Split '\0')[0]
					
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize'	    = $ItemIdListItem.ItemIDSize
						'ItemIDType'	    = $ItemIDType
						'Subfolder Ansi'    = $foldernameAnsi
						'Subfolder Unicode' = $foldernameunicode
						'Data'			    = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
					
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif (($ItemIDType -eq '47' -and $ItemIdListItem.Data[2] -eq [byte]02) -or # NetworkPlaces
				($ItemIDType -in ('47', '46', '41', '42') -and $ItemIdListItem.Data[2] -eq [byte]130) -or
				($ItemIDType -eq '42' -and $ItemIdListItem.Data[2] -eq [byte]194))
			{
				try
				{
					$ByteArray = $ItemIdListItem.Data
					
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
					
					$Items = ([System.Text.Encoding]::GetEncoding(1252).GetString($ByteArray[3 .. ($ByteArray.Count - 1)]) -Split '\0')
					
					if ($items.count -ge 1)
					{
						$Path = $items[0]
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Path' -Value $Path
					}
					if ($items.count -ge 2)
					{
						$Network = $items[1]
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'NetworkType' -Value $Network
					}
					if ($items.count -ge 3 -and $items[2] -ne [System.Text.Encoding]::UTF8.GetString([byte[]](2, 0)))
					{
						$Device = $items[2]
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name 'Device' -Value $Device
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq 'C3')
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_C3 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq '46')
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_46 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
			elseif ($ItemIDType -eq '47')
			{
				try
				{
					$ItemIdListProperties = [PSCustomObject]@{ }
					$Items = Get-Ext_47 -ByteArray $ItemIdListItem.Data
					foreach ($property in $items.psobject.Properties)
					{
						$ItemIdListProperties | Add-Member -MemberType NoteProperty -Name $property.Name -Value $Property.Value
					}
				}
				catch
				{
					$ItemIdListProperties = [PSCustomObject]@{
						'ItemIDSize' = $ItemIdListItem.ItemIDSize
						'ItemIDType' = $ItemIDType
						'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					}
				}
			}
		<#	elseif ($ItemIDType -eq '4C' -and $ItemIdListItem.Data[1] -eq [byte]80)
			{
				$ByteArray = $ItemIdListItem.Data
				$Namelength = [System.BitConverter]::ToUInt16($ByteArray[26 .. 27], 0)*2
				$Name = [System.Text.Encoding]::Unicode.GetString($ByteArray[26..(24+ $Namelength-1)])
				
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIdListItem.ItemIDSize
					'ItemIDType' = $ItemIDType
					'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
					'Name'       = $Name
				}
			}#>
			else
			{
				$ItemIdListProperties = [PSCustomObject]@{
					'ItemIDSize' = $ItemIdListItem.ItemIDSize
					'ItemIDType' = $ItemIDType
					'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
				}
			}
		}
		catch
		{
			$ItemIdListProperties = [PSCustomObject]@{
				'ItemIDSize' = $ItemIdListItem.ItemIDSize
				'ItemIDType' = $ItemIDType
				'Data'	     = [System.BitConverter]::ToString($ItemIdListItem.Data) -replace '-', ''
			}
		}
		return $ItemIdListProperties
	} # End Get-LinkTargetIdList
	
	function Get-ShellLinkHeaderfrombyteArray
	{
		[OutputType([string])]
		param
		(
			[Parameter(Mandatory = $true)]
			[Byte[]]$ByteArray
		)
		$Error.Clear()
		# Check the Header Size
		if ($ByteArray[0] -ne '76')
		{
			# [System.Console]::Beep(500,150)
			# Show-ErrorMessage -ErrorMessage "The LNK Header Size is not 76"
			$ShortcutInfo = $null
			$Status.Text = "Invalid LNK header"
			return
		}
		
		try { $ShortcutInfo = [ShellLink.Structures.ShellLinkHeader]::FromByteArray($ByteArray[0 .. 75]) }
		catch [System.Management.Automation.MethodInvocationException]{
			# Show-ErrorMessage -ErrorMessage "[ShellLink] $($Error[0].Exception.InnerException.Message)"
			# $Status.Text = "$($Error[0].Exception.InnerException.Message)"
			$error.Clear()
			$ShortcutInfo = $null
			$Status.Text = "Invalid LNK header"
			return
		}
		catch
		{
			# [System.Console]::Beep(500, 150)
			$ShortcutInfo = $null
			$Status.Text = "Invalid LNK header"
			return
		}
		
		# Get Shotcut Flags
		$LinkFlags = $ShortcutInfo.LinkFlags.ToString()
		
		# Header - Timestamps are stored in UTC
		$fileattributes = if ($ShortcutInfo.FileAttributes -notmatch '^\d+$') { $ShortcutInfo.FileAttributes.ToString().split(',').foreach{ $_.replace('FILE_ATTRIBUTE_', '').ToLower() } }
		elseif ($ShortcutInfo.FileAttributes -match '^\d+$' -and $ShortcutInfo.FileAttributes -ne 0)
		{ (Get-Attributes -Bytes ([System.BitConverter]::GetBytes([System.UInt32]$ShortcutInfo.FileAttributes)) -NoNumber).split(',') }
		else { $null }
		$ShowCommand = if (!!$ShowCommands[[System.String]$ShortcutInfo.ShowCommand.value__]) { $ShowCommands[[System.String]$ShortcutInfo.ShowCommand.value__] }
		else { [System.String]$ShortcutInfo.ShowCommand }
		$creation = if ($ShortcutInfo.creationTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.creationTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
		else { $null }
		$access = if ($ShortcutInfo.AccessTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.AccessTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
		else { $null }
		$write = if ($ShortcutInfo.WriteTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.WriteTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
		else { $null }
		$HotKey = if ($ShortcutInfo.HotKey.Highbyte -eq 0 -and $ShortcutInfo.HotKey.Lowbyte -eq 0) { "----" }
		else { "$($ShortcutInfo.HotKey.Highbyte) + $($ShortcutInfo.HotKey.Lowbyte)" }
		$LnkSize = ($ShortcutInfo.ShellLinkHeader.HeaderSize +
			$ShortcutInfo.LinkInfo.LinkInfoSize +
			$ShortcutInfo.LinkTargetIDList.IDListSize +
			$ShortcutInfo.StringData.StringDataSize +
			$ShortcutInfo.ExtraData.ExtraDataSize)
		$Size = 76
		$LS = if ($ByteArray.Count -gt $Size) { $ByteArray[($Size - 1) .. $ByteArray.Count] }
		else { $null }
		$LinkSlackLength = if (!!$LS) { $ls.length }
		else { $null }
		$LinkSlack = if (!!$LS) { [System.BitConverter]::ToString($LS) -replace '-', '' }
		else { '' }
		
		
		$iconIndex = if ($null -ne $ShortcutInfo.IconIndex)
		{
			if (!!$StockIconIDs[([System.String]($ShortcutInfo.IconIndex))]) { "[$($ShortcutInfo.IconIndex)] $($StockIconIDs[([System.String]($ShortcutInfo.IconIndex))])" }
			else { $ShortcutInfo.IconIndex }
		}
		else { $null }
		
		$linktargets = [PSCustomObject]@{
			# Header
			'Shortcut Size'	    = $Size
			'Header Block Size' = $Size
			'LinkCLSID'		    = $ShortcutInfo.LinkCLSID
			'Link_Flags'	    = $LinkFlags
			'FileAttributes'    = $fileattributes
			'CreationTime'	    = $creation
			'AccessTime'	    = $access
			'WriteTime'		    = $write
			'Target File Size'  = $ShortcutInfo.FileSize.ToString('N0')
			'Icon Idx'		    = $iconIndex
			'ShowCommand'	    = $ShowCommand
			'HotKey'		    = $HotKey
			'LinkSlackLength'   = $LinkSlackLength
			'LinkSlack'		    = $LinkSlack
		}
		
		return $linktargets
	}
	
	function Get-ShellLinkfrombyteArray
	{
		[OutputType([string])]
		param
		(
			[Parameter(Mandatory = $true)]
			[Byte[]]$ByteArray
		)
		
		$Error.Clear()
		# Check the Header Size
		if ($ByteArray[0] -ne '76')
		{
			# [System.Console]::Beep(500,150)
			# Show-ErrorMessage -ErrorMessage "The LNK Header Size is not 76"
			$Status.Text = "The LNK Header Size is not 76"
			$ShortcutInfo = $null
			return
		}
		
		try
		{
			try { $ShortcutInfo = [ShellLink.Shortcut]::FromByteArray($ByteArray) }
			catch [System.Management.Automation.MethodInvocationException]{
				# Show-ErrorMessage -ErrorMessage "[ShellLink] $($Error[0].Exception.InnerException.Message)"
				# $Status.Text = "$($Error[0].Exception.InnerException.Message)"
				$ShortcutInfo = $null
				# $Status.Text = "Invalid LNK"
				return
			}
			catch
			{
				# [System.Console]::Beep(500, 150)
				# Show-ErrorMessage -ErrorMessage "Invalid LNK"
				# $Status.Text = "Invalid LNK"
				$ShortcutInfo = $null
				return
			}
			
			# Get Shotcut Flags
			$LinkFlags = $ShortcutInfo.LinkFlags.ToString()
			
			# Header - Timestamps are stored in UTC
			$fileattributes = if ($ShortcutInfo.FileAttributes -notmatch '^\d+$') { $ShortcutInfo.FileAttributes.ToString().split(',').foreach{ $_.replace('FILE_ATTRIBUTE_', '').ToLower() } }
			elseif ($ShortcutInfo.FileAttributes -match '^\d+$' -and $ShortcutInfo.FileAttributes -ne 0)
			{ (Get-Attributes -Bytes ([System.BitConverter]::GetBytes([System.UInt32]$ShortcutInfo.FileAttributes)) -NoNumber).split(',') }
			else { $null }
			$ShowCommand = if (!!$ShowCommands[[System.String]$ShortcutInfo.ShowCommand.value__]) { $ShowCommands[[System.String]$ShortcutInfo.ShowCommand.value__] }
			else { [System.String]$ShortcutInfo.ShowCommand }
			$creation = if ($ShortcutInfo.creationTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.creationTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
			else { $null }
			$access = if ($ShortcutInfo.AccessTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.AccessTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
			else { $null }
			$write = if ($ShortcutInfo.WriteTime -ne 0) { [DateTime]::FromFileTimeUtc($ShortcutInfo.WriteTime).ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
			else { $null }
			$HotKey = if ($ShortcutInfo.HotKey.Highbyte -eq 0 -and $ShortcutInfo.HotKey.Lowbyte -eq 0) { "----" }
			else { "$($ShortcutInfo.HotKey.Highbyte) + $($ShortcutInfo.HotKey.Lowbyte)" }
			$LnkSize = ($ShortcutInfo.ShellLinkHeader.HeaderSize +
				$ShortcutInfo.LinkInfo.LinkInfoSize +
				$ShortcutInfo.LinkTargetIDList.IDListSize +
				$ShortcutInfo.StringData.StringDataSize +
				$ShortcutInfo.ExtraData.ExtraDataSize)
			$LS = if ($ByteArray.Count -gt $ShortcutInfo.Size) { $ByteArray[($ShortcutInfo.Size - 1) .. $ByteArray.Count] }
			else { $null }
			$LinkSlackLength = if (!!$LS) { $ls.length }
			else { $null }
			$LinkSlack = if (!!$LS) { [System.BitConverter]::ToString($LS) -replace '-', '' }
			else { '' }
			
			$LinkInfoData = if (!!$ShortcutInfo.LinkInfo) { $ShortcutInfo.LinkInfo.GetBytes() }
			else { $null }
			$LinkTargetIDListData = if (!!$ShortcutInfo.LinkTargetIDList) { $ShortcutInfo.LinkTargetIDList.GetBytes() }
			else { $null }
			$StringDataData = if (!!$ShortcutInfo.StringData) { $ShortcutInfo.StringData.GetBytes() }
			else { $null }
			$ExtraDataData = if (!!$ShortcutInfo.ExtraData) { $ShortcutInfo.ExtraData.GetBytes() }
			else { $null }
			
			$iconIndex = if ($null -ne $ShortcutInfo.IconIndex)
			{
				if (!!$StockIconIDs[([System.String]($ShortcutInfo.IconIndex))]) { "[$($ShortcutInfo.IconIndex)] $($StockIconIDs[([System.String]($ShortcutInfo.IconIndex))])" }
				else { $ShortcutInfo.IconIndex }
			}
			else { $null }
			
			$linktargets = [PSCustomObject]@{
				# Header
				'Shortcut Size'	       = $ShortcutInfo.Size
				'Header Block Size'    = $ShortcutInfo.ShellLinkHeader.HeaderSize
				'LinkCLSID'		       = $ShortcutInfo.LinkCLSID
				'Link_Flags'		   = $LinkFlags
				'FileAttributes'	   = $fileattributes
				'CreationTime'		   = $creation
				'AccessTime'		   = $access
				'WriteTime'		       = $write
				'Target File Size'	   = $ShortcutInfo.FileSize.ToString('N0')
				'Icon Idx'			   = $iconIndex
				'ShowCommand'		   = $ShowCommand
				'HotKey'			   = $HotKey
				'LinkSlackLength'	   = $LinkSlackLength
				'LinkSlack'		       = $LinkSlack
				'LinkInfoData'		   = $LinkInfoData
				'LinkTargetIDListData' = $LinkTargetIDListData
				'StringDataData'	   = $StringDataData
				'ExtraDataData'	       = $ExtraDataData
			}
			# ShowCommand:	
			# https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow	
			
			# LinkTargetIDList
			if ($LinkFlags.contains('HasLinkTargetIDList'))
			{
				$targetidlistSize = $ShortcutInfo.LinkTargetIDList.IDListSize
				$linktargets | Add-Member -MemberType NoteProperty -Name "TargetID Block Size" -Value $targetidlistSize
				
				# Add the ItemIdListItems	
				$ItemIdListItems = [System.Collections.ArrayList]::new()
				if ($ShortcutInfo.LinkTargetIDList.GetBytes().Count -ge 8)
				{
					$LinkTargetIDListBytes = $ShortcutInfo.LinkTargetIDList.GetBytes()
					$ItemIdListItems = @(Get-IDList -ByteArray $LinkTargetIDListBytes)
				} # end if count ge 8
				else { $ItemIdListItems = $null }
				$linktargets | Add-Member -MemberType NoteProperty -Name "ItemIdListItems" -Value $ItemIdListItems
				
				try
				{
					if ($ItemIdListItems.ItemIDType -match "01|23|2F|2E|31|32|3A|35|36|61|71|B1" -and !!$ShortcutInfo.LinkTargetIDList.Path)
					{
						$len = $ShortcutInfo.LinkTargetIDList.Path.Length
						$dcount = $ShortcutInfo.LinkTargetIDList.ItemIDList.displayname.Count
						if ($len -eq 3 -and $dcount -eq 1)
						{
							$linkpath = $displayname = $ShortcutInfo.LinkTargetIDList.Path.ToString()
						}
						elseif ($len -gt 0 -and $dcount -ge 1)
						{
							foreach ($known in $ShellFolders)
							{
								if ($ShortcutInfo.LinkTargetIDList.Path.Contains("$($known.Value)"))
								{
									$linkpath = $ShortcutInfo.LinkTargetIDList.Path.Replace("$($known.Value)", "[$($known.Name)]")
									break
								}
								else { $linkpath = $ShortcutInfo.LinkTargetIDList.Path.ToString() }
							}
							try
							{
								$displayname = if ($dcount -gt 1)
								{
									$ShortcutInfo.LinkTargetIDList.ItemIDList.displayname[$dcount - 1]
								}
								else { $ShortcutInfo.LinkTargetIDList.ItemIDList.displayname }
							}
							catch { $displayname = $ShortcutInfo.LinkTargetIDList.ItemIDList.displayname }
						}
						else
						{
							foreach ($known in $ShellFolders)
							{
								if ($ShortcutInfo.LinkTargetIDList.Path.Contains("$($known.Value)"))
								{
									$linkpath = $ShortcutInfo.LinkTargetIDList.Path.Replace("$($known.Value)", "[$($known.Name)]")
									break
								}
								else { $linkpath = $ShortcutInfo.LinkTargetIDList.Path.ToString() }
							}
							$displayname = $ShortcutInfo.LinkTargetIDList.displayname
						}
					}
					else
					{
						$null = $linkpath = $displayname
					}
				}
				catch { $null = $linkpath = $displayname }
				
				if (!!$displayname)
				{
					$linktargets | Add-Member -MemberType NoteProperty -Name "Display Name" -Value $displayname
				}
				$linktargets | Add-Member -MemberType NoteProperty -Name "Path" -Value $linkpath
				
			}
			else { $null = $linkpath = $displayname }
			
			# StringData:
			if (!!$ShortcutInfo.StringData)
			{
				$StringDataBlockSize = $ShortcutInfo.StringData.StringDataSize
				$linktargets | Add-Member -MemberType NoteProperty -Name "StringData Block Size" -Value $StringDataBlockSize
				$IsUnicode = $ShortcutInfo.StringData.IsUnicode
				$linktargets | Add-Member -MemberType NoteProperty -Name "StringData IsUnicode" -Value $IsUnicode
				
				#		HasName
				if ($LinkFlags.contains('HasName'))
				{
					$name = $ShortcutInfo.StringData.NameString
					$linktargets | Add-Member -MemberType NoteProperty -Name "NameString" -Value $name
				}
				# 		HasWorkingDir
				if ($LinkFlags.contains('HasWorkingDir'))
				{
					$WorkingDir = $ShortcutInfo.StringData.WorkingDir
					$linktargets | Add-Member -MemberType NoteProperty -Name "Working Dir." -Value $WorkingDir
				}
				#		HasRelativePath
				if ($LinkFlags.contains('HasRelativePath'))
				{
					$RelativePath = $ShortcutInfo.StringData.RelativePath
					$linktargets | Add-Member -MemberType NoteProperty -Name "Relative Path" -Value $RelativePath
				}
				# HasArguments
				if ($LinkFlags.contains('HasArguments'))
				{
					$CommandLineArguments = $ShortcutInfo.StringData.CommandLineArguments
					$cma_length = $ShortcutInfo.StringData.CommandLineArguments.Length
					$linktargets | Add-Member -MemberType NoteProperty -Name "Command Args Length" -Value $cma_length
					$linktargets | Add-Member -MemberType NoteProperty -Name "Command Args" -Value $CommandLineArguments.TrimStart(' ')
				}
				
				# HasIconLocation
				if ($LinkFlags.contains('HasIconLocation'))
				{
					$iconlocation = $ShortcutInfo.StringData.IconLocation
					$linktargets | Add-Member -MemberType NoteProperty -Name "Icon Location" -Value $iconlocation
				}
			}
			
			# LinkInfo
			if ($LinkFlags.contains('HasLinkInfo'))
			{
				$LinkInfoSize = $ShortcutInfo.LinkInfo.LinkInfoSize
				$LinkInfoFlags = $ShortcutInfo.LinkInfo.LinkInfoFlags.ToString()
				$linktargets | Add-Member -MemberType NoteProperty -Name "Link Info Block Size" -Value $LinkInfoSize
				$linktargets | Add-Member -MemberType NoteProperty -Name "Link Info Flags" -Value $LinkInfoFlags
				
				# VolumeID
				if ($LinkInfoFlags.contains('VolumeID'))
				{
					$DriveSerialNumber = $ShortcutInfo.LinkInfo.VolumeID.DriveSerialNumber.tostring('X3')
					$DriveType = $ShortcutInfo.LinkInfo.VolumeID.DriveType.ToString().replace('DRIVE_', '').replace(' ', '')
					$VolumeLabel = $ShortcutInfo.LinkInfo.VolumeID.VolumeLabel
					$linktargets | Add-Member -MemberType NoteProperty -Name "Drive Type" -Value $DriveType
					$linktargets | Add-Member -MemberType NoteProperty -Name "Volume Label" -Value $VolumeLabel
					$linktargets | Add-Member -MemberType NoteProperty -Name "Drive s/n" -Value $DriveSerialNumber
				}
				# LocalBasePath
				if ($LinkInfoFlags.contains('LocalBasePath'))
				{
					$LocalBasePath = $ShortcutInfo.LinkInfo.LocalBasePath
					$LocalBasePathUnicode = $ShortcutInfo.LinkInfo.LocalBasePathUnicode
					$linktargets | Add-Member -MemberType NoteProperty -Name "Local Base Path" -Value $LocalBasePath
					$linktargets | Add-Member -MemberType NoteProperty -Name "Local Base Path Unicode" -Value $LocalBasePathUnicode
				}
				# CommonPathSuffix
				if (!!$ShortcutInfo.LinkInfo.CommonPathSuffix)
				{
					$CommonPathSuffix = $ShortcutInfo.LinkInfo.CommonPathSuffix
					$CommonPathSuffixUnicode = $ShortcutInfo.LinkInfo.CommonPathSuffixUnicode
					$linktargets | Add-Member -MemberType NoteProperty -Name "CommonPathSuffix" -Value $CommonPathSuffix
					$linktargets | Add-Member -MemberType NoteProperty -Name "CommonPathSuffixUnicode" -Value $CommonPathSuffixUnicode
				}
				# CommonNetworkRelativeLink
				if ($LinkInfoFlags.contains('CommonNetworkRelativeLink'))
				{
					$CommonNetworkRelativeLinkFlags = $ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.CommonNetworkRelativeLinkFlags.ToString()
					$linktargets | Add-Member -MemberType NoteProperty -Name "Common Network Relative Link Flags" -Value $CommonNetworkRelativeLinkFlags
					
					# ValidNetType
					if ($CommonNetworkRelativeLinkFlags.Contains('ValidNetType'))
					{
						$NetworkProviderType = ($ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.NetworkProviderType).ToString('X')
						$NetworkProvider = if (!!$($Vendors[$NetworkProviderType])) { "0x$($NetworkProviderType) ($($Vendors[$NetworkProviderType]))" }
						else { "0x$($NetworkProviderType)" }
						$linktargets | Add-Member -MemberType NoteProperty -Name "NetworkProviderType" -Value $NetworkProvider
					}
					$NetName = $ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.NetName
					$NetNameUnicode = $ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.NetNameUnicode
					$linktargets | Add-Member -MemberType NoteProperty -Name "NetName" -Value $NetName
					$linktargets | Add-Member -MemberType NoteProperty -Name "NetName Unicode" -Value $NetNameUnicode
					
					# ValidDevice
					if ($CommonNetworkRelativeLinkFlags.Contains('ValidDevice'))
					{
						$DeviceName = $ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.DeviceName
						$DeviceNameUnicode = $ShortcutInfo.LinkInfo.CommonNetworkRelativeLink.DeviceNameUnicode
						$linktargets | Add-Member -MemberType NoteProperty -Name "Device Name" -Value $DeviceName
						$linktargets | Add-Member -MemberType NoteProperty -Name "Device Name Unicode" -Value $DeviceNameUnicode
					}
				}
			}
			
			# ExtraData Block
			if (!!$ShortcutInfo.Extradata)
			{
				$ExtraDataBlockSize = $ShortcutInfo.ExtraData.ExtraDataSize
				$linktargets | Add-Member -MemberType NoteProperty -Name "ExtraData Block Size" -Value $ExtraDataBlockSize
				
				# HasDarwinID
				if ($LinkFlags.contains('HasDarwinID'))
				{
					$DarwinDataAnsi = $ShortcutInfo.ExtraData.DarwinDataBlock.DarwinDataAnsi
					$DarwinDataUnicode = $ShortcutInfo.ExtraData.DarwinDataBlock.DarwinDataUnicode
					$linktargets | Add-Member -MemberType NoteProperty -Name "DarwinDataAnsi" -Value $DarwinDataAnsi
					$linktargets | Add-Member -MemberType NoteProperty -Name "DarwinDataUnicode" -Value $DarwinDataUnicode
				}
				
				# RunWithShimLayer
				if ($LinkFlags.contains('RunWithShimLayer'))
				{
					$LayerName = $ShortcutInfo.ExtraData.ShimDataBlock.LayerName
					$linktargets | Add-Member -MemberType NoteProperty -Name "ShimLayerName" -Value $LayerName
				}
				
				# EnableTargetMetadata - PropertyStore
				if (!!$ShortcutInfo.ExtraData.PropertyStoreDataBlock.PropertyStore.PropertyStorage)
				{
					# Get All PropertyStore Properties
					$propertystoredata = $ShortcutInfo.ExtraData.PropertyStoreDataBlock.GetBytes()
					$PropertyStoreEntries = [System.Collections.ArrayList]::new()
					$Items = Get-Ext_SPS1 -ByteArray ([byte[]](0, 0, 0, 0) + $propertystoredata[8 .. ($propertystoredata.count - 1)])
					foreach ($property in $items)
					{
						$PropertyStoreEntry = [PSCustomObject]::new()
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
						$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value @($property.PropertyStore)
						$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
					}
					$linktargets | Add-Member -MemberType NoteProperty -Name "PropertyStoreEntries" -Value $PropertyStoreEntries
				}
				
				# KnownFolderDataBlock
				if ($ShortcutInfo.ExtraData.KnownFolderDataBlock)
				{
					$KnBlockSignature = $ShortcutInfo.ExtraData.KnownFolderDataBlock.BlockSignature
					$KnownFolderID = $ShortcutInfo.ExtraData.KnownFolderDataBlock.KnownFolderID
					
					$kfguid = $ShortcutInfo.ExtraData.KnownFolderDataBlock.KnownFolderID.Guid
					$KnownFolderDisplayName = if (!!$knownfolders.Where{ $_.GUID -eq "{$($kfguid)}" })
					{ "$($knownfolders.Where{ $_.GUID -eq "{$($kfguid)}" }.Name)" }
					else { "----" }
					$KnownFolderIDOffset = $ShortcutInfo.ExtraData.KnownFolderDataBlock.Offset
					$linktargets | Add-Member -MemberType NoteProperty -Name "Known Folder BlockSignature" -Value $KnBlockSignature
					$linktargets | Add-Member -MemberType NoteProperty -Name "Known Folder ID" -Value $KnownFolderID
					$linktargets | Add-Member -MemberType NoteProperty -Name "Known Folder DisplayName" -Value $KnownFolderDisplayName
					$linktargets | Add-Member -MemberType NoteProperty -Name "Known FolderID Offset" -Value $KnownFolderIDOffset
				}
				
				# SpecialFolderDataBlock
				if ($ShortcutInfo.ExtraData.SpecialFolderDataBlock)
				{
					$SpBlockSignature = $ShortcutInfo.ExtraData.SpecialFolderDataBlock.BlockSignature
					$SpecialFolderID = $ShortcutInfo.ExtraData.SpecialFolderDataBlock.SpecialFolderID
					$SpecialFolderIDOffset = $ShortcutInfo.ExtraData.SpecialFolderDataBlock.Offset
					$linktargets | Add-Member -MemberType NoteProperty -Name "Special Folder BlockSignature" -Value $SpBlockSignature
					$linktargets | Add-Member -MemberType NoteProperty -Name "Special Folder ID" -Value $SpecialFolderID
					$linktargets | Add-Member -MemberType NoteProperty -Name "Special Folder Offset" -Value $SpecialFolderIDOffset
				}
				
				# EnvironmentVariableDataBlock # HasExpString
				if ($LinkFlags.contains('HasExpString') -and $ShortcutInfo.ExtraData.EnvironmentVariableDataBlock)
				{
					$EnvBlockSignature = $ShortcutInfo.ExtraData.EnvironmentVariableDataBlock.BlockSignature
					
					$Bytes = $ShortcutInfo.ExtraData.EnvironmentVariableDataBlock.GetBytes()
					
					$BlockLength = [System.BitConverter]::ToUInt32($Bytes[0 .. 3], 0)
					$BlockSignature = [System.BitConverter]::ToString($Bytes[7 .. 4]) -replace '-', ''
					if ($BlockSignature -ne 'A0000001') { return }
					
					$TargetAnsi = [System.Text.Encoding]::UTF8.GetString($bytes[8 .. 267], 0, $bytes[8 .. 267].IndexOf([byte]0)) #(260 bytes)
					
					$TargetUnicodeHex = [System.Text.Encoding]::GetEncoding(28591).GetString($bytes[268 .. (268 + 519)])
					$UnicodeEnd = [System.Text.RegularExpressions.Regex]::Match($TargetUnicodeHex, "(\x00\x00)").index + 1
					$TargetUnicode = [System.Text.Encoding]::Unicode.GetString($bytes[268 .. (268 + 519)], 0, $UnicodeEnd) #(520 bytes)	
					
					$linktargets | Add-Member -MemberType NoteProperty -Name "Environment Variable BlockSignature" -Value $EnvBlockSignature
					$linktargets | Add-Member -MemberType NoteProperty -Name "TargetAnsi" -Value $TargetAnsi
					$linktargets | Add-Member -MemberType NoteProperty -Name "TargetUnicode" -Value $TargetUnicode
				}
				# ConsoleDataBlock
				if ($ShortcutInfo.ExtraData.ConsoleDataBlock)
				{
					$ConsoleDataBlock = $ShortcutInfo.ExtraData.ConsoleDataBlock
					if ($ConsoleDataBlock.count -ge 1)
					{
						$ConsoleData = [PSCustomObject]@{ }
						foreach ($consoleentry in ($ConsoleDataBlock | Get-Member -MemberType Property).Name)
						{
							$Centry = if ($ConsoleDataBlock.$consoleentry.GetType().BaseType.Name -match 'Array') { $ConsoleDataBlock.$consoleentry -join ',' }
							else { ($ConsoleDataBlock.$consoleentry.ToString()).Replace('\\s+', ',') }
							$ConsoleData | Add-Member -MemberType NoteProperty -Name $consoleentry -Value $Centry
						}
					}
					$linktargets | Add-Member -MemberType NoteProperty -Name "Console Data Block" -Value $ConsoleData
				}
				
				# ConsoleFEDataBlock
				if ($ShortcutInfo.ExtraData.ConsoleFEDataBlock)
				{
					# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lcid/63d3d639-7fd2-4afb-abbe-0d5b5551eef8
					$CodePage = $ShortcutInfo.ExtraData.ConsoleFEDataBlock.CodePage
					$linktargets | Add-Member -MemberType NoteProperty -Name "Console CodePage ID" -Value $CodePage
				}
				
				# TrackerDataBlock
				if ($ShortcutInfo.ExtraData.TrackerDataBlock)
				{
					# MachineID
					if (!!$ShortcutInfo.ExtraData.TrackerDataBlock.MachineID)
					{
						$machineid = $ShortcutInfo.ExtraData.TrackerDataBlock.MachineID.ToUpper()
						$linktargets | Add-Member -MemberType NoteProperty -Name "Machine Id" -Value $machineid
					}
					
					# GUIDs
					if (!!$ShortcutInfo.ExtraData.TrackerDataBlock.Droid.guid[0]) # VolumeID
					{
						$g1b = ([GUID]$ShortcutInfo.ExtraData.TrackerDataBlock.Droid.guid[0].Replace('-', '')).ToByteArray()
						$g1h = [System.BitConverter]::ToString($g1b).Replace('-', '')
						$Guid1 = Get-ObjectIdFromHex -Hex $g1h
						$linktargets | Add-Member -MemberType NoteProperty -Name "Guid 1" -Value $Guid1
					}
					if (!!$ShortcutInfo.ExtraData.TrackerDataBlock.DroidBirth.guid[0]) # Birth VolumeID
					{
						$bg1b = ([GUID]($ShortcutInfo.ExtraData.TrackerDataBlock.DroidBirth.guid[0].Replace('-', ''))).ToByteArray()
						$bg1h = [System.BitConverter]::ToString($bg1b).Replace('-', '')
						$BGuid1 = Get-ObjectIdFromHex -Hex $bg1h
						$linktargets | Add-Member -MemberType NoteProperty -Name "Birth Guid 1" -Value $BGuid1
					}
					if (!!$ShortcutInfo.ExtraData.TrackerDataBlock.Droid.guid[1]) # File ObjectID
					{
						$g2b = ([GUID]($ShortcutInfo.ExtraData.TrackerDataBlock.Droid.guid[1].Replace('-', ''))).ToByteArray()
						$g2h = [System.BitConverter]::ToString($g2b).Replace('-', '')
						$Guid2 = Get-ObjectIdFromHex -Hex $g2h
						$linktargets | Add-Member -MemberType NoteProperty -Name "Guid 2" -Value $Guid2
					}
					if (!!$ShortcutInfo.ExtraData.TrackerDataBlock.DroidBirth.guid[1]) # Birth File ObjectID
					{
						$bg2b = ([GUID]($ShortcutInfo.ExtraData.TrackerDataBlock.DroidBirth.guid[1].Replace('-', ''))).ToByteArray()
						$bg2h = [System.BitConverter]::ToString($bg2b).Replace('-', '')
						$BGuid2 = Get-ObjectIdFromHex -Hex $bg2h
						$linktargets | Add-Member -MemberType NoteProperty -Name "Birth Guid 2" -Value $BGuid2
					}
				}
				
				# ExtraData.VistaAndAboveIDListDataBlock 
				if (!!$ShortcutInfo.ExtraData.VistaAndAboveIDListDataBlock)
				{
					$VistaDisplayName = $ShortcutInfo.ExtraData.VistaAndAboveIDListDataBlock.IDList.DisplayName
					$VistaPath = $ShortcutInfo.ExtraData.VistaAndAboveIDListDataBlock.IDList.Path
					$linktargets | Add-Member -MemberType NoteProperty -Name "Vista_Path" -Value $VistaPath
					$linktargets | Add-Member -MemberType NoteProperty -Name "Vista_DisplayName" -Value $VistaDisplayName
					
					# Add the raw data	
					$VistaItemIdListItems = [System.Collections.ArrayList]::new()
					if ($ShortcutInfo.ExtraData.VistaAndAboveIDListDataBlock.IDList.ItemIDList.Count -ge 1)
					{
						foreach ($VistaItemIdListItem in $ShortcutInfo.ExtraData.VistaAndAboveIDListDataBlock.IDList.ItemIDList)
						{
							$VistalinkItem = Get-LinkTargetIDList -ItemIdListItem $VistaItemIdListItem
							$null = $VistaItemIdListItems.Add($VistalinkItem)
						} # End for each#>
					} # end if count ge 1
					else { $VistaItemIdListItems = $null }
					$linktargets | Add-Member -MemberType NoteProperty -Name "VistaItemIdListItems" -Value $VistaItemIdListItems
				}
				
				# HasExpIcon
				if ($LinkFlags.contains('HasExpIcon'))
				{
					$iconbytes = $ShortcutInfo.ExtraData.IconEnvironmentDataBlock.GetBytes()
					if ($iconbytes.count -ge 788)
					{
						$iconTargetAnsi = ([System.Text.Encoding]::GetEncoding(1252).GetString($iconbytes[8 .. 267]) -Split '\0')[0]
						$iconTargetUnicode = ([System.Text.Encoding]::Unicode.GetString($iconbytes[268 .. (268 + 520 - 1)]) -Split '\0')[0]
						$linktargets | Add-Member -MemberType NoteProperty -Name "iconTargetAnsi" -Value $iconTargetAnsi
						$linktargets | Add-Member -MemberType NoteProperty -Name "iconTargetUnicode" -Value $iconTargetUnicode
					}
					
				}
			}
			# For debug	
			# Show-InfoMessage -InfoMessage ($linktargets|Out-String)
		}
		catch
		{
			$linktargets = $null
		}
		
		return $linktargets
	} # End function Get-ShellLinkfrombyteArray
	
	function Get-SafePath
	{
		param
		(
			[Parameter(Mandatory = $true,
					   ValueFromPipeline = $true,
					   Position = 0)]
			[object]$Path,
			[Parameter(Mandatory = $false)]
			$Char = '~'
		)
		
		process
		{
			$pattern = "[" + (([System.IO.Path]::GetInvalidFileNameChars().foreach{ "\x" + ([int]$_).ToString('X2') }) -join '') + "]+"
			[regex]::Replace($Path, $pattern, $Char)
		}
	} # Get-SafePath
	
	# There is a shell API for the SHOpenWithDialog function
	Add-Type -TypeDefinition @'

    using System;
    using System.Runtime.InteropServices;

    public class ShellOpenWith {

        [DllImport("shell32.dll", EntryPoint = "SHOpenWithDialog", CharSet = CharSet.Unicode)]
        private static extern int SHOpenWithDialog(IntPtr hWndParent, ref tagOPENASINFO oOAI);

        // https://learn.microsoft.com/en-us/windows/win32/api/shlobj_core/ns-shlobj_core-openasinfo
        private struct tagOPENASINFO
        {
            [MarshalAs(UnmanagedType.LPWStr)]
            public string cszFile;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string cszClass;

            [MarshalAs(UnmanagedType.I4)]
            public tagOPEN_AS_INFO_FLAGS oaifInFlags;
        }

        [Flags]
        private enum tagOPEN_AS_INFO_FLAGS
        {
            OAIF_ALLOW_REGISTRATION =  0x00000001,   // Show "Always" checkbox
            OAIF_REGISTER_EXT =    0x00000002,   // Perform registration when user hits OK
            OAIF_EXEC =        0x00000004,   // Exec file after registering
            OAIF_FORCE_REGISTRATION =  0x00000008,   // Force the checkbox to be registration
            OAIF_HIDE_REGISTRATION =   0x00000020,   // Vista+: Hide the "always use this file" checkbox
            OAIF_URL_PROTOCOL =    0x00000040,   // Vista+: cszFile is actually a URI scheme; show handlers for that scheme
            OAIF_FILE_IS_URI =     0x00000080    // Win8+: The location pointed to by the pcszFile parameter is given as a URI
        }

        public static void DoOpenFileWith(string sFilename, IntPtr hwndParent = new IntPtr())
        {
            tagOPENASINFO oOAI = new tagOPENASINFO();
            oOAI.cszFile = sFilename;
            oOAI.cszClass = String.Empty;
            oOAI.oaifInFlags = tagOPEN_AS_INFO_FLAGS.OAIF_ALLOW_REGISTRATION | tagOPEN_AS_INFO_FLAGS.OAIF_EXEC;
            SHOpenWithDialog(hwndParent, ref oOAI);
        }    
    }
'@
	
	<#
	    .SYNOPSIS
		Retrieves the last write time of the supplied registry key
	
		.DESCRIPTION
		The Registry data that a hive stores in containers are called cells. A cell 
		can hold a key, a value, a security descriptor, a list of subkeys, or a 
		list of key values.
	
		Get-RegKeyLastWriteTime retrieves the LastWriteTime through a pointer to the
		FILETIME structure that receives the time at which the enumerated subkey was
		last written. Values do not contain a LastWriteTime property, but changes to
		child values update the parent keys lpftLastWriteTime.
		
		The LastWriteTime is updated when a key is created, modified, accessed, or
		deleted.
	
		.PARAMETER ComputerName
		Computer name to query
	
		.PARAMETER Key
		Root Key to query
	
		HKCR - Symbolic link to HKEY_LOCAL_MACHINE \SOFTWARE \Classes.
		HKCU - Symbolic link to a key under HKEY_USERS representing a user's profile
		hive.
		HKLM - Placeholder with no corresponding physical hive. This key contains
		other keys that are hives.
		HKU  - Placeholder that contains the user-profile hives of logged-on
		accounts.
		HKCC - Symbolic link to the key of the current hardware profile
	
		.PARAMETER SubKey
		Registry Key to query
	
		.EXAMPLE
		Get-RegKeyLastWriteTime -ComputerName testwks -Key HKLM -SubKey Software
	
	        .EXAMPLE
		Get-RegKeyLastWriteTime -ComputerName testwks1,testwks2 -SubKey Software
	
		.EXAMPLE
		Get-RegKeyLastWriteTime -SubKey Software\Microsoft
	
		.EXAMPLE
		"testwks1","testwks2" | Get-RegKeyLastWriteTime -SubKey Software\Microsoft `
		\Windows\CurrentVersion
	
		.NOTES
		NAME: Get-RegKeyLastWriteTime
		AUTHOR: Shaun Hess
		VERSION: 1.0
		LASTEDIT: 01JUL2011
		LICENSE: Creative Commons Attribution 3.0 Unported License
		(http://creativecommons.org/licenses/by/3.0/)
	
		.LINK
		http://www.shaunhess.com
		#>
	function Get-RegKeyLastWriteTime # Modified
	{
		[CmdletBinding()]
		param (
			[parameter(
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true)]
			[Alias("CN", "__SERVER", "Computer", "CNAME")]
			[string[]]$ComputerName = $env:ComputerName,
			[string]$Key = "HKCU",
			[string]$SubKey
		)
		
		BEGIN
		{
			switch ($Key)
			{
				"HKCR" { $searchKey = 0x80000000 } #HK Classes Root            
				"HKCU" { $searchKey = 0x80000001 } #HK Current User            
				"HKLM" { $searchKey = 0x80000002 } #HK Local Machine            
				"HKU"  { $searchKey = 0x80000003 } #HK Users            
				"HKCC" { $searchKey = 0x80000005 } #HK Current Config            
				default {
					"Invalid Key. Use one of the following options:
			HKCR, HKCU, HKLM, HKU, HKCC"
				}
			}
			
			$KEYQUERYVALUE = 0x1
			$KEYREAD = 0x19
			$KEYALLACCESS = 0x3F
		}
		PROCESS
		{
			foreach ($computer in $ComputerName)
			{
				
				$sig0 = @'
[DllImport("advapi32.dll", SetLastError = true)]
  public static extern int RegConnectRegistry(
  	string lpMachineName,
	int hkey,
	ref int phkResult);
'@
				$type0 = Add-Type -MemberDefinition $sig0 -Name Win32Utils -Namespace RegConnectRegistry -Using System.Text -PassThru
				
				$sig1 = @'
[DllImport("advapi32.dll", CharSet = CharSet.Auto)]
  public static extern int RegOpenKeyEx(
    int hKey,
    string subKey,
    int ulOptions,
    int samDesired,
    out int hkResult);
'@
				$type1 = Add-Type -MemberDefinition $sig1 -Name Win32Utils `
								  -Namespace RegOpenKeyEx -Using System.Text -PassThru
				
				$sig2 = @'
[DllImport("advapi32.dll", EntryPoint = "RegEnumKeyEx")]
extern public static int RegEnumKeyEx(
    int hkey,
    int index,
    StringBuilder lpName,
    ref int lpcbName,
    int reserved,
    int lpClass,
    int lpcbClass,
    out long lpftLastWriteTime);


'@
				$type2 = Add-Type -MemberDefinition $sig2 -Name Win32Utils `
								  -Namespace RegEnumKeyEx -Using System.Text -PassThru
				
				$sig3 = @'
[DllImport("advapi32.dll", SetLastError=true)]
public static extern int RegCloseKey(
    int hKey);
'@
				$type3 = Add-Type -MemberDefinition $sig3 -Name Win32Utils -Namespace RegCloseKey -Using System.Text -PassThru
				
				
				$hKey = new-object int
				$hKeyref = new-object int
				$searchKeyRemote = $type0::RegConnectRegistry($computer, $searchKey, [ref]$hKey)
				$result = $type1::RegOpenKeyEx($hKey, $SubKey, 0, $KEYREAD, [ref]$hKeyref)
				
				#initialize variables            
				$builder = New-Object System.Text.StringBuilder 1024
				$index = 0
				$length = [int] 1024
				$time = New-Object Long
				$Timestamps = [System.Collections.Hashtable]::new()
				#234 means more info, 0 means success. Either way, keep reading            
				while (0, 234 -contains $type2::RegEnumKeyEx($hKeyref, $index++ , $builder, [ref]$length, $null, $null, $null, [ref]$time))
				{
					#create output object            
					$o = "" | Select Key, LastWriteTime
					# Don't need the Computername
					# $o.ComputerName = "$computer"
					$o.Key = $builder.ToString() # key name 
					$o.LastWriteTime = [datetime]::FromFileTimeUtc($time).ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
					$null = $Timestamps.Add($o.Key, $o.LastWriteTime)
					#reinitialize for next time through the loop            
					$length = [int] 1024
					$builder = New-Object System.Text.StringBuilder 1024
				}
				
				$result = $type3::RegCloseKey($hKey)
				return $Timestamps
			}
		}
	} # End Get-RegKeyLastWriteTime function
	
	function Get-Files
	{
		[CmdletBinding()]
		param
		(
			[Parameter(Mandatory = $true)]
			$Folder
		)
		
		try
		{
			$Status.Text = "Please wait ..."
			$dirFiles = [System.IO.Directory]::GetFiles("$($Folder)", "*", [System.IO.SearchOption]::AllDirectories).Where{ [System.IO.FileInfo]::new($_).Extension -in ('.lnk', '.customDestinations-ms', '.automaticDestinations-ms', '.temp') } 
			# Get File Properties
			$Script:AppListIdx = [System.Collections.Hashtable]::New()
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			if ($Tree1Search.Items.Count -gt 0)
			{
				$Tree1Search.Items.Clear()
			}
			$files = @(foreach ($file in $dirFiles)
			{
				[System.Windows.Forms.Application]::DoEvents()
				
				if (![System.IO.FileInfo]::new($file).Exists)
				{
					continue
				}
				
				# Replace known AppID with it's Name
				$fname = Split-Path -Path $file -leaf
				$AppName = $null
				
				# Add known App Name
				foreach ($i in $AppIDs.Keys)
				{
					if ($fname -match "$($i)")
					{
						$AppName = $AppIDs[$i].ToString()
						$t = $Tree1Search.Items.Add($AppName)
						$null = $Script:AppListIdx.Add($t, $file)
						break
					}
				} # end for each Appid
				
				# Add A.D.Streams
				try
				{
					$StreamName = [System.Collections.ArrayList]::new()
					if (!!((Get-Item $file -Stream * -Force -ErrorAction SilentlyContinue).Stream -ne ':$DATA'))
					{
						$null = $StreamName.Add((Get-Item $file -Stream * -Force -ErrorAction SilentlyContinue).Stream -ne ':$DATA')
					}
				}
				catch { $StreamName = [System.Collections.ArrayList]::new() }
					
				[PSCustomObject][Ordered]@{
					'FileName' = $file
					'Name'	   = $fname
					'AppName'  = $AppName
					'Parent'   = Split-Path -Path $file -Parent
					'CreationTimeUtc' = [System.IO.File]::GetCreationTimeUtc($file)
					'LastAccessTimeUtc' = [System.IO.File]::GetLastAccessTimeUtc($file)
					'LastWriteTimeUtc' = [System.IO.File]::GetLastWriteTimeUtc($file)
					'Attributes' = [System.IO.File]::GetAttributes($file)
					'Size'	   = [System.IO.FileInfo]::new($file).Length
					'ADS_Stream' = if (!!$StreamName) { $StreamName } else { $null }
				}
				
			}) # end for each
			
		} # end try
		catch { $files = $null }
		
		if ($files.Count -ge 1)
		{
			$Status.Text = "LNK/*-ms Files: $($files.count) "
			Add-fileNodes -Files $files -RootFolder "$($Folder)"
			
			if ($Tree1Search.Items.Count -ge 1)
			{
				$Tree1Search.Visible = $true
			}
			else
			{
				$Tree1Search.Visible = $false
			}
			return $true
		}
		else
		{
			$Status.Text = "NO LNK/*-ms Files found in $($Folder)"
			[System.Console]::Beep(500, 150)
			return $false
		}
		
	} # End get-files
	
	function Add-Directories
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$RootNode,
			[Parameter(Mandatory = $true)]
			$Directories
		)
		
		foreach ($Directory in $Directories)
		{
			$lastNode = $null
			$subPathAgg = ""
			$Status.Text = "Please wait - Creating Directory structure"
			foreach ($subPath in $Directory.split('\\'))
			{
				$subPathAgg += ($subPath + '\')
				$nodes = $RootNode.Nodes.Find($subPathAgg.TrimEnd('\'), $true)
				[System.Windows.Forms.Application]::DoEvents()
				if ($nodes.Length -eq 0)
				{
					if ($lastNode -eq $null)
					{
						$lastNode = $RootNode.Nodes.Add($subPathAgg.TrimEnd('\'), $subPath)
						$lastNode.TooltipText = "$($subPathAgg.TrimEnd('\'))"
						$lastNode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
						$lastNode.ForeColor = 'DodgerBlue'
						$lastNode.ImageIndex = 1
						$lastNode.SelectedImageIndex = 2
					}
					else
					{
						$lastNode = $lastNode.Nodes.Add($subPathAgg.TrimEnd('\'), $subPath)
						$lastNode.TooltipText = "$($subPathAgg.TrimEnd('\'))"
						$lastNode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
						$lastNode.ForeColor = 'DodgerBlue'
						$lastNode.ImageIndex = 1
						$lastNode.SelectedImageIndex = 2
					}
					if ($subPath -match 'CustomDestinations')
					{
						$lastNode.ToolTipText = 'Tasks + Features'
					}
					elseif ($subPath -match 'AutomaticDestinations')
					{
						$lastNode.ToolTipText = 'Recent + Pinned'
					}
				}
				else
				{
					$lastNode = $nodes[0]
					$lastNode.TooltipText = "$($subPathAgg.TrimEnd('\'))"
					$lastNode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
					$lastNode.ForeColor = 'DodgerBlue'
					$lastNode.ImageIndex = 1
					$lastNode.SelectedImageIndex = 2
				}
			}
		}
	} # End Add-Directories
	
	function Add-fileNodes
	{
		[CmdletBinding()]
		param
		(
			[Parameter(Mandatory = $true)]
			$Files,
			[Parameter(Mandatory = $true)]
			$RootFolder
		)
		
		$treeview1.BeginUpdate()
		$treeview1.Nodes.Clear()
		$treeview2.Nodes.Clear()
		$treeview2.ImageList = $null
		[System.GC]::Collect()
		$rootfoldername = Split-Path -Path $RootFolder -Leaf
		$Root = $treeview1.Nodes.Add("$($RootFolder)", "$($RootFolder)")
		$Root.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
		$Root.ForeColor = 'DarkTurquoise'
		$Root.ImageIndex = 1
		$Root.SelectedImageIndex = 2
		
		if ($files.Count -ge 1)
		{
			# Get Directories
			$dirs = foreach ($dir in $Files.Parent)
			{
				if ([System.IO.DirectoryInfo]::new($dir).Exists)
				{
					try { $dir.Replace("$(Split-Path -path $RootFolder -Parent)", '').Trimstart("\") }
					catch { continue }
				}
			}
			$dirs = $dirs | sort -Unique
			# Add Directories
			if ($dirs.count -ge 1)
			{
				Add-Directories -RootNode $Root -Directories $dirs
			}
			
			# Add Files
			$i = 1
			$files = ($files | sort -Property LastWriteTimeUtc -Descending)
			foreach ($file in $files)
			{
				$fname = $file.Name
				$parent = $file.Parent
				try { $filep = $parent.Replace("$(Split-Path -path $RootFolder -Parent)", '').Trimstart("\") }
				catch { $filep = $parent }
				$node = $Root.Nodes.Find("$($filep)", $true)
				if (!!$node) { $ParentNode = $node[0] }
				else { $ParentNode = $Root }
				
				# Add File
				$filenode = $ParentNode.Nodes.Add("$($file.Filename)", "$($fname)")
				$filenode.Tag = @("$($file.Filename)")
				$Status.Text = "Please wait - Populating Directory Tree with Files: $($i)/$($files.count)"
				$i++
				[System.Windows.Forms.Application]::DoEvents()
				
				# Get associated icon for the file
				try
				{
					if ($file.Filename.length -le 260 -and $file.Attributes -notmatch 'Directory')
					{
						$handle = [System.Drawing.Icon]::ExtractAssociatedIcon("$($file.Filename)").Handle
						$icon = [System.Drawing.Icon]::FromHandle($handle)
					}
				}
				catch
				{
					Show-ErrorMessage -ErrorMessage "$($file.Filename)`n$($Error[0].Exception.InnerException.Message)"
					$Error.Clear()
				}
				if (!!$icon -and $icon.Height -ne 0)
				{
					try
					{
						$newkey = $handle.ToString()
						if (!$treeview1.ImageList.Images.ContainsKey($newkey))
						{
							$null = $treeview1.ImageList.Images.Add($newkey, $icon.ToBitmap())
						}
						$filenode.ImageIndex = $treeview1.ImageList.Images.IndexOfKey($newkey)
						$filenode.SelectedImageIndex = $treeview1.ImageList.Images.IndexOfKey($newkey)
					}
					catch
					{
						$filenode.ImageIndex = 11
						$filenode.SelectedImageIndex = 12
					}
				}
				else
				{
					$filenode.ImageIndex = 11
					$filenode.SelectedImageIndex = 12
				}
				if ($file.AppName -ne $null)
				{
					$filenode.ToolTipText = "$($file.AppName)"
					$filenode.ForeColor = 'LightGreen'
					$filenode.Text = "$($file.AppName)"
					$null = $filenode.Nodes.Add("FileName", "FileName: $($fname)")
					$AppNameNode = $filenode.Nodes.Add("AppName", "AppName: $($file.AppName)")
					$AppNameNode.ForeColor = 'Yellow'
				}
				
				if ($file.Size -lt 76)
				{
					$filenode.ForeColor = 'DimGray'
					$filenode.Tooltiptext = "$($file.Name) is too small"
				}
				# Add the FileSystem Info Properties
				try
				{
					$CreationTimeUtc = $file.CreationTimeUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
					$LastAccessTimeUtc = $file.LastAccessTimeUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
					$LastWriteTimeUtc = $file.LastWriteTimeUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff")
					$Attributes = $file.Attributes
					$Length = $file.Size.Tostring('N0')
					
					# Add Child Nodes
					$null = $filenode.Nodes.Add("CreationTimeUtc", "CreationTimeUtc: $($CreationTimeUtc)")
					$null = $filenode.Nodes.Add("LastAccessTimeUtc", "LastAccessTimeUtc: $($LastAccessTimeUtc)")
					$null = $filenode.Nodes.Add("LastWriteTimeUtc", "LastWriteTimeUtc: $($LastWriteTimeUtc)")
					$null = $filenode.Nodes.Add("Attributes", "Attributes: $($Attributes) ")
					$null = $filenode.Nodes.Add("Length", "File Size: $($Length)")
					$filenode.Nodes["CreationTimeUtc"].ImageIndex = 17
					$filenode.Nodes["LastAccessTimeUtc"].ImageIndex = 17
					$filenode.Nodes["LastWriteTimeUtc"].ImageIndex = 17
					$filenode.Nodes["Attributes"].ImageIndex = 13
					$filenode.Nodes["Length"].ImageIndex = 13
					$filenode.Nodes["CreationTimeUtc"].SelectedImageIndex = 18
					$filenode.Nodes["LastAccessTimeUtc"].SelectedImageIndex = 18
					$filenode.Nodes["LastWriteTimeUtc"].SelectedImageIndex = 18
					$filenode.Nodes["Attributes"].SelectedImageIndex = 13
					$filenode.Nodes["Length"].SelectedImageIndex = 13
					
					try
					{
						if (!!$file.ADS_Stream)
						{
							foreach ($stream in $file.ADS_Stream)
							{
								$null = $filenode.Nodes.Add("Stream Name $($stream)", "Stream Name: $($stream)")
								$filenode.Nodes["Stream Name $($stream)"].ForeColor = 'Tomato'
								$filenode.Nodes["Stream Name $($stream)"].Tag = @("$($file.Filename):$($stream)")
								$filenode.Nodes["Stream Name $($stream)"].ImageIndex = 13
							}
						}
					}
					catch { $null }
				}
				catch { $null }
			}
		}
		
		$treeview1.EndUpdate()
		if (!!$treeview1.Nodes)
		{
			# $Root.Expand()
			if ($treeview1.GetNodeCount($false) -eq 1)
			{
				$treeview1.Nodes[0].Expand()
				if ($treeview1.Nodes[0].GetNodeCount($true) -ge 1)
				{
					$treeview1.Nodes[0].Nodes[0].Expand()
				}
			}
		
		}
		else
		{
			[System.Console]::Beep(500, 150)
		}
		$Status.Text = 'Ready'
	} # End Add-fileNodes
	
	function Process-Link
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$File,
			[System.Windows.Forms.TreeNode]$Root2,
			$FileOffset,
			$CustomLength,
			$GroupCount,
			[System.Boolean]$Custom = $false
		)
		
		# Clear tree
		$TreeSearchState = $TreeSearch.Visible
		if (!$Root2)
		{
			$treeview2.Nodes.Clear()
			$TreeSearch.Visible = $false
		}
		else
		{
			$TreeSearch.Visible = $TreeSearchState
		}
		
		# Get File Size
		$fname = Split-Path -Path "$($File)" -Leaf
		try
		{
			$fileinfo = [System.IO.FileInfo]::new("$($File)")
			if ($fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::Offline) -or $fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::ReparsePoint))
			{
				$Status.Text = "$($fname) has flags:  $($fileinfo.Attributes)"
				[System.Console]::Beep(500, 150)
				return
			}
			$fs = $fileinfo.Length
		}
		catch
		{
			$Status.Text = "Can not get the File Size of $($fname)"
			[System.Console]::Beep(500, 150)
			return
		}
		
		if ($fs -lt 76) # Minimum Header Size (0x4C = 76)
		{
			$Status.Text = "$($fname) is too small"
			[System.Console]::Beep(500, 150)
			return
		}
		
		$Status.Text = "Selected file: $($fname)"
		# Read the File & search for LNKs
		$dataoffsets = New-Object System.Collections.Generic.List[uint64]
		
		# Search for valid header size (0x0000004C) and LinkCLSID (00021401-0000-0000-C000-000000000046)
		# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/c3376b21-0931-45e4-b2fc-a48ac0e60d15
		[System.Text.RegularExpressions.Regex]$regex = "(\x4C\x00\x00\x00\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46)"
		
		if ($null -ne $FileOffset -and $null -ne $CustomLength)
		{
			#Open file & read the Header
			$FileStream = New-Object IO.FileStream($File, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::ReadWrite))
			$Status.Text = "Please wait - searching for LNK Signatures .."
			# Set offset to read from the file
			$null = $FileStream.Seek($FileOffset, [System.IO.SeekOrigin]::Begin)
			# Initialize the buffer 
			$buffer = [System.Byte[]]::new($CustomLength)
			# Read offset to the buffer
			$null = $FileStream.Read($buffer, 0, $CustomLength)
			# Find LNK records
			$bufferstring = [System.Text.Encoding]::GetEncoding(28591).GetString($buffer)
			if (!!($regex.Matches($bufferstring).success))
			{
				foreach ($match in $regex.Matches($bufferstring))
				{
					$null = $dataoffsets.Add((($FileOffset) + ($match.index)))
				}
			}
			$FileStream.Dispose()
			$bufferstring = $null
			$buffersize = $CustomLength
			[System.GC]::Collect()
		}
		else
		{
			if ($fs -gt 536870912)
			{
				$buffersize = 4096 * 1024
				$list = (0 .. [math]::Ceiling($fs/$buffersize))
			}
			else
			{
				$buffersize = $fs
				$list = [int]0
			}
			
			$FileStream = New-Object IO.FileStream($File, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::ReadWrite))
			foreach ($step in $list)
			{
				[System.Windows.Forms.Application]::DoEvents()
				$Status.Text = "Please wait - searching for LNK Signatures .."
				# Set offset to read from the file
				if ($step * $buffersize -gt $fs) { $buffersize = $buffersize - ($fs % $buffersize) }
				$null = $FileStream.Seek([UInt64]($step * $buffersize), [System.IO.SeekOrigin]::Begin)
				# Initialize the buffer 
				$buffer = [System.Byte[]]::new($buffersize)
				# Read offset to the buffer
				$null = $FileStream.Read($buffer, 0, $buffersize)
				# Find LNK records
				$bufferstring = [System.Text.Encoding]::GetEncoding(28591).GetString($buffer)
				
				if (!!($regex.Matches($bufferstring).success))
				{
					foreach ($match in $regex.Matches($bufferstring))
					{
						$null = $dataoffsets.Add((($step * $buffersize) + ($match.index)))
					}
				}
			}
			$FileStream.Dispose()
			$bufferstring = $null
			[System.GC]::Collect()
		}
		$dcount = $dataoffsets.Count
		if (!!$GroupCount -and $GroupCount -lt $dcount)
		{
			$dcount = $GroupCount
		}
		if ($dcount -eq 0)
		{
			[System.Console]::Beep(500, 150)
			$Status.Text = "Nothing to see in $($fname)"
			return
		}
		elseif ($dcount -ge 1)
		{
			$offsets = for ($r = 0; $r -lt $dcount; $r++)
			{
				$length = if ($r -eq ($dcount - 1)) { $buffersize - $dataoffsets[$r] }
				elseif (($r + 1) -ge $dcount) { $fs - $dataoffsets[$r] }
				else { $dataoffsets[$r + 1] - $dataoffsets[$r] }
				# check
				if ($length -eq 0 -or $length -gt $buffersize -or $length -lt 76) { continue }
				if ($length -ge [System.UInt32]::MaxValue) { $length = ([System.UInt32]::MaxValue - 1) }
				
				[PSCustomObject]@{
					'Start' = [UInt32]$dataoffsets[$r]
					'Length' = $length
				}
				if ($r -eq ($dcount - 1)) { break }
			}
			
			$Status.Text = "Found $($dcount) LNK Signature matches"
			
			# Update Tree
			$treeview2.BeginUpdate()
			# Add Root branch
			if (!$Root2)
			{
				$Root2 = $treeview2.Nodes.Add("Root", "$($fname)")
			}
			
			$Root2.ToolTipText = "$($File)"
			
			$o = 0
			$FileStream = New-Object IO.FileStream($File, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::ReadWrite))
			$timer = [system.Diagnostics.Stopwatch]::StartNew()
			foreach ($offset in $offsets)
			{
				# Just in case
				if (($offset.start + $offset.Length - 1) -gt $fs -or !$offset.Length -or $offset.Length -ge [System.Int32]::MaxValue) { continue }
				# Get the data from the offset
				$null = $FileStream.Seek([UInt32]($offset.start), [System.IO.SeekOrigin]::Begin)
				# Initialize the buffer 
				$buffer = [System.Byte[]]::new([UInt32]$offset.Length)
				# Read offset to the buffer
				$null = $FileStream.Read($buffer, 0, [UInt32]$offset.Length)
				$data = $buffer
				
				if (!!$data)
				{
					$Status.Text = "Please wait - Processing LNK #$($o)"
					if ($offsets.count -gt 1) { $Status.Text = "$($Status.Text) of #$($offsets.count)" }
					try
					{
						$timer.Start()
						for ($i = ($data.Length - 1); $i -gt 75; $i--)
						{
							[System.Windows.Forms.Application]::DoEvents()
							$Status.Text = "Please wait - Trying to parse LNK #$($o)"
							if (!!($LNKData = Get-ShellLinkfrombyteArray -ByteArray $data[0..$i]))
							{
								$ShellLink_data = $data[0 .. $i]
								$Status.Text = "LNK #$($o) => Offset Start: $($offset.Start.ToString('D5')) - Length: $($i)"
								$timer.Reset()
								break
							}
							elseif ($timer.Elapsed.Seconds -ge 10 -or $i -eq 76)
							{
								$Status.Text = "Please wait - Trying to get the LNK #$($o) Header"
								if (!!($LNKData = Get-ShellLinkHeaderfrombyteArray -ByteArray $data)) # Try to get just the header
								{
									$ShellLink_data = $data[0 .. 75]
									$timer.Reset()
									break
								}
								else
								{
									$timer.Reset()
									$Status.Text = $LNKData = $null
									break
								}
							}
						}
						$timer.Reset()
					}
					catch [System.Management.Automation.MethodInvocationException] {
						if ($offsets.count -eq 1)
						{
							Show-ErrorMessage -ErrorMessage "[ShellLink] $($Error[0].Exception.InnerException.Message)"
						}
						else
						{
							$Status.Text = "Offset: $($offset) - $($Error[0].Exception.InnerException.Message)"
							$LNKNode = $Root2.Nodes.Add("LNK #$($o)", "[$($offset.Start.ToString('D5'))] LNK #$($o.ToString('D3')) ")
							$Root2.Nodes["LNK #$($o)"].ForeColor = 'IndianRed'
							$Root2.Nodes["LNK #$($o)"].Tag = @([System.BitConverter]::ToString($data) -replace '-', '')
							# $Root2.Nodes["LNK #$($o)"].ToolTipText = "LNK Signature @ Offset: $($offset.Start) - Data Length: $($offset.Length)`n$($Error[0].Exception.InnerException.Message)"
						}
						$Error.Clear()
						$LNKData = $null
						$treeview2.EndUpdate()
						$o = $o + 1
						continue
					}
					catch
					{
						$LNKData = $null
						$Error.Clear()
						$treeview2.EndUpdate()
						if ($offsets.count -gt 1)
						{
							$Status.Text = "Error processing LNK #$($o) at Offset: $($offset.Start.ToString('D5')) as a ShellLNK"
						}
						else
						{
							$Status.Text = "Error processing $($fname) as a ShellLNK"
						}
						$o = $o + 1
						continue
					}
				}
				else { $LNKData -eq $null }
				
				if (!!$LNKData)
				{
					if ($offsets.count -ge 2)
					{
						Populate-LNKData -LNKData $LNKData -offset $offset -o $o -Node $Root2 -ShellLink_data $ShellLink_data
					}
					else
					{
						Populate-LNKData -LNKData $LNKData -offset $offset -Node $Root2 -ShellLink_data $ShellLink_data -Single $true
					}
				}
				else
				{
					$LNKNode = $Root2.Nodes.Add("LNK #$($o)", "[$($offset.Start.ToString('D5'))] LNK #$($o.ToString('D3')) ")
					$Root2.Nodes["LNK #$($o)"].ForeColor = 'IndianRed'
					$Root2.Nodes["LNK #$($o)"].Tag = @([System.BitConverter]::ToString($data).Replace('-', ''))
				}
				$o = $o + 1
			}
			$FileStream.Dispose()
			$treeview2.EndUpdate()
	
			if (!$Custom)
			{
				if ($treeview2.Nodes[0].Nodes.Count -ge 1)
				{
					$TreeSearch.Visible = $true
					if ($dcount -eq 1)
					{
						$treeview2.Nodes[0].Expand()
						$treeview2.Nodes[0].Nodes[0 .. 2].Expand()
					}
					elseif ($dcount -gt 1)
					{
						$treeview2.Nodes[0].Expand()
						$treeview2.Nodes[0].Nodes[1].FirstNode.Expand()
					}
					$Status.Text = "Ready"
				}
				else
				{ $TreeSearch.Visible = $false }
			}
		}
		else
		{
			[System.Console]::Beep(500, 150)
			$Status.Text = "Nothing to see in $($fname)"
		}
	} # End Process-Link
	
	function Get-IDListDisplayName
	{
		param
		(
			[Parameter(Mandatory = $false)]
			$itemIDlist,
			[Parameter(Mandatory = $true)]
			$LNKData
		)
		try
		{
			
			$ShowName = if (!!$LNKData -and !!$LNKData.'NameString') { $LNKData.'NameString' }
					elseif (!!$LNKData -and @($LNKData.PropertyStoreEntries.TypedProperty).count -ge 1 -and @($LNKData.PropertyStoreEntries.TypedProperty).Where{ $_.Description -eq 'Title [F29F85E0-4FF9-1068-AB91-08002B27B3D9\2]' }.count -ge 1)
					{
						@($LNKData.PropertyStoreEntries.TypedProperty).Where{ $_.Description -eq 'Title [F29F85E0-4FF9-1068-AB91-08002B27B3D9\2]' }[0].TypedProp.Value
					}
					elseif (!!$LNKData -and !!$LNKData.'Display Name') { $LNKData.'Display Name' }
					elseif (!!$LNKData -and !!$LNKData.TargetUnicode) { $LNKData.TargetUnicode }
					elseif (!!$itemIDlist)
					{
						$ic = $itemIDlist.Count
						if (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
						elseif (!!$itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
						elseif (!!$itemIDlist[$ic - 1].URI) { Get-SafePath -Path "$($itemIDlist[$ic - 1].URI)" -Char '~' }
						elseif (!!$itemIDlist[$ic - 1].CPcategory -and !($itemIDlist[$ic - 1].CPcategory).StartsWith('[')) { ($itemIDlist[$ic - 1].CPcategory).Split('[')[0] }
						elseif (!!$itemIDlist[$ic - 1].CPcategory -and !!($itemIDlist[$ic - 1].CPcategory).StartsWith('[')) { $itemIDlist[$ic - 1].CPcategory }
						elseif (!!$itemIDlist.PropertyStoreEntries.TypedProperty -and $itemIDlist.PropertyStoreEntries.TypedProperty.count -ge 1)
						{
							if ($itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ParsingName [28636AA6-953D-11D2-B5D6-00C04FD918D0\24]' }.count -ge 1)
							{
								$c = $itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ParsingName [28636AA6-953D-11D2-B5D6-00C04FD918D0\24]' }.count
								$itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ParsingName [28636AA6-953D-11D2-B5D6-00C04FD918D0\24]' }[$c - 1].TypedProp.Value
							}
							elseif ($itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }.count -ge 1)
							{
								$c = $itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }.count
								$itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }[$c - 1].TypedProp.Value
							}
							elseif ($itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }.count -ge 1)
							{
								$c = $itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }.count
								$itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }[$c - 1].TypedProp.Value
							}
							elseif ($itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }.count -ge 1)
							{
								$c = $itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }.count
								$itemIDlist.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }[$c - 1].TypedProp.Value
							}
						}
						elseif (!!$itemIDlist[$ic - 1].CLSID -and !($itemIDlist[$ic - 1].CLSID).StartsWith('[')) { ($itemIDlist[$ic - 1].CLSID).Split('[')[0] }
						elseif (!!$itemIDlist[$ic - 1].CLSID -and !!($itemIDlist[$ic - 1].CLSID).StartsWith('[')) { $itemIDlist[$ic - 1].CLSID }
						elseif (!!$itemIDlist[$ic - 1].GUID) { $itemIDlist[$ic - 1].GUID }
						elseif (!!$itemIDlist[$ic - 1].SortOrderIndex) { $itemIDlist[$ic - 1].SortOrderIndex }
						elseif (!!$itemIDlist[$ic - 1].DriveLetter) { $itemIDlist[$ic - 1].DriveLetter }
					}
					elseif (!!$LNKData -and !!$LNKData.TargetAnsi) { $LNKData.TargetAnsi }
					elseif (!!$LNKData -and !!$LNKData.'Local Base Path') { Split-Path -Path $LNKData.'Local Base Path' -Leaf }
					elseif (!!$LNKData -and !!$LNKData.CommonPathSuffix) { Split-Path -Path $LNKData.CommonPathSuffix -Leaf }
					elseif (!!$LNKData -and !!$LNKData.NameString) { $LNKData.NameString }
					elseif (!!$LNKData -and !!$LNKData.NetName) { $LNKData.NetName }
					else { $null }
		}
		catch
		{
			$null = $ShowName
		}
		return $ShowName
	} # End Get-IDListDisplayName
	
	function Populate-LNKData
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$LNKData,
			[Parameter(Mandatory = $false)]
			$offset,
			[Parameter(Mandatory = $false)]
			$o,
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Node,
			[Parameter(Mandatory = $false)]
			$StreamName,
			[Parameter(Mandatory = $true)]
			[System.Byte[]]$ShellLink_data,
			[System.Boolean]$Single = $false
		)
		
		$data = $ShellLink_data
		
		try
		{
			$ShowName = if (!!$LNKData.ItemIdListItems)
						{
							Get-IDListDisplayName -itemIDlist @($LNKData.ItemIdListItems) -LNKData $LNKData
						}
						elseif (!!$LNKData.VistaItemIdListItems)
						{
							Get-IDListDisplayName -itemIDlist @($LNKData.VistaItemIdListItems) -LNKData $LNKData
						}
						else
						{
							Get-IDListDisplayName -LNKData $LNKData 
						}
		}
		catch
		{
			$ShowName = $LNKData.'Display Name'
		}
		# Add Node
		if (!!$offset)
		{
			$LNKNodeText = if (!$Single)
			{
				"[$($offset.Start.ToString('D5'))] LNK #$($o.ToString('D3')) - $($ShowName)"
			}
			else
			{
				"[$($offset.Start.ToString('D5'))] LNK - $($ShowName)"
			}
			$LNKNode = $Node.Nodes.Add("LNK #$($o)", $LNKNodeText)
			$LNKNode.ForeColor = 'DarkTurquoise'
		}
		else
		{
			if (!!$StreamName)
			{
				if ($o -ne $null)
				{
					$LNKNodeText = "LNK Stream [$($StreamName.ToString().ToUpper())] Entry #$($o.ToString('D3')) - $($ShowName)"
				}
				else
				{
					$LNKNodeText = "LNK Stream [$($StreamName.ToString().ToUpper())] - $($ShowName)"
				}
			}
			else
			{
				$LNKNodeText = "LNK: $($ShowName)"
			}
			$LNKNode = $Node.Nodes.Add("LNK #$($o)", $LNKNodeText)
			$LNKNode.ForeColor = 'Orange'
		}
		
		$LNKNode.ImageIndex = 11
		$LNKNode.SelectedImageIndex = 12
		$draw = @([System.BitConverter]::ToString($Data).Replace('-', ''))
		$LNKNode.Tag = @($draw, $null, $null, $null, $LNKData)
		# Header
		$SizeNode = $LNKNode.Nodes.Add('Shortcut Size', "Shortcut Size: $($LNKData.'Shortcut Size')")
		if ($LNKData.'Shortcut Size' -eq '76')
		{
			$SizeNode.ToolTipText = "Invalid LNK - Header only"
			$SizeNode.BackColor = 'DarkRed'
			$SizeNode.ForeColor = 'White'
		}
		$null = $SizeNode.Nodes.Add('Header Block Size', "Header Block Size: $($LNKData.'Header Block Size')")
		$SizeNode.Nodes['Header Block Size'].Tag = @([System.BitConverter]::ToString($data[0 .. 75]).Replace('-', ''))
		$SizeNode.Nodes['Header Block Size'].ToolTipText = "Right click to copy the raw (Hex) data (76)"
		$SizeNode.Nodes['Header Block Size'].ForeColor = 'Peru'
		
		if (!!$LNKData.'Link Info Block Size')
		{
			$null = $SizeNode.Nodes.Add('Link Info Block Size', "Link Info Block Size: $($LNKData.'Link Info Block Size')")
			if ($LNKData.LinkInfoData.count -gt 0)
			{
				$SizeNode.Nodes['Link Info Block Size'].Tag = @([System.BitConverter]::ToString($LNKData.LinkInfoData).Replace('-', ''))
				$SizeNode.Nodes['Link Info Block Size'].ToolTipText = "Right click to copy the raw (Hex) data ($($LNKData.LinkInfoData.count))"
				$SizeNode.Nodes['Link Info Block Size'].ForeColor = 'Peru'
			}
		}
		if (!!$LNKData.'TargetID Block Size')
		{
			$null = $SizeNode.Nodes.Add('TargetID Block Size', "TargetID Block Size: $($LNKData.'TargetID Block Size' + 2)")
			if ($LNKData.LinkTargetIDListData.count -gt 0)
			{
				$SizeNode.Nodes['TargetID Block Size'].Tag = @([System.BitConverter]::ToString($LNKData.LinkTargetIDListData).Replace('-', ''))
				$SizeNode.Nodes['TargetID Block Size'].ToolTipText = "Right click to copy the raw (Hex) data ($($LNKData.LinkTargetIDListData.count + 2))"
				$SizeNode.Nodes['TargetID Block Size'].ForeColor = 'Peru'
			}
		}
		if (!!$LNKData.'StringData Block Size')
		{
			$null = $SizeNode.Nodes.Add('StringData Block Size', "StringData Block Size: $($LNKData.'StringData Block Size')")
			if ($LNKData.StringDataData.count -gt 0)
			{
				$SizeNode.Nodes['StringData Block Size'].Tag = @([System.BitConverter]::ToString($LNKData.StringDataData).Replace('-', ''))
				$SizeNode.Nodes['StringData Block Size'].ToolTipText = "Right click to copy the raw (Hex) data ($($LNKData.StringDataData.count))"
				$SizeNode.Nodes['StringData Block Size'].ForeColor = 'Peru'
			}
		}
		if (!!$LNKData.'ExtraData Block Size')
		{
			$null = $SizeNode.Nodes.Add('ExtraData Block Size', "ExtraData Block Size: $($LNKData.'ExtraData Block Size')")
			if ($LNKData.ExtraDataData.count -gt 0)
			{
				$SizeNode.Nodes['ExtraData Block Size'].Tag = @([System.BitConverter]::ToString($LNKData.ExtraDataData).Replace('-', ''))
				$SizeNode.Nodes['ExtraData Block Size'].ToolTipText = "Right click to copy the raw (Hex) data ($($LNKData.ExtraDataData.count))"
				$SizeNode.Nodes['ExtraData Block Size'].ForeColor = 'Peru'
			}
		}
		if (!!$slackStart -and ($offset.Length - $slackStart) -gt 0)
		{
			$null = $LNKNode.Nodes.Add("$('LinkSlack')", "LNK Slack: $($offset.Length - $slackStart)")
			$linkSlack = [System.BitConverter]::ToString($data[($slackStart) .. ($offset.Length - 1)]).Replace('-', '')
			$LNKNode.Nodes["$('LinkSlack')"].ForeColor = 'Red'
			$LNKNode.Nodes["$('LinkSlack')"].Tag = @($linkSlack)
			$LNKNode.Nodes["$('LinkSlack')"].ToolTipText = "Right click to copy the raw (Hex) Slack data $($linkSlack.Length)"
		}
		
		# Header 
		$null = $LNKNode.Nodes.Add("$('LinkCLSID')", "Link CLSID: $($LNKData.'LinkCLSID')")
		$flagnodes = $LNKNode.Nodes.Add("Link_Flags", "Link Flags")
		$l = 0
		foreach ($flag in $LNKData.Link_Flags.split(','))
		{
			$null = $flagnodes.Nodes.Add("$($flag)_$($l)", "Link Flag [$($l)]: $($flag.Replace(' ', ''))")
			if (!!$LinkFlagsTT["$($flag.Replace(' ', ''))"]) { $flagnodes.Nodes["$($flag)_$($l)"].ToolTipText = $LinkFlagsTT["$($flag.Replace(' ', ''))"] }
			$l++
		}
		$AttributesNode = $LNKNode.Nodes.Add("$('FileAttributes')", "File Attributes")
		$y = 0
		foreach ($attribute in $LNKData.'FileAttributes')
		{
			$null = $AttributesNode.Nodes.Add("$($attribute)_$($y)", "Attribute [$($y)]: $($attribute.replace('FILE_ATTRIBUTE_', '').Replace(' ', ''))")
			$y++
		}
		if ($null -ne $LNKData.CreationTime)
		{
			$CreationTime = $LNKNode.Nodes.Add("$('CreationTime')", "Creation Time (UTC): $($LNKData.CreationTime)")
			$CreationTime.ForeColor = 'Cyan'
		}
		if ($null -ne $LNKData.AccessTime)
		{
			$AccessTime = $LNKNode.Nodes.Add("$('AccessTime')", "Access   Time (UTC): $($LNKData.AccessTime)")
			$AccessTime.ForeColor = 'Cyan'
		}
		if ($null -ne $LNKData.WriteTime)
		{
			$WriteTime = $LNKNode.Nodes.Add("$('WriteTime')", "Write    Time (UTC): $($LNKData.WriteTime)")
			$WriteTime.ForeColor = 'Cyan'
		}
		if (!!$LNKData.'Target File Size')
		{
			$null = $LNKNode.Nodes.Add("$('Target File Size')", "Target File Size (32bit): $($LNKData.'Target File Size')")
			$LNKNode.Nodes['Target File Size'].ToolTipText = "If the link target file is larger than 0xFFFFFFFF, this value specifies the least significant 32 bits of the link
target file size."
		}
		$null = $LNKNode.Nodes.Add("$('Icon Idx')", "Icon Idx: $($LNKData.'Icon Idx')")
		$null = $LNKNode.Nodes.Add("$('ShowCommand')", "ShowCommand: $($LNKData.'ShowCommand')")
		$null = $LNKNode.Nodes.Add("$('HotKey')", "HotKey: $($LNKData.'HotKey')")
		
		if (!!$LNKData.Link_Flags -and $LNKData.'Shortcut Size' -gt 76)
		{
			# LinkTargetIDList
			if ($LNKData.Link_Flags.contains('HasLinkTargetIDList'))
			{
				if (!!$LNKData.'Display Name' -or !!$LNKData.'Path')
				{
					$null = $LNKNode.Nodes.Add("$('Display Name')", "Display Name: $($LNKData.'Display Name')")
					$null = $LNKNode.Nodes.Add("$('TargetPath')", "Target Path: $($LNKData.'Path')")
				}
			}
			if ($LNKData.ItemIdListItems)
			{
				Populate-ItemIdListItems -ItemIDListNode $LNKNode -ItemIdList @($LNKData.ItemIdListItems)
			}
			
			# StringData - HasName
			if ($LNKData.Link_Flags.contains('HasName'))
			{
				$NameStringnode = $LNKNode.Nodes.Add("$('NameString')", "LNK Name: $($LNKData.'NameString')")
				$NameStringnode.ForeColor = 'PaleGreen'
			}
			
			# StringData - HasWorkingDir
			if ($LNKData.Link_Flags.contains('HasWorkingDir'))
			{
				$null = $LNKNode.Nodes.Add("$('Working Dir.')", "Working Dir.: $($LNKData.'Working Dir.')")
			}
			
			# StringData - HasRelativePath
			if ($LNKData.Link_Flags.contains('HasRelativePath'))
			{
				$null = $LNKNode.Nodes.Add("$('Relative Path')", "Relative Path: $($LNKData.'Relative Path')")
			}
			# StringData - HasArguments
			if ($LNKData.Link_Flags.contains('HasArguments'))
			{
				$argsnode = $LNKNode.Nodes.Add("$('Command Args')", "Command Arguments [$($LNKData.'Command Args Length')]: $($LNKData.'Command Args')")
				$argsnode.ToolTipText = [System.Text.RegularExpressions.Regex]::Replace($LNKData.'Command Args', '(.){100}', "$('$0')`n")
				$argsnode.ForeColor = 'Gold'
			}
			
			# Link Info
			if ($LNKData.Link_Flags.contains('HasLinkInfo'))
			{
				$liflagnodes = $LNKNode.Nodes.Add("$('LinkInfoFlags')", "Link Info Flags")
				$li = 0
				if (![System.String]::IsNullOrEmpty($LNKData.'Link Info Flags'))
				{
					$liflags = @($LNKData.'Link Info Flags'.ToString().split(',').foreach{ $_ -split ("And", 2, [System.StringSplitOptions]::RemoveEmptyEntries) })
					foreach ($liflag in $liflags)
					{
						$null = $liflagnodes.Nodes.Add("$($liflag)_$($li)", "Info Flag [$($li)]: $($liflag.Replace(' ', ''))")
						$li++
					}
				}
				# VolumeID
				if ($LNKData.'Link Info Flags'.Contains('VolumeID'))
				{
					$null = $LNKNode.Nodes.Add("$('Drive Type')", "Drive Type: $($LNKData.'Drive Type')")
					if (!!$DriveTypes["$($LNKData.'Drive Type')"])
					{
						$LNKNode.Nodes["$('Drive Type')"].ToolTipText = $DriveTypes["$($LNKData.'Drive Type')"]
					}
					$null = $LNKNode.Nodes.Add("$('Drive s/n')", "Drive Serial Number: $($LNKData.'Drive s/n')")
					$null = $LNKNode.Nodes.Add("$('VolumeLabel')", "Volume Label: $($LNKData.'Volume Label')")
				}
				
				# LocalBasePath
				if ($LNKData.'Link Info Flags'.Contains('LocalBasePath'))
				{
					if ($null -ne $LNKData.'Local Base Path')
					{
						$null = $LNKNode.Nodes.Add("$('Local Base Path')", "Local Base Path: $($LNKData.'Local Base Path')")
					}
					if ($null -ne $LNKData.'Local Base Path Unicode')
					{
						$null = $LNKNode.Nodes.Add("$('Local Base Path Unicode')", "Local Base Path Unicode: $($LNKData.'Local Base Path Unicode')")
					}
				}
				# CommonPathSuffix
				if ($LNKData.'Link Info Flags'.Contains('PathSuffix'))
				{
					if ($null -ne $LNKData.CommonPathSuffix)
					{
						$null = $LNKNode.Nodes.Add("$('CommonPathSuffix')", "Common Path Suffix: $($LNKData.CommonPathSuffix)")
					}
					if ($null -ne $LNKData.CommonPathSuffixUnicode)
					{
						$null = $LNKNode.Nodes.Add("$('CommonPathSuffixUnicode')", "Common Path Suffix Unicode: $($LNKData.CommonPathSuffixUnicode)")
					}
				}
				
				# CommonNetworkRelativeLink
				if ($LNKData.'Link Info Flags'.Contains('CommonNetworkRelativeLink'))
				{
					$CommonNetworkRelativeLinkFlagsNode = $LNKNode.Nodes.Add("$('CommonNetworkRelativeLinkFlags')", "Common Network Relative Link Flags")
					if (![System.String]::IsNullOrEmpty($LNKData.'CommonNetworkRelativeLinkFlags'))
					{
						$CommonNetworkflags = @($LNKData.'Common Network Relative Link Flags'.split(',', [System.StringSplitOptions]::RemoveEmptyEntries))
						foreach ($cnflag in $CommonNetworkflags)
						{
							$null = $CommonNetworkRelativeLinkFlagsNode.Nodes.Add("$($cnflag)", "Relative Link Flag: $($cnflag.Replace(' ', ''))")
						}
					}
					# ValidNetType
					if ($LNKData.'Common Network Relative Link Flags'.Contains('ValidNetType'))
					{
						$null = $LNKNode.Nodes.Add("$('NetworkProviderType')", "Network Provider Type: $($LNKData.NetworkProviderType)")
					}
					
					$null = $LNKNode.Nodes.Add("$('NetName')", "NetName: $($LNKData.'NetName')")
					$null = $LNKNode.Nodes.Add("$('NetName Unicode')", "NetName Unicode: $($LNKData.'NetName Unicode')")
					# ValidDevice
					if ($LNKData.'Common Network Relative Link Flags'.Contains('ValidDevice'))
					{
						$null = $LNKNode.Nodes.Add("$('Device Name')", "Device Name: $($LNKData.'Device Name')")
						$null = $LNKNode.Nodes.Add("$('Device Name Unicode')", "Device Name Unicode: $($LNKData.'Device Name Unicode')")
					}
				}
			}
			
			# HasDarwinID
			if ($LNKData.Link_Flags.contains('HasDarwinID'))
			{
				$null = $LNKNode.Nodes.Add("$('DarwinDataAnsi')", "Darwin Data Ansi: $($LNKData.'DarwinDataAnsi')")
				$null = $LNKNode.Nodes.Add("$('DarwinDataUnicode')", "Darwin Data Unicode: $($LNKData.'DarwinDataUnicode')")
			}
			
			# RunWithShimLayer
			if ($LNKData.Link_Flags.contains('RunWithShimLayer'))
			{
				$null = $LNKNode.Nodes.Add("$('ShimLayerName')", "Shim Layer Name: $($LNKData.'ShimLayerName')")
			}
			
			# HasExpString
			if ($LNKData.Link_Flags.contains('HasExpString'))
			{
				if ($null -ne $LNKData.TargetAnsi)
				{
					$null = $LNKNode.Nodes.Add("$('TargetAnsi')", "Target Ansi: $($LNKData.'TargetAnsi')")
				}
				if ($null -ne $LNKData.TargetUnicode)
				{
					$null = $LNKNode.Nodes.Add("$('TargetUnicode')", "Target Unicode: $($LNKData.TargetUnicode)")
				}
			}
			
			# EnableTargetMetadata
			if ($LNKData.Link_Flags.contains('EnableTargetMetadata') -and !!$LNKData.PropertyStoreEntries)
			{
				$TargetMetadataNode = $LNKNode.Nodes.Add("TargetMetadata", "Target Metadata")
				$TargetMetadataNode.ForeColor = 'Violet'
				Populate-SPS1 -Node $TargetMetadataNode -SPS1properties @($LNKData.PropertyStoreEntries)
			}
			
			# 	Extradata - KnownFolderDataBlock
			if (!!$LNKData.'Known Folder BlockSignature')
			{
				$null = $LNKNode.Nodes.Add("$('KnBlockSignature')", "Known Folder BlockSignature: $($LNKData.'Known Folder BlockSignature')")
				$null = $LNKNode.Nodes.Add("$('KnownFolderID')", "Known Folder GUID: $($LNKData.'Known Folder ID')")
				$null = $LNKNode.Nodes.Add("$('KnownFolderDisplayName')", "Known Folder Display Name: $($LNKData.'Known Folder DisplayName')")
				$null = $LNKNode.Nodes.Add("$('KnownFolderIDOffset')", "Known FolderID Offset: $($LNKData.'Known FolderID Offset')")
			}
			
			# Extradata - SpecialFolderDataBlock
			if (!!$LNKData.'Special Folder BlockSignature')
			{
				$null = $LNKNode.Nodes.Add("$('SpBlockSignature')", "Special Folder BlockSignature: $($LNKData.'Special Folder BlockSignature')")
				$null = $LNKNode.Nodes.Add("$('SpecialFolderID')", "Special Folder ID: $($LNKData.'Special Folder ID')")
				$null = $LNKNode.Nodes.Add("$('SpecialFolderIDOffset')", "Special Folder Offset: $($LNKData.'Special Folder Offset')")
			}
			
			# Extradata - EnvironmentVariableDataBlock
			if (!!$LNKData.'Environment Variable BlockSignature')
			{
				$null = $LNKNode.Nodes.Add("$('EnvBlockSignature')", "Environment Variable BlockSignature: $($LNKData.'Environment Variable BlockSignature')")
				$null = $LNKNode.Nodes.Add("$('EnvTargetAnsi')", "Environment Variable TargetAnsi: $($LNKData.'Environment Variable TargetAnsi')")
				$null = $LNKNode.Nodes.Add("$('EnvTargetUnicode')", "Environment Variable TargetUnicode: $($LNKData.'Environment Variable TargetUnicode')")
			}
			
			# Extradata - ConsoleDataBlock
			if (!!$LNKData.'Console Data Block')
			{
				$consolenode = $LNKNode.Nodes.Add("ConsoleNode", "Console Properties")
				foreach ($consoleprop in ($LNKData.'Console Data Block' | Get-Member -MemberType NoteProperty).Name)
				{
					$null = $consolenode.Nodes.Add("Console$($consoleprop)", "$($consoleprop): $($LNKData.'Console Data Block'.$consoleprop)")
				}
			}
			
			# Extradata - ConsoleFEDataBlock
			if (!!$LNKData.'Console CodePage ID')
			{
				$null = $LNKNode.Nodes.Add("$('CodePage')", "Console Code Page ID: $($LNKData.'Console CodePage ID')")
				$LNKNode.Nodes['CodePage'].ToolTipText = "LCID Structure`nhttps://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-lcid/63d3d639-7fd2-4afb-abbe-0d5b5551eef8"
			}
			# Extradata - TrackerDataBlock
			# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/df8e3748-fba5-4524-968a-f72be06d71fc
			if (!!$LNKData.'Machine ID')
			{
				$null = $LNKNode.Nodes.Add("$('Machine ID')", "Machine ID: $($LNKData.'Machine ID')")
			}
			if (!!$LNKData.'Guid 1')
			{
				$Guid1Node = $LNKNode.Nodes.Add("$('Guid 1')", "VolumeID: $($LNKData.'Guid 1'.ObjectID)")
				$Null = $Guid1Node.Nodes.Add("version", "GUID Version: $($LNKData.'Guid 1'.version)")
				$Null = $Guid1Node.Nodes.Add("variant", "GUID Variant: $($LNKData.'Guid 1'.variant)")
				$Null = $Guid1Node.Nodes.Add("Sequence", "GUID Sequence: $($LNKData.'Guid 1'.Sequence)")
				if (!!$LNKData.'Guid 1'.MAC)
				{
					# Add to tree
					$Null = $Guid1Node.Nodes.Add("GUIDcreated", "GUID created at: $($LNKData.'Guid 1'.Created)")
					$Guid1Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
					$Null = $Guid1Node.Nodes.Add("MAC Address", "MAC Address: $($LNKData.'Guid 1'.MAC)")
					$Guid1Node.Nodes["MAC Address"].Tag = $LNKData.'Guid 1'.MAC
					$Guid1Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
					$man1 = Get-MACManufacturer -MacAddress "$($LNKData.'Guid 1'.MAC)"
					if (!!$man1)
					{
						$Null = $Guid1Node.Nodes.Add("MACManufacturer", "MAC Company: $($man1)")
						$Guid1Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
					}
				}
			}
			if (!!$LNKData.'Birth Guid 1')
			{
				$BGuid1Node = $LNKNode.Nodes.Add("$('Birth Guid 1')", "Birth VolumeID: $($LNKData.'Birth Guid 1'.ObjectID)")
				$Null = $BGuid1Node.Nodes.Add("version", "GUID Version: $($LNKData.'Birth Guid 1'.version)")
				$Null = $BGuid1Node.Nodes.Add("variant", "GUID Variant: $($LNKData.'Birth Guid 1'.variant)")
				$Null = $BGuid1Node.Nodes.Add("Sequence", "GUID Sequence: $($LNKData.'Birth Guid 1'.Sequence)")
				if (!!$LNKData.'Birth Guid 1'.MAC)
				{
					# Add to tree
					$Null = $BGuid1Node.Nodes.Add("GUIDcreated", "GUID created at: $($LNKData.'Birth Guid 1'.Created)")
					$BGuid1Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
					$Null = $BGuid1Node.Nodes.Add("MAC Address", "MAC Address: $($LNKData.'Birth Guid 1'.MAC)")
					$BGuid1Node.Nodes["MAC Address"].Tag = $LNKData.'Birth Guid 1'.MAC
					$BGuid1Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
					$bman1 = Get-MACManufacturer -MacAddress "$($LNKData.'Birth Guid 1'.MAC)"
					if (!!$bman1)
					{
						$Null = $BGuid1Node.Nodes.Add("MACManufacturer", "MAC Company: $($bman1)")
						$BGuid1Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
					}
				}
			}
			if (!!$LNKData.'Guid 2')
			{
				$Guid2Node = $LNKNode.Nodes.Add("$('Guid 2')", "File ObjectID: $($LNKData.'Guid 2'.ObjectID)")
				$Null = $Guid2Node.Nodes.Add("version", "GUID Version: $($LNKData.'Guid 2'.version)")
				$Null = $Guid2Node.Nodes.Add("variant", "GUID Variant: $($LNKData.'Guid 2'.variant)")
				$Null = $Guid2Node.Nodes.Add("Sequence", "GUID Sequence: $($LNKData.'Guid 2'.Sequence)")
				if (!!$LNKData.'Guid 2'.MAC)
				{
					# Add to tree
					$Null = $Guid2Node.Nodes.Add("GUIDcreated", "GUID created at: $($LNKData.'Guid 2'.Created)")
					$Guid2Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
					$Null = $Guid2Node.Nodes.Add("MAC Address", "MAC Address: $($LNKData.'Guid 2'.MAC)")
					$Guid2Node.Nodes["MAC Address"].Tag = $LNKData.'Guid 2'.MAC
					$Guid2Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
					$man2 = Get-MACManufacturer -MacAddress "$($LNKData.'Guid 2'.MAC)"
					if (!!$man2)
					{
						$Null = $Guid2Node.Nodes.Add("MACManufacturer", "MAC Company: $($man2)")
						$Guid2Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
					}
				}
			}
			if (!!$LNKData.'Birth Guid 2')
			{
				$BGuid2Node = $LNKNode.Nodes.Add("$('Birth Guid 2')", "Birth File ObjectID: $($LNKData.'Birth Guid 2'.ObjectID)")
				$Null = $BGuid2Node.Nodes.Add("version", "GUID Version: $($LNKData.'Birth Guid 2'.version)")
				$Null = $BGuid2Node.Nodes.Add("variant", "GUID Variant: $($LNKData.'Birth Guid 2'.variant)")
				$Null = $BGuid2Node.Nodes.Add("Sequence", "GUID Sequence: $($LNKData.'Birth Guid 2'.Sequence)")
				if (!!$LNKData.'Guid 2'.MAC)
				{
					# Add to tree
					$Null = $BGuid2Node.Nodes.Add("GUIDcreated", "GUID created at: $($LNKData.'Birth Guid 2'.Created)")
					$BGuid2Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
					$Null = $BGuid2Node.Nodes.Add("MAC Address", "MAC Address: $($LNKData.'Birth Guid 2'.MAC)")
					$BGuid2Node.Nodes["MAC Address"].Tag = $LNKData.'Birth Guid 2'.MAC
					$BGuid2Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
					$bman2 = Get-MACManufacturer -MacAddress "$($LNKData.'Birth Guid 2'.MAC)"
					if (!!$bman2)
					{
						$Null = $BGuid2Node.Nodes.Add("MACManufacturer", "MAC Company: $($bman2)")
						$BGuid2Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
					}
				}
			}
			
			# Extradata -VistaAndAboveIDListDataBlock
			if (!!$LNKData.VistaItemIdListItems)
			{
				$VistaNode = $LNKNode.Nodes.Add("VistaPath", "Vista And Above IDList Items")
				$VistaNode.ForeColor = 'Violet'
				$null = $VistaNode.Nodes.Add("VistaDisplayName", "VistaAndAbove DisplayName: $($LNKData.Vista_DisplayName)")
				$null = $VistaNode.Nodes.Add("VistaPath", "VistaAndAbove Path: $($LNKData.Vista_Path)")
				Populate-ItemIdListItems -ItemIDListNode $VistaNode -ItemIdList @($LNKData.VistaItemIdListItems)
			}
			
			# HasIconLocation
			if ($LNKData.Link_Flags.contains('HasIconLocation'))
			{
				$null = $LNKNode.Nodes.Add("$('Icon Location')", "Icon Location: $($LNKData.'Icon Location')")
			}
			# HasIconLocation
			if ($LNKData.Link_Flags.contains('HasExpIcon'))
			{
				$null = $LNKNode.Nodes.Add("$('iconTargetAnsi')", "Icon Target Ansi: $($LNKData.iconTargetAnsi)")
				$null = $LNKNode.Nodes.Add("$('iconTargetUnicode')", "Icon Target Unicode: $($LNKData.iconTargetUnicode)")
			}
		} # End if FLAGS
		
		$raw = $LNKNode.Nodes.Add("RawHexData", "LNK Data")
		if ($offsets.count -gt 1)
		{
			$raw.Tag = @([System.BitConverter]::ToString($ShellLink_data[0 .. ($LNKData.'Shortcut Size' -1)]).Replace('-', ''))
			$raw.ToolTipText = "Right click to copy the raw (Hex) data ($($LNKData.'Shortcut Size'))"
		}
		else
		{
			$raw.Tag = @([System.BitConverter]::ToString($ShellLink_data).Replace('-', ''))
			$raw.ToolTipText = "Right click to copy the raw (Hex) data ($($ShellLink_data.count))"
		}
		$raw.ForeColor = 'Peru'
		
		#	In customdestinations-ms:
		#	The Lnk CLSID '0x0114020000000000C000000000000046' precedes each LNK entry
		#	The end signature of customdestinations-ms is: '0xFBBFBA'
		
	<#	if (!!$LNKData.LinkSlackLength -and $LNKData.LinkSlack -match '[a-fA-F1-9]' -and $LNKData.LinkSlack -notmatch 'C0000000000000464C' -and $LNKData.LinkSlack -notmatch '(ABFBBFBA)' -and $LNKData.LinkSlack -notmatch '(FBBFBA)')
		{
			$null = $LNKNode.Nodes.Add("$('Link Slack')", "Link Slack")
			$LNKNode.Nodes["$('Link Slack')"].Tag = @($LNKData.LinkSlack)
			$LNKNode.Nodes["$('Link Slack')"].ToolTipText = "Right click to copy the raw (Hex) Link Slack data"
			$LNKNode.Nodes["$('Link Slack')"].ForeColor = 'Tomato'
		}#>
		
		$Status.Text = ''
	} # End opulate-LNKData
	
	function Process-Custom
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$File
		)
		$TreeSearchState = $TreeSearch.Visible
		
		$fname = Split-Path -Path "$($File)" -Leaf
		try
		{
			$fileinfo = [System.IO.FileInfo]::new("$($File)")
			if ($fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::SparseFile) -or $fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::Offline) -or $fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::ReparsePoint))
			{
				$Status.Text = "$($fname) has flags:  $($fileinfo.Attributes)"
				[System.Console]::Beep(500, 150)
				return
			}
			#Check file size
			$fs = $fileinfo.Length
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			Show-ErrorMessage -ErrorMessage "Can not Access $($fname)"
			$Error.Clear()
			return
		}
		if ($fs -ge 512)
		{
			#Open file & read the Header
			$Status.Text = " Please wait - Reading $($fname)"
			$ReadFile = [System.IO.File]::Open("$($File)", ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::ReadWrite))
			$Header = [System.Byte[]]::new([Int]$fs)
			$null = $ReadFile.Read($Header, 0, $fs)
			$ReadFile.Dispose()
			[System.Text.RegularExpressions.Regex]$regex = "(\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46)"
			[System.Text.RegularExpressions.Regex]$regexC = "(\xAB\xFB\xBF\xBA)"
			$Headerstring = [System.Text.Encoding]::GetEncoding(28591).GetString($Header)
			if (!!($regex.Match($Headerstring).success))
			{
				$idx = $regex.Match($Headerstring).index
			}
			if (!!($regexC.Matches($Headerstring).success))
			{
				$tidx = $regexC.Matches($Headerstring).index
			}
			else
			{
				return (Process-Link -File $File)
			}
			$TypeCount = [Bitconverter]::ToUInt32($Header[4 .. 7], 0)
			
			$treeview2.Nodes.Clear()
			[System.GC]::Collect()
			$TreeSearch.Visible = $false
			$Root2 = $treeview2.Nodes.Add("$($File)", $fname)
			$Root2.ToolTipText = "$($File)"
			
			if ($fname -match '.customDestinations-ms')
			{
				$PathHash = $fname.Replace('.customDestinations-ms', '')
				$appidnode = $Root2.Nodes.Add("$($PathHash)", "AppID: $($PathHash.ToUpper())")
				$appidnode.ForeColor = 'LimeGreen'
				if (!!$AppIDs["$($PathHash)"])
				{
					$appidnode.Text = "$($appidnode.Text) [$($AppIDs["$($PathHash)"])]"
				}
			}
			
			$Groups = [System.Collections.ArrayList]::New()
			
			$ECount = [Bitconverter]::ToUInt16($Header[16 .. 17], 0)
			if ($idx -eq 20 -and $tidx[0] -ne 20)
			{
				$Group = [PSCustomObject]@{
					'Title'   = 'Tasks'
					'Entries' = $ECount
					'Offset'  = $idx
					'End'     = $tidx[0]
				}
				$null = $Groups.Add($Group)
			}
			elseif ($ECount -ne 65535 -and $tidx[0] -ne 20) # Has Name
			{
				$TitleSize = [Bitconverter]::ToUInt16($Header[16 .. 17], 0)
				if ($TitleSize -gt 0 -and (18 + $TitleSize * 2) -lt $idx)
				{
					$Title = [System.Text.Encoding]::Unicode.GetString($Header[18 .. (18 + $TitleSize * 2 - 1)])
				}
				$off = 18 + $TitleSize * 2
				if (($off + 1) -lt $idx)
				{
					$EntryCount = [Bitconverter]::ToUInt16($Header[$off .. ($off + 1)], 0)
				}
				$Group = [PSCustomObject]@{
					'Title'   = $Title
					'Entries' = $EntryCount
					'Offset'  = $idx
					'End'	  = $tidx[0]
				}
				$null = $Groups.Add($Group)
			}
					
			if ($TypeCount -gt 1 -and $tidx.Count -gt 1)
			{
				for ($ti = 0; $ti -lt ($TypeCount-1); $ti++)
				{
					$i = $tidx[$ti]+4
					$t = [Bitconverter]::ToUInt32($Header[$i .. ($i + 3)], 0)
					if ($t -eq 0)
					{
						$TitleSize = [Bitconverter]::ToUInt16($Header[($i + 4) .. ($i + 5)], 0)
						$Title = [System.Text.Encoding]::Unicode.GetString($Header[($i + 6) .. ($i + 6 + $TitleSize * 2 - 1)])
						$EntryCount = [Bitconverter]::ToUInt16($Header[($i + 6 + $TitleSize * 2) .. ($i + 6 + $TitleSize * 2 + 1)], 0)
						if (($tidx[($ti + 1)] - $tidx[$ti]) -lt 76) { continue }
						$Group = [PSCustomObject]@{
							'Title'   = $Title
							'Entries' = $EntryCount
							'Offset'  = $i
							'End'	  = $tidx[($ti + 1)]
						}
						$null = $Groups.Add($Group)
					}
					else
					{
						if (($tidx[($ti + 1)] - $tidx[$ti]) -lt 76) { continue }
						$Group = [PSCustomObject]@{
							'Title'   = 'Tasks'
							'Entries' = [Bitconverter]::ToUInt16($Header[($i + 4) .. ($i + 5)], 0)
							'Offset'  = $i
							'End'	  = $tidx[($ti + 1)]
						}
						$null = $Groups.Add($Group)
					}
				}
			}
			
			if ($Groups.Count -ge 1)
			{
				foreach ($CustomGroup in $Groups)
				{
					$TitleNode = $Root2.Nodes.Add("$($CustomGroup.Offset)", "[$($CustomGroup.Offset)] $($CustomGroup.Title)")
					$TitleNode.ForeColor = 'Yellow'
					$null = $TitleNode.Nodes.Add('Entries', "Number of Entries: $($CustomGroup.Entries)")
					$CustomOffset = $CustomGroup.Offset
					$CustomLength = $CustomGroup.End
					Process-Link -File $File -Root2 $TitleNode -FileOffset $CustomOffset -CustomLength $CustomLength -GroupCount $CustomGroup.Entries -Custom $true
				}
				$Status.Text = 'Please wait - Loading Tree'
				$treeview2.EndUpdate()
				$treeview2.Nodes[0].Expand()
				$treeview2.Nodes[0].Nodes[0 .. 4].Expand()
				$TreeSearch.Visible = $true
			}
			else
			{
				$treeview2.EndUpdate()
				$treeview2.Nodes[0].Expand()
			}
		}
		else
		{
			Process-Link -File $File
		}
	} # End Process-Custom
	
	function Process-Automatic
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$File
		)
		$TreeSearchState = $TreeSearch.Visible
		
		$fname = Split-Path -Path "$($File)" -Leaf
		try
		{
			$fileinfo = [System.IO.FileInfo]::new("$($File)")
			if ($fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::SparseFile) -or $fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::Offline) -or $fileinfo.Attributes.HasFlag([System.IO.FileAttributes]::ReparsePoint))
			{
				$Status.Text = "$($fname) has flags:  $($fileinfo.Attributes)"
				[System.Console]::Beep(500, 150)
				return
			}
			#Check file size
			$fs = $fileinfo.Length
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			Show-ErrorMessage -ErrorMessage "Can not Access $($fname)"
			$Error.Clear()
			return
		}
		if ($fs -lt 512)
		{
			$Status.Text = "$($fname) is too small"
			[System.Console]::Beep(500, 150)
			return
		}
		
		#Open file & read the Header
		$ReadHeader = [System.IO.File]::Open("$($File)", ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::ReadWrite))
		$Header = [System.Byte[]]::new([Int]8)
		$null = $ReadHeader.Read($Header, 0, 8)
		$ReadHeader.Dispose()
		
		# Check the Header if file is 'Microsoft Compound File Binary File Format, Version 4'
		$filesignature = [System.BitConverter]::ToString($header).Replace('-', '')
		if ($filesignature -ne 'D0CF11E0A1B11AE1')
		{
			$Status.Text = "$($fname)'s signature [$($filesignature)] is not a MS Compound File Binary File ('D0CF11E0A1B11AE1')"
			Process-Link -File $File
			return
		}
		else
		{
			$Status.Text = "$($fname) is a MS Compound File Binary File"
		}
		
		try
		{
			# Open & Read 'Microsoft Compound File Binary File Format, Version 4'
			$methodArgs = @($File, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::Read)
			$storageRootType = [System.IO.Packaging.StorageInfo].Assembly.GetType("System.IO.Packaging.StorageRoot", $true, $false)
			$result = $storageRootType.InvokeMember("Open", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::InvokeMethod, $null, $null, $methodArgs)
			
			$count = $result.GetStreams().count
			if ($count -ge 1)
			{
				$Status.Text = "$($fname) has $($count) streams"
				# Clear tree
				$treeview2.Nodes.Clear()
				[System.GC]::Collect()
				$treeview2.BeginUpdate()
				$TreeSearch.Visible = $false
				# Get each Stream
				$r = 0
				$streams = @(ForEach ($stream in $result.GetStreams())
				{
					$data = $null
					$reader = New-Object System.IO.BinaryReader($stream.GetStream())
					$data = $reader.ReadBytes($reader.BaseStream.Length)
					$Status.Text = "Please wait - Processing Streams $($r)/$($count)"
					[System.Windows.Forms.Application]::DoEvents()
					$shellLnk = if ($data.Length -ge 20 -and $stream.Name -notmatch "DestList") { Get-ShellLinkfrombyteArray -ByteArray $data }
					else { $null }
					
					[pscustomobject][Ordered]@{
						'Name'	     = $fname
						'StreamName' = $stream.Name
						'StreamData' = $shellLnk
						'DataLength' = $data.count
						'Data'	     = $data
					}
					$reader.Close()
					$r++
				})
				$reader.Dispose()
				# Close Microsoft Compound File Binary File Format, Version 4'
				$result = $storageRootType.InvokeMember("Close", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::InvokeMethod, $null, $result, $null)
				# Add Root Node
				$Root2 = $treeview2.Nodes.Add("Root", "$($fname)")
				$Root2.ToolTipText = "$($File)"
				$null = $Root2.Nodes.Add("FullPath", "Full Path: $($File)")
				
				# Get Filename Path Hash and add to tree
				if ($fname -match '.automaticDestinations-ms')
				{
					$PathHash = $fname.Replace('.automaticDestinations-ms', '')
					$Status.Text = "Populating tree from automaticDestinations-ms file $($PathHash.ToUpper())"
					$appidnode = $Root2.Nodes.Add("$($PathHash)", "AppID: $($PathHash.ToUpper())")
					$appidnode.ForeColor = 'LimeGreen'
					if (!!$AppIDs["$($PathHash)"])
					{
						$appidnode.Text = "$($appidnode.Text) [$($AppIDs["$($PathHash)"])]"
					}
					# Add Node for the Link Streams
					$LNK_Streams_Count = $streams.Where{ $_.StreamName -notmatch 'DestList' }.count
					if (!!$LNK_Streams_Count)
					{
						$LNK_Nodes = $Root2.Nodes.Add("LNK_Nodes", "LNK Streams")
						$LNK_Nodes.ForeColor = 'Fuchsia'
					}
				}
				else { $LNK_Nodes = $Root2.Nodes }
				
				$o = 0
				foreach ($streaminf in $streams)
				{
					[System.Windows.Forms.Application]::DoEvents()
					# Get Link Data
					$LNKData = $streaminf.StreamData
					if (!!$LNK_Streams_Count -and $LNKData -ne $null)
					{
						if ($fname.EndsWith('.automaticDestinations-ms'))
						{
							Populate-LNKData -LNKData $LNKData -Node $LNK_Nodes -o $o -StreamName "$($streaminf.StreamName.ToString().ToUpper())" -ShellLink_data $streaminf.Data
						}
						else
						{
							Populate-LNKData -LNKData $LNKData -Node $LNK_Nodes -o $o -StreamName "$($streaminf.StreamName.ToString())" -ShellLink_data $streaminf.Data
						}
						$o++
					}
					# Process DestList
					elseif ($LNKData -eq $null -and ($streaminf.StreamName -eq 'DestList'))
					{
						$check = $Root2.Nodes.Find("$($streaminf.StreamName)", $true)
						if (!!$check)
						{
							$DestNode = $check[0]
						}
						else
						{
							$DestNode = $Root2.Nodes.Add("$($streaminf.StreamName)", "$($streaminf.StreamName) Stream")
						}
						$DestNode.ForeColor = 'Fuchsia'
						try
						{
							$x = $streaminf
							if ($x.DataLength -ge 32)
							{
								
								$header = [pscustomobject]@{
									'Version' = $versions["$([Bitconverter]::ToUInt32($x.Data[0 .. 3], 0))"] + " ($([Bitconverter]::ToUInt32($x.Data[0 .. 3], 0)))"
									'Current Entries' = [Bitconverter]::ToUInt32($x.Data[4 .. 7], 0)
									'Pinned Entries' = [Bitconverter]::ToUInt32($x.Data[8 .. 11], 0)
									'Counter' = [System.BitConverter]::ToString($x.Data[12 .. 15]).Replace('-', '') # [Bitconverter]::ToUInt32($x.Data[12 .. 15], 0)
									'Last Issued Nr' = [Bitconverter]::ToUInt32($x.Data[16 .. 23], 0)
									'Nr of Actions' = [Bitconverter]::ToUInt32($x.Data[24 .. 31], 0)
								}
								$totalentrysize = ($x.DataLength - 32)
								$entrylength = $lengths["$([Bitconverter]::ToUInt32($x.Data[0 .. 3], 0))"]/1
								
								# Add to tree
								$headernode = $DestNode.Nodes.Add("Header", "Header")
								$headernode.ForeColor = 'DarkTurquoise'
								$null = $headernode.Nodes.Add("Version", "Version: $($header.Version)")
								$null = $headernode.Nodes.Add("Current Entries", "Current Entries: $($header.'Current Entries')")
								$null = $headernode.Nodes.Add("Pinned Entries", "Number of Pinned Entries: $($header.'Pinned Entries')")
								if ($header.'Pinned Entries' -ge 1)
								{
									$headernode.Nodes["Pinned Entries"].ForeColor = 'DodgerBlue'
								}
								$null = $headernode.Nodes.Add("Entries Counter", "Entries Counter: 0x$($header.'Counter')") # ???
								$null = $headernode.Nodes.Add("Last Issued Nr", "Last Issued Nr: $($header.'Last Issued Nr')")
								$null = $headernode.Nodes.Add("Nr of Actions", "Nr of Actions: $($header.'Nr of Actions')")
								
								# Get Entries
								$e = 0
								$entries = @(for ($start = 32; $start -lt $totalentrysize)
								{
									$lastaccessed = try { [datetime]::FromFileTimeUtc("0x$([System.BitConverter]::ToString($x.data[($start + 107) .. ($start + 100)]).Replace('-', ''))").ToString("dd-MMM-yyyy HH:mm:ss.fffffff") }
									catch { [System.BitConverter]::ToString($x.data[($start + 107) .. ($start + 100)]).Replace('-', '') }
									
									if (([Bitconverter]::ToUInt32($x.Data[0 .. 3], 0)) -eq 1) # Version 1
									{
										$stringlength = [Bitconverter]::ToUInt16($x.data[($start + 112) .. ($start + 113)], 0)
										$Hostname = if (([System.BitConverter]::ToString($x.data[($start + 72) .. ($start + 87)]).Replace('-', '')) -ne '00000000000000000000000000000000') { [System.Text.Encoding]::UTF8.GetString($x.data[($start + 72) .. ($start + 87)]) }
										else { $null }
										
										[pscustomobject]@{
											'Hash' = [System.BitConverter]::ToString($x.data[$start .. ($start + 7)]) -replace '-', ''
											'Volume Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 8) .. ($start + 23)]).Replace('-', ''))
											'File Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 24) .. ($start + 39)]).Replace('-', ''))
											'Birth volume Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 40) .. ($start + 55)]).Replace('-', ''))
											'Birth file Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 56) .. ($start + 71)]).Replace('-', ''))
											'Hostname' = $Hostname
											'EntryID' = [Bitconverter]::ToUInt64($x.data[($start + 88) .. ($start + 95)], 0)
											'Access Counter' = [Bitconverter]::ToInt32($x.data[($start + 96) .. ($start + 99)], 0)
											'Last Accessed' = $lastaccessed
											'Pin ID' = if (([System.BitConverter]::ToString($x.data[($start + 108) .. ($start + 111)]) -replace '-', '') -eq 'FFFFFFFF') { 'Unpinned' } else { [Bitconverter]::ToUInt32($x.data[($start + 108) .. ($start + 111)], 0) }
											'String Data Length' = $stringlength
											'InQuickAccess' = $null
											'String' = [System.Text.Encoding]::Unicode.GetString($x.data[($start + $entrylength) .. ($start + $entrylength + $stringlength * 2 - 1)])
											'ExtensionSize' = 0
											'ExtensionData' = $null
											'RawEntryData' = [System.BitConverter]::ToString($x.data[$start .. ($start + $entrylength + $stringlength * 2 - 1)]).Replace('-', '')
										} # eND psCO
										
										$start = $start + $entrylength + $stringlength * 2
									}
									else
									{
										$stringlength = [Bitconverter]::ToUInt16($x.data[($start + 128) .. ($start + 129)], 0)
										$extsize = [Bitconverter]::ToInt32($x.data[($start + $entrylength + $stringlength * 2) .. ($start + $entrylength + $stringlength * 2 + 3)], 0)
										$Hostname = if (([System.BitConverter]::ToString($x.data[($start + 72) .. ($start + 87)]).Replace('-', '')) -ne '00000000000000000000000000000000') { [System.Text.Encoding]::UTF8.GetString($x.data[($start + 72) .. ($start + 87)]) }
										else { $null }
										
										[pscustomobject]@{
											'Hash' = [System.BitConverter]::ToString($x.data[$start .. ($start + 7)]) -replace '-', ''
											'Volume Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 8) .. ($start + 23)]).Replace('-', ''))
											'File Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 24) .. ($start + 39)]).Replace('-', ''))
											'Birth volume Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 40) .. ($start + 55)]).Replace('-', ''))
											'Birth file Droid ID' = Get-ObjectIdFromHex -Hex ([System.BitConverter]::ToString($x.data[($start + 56) .. ($start + 71)]).Replace('-', ''))
											'Hostname' = $Hostname
											'EntryID' = [Bitconverter]::ToUInt64($x.data[($start + 88) .. ($start + 95)], 0)
											'Access Counter' = [Bitconverter]::ToInt32($x.data[($start + 96) .. ($start + 99)], 0)
											'Last Accessed' = $lastaccessed
											'Pin ID' = if (([System.BitConverter]::ToString($x.data[($start + 108) .. ($start + 111)]).Replace('-', '')) -eq 'FFFFFFFF') { 'Unpinned' } else { [Bitconverter]::ToUInt32($x.data[($start + 108) .. ($start + 111)], 0) }
											'String Data Length' = $stringlength
											'InQuickAccess' = if ([Bitconverter]::ToUInt64($x.data[($start + 116) .. ($start + 123)], 0) -eq 1) { $true }else{ $false }
											'String' = [System.Text.Encoding]::Unicode.GetString($x.data[($start + $entrylength) .. ($start + $entrylength + $stringlength * 2 - 1)])
											'ExtensionSize' = $extsize
											'ExtensionData' = if ($extsize -gt 0) { $x.data[($start + $entrylength + $stringlength * 2) .. ($start + $entrylength + $stringlength * 2 + 4 + $extsize - 1)] } else { $null }
											'RawEntryData' = [System.BitConverter]::ToString($x.data[$start .. ($start + $entrylength + $stringlength * 2 + 4 + $extsize)]) -replace '-', ''
										} # eND psCO
										
										if ($extsize -eq 0)
										{
											$start = $start + $entrylength + $stringlength * 2 + 4
										}
										else
										{
											$start = $start + $entrylength + $stringlength * 2 + 4 + $extsize
										} # end else
									} # end else
								}) # End entries
								
								# Add Entries
								if ($entries.count -ge 1)
								{
									$EntriesNodes = $DestNode.Nodes.Add("Entries", "Entries")
									$EntriesNodes.ForeColor = 'DarkTurquoise'
									foreach ($entry in $entries)
									{
										$entryNodeText = "$($streaminf.StreamName.ToString()) [$($entry.EntryID.ToString('X'))] Entry #$($e.ToString('D3')) - $($entry.'String')"
										$entryNode = $EntriesNodes.Nodes.Add("Entry_$($e)", $entryNodeText)
										$entryNode.ForeColor = 'GreenYellow'
										$null = $entryNode.Nodes.Add("$($e)entry.Hash", "Hash: $($entry.'Hash')")
										
										if (!!$entry.'Volume Droid ID' -and $entry.'Volume Droid ID'.ObjectID -ne '00000000-0000-0000-0000-000000000000')
										{
											$Guid1Node = $entryNode.Nodes.Add("$('Volume Droid')", "VolumeID: $($entry.'Volume Droid ID'.ObjectID)")
											$Null = $Guid1Node.Nodes.Add("version", "GUID Version: $($entry.'Volume Droid ID'.version)")
											$Null = $Guid1Node.Nodes.Add("variant", "GUID Variant: $($entry.'Volume Droid ID'.variant)")
											$Null = $Guid1Node.Nodes.Add("Sequence", "GUID Sequence: $($entry.'Volume Droid ID'.Sequence)")
											if (!!$entry.'Volume Droid ID'.MAC)
											{
												# Add to tree
												$Null = $Guid1Node.Nodes.Add("GUIDcreated", "GUID created at: $($entry.'Volume Droid ID'.Created)")
												$Guid1Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
												$Null = $Guid1Node.Nodes.Add("MAC Address", "MAC Address: $($entry.'Volume Droid ID'.MAC)")
												$Guid1Node.Nodes["MAC Address"].Tag = $entry.'Volume Droid ID'.MAC
												$Guid1Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
												$man1 = Get-MACManufacturer -MacAddress "$($entry.'Volume Droid ID'.MAC)"
												if (!!$man1)
												{
													$Null = $Guid1Node.Nodes.Add("MACManufacturer", "MAC Company: $($man1)")
													$Guid1Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
												}
											}
										}
										if (!!$entry.'File Droid ID' -and $entry.'File Droid ID'.ObjectID -ne '00000000-0000-0000-0000-000000000000')
										{
											$BGuid1Node = $entryNode.Nodes.Add("$('File Droid')", "File ObjectID: $($entry.'File Droid ID'.ObjectID)")
											$Null = $BGuid1Node.Nodes.Add("version", "GUID Version: $($entry.'File Droid ID'.version)")
											$Null = $BGuid1Node.Nodes.Add("variant", "GUID Variant: $($entry.'File Droid ID'.variant)")
											$Null = $BGuid1Node.Nodes.Add("Sequence", "GUID Sequence: $($entry.'File Droid ID'.Sequence)")
											if (!!$entry.'File Droid ID'.MAC)
											{
												# Add to tree
												$Null = $BGuid1Node.Nodes.Add("GUIDcreated", "GUID created at: $($entry.'File Droid ID'.Created)")
												$BGuid1Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
												$Null = $BGuid1Node.Nodes.Add("MAC Address", "MAC Address: $($entry.'File Droid ID'.MAC)")
												$BGuid1Node.Nodes["MAC Address"].Tag = $entry.'File Droid ID'.MAC
												$BGuid1Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
												$bman1 = Get-MACManufacturer -MacAddress "$($entry.'File Droid ID'.MAC)"
												if (!!$bman1)
												{
													$Null = $BGuid1Node.Nodes.Add("MACManufacturer", "MAC Company: $($bman1)")
													$BGuid1Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
												}
											}
										}
										if (!!$entry.'Birth Volume Droid ID' -and $entry.'Birth Volume Droid ID'.ObjectID -ne '00000000-0000-0000-0000-000000000000')
										{
											$Guid2Node = $entryNode.Nodes.Add("$('Birth Volume Droid')", "Birth VolumeID: $($entry.'Birth Volume Droid ID'.ObjectID)")
											$Null = $Guid2Node.Nodes.Add("version", "GUID Version: $($entry.'Birth volume Droid ID'.version)")
											$Null = $Guid2Node.Nodes.Add("variant", "GUID Variant: $($entry.'Birth volume Droid ID'.variant)")
											$Null = $Guid2Node.Nodes.Add("Sequence", "GUID Sequence: $($entry.'Birth volume Droid ID'.Sequence)")
											if (!!$entry.'Birth volume Droid ID'.MAC)
											{
												# Add to tree
												$Null = $Guid2Node.Nodes.Add("GUIDcreated", "GUID created at: $($entry.'Birth Volume Droid ID'.Created)")
												$Guid2Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
												$Null = $Guid2Node.Nodes.Add("MAC Address", "MAC Address: $($entry.'Birth volume Droid ID'.MAC)")
												$Guid2Node.Nodes["MAC Address"].Tag = $entry.'Birth volume Droid ID'.MAC
												$Guid2Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
												$man2 = Get-MACManufacturer -MacAddress "$($entry.'Birth volume Droid ID'.MAC)"
												if (!!$man2)
												{
													$Null = $Guid2Node.Nodes.Add("MACManufacturer", "MAC Company: $($man2)")
													$Guid2Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
												}
											}
										}
										if (!!$entry.'Birth file Droid ID' -and $entry.'Birth file Droid ID'.ObjectID -ne '00000000-0000-0000-0000-000000000000')
										{
											$BGuid2Node = $entryNode.Nodes.Add("$('Birth File Droid')", "Birth File ObjectID: $($entry.'Birth file Droid ID'.ObjectID)")
											$Null = $BGuid2Node.Nodes.Add("version", "GUID Version: $($entry.'Birth file Droid ID'.version)")
											$Null = $BGuid2Node.Nodes.Add("variant", "GUID Variant: $($entry.'Birth file Droid ID'.variant)")
											$Null = $BGuid2Node.Nodes.Add("Sequence", "GUID Sequence: $($entry.'Birth file Droid ID'.Sequence)")
											if (!!$entry.'Birth file Droid ID'.MAC)
											{
												# Add to tree
												$Null = $BGuid2Node.Nodes.Add("GUIDcreated", "GUID created at: $($entry.'Birth file Droid ID'.Created)")
												$BGuid2Node.Nodes["GUIDcreated"].ForeColor = 'Cyan'
												$Null = $BGuid2Node.Nodes.Add("MAC Address", "MAC Address: $($entry.'Birth file Droid ID'.MAC)")
												$BGuid2Node.Nodes["MAC Address"].Tag = $entry.'Birth file Droid ID'.MAC
												$BGuid2Node.Nodes["MAC Address"].ForeColor = 'LightGreen'
												$bman2 = Get-MACManufacturer -MacAddress "$($entry.'Birth file Droid ID'.MAC)"
												if (!!$bman2)
												{
													$Null = $BGuid2Node.Nodes.Add("MACManufacturer", "MAC Company: $($bman2)")
													$BGuid2Node.Nodes["MACManufacturer"].ForeColor = 'Gold'
												}
											}
										}
										
										$null = $entryNode.Nodes.Add("$($e)entry.Hostname", "Hostname: $($entry.'Hostname')")
										$null = $entryNode.Nodes.Add("$($e)entry.ID", "LNK Stream ID: [$($entry.EntryID.ToString('X'))]")
										$entryNode.Nodes["$($e)entry.ID"].ForeColor = 'Orange'
										$LastAccessed = $entryNode.Nodes.Add("$($e)Last Accessed", "Last Accessed: $($entry.'Last Accessed')")
										$LastAccessed.ForeColor = 'Cyan'
										
										if ($entry.'Pin ID' -ne 'Unpinned')
										{
											$null = $entryNode.Nodes.Add("$($e)Pin ID", "Pin Entry: #$($entry.'Pin ID'.ToString('D3'))")
											$entryNode.Nodes["$($e)Pin ID"].ForeColor = 'MediumSpringGreen'
											$entryNode.Text = "$($streaminf.StreamName.ToString()) [$($entry.EntryID.ToString('X'))] Entry #$($e.ToString('D3')) Pin #$($entry.'Pin ID'.ToString('D2')) - $($entry.'String')"
											$entryNode.ForeColor = 'MediumSpringGreen' #'DodgerBlue'
										}
										else
										{
											$null = $entryNode.Nodes.Add("$($e)Pin ID", "Pin Status: Unpinned")
										}
										if ($null -ne $entry.'InQuickAccess')
										{
											$null = $entryNode.Nodes.Add("$($e)InQuickAccess", "InQuickAccess: $($entry.'InQuickAccess')")
										}
										$null = $entryNode.Nodes.Add("$($e)String Data Length", "String Data Length: $($entry.'String Data Length')")
										$null = $entryNode.Nodes.Add("$($e)String", "String: $($entry.'String'.Replace(':', '~'))")
										$entryNode.Nodes["$($e)String"].ForeColor = 'LightGreen'
										
										if ($entry.ExtensionSize -gt 0)
										{
											$null = $entryNode.Nodes.Add("$($e)ExtensionSize", "PropertyStore Size: $($entry.ExtensionSize)")
											$items = Get-Ext_SPS1 -ByteArray ($entry.ExtensionData)
											$PropertyStoreEntries = [System.Collections.ArrayList]::new()
											foreach ($property in $items)
											{
												$PropertyStoreEntry = [PSCustomObject]::new()
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
												$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
												$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
											}
											if (!!$items)
											{
												Populate-SPS1 -Node $entryNode -SPS1properties @($PropertyStoreEntries)
											}
										}
										# Add the Raw Stream (LNK) Hex Data
										if (!!$entry.RawEntryData)
										{
											$rawstream = $entryNode.Nodes.Add("RawHexData", "Stream Data")
											$rawstream.Tag = @($entry.RawEntryData)
											$rawstream.ToolTipText = "Right click to copy the raw (Hex) data ($($entry.RawEntryData.length))"
											$rawstream.ForeColor = 'Peru'
										}
										$e = $e + 1
									}
								}
								
								if ($null -ne $x.DataLength)
								{
									$sdata = [System.BitConverter]::ToString($streaminf.Data).Replace('-', '')
									$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.Data.count)")
									$null = $DestNode.Nodes.Add("Data", "Stream Data")
									$DestNode.Nodes["Data"].Tag = @($sdata)
									$DestNode.Nodes["Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($x.DataLength))"
									$DestNode.Nodes["Data"].ForeColor = 'Peru'
								}
							}
							else
							{
								$DestNode.ToolTipText =  "Stream has no Data"
								$DestNode.ForeColor = 'Gray'
							}
						} #end try
						catch
						{
							if ($null -ne $streaminf.Data)
							{
								$sdata = [System.BitConverter]::ToString($streaminf.Data).Replace('-', '')
								$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.DataLength)")
								$null = $DestNode.Nodes.Add("Data", "Stream Data")
								$DestNode["Data"].Tag = @($sdata)
								$DestNode["Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($streaminf.DataLength))"
								$DestNode["Data"].ForeColor = 'Peru'
							}
							else
							{
								$DestNode.ToolTipText = "Stream has no Data"
								$DestNode.ForeColor = 'Gray'
							}
						}
					}
					# Process DestListPropertyStore
					elseif ($LNKData -eq $null -and ($streaminf.StreamName -eq 'DestListPropertyStore'))
					{
						$check2 = $Root2.Nodes.Find("$($streaminf.StreamName)", $true)
						if (!!$check2)
						{
							$DestNode = $check2[0]
						}
						else
						{
							$DestNode = $Root2.Nodes.Add("$($streaminf.StreamName)", "$($streaminf.StreamName) Stream")
						}
						
						if ($null -ne $streaminf.Data)
						{
							$StreamSize = [System.BitConverter]::ToInt32($streaminf.data[0 .. 3], 0)
							if ($StreamSize -eq 0)
							{
								$DestNode.ForeColor = 'Gray'
								continue
							}
							$sdata = [System.BitConverter]::ToString($streaminf.Data).Replace('-', '')
							if ($streaminf.data.count -gt 12 -and [System.BitConverter]::ToString($streaminf.data[8 .. 11]) -eq '31-53-50-53') # 1SPS
							{
								$items = Get-Ext_SPS1 -ByteArray $streaminf.Data
								$PropertyStoreEntries = [System.Collections.ArrayList]::new()
								foreach ($property in $items)
								{
									$PropertyStoreEntry = [PSCustomObject]::new()
									$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
									$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
									$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
									$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
								}
								if (!!$items)
								{
									Populate-SPS1 -Node $DestNode -SPS1properties @($PropertyStoreEntries)
									$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.Data.count)")
									$null = $DestNode.Nodes.Add("Data", "Stream Data")
									$DestNode.Nodes["Data"].Tag = @($sdata)
									$DestNode.Nodes["Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($sdata.Length))"
									$DestNode.Nodes["Data"].ForeColor = 'Peru'
									$DestNode.ForeColor = 'Fuchsia' # 'Lime'
								}
								else
								{
									$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.Data.count)")
									$null = $DestNode.Nodes.Add("Data", "Stream Data")
									$DestNode.Nodes["Data"].Tag = @($sdata)
									$DestNode.Nodes["Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($sdata.Length))"
									$DestNode.Nodes["Data"].ForeColor = 'Peru'
									$DestNode.ForeColor = 'Teal'
								}
							}
							else
							{
								$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.Data.count)")
								$null = $DestNode.Nodes.Add("Data", "Stream Data")
								$DestNode.Nodes["Data"].Tag = @($sdata)
								$DestNode.Nodes["Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($streaminf.Data.count))"
								$DestNode.Nodes["Data"].ForeColor = 'Peru'
								$DestNode.ForeColor = 'Teal'
							}
						}
						else
						{
							$DestNode.ForeColor = 'Gray'
						}
					}
					else
					{
						$check2 = $Root2.Nodes.Find("$($streaminf.StreamName)", $true)
						if (!!$check2)
						{
							$DestNode = $check2[0]
						}
						else
						{
							$DestNode = $Root2.Nodes.Add($streaminf.StreamName, "Stream Name: $($streaminf.StreamName)")
						}
						
						if (!!$streaminf.Data)
						{
							$sdata = [System.BitConverter]::ToString($streaminf.Data).Replace('-', '')
							$null = $DestNode.Nodes.Add("DataSize", "Stream Data Size: $($streaminf.DataLength)")
							$null = $DestNode.Nodes.Add("Raw Data", "Stream Data")
							$DestNode.Nodes["Raw Data"].Tag = @($sdata)
							$DestNode.Nodes["Raw Data"].ToolTipText = "Right click to copy the raw (Hex) data ($($streaminf.DataLength))"
							$DestNode.Nodes["Raw Data"].ForeColor = 'Peru'
							$DestNode.ForeColor = 'Red'
						}
						else
						{
							$sdata = $null
							$null = $DestNode.Nodes.Add("DataSize", "Stream has no Data")
							$DestNode.ForeColor = 'Gray'
						}
					}
				} # End Stream Processing
				
				$Status.Text = 'Please wait - Loading Tree ..'
				$treeview2.EndUpdate()
				$treeview2.Nodes[0].Expand()
				if ($treeview2.Nodes[0].Nodes['LNK_Nodes'])
				{
					$treeview2.Nodes[0].Nodes['LNK_Nodes'].Expand()
				}
				if ($treeview2.Nodes[0].Nodes['DestList'])
				{
					$treeview2.Nodes[0].Nodes['DestList'].Expand()
					if ($treeview2.Nodes[0].Nodes['DestList'].Nodes['Entries'])
					{
						$treeview2.Nodes[0].Nodes['DestList'].Nodes['Entries'].Expand()
					}
					elseif($treeview2.Nodes[0].Nodes['DestList'].Nodes["Header"])
					{
						$treeview2.Nodes[0].Nodes['DestList'].Nodes["Header"].Expand()
						$treeview2.Nodes[0].Nodes['DestList'].Nodes["Header"].EnsureVisible()
					}
				}
				if ($treeview2.Nodes[0].Nodes['DestListPropertyStore'])
				{
					$treeview2.Nodes[0].Nodes['DestListPropertyStore'].Expand()
					if ($treeview2.Nodes[0].Nodes['DestListPropertyStore'].GetNodeCount($true) -gt 1)
					{
						$treeview2.Nodes[0].Nodes['DestListPropertyStore'].Nodes[0].Expand()
						$treeview2.Nodes[0].Nodes['DestListPropertyStore'].EnsureVisible()
					}
					
				}
				$TreeSearch.Visible = $true
				$Status.Text = "Selected file: $($fname) - Ready"
			}
			else
			{
				$treeview2.BeginUpdate()
				$treeview2.Nodes.Clear()
				[System.GC]::Collect()
				# Add Root Node
				$Root2 = $treeview2.Nodes.Add("Root", "$($fname)")
				$Root2.ToolTipText = "$($File)"
				$null = $Root2.Nodes.Add("FullPath", "Full Path: $($File)")
				if ($fname -match '.automaticDestinations-ms')
				{
					$PathHash = $fname.Replace('.automaticDestinations-ms', '')
					$appidnode = $Root2.Nodes.Add("$($PathHash)", "AppID: $($PathHash.ToUpper())")
					$appidnode.ForeColor = 'LimeGreen'
					if (!!$AppIDs["$($PathHash)"])
					{
						$appidnode.Text = "$($appidnode.Text) [$($AppIDs["$($PathHash)"])]"
					}
				}
				
				if (!!$result)
				{
					# Close Microsoft Compound File Binary File Format, Version 4'
					$result = $storageRootType.InvokeMember("Close", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::InvokeMethod, $null, $result, $null)
				}
				$Status.Text = "$($fname) has NO streams"
				[System.Console]::Beep(500, 150)
				$treeview2.Nodes[0].Expand()
				$treeview2.EndUpdate()
				$TreeSearch.Visible = $false
			}
		}
		catch [System.Management.Automation.InvocationInfo]{
			if (!!$result)
			{
				# Close Microsoft Compound File Binary File Format, Version 4'
				$result = $storageRootType.InvokeMember("Close", [System.Reflection.BindingFlags]::Static -bor [System.Reflection.BindingFlags]::Instance -bor [System.Reflection.BindingFlags]::Public -bor [System.Reflection.BindingFlags]::NonPublic -bor [System.Reflection.BindingFlags]::InvokeMethod, $null, $result, $null)
				$Status.Text = "$($fname) has no streams"
			}
		}
		catch
		{
			$treeview2.EndUpdate()
			$TreeSearch.Visible = $TreeSearchState
		}
		[GC]::Collect()
	} # End Process-Automatic
	
	function Get-SubKeysHKCU
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Node,
			[Parameter(Mandatory = $true)]
			$key
		)
		
		$ParentTimestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
		$Timestamps = Get-RegKeyLastWriteTime -SubKey $key
		if ($Timestamps.Count -eq 0) { $Timestamps = $ParentTimestamps }
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		$registrykey = $Registry.OpenSubKey($key)
		if (!$registrykey) { return }
		
		$keyname = split-path $key -Leaf
		$keyparent = split-path $key -Parent
		$Status.Text = "Please wait - Processing $($key)"
		$MRUList = [System.Collections.ArrayList]::new()
		$MRUListEx = $registrykey.GetValue([System.String]'MRUListEx')
		$count = $MRUListEx.count
		for ($m = 0; $m -lt $count; $m = $m + 4)
		{
			$null = $MRUList.Add([System.BitConverter]::ToUInt32($MRUListEx[$m .. ($m + 3)], 0))
		}
		
		ForEach ($sub in $MRUList <#$registrykey.GetSubKeyNames()#>)
		{
			# Get SubKey Values
			$SubkeyValue = $registrykey.GetValue([System.String]$sub)
			$LastWriteTime = if (!!$Timestamps[[System.String]$sub]) { $Timestamps[[System.String]$sub] }
			if ($null -ne $SubkeyValue)
			{
				try { $itemID = [ShellLink.Structures.ItemID]::FromByteArray($SubkeyValue) }
				catch { $itemID = $null }
				
				$MRUcontents = [PSCustomObject]@{
					'Key' = ($registrykey.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
					'SubKey' = $sub
					'LastWriteTime' = $LastWriteTime
					'Data' = ([System.BitConverter]::ToString($SubkeyValue) -replace '-', '')
					'ItemID' = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID } else{ $null }
				}
				
				[System.Windows.Forms.Application]::DoEvents()
				
				# Add Node
				$subkeynode = $Node.Nodes.Add("$($sub)", "$($sub)")
				$subkeynode.Tag = @($null, $null, $MRUcontents)
				
				if ($MRUcontents.ItemID.ItemIDType -notin ('1F', 'C3', '31', '32', '35', '36', '3A', 'B1', '23', '2E', '2F', '74', '77'))
				{
					$subkeynode.ImageIndex = 5
					$subkeynode.SelectedImageIndex = 6
					if (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
					elseif (!!$MRUcontents.ItemID.CLSID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CLSID)"
					}
					elseif (!!$MRUcontents.ItemID.CPcategory)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CPcategory)"
					}
					elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty)
					{
						if (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }[0].TypedProp.Value)" }
						elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }[0].TypedProp.Value)" }
						elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }[0].TypedProp.Value)" }
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -eq '1F')
				{
					$subkeynode.ImageIndex = 9
					$subkeynode.SelectedImageIndex = 10
					if (!!$MRUcontents.ItemID.DriveLetter)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.DriveLetter)"
					}
					elseif (!!$MRUcontents.ItemID.CLSID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CLSID)"
					}
					elseif (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
					elseif (!!$MRUcontents.ItemID.SortOrderIndex)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.SortOrderIndex)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('23', '2E', '2F'))
				{
					$subkeynode.ImageIndex = 9
					$subkeynode.SelectedImageIndex = 10
					if (!!$MRUcontents.ItemID.DriveLetter)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.DriveLetter)"
					}
					elseif (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
					elseif (!!$MRUcontents.ItemID.CLSID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CLSID)"
					}
					elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty)
					{
						if (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemNameDisplay [B725F130-47EF-101A-A5F1-02608C9EEBAC\10]' }[0].TypedProp.Value)" }
						elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'Devices FriendlyName [656A3BB3-ECC0-43FD-8477-4AE0404A96CD\12288]' }[0].TypedProp.Value)" }
						elseif (!!$MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }[0].TypedProp.Value)
						{ $subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.PropertyStoreEntries.TypedProperty.Where{ $_.Description -eq 'ItemName [6B8DA074-3B5C-43BC-886F-0A2CDCE00B6F\100]' }[0].TypedProp.Value)" }
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -eq 'C3')
				{
					$subkeynode.ImageIndex = 7
					$subkeynode.SelectedImageIndex = 8
					if ($MRUcontents.ItemID.Path -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Path)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('31', '35', 'B1', '74')) # Folder
				{
					$subkeynode.ImageIndex = 1
					$subkeynode.SelectedImageIndex = 2
					if (!!$MRUcontents.ItemID.ItemIdExtensions -and $MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name)"
					}
					
					else
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Ansi_Name)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('32', '36', '3A', '77')) # File
				{
					$subkeynode.ImageIndex = 3
					$subkeynode.SelectedImageIndex = 4
					if (!!$MRUcontents.ItemID.ItemIdExtensions -and $MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name)"
					}
					else
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Ansi_Name)"
					}
				}
				
				Get-SubKeysHKCU -Node $subkeynode -key "$($key)\$($sub)"
			}
		}
		
		$Registry.Close()
		$Registry.Dispose()
	} # End Get-SubKeysHKCU 
	
	function Get-SubKeysClassesRoot
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Node,
			[Parameter(Mandatory = $true)]
			$key
		)
		
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::ClassesRoot, [Microsoft.Win32.RegistryView]::Default)
		$registrykey = $Registry.OpenSubKey($key)
		
		$MRUList = [System.Collections.ArrayList]::new()
		$MRUListEx = $registrykey.GetValue([System.String]'MRUListEx')
		$count = $MRUListEx.count
		for ($m = 0; $m -lt $count; $m = $m + 4)
		{
			$null = $MRUList.Add([System.BitConverter]::ToUInt32($MRUListEx[$m .. ($m + 3)], 0))
		}
		
		ForEach ($sub in $MRUList<#$registrykey.GetSubKeyNames()#>)
		{
			#	$subkey = $registry.OpenSubKey("$($key)\$($sub)")
			$SubkeyValue = $registrykey.GetValue([System.String]$sub)
			if ($null -ne $SubkeyValue)
			{
				try { $itemID = [ShellLink.Structures.ItemID]::FromByteArray($SubkeyValue) }
				catch { $itemID = $null }
				
				$MRUcontents = [PSCustomObject]@{
					'Key' = ($registrykey.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
					'SubKey' = $sub
					'Data' = ([System.BitConverter]::ToString($SubkeyValue) -replace '-', '')
					'ItemID' = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID } else{ $null }
				}
				
				# Add Node
				$subkeynode = $Node.Nodes.Add("$($sub)", "$($sub)")
				$subkeynode.Tag = @($null, $null, $MRUcontents)
				if ($MRUcontents.ItemID.ItemIDType -notin ('1F', 'C3', '31', '32', '35', '36', '3A', 'B1', '23', '2E', '2F', '74', '77'))
				{
					$subkeynode.ImageIndex = 5
					$subkeynode.SelectedImageIndex = 6
					if (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
					elseif (!!$MRUcontents.ItemID.CLSID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CLSID)"
					}
					elseif (!!$MRUcontents.ItemID.CPcategory)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CPcategory)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -eq '1F')
				{
					$subkeynode.ImageIndex = 9
					$subkeynode.SelectedImageIndex = 10
					if (!!$MRUcontents.ItemID.DriveLetter)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.DriveLetter)"
					}
					elseif (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
					elseif (!!$MRUcontents.ItemID.CLSID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.CLSID)"
					}
					elseif (!!$MRUcontents.ItemID.SortOrderIndex)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.SortOrderIndex)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('23', '2E', '2F'))
				{
					$subkeynode.ImageIndex = 9
					$subkeynode.SelectedImageIndex = 10
					if (!!$MRUcontents.ItemID.DriveLetter)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.DriveLetter)"
					}
					elseif (!!$MRUcontents.ItemID.GUID)
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.GUID)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -eq 'C3')
				{
					$subkeynode.ImageIndex = 7
					$subkeynode.SelectedImageIndex = 8
					if ($MRUcontents.ItemID.Name -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Name)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('31', '35', 'B1', '74')) # Folder
				{
					$subkeynode.ImageIndex = 1
					$subkeynode.SelectedImageIndex = 2
					if (!!$MRUcontents.ItemID.ItemIdExtensions -and $MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name)"
					}
					else
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Ansi_Name)"
					}
				}
				elseif ($MRUcontents.ItemID.ItemIDType -in ('32', '36', '3A', '77')) # File
				{
					$subkeynode.ImageIndex = 3
					$subkeynode.SelectedImageIndex = 4
					if (!!$MRUcontents.ItemID.ItemIdExtensions -and $MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name -ne '')
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.ItemIdExtensions[0].Unicode_Name)"
					}
					else
					{
						$subkeynode.Text = "$($subkeynode.Text) - $($MRUcontents.ItemID.Ansi_Name)"
					}
				}
				Get-SubKeysClassesRoot -Node $subkeynode -key "$($key)\$($sub)"
			}
		}
		
		$Registry.Close()
		$Registry.Dispose()
	} # End Get-SubKeysClassesRoot
	
	function Get-RecentDocs
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Node,
			[Parameter(Mandatory = $true)]
			$key
		)
		$keyname = split-path $key -Leaf
		$keyparent = split-path $key -Parent
		$ParentTimestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
		$Timestamps = Get-RegKeyLastWriteTime -SubKey $key
		if ($Timestamps.Count -eq 0) { $Timestamps = $ParentTimestamps }
		
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		$registrykey = $Registry.OpenSubKey($key)
		if (!$registrykey) { return }
		
		if ($registrykey.ValueCount -gt 0 -and $keyname -in ('RecentDocs'))
		{
			$LastWriteTime = if (!!$ParentTimestamps[[System.String]$keyname]) { $ParentTimestamps[[System.String]$keyname] }
			$ValueNames = $registrykey.GetValueNames()
			$Status.Text = "Please wait - Processing $($key)"
			$MRUListS = [System.Collections.ArrayList]::new()
			$MRUListExS = $registrykey.GetValue([System.String]'MRUListEx')
			$count = $MRUListExS.count
			for ($m = 0; $m -lt $count; $m = $m + 4)
			{
				if([System.BitConverter]::ToInt32($MRUListExS[$m .. ($m + 3)], 0) -eq -1){break} # 0xFFFFFFFF
				$null = $MRUListS.Add([System.BitConverter]::ToUInt32($MRUListExS[$m .. ($m + 3)], 0))
			}
			if (!$MRUListS) { $MRUListS = $ValueNames }
			
			$RecentNode = $Node.Nodes.Add("RecentDocsMRU", "RecentDocs MRU Files")
			$RecentNode.ImageIndex = 15
			$RecentNode.SelectedImageIndex = 16
			foreach ($name in ($MRUListS -ne 'MRUListEx'))
			{
				$KeyValue = $registrykey.GetValue([System.String]$name)
				$Valuenode = $RecentNode.Nodes.Add("$($KeyValue)", "$($name)")
				
				if ($null -ne $keyValue)
				{
					try
					{
						$TargetString = [System.Text.Encoding]::Unicode.GetString($KeyValue)
						if ($keyname -in ('RecentDocs'))
						{
							$TargetName = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')[0]
							$idx = $TargetName.Length * 2 + 2
							$itemID = [ShellLink.Structures.ItemID]::FromByteArray($KeyValue[$idx .. ($KeyValue.Count - 1)])
							# Add Node
							$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
							else { $null }
							$Valuenode.Text = "[$($name)] $($TargetName)"
						}
						elseif ($keyname -in ('OpenSavePidlMRU'))
						{
							$itemIDlist = Get-EmbeddedIDList -ByteArray $KeyValue -Index 0
							
							# @(Get-EmbeddedIDList -ByteArray $SubkeyValue -Index 0)
							# [ShellLink.Structures.LinkTargetIDList]::FromByteArray([System.BitConverter]::GetBytes([uint16]$SubkeyValue.Count) + $SubkeyValue).ItemIDList
							# Add Node
						}
						elseif ($keyname -in ('Streams'))
						{
							$itemID = [ShellLink.Structures.ItemID]::FromByteArray(([System.BitConverter]::GetBytes($KeyValue.Count) + $KeyValue))
							$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
							else { $null }
						}
						else
						{
							$itemID = [ShellLink.Structures.ItemID]::FromByteArray($KeyValue)
							$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
							else { $null }
						}
					}
					catch { $itemIDlist = $null }
					
					$MRUcontentsS = [PSCustomObject]@{
						'Key' = ($registrykey.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
						'SubKey' = $name
						'LastWriteTime' = $LastWriteTime
						'Data' = ([System.BitConverter]::ToString($KeyValue, 0).replace('-', ''))
						'TargetName' = $TargetName
						'ItemID' = $itemIDlist
					}
					
					[System.Windows.Forms.Application]::DoEvents()
					
					# Add Node
					$Valuenode.Tag = @($null, $null, $MRUcontentsS)
					$Valuenode.ImageIndex = 3
					$Valuenode.SelectedImageIndex = 4
				}
			}
		}
		
		if ($registrykey.SubKeyCount -gt 0)
		{
			$SubKeyNames = $registrykey.GetSubKeyNames()
			ForEach ($subkey in $SubKeyNames)
			{
				$LastWriteTime = if (!!$Timestamps[[System.String]$subkey]) { $Timestamps[[System.String]$subkey] }
				$subkeys = $registry.OpenSubKey("$($key)\$($subkey)")
				ForEach ($sub in $subkeys)
				{
					# Add Node
					$nodename = split-path $sub.Name -Leaf
					$subkeynode = $Node.Nodes.Add("$($nodename)", "$($nodename)")
					$subkeynode.ImageIndex = 1
					$subkeynode.SelectedImageIndex = 2
					$Status.Text = "Please wait - Processing $($key)\$($subkey)"
					# Get Value Names
					$SubkeyValueNames = $sub.GetValueNames()
					
					# Get MRUlist Order
					$MRUList = [System.Collections.ArrayList]::new()
					$MRUListEx = $subkeys.GetValue([System.String]'MRUListEx')
					$count = $MRUListEx.count
					for ($m = 0; $m -lt $count; $m = $m + 4)
					{
						$null = $MRUList.Add([System.BitConverter]::ToUInt32($MRUListEx[$m .. ($m + 3)], 0))
					}
					if (!$MRUList) { $MRUList = $SubkeyValueNames }
					# foreach ($name in ($SubkeyValueNames -ne 'MRUListEx'))
					foreach ($name in $MRUList)
					{
						$SubkeyValue = $subkeys.GetValue([System.String]$name)
						
						if ($null -ne $SubkeyValue)
						{
							try
							{
								$TargetString = [System.Text.Encoding]::Unicode.GetString($SubkeyValue)
								if ($keyname -in ('RecentDocs', 'LastVisitedPidlMRU'))
								{
									$TargetName = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')[0]
									$idx = $TargetName.Length * 2 + 2
									$itemID = [ShellLink.Structures.ItemID]::FromByteArray($SubkeyValue[$idx .. ($SubkeyValue.Count - 1)])
									# Add Node
									$subkeyValuenode = $subkeynode.Nodes.Add("$($TargetName)", "[$($name)] $($TargetName)")
									$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
									else { $null }
								}
								elseif ($keyname -in ('OpenSavePidlMRU'))
								{
									$itemIDlist = Get-EmbeddedIDList -ByteArray $SubkeyValue -Index 0
									
									# @(Get-EmbeddedIDList -ByteArray $SubkeyValue -Index 0)
									# [ShellLink.Structures.LinkTargetIDList]::FromByteArray([System.BitConverter]::GetBytes([uint16]$SubkeyValue.Count) + $SubkeyValue).ItemIDList
									# Add Node
									$subkeyValuenode = $subkeynode.Nodes.Add("$($name)", "$($name)")
									
									if (!!$itemIDlist)
									{
										$ic = $itemIDlist.Count
										$iname = if (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
										elseif (!! $itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
										elseif (!!$itemIDlist[0].CLSID) { $itemIDlist[0].CLSID }
										elseif (!!$itemIDlist[0].GUID) { $itemIDlist[0].GUID }
										else { $null }
										
										if (!!$iname)
										{
											$subkeyValuenode.Text = "[$($subkeyValuenode.Text)] $($iname)"
										}
									}
								}
								elseif ($keyname -in ('Streams'))
								{
									$itemID = [ShellLink.Structures.ItemID]::FromByteArray(([System.BitConverter]::GetBytes([uint16]$SubkeyValue.Count) + $SubkeyValue[2 .. ($SubkeyValue.Count - 1)]))
									$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
									else { $null }
									$CLSID = Get-CLSID -CLSIDstring $name.TrimStart('{').TrimEnd('}')
									if(!!$CLSID){$name = $CLSID}
									$subkeyValuenode = $subkeynode.Nodes.Add("$($name)", "$($name)")
								}
								else
								{
									$itemID = [ShellLink.Structures.ItemID]::FromByteArray($SubkeyValue)
									$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
									else { $null }
									
									$subkeyValuenode = $subkeynode.Nodes.Add("$($name)", "$($name)")
								}
							}
							catch { $itemIDlist = $null }
							
							$MRUcontents = [PSCustomObject]@{
								'Key' = ($subkeys.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
								'SubKey' = $name
								'LastWriteTime' = $LastWriteTime
								'Data' = ([System.BitConverter]::ToString($subkeyvalue, 0).replace('-', ''))
								'TargetName' = $TargetName
								'ItemID' = $itemIDlist
							}
							
							[System.Windows.Forms.Application]::DoEvents()
							
							# Add Node
							$subkeyValuenode.Tag = @($null, $null, $MRUcontents)
							$subkeyValuenode.ImageIndex = 3
							$subkeyValuenode.SelectedImageIndex = 4
						}
					}
				}
			}
		}
		else
		{
			# Add Node
			$nodename = split-path $key -Leaf
			$subkeynode = $Node
			# Get Value Names
			$SubkeyValueNames = $registrykey.GetValueNames()
			$LastWriteTime = if (!!$Timestamps[[System.String]$nodename]) { $Timestamps[[System.String]$nodename] }
			
			# Get MRUlist Order
			$MRUList = [System.Collections.ArrayList]::new()
			$MRUListEx = $registrykey.GetValue([System.String]'MRUListEx')
			$count = $MRUListEx.count
			for ($m = 0; $m -lt $count; $m = $m + 4)
			{
				$null = $MRUList.Add([System.BitConverter]::ToUInt32($MRUListEx[$m .. ($m + 3)], 0))
			}
			if (!$MRUList) { $MRUList = $SubkeyValueNames }
			# foreach ($name in ($SubkeyValueNames -ne 'MRUListEx'))
			foreach ($name in $MRUList)
			{
				$SubkeyValue = $registrykey.GetValue([System.String]$name)
				
				if ($null -ne $SubkeyValue)
				{
					try
					{
						if ($keyname -in ('LastVisitedPidlMRU', 'LastVisitedPidlMRULegacy', 'WordWheelQuery'))
						{
							$TargetString = [System.Text.Encoding]::Unicode.GetString($SubkeyValue)
							$TargetName = [System.Text.RegularExpressions.Regex]::Split($TargetString, '\x00')[0]
							$idx = $TargetName.Length * 2 + 2
							$itemIDlist = Get-EmbeddedIDList -ByteArray $SubkeyValue -Index $idx
							$subkeyValuenode = $subkeynode.Nodes.Add("$($name)", "$($name)")
							$subkeyValuenode.Text = "[$($subkeyValuenode.Text)] $($TargetName)"
						}
						else # one IDlist usually (eg StreamMRU )
						{
							$itemID = [ShellLink.Structures.ItemID]::FromByteArray($SubkeyValue)
							$itemIDlist = if ($itemID -is [ShellLink.Structures.ItemID]) { Get-LinkTargetIdList -ItemIdListItem $itemID }
							else { $null }
							$subkeyValuenode = $subkeynode.Nodes.Add("$($name)", "$($name)")
							
							if (!!$itemIDlist)
							{
								$ic = $itemIDlist.count
								$iname = if (!!$itemIDlist[0].CLSID) { $itemIDlist[0].CLSID }
								elseif (!!$itemIDlist[0].SortOrderIndex) { $itemIDlist[0].SortOrderIndex }
								elseif (!!$itemIDlist[0].GUID) { $itemIDlist[0].GUID }
								elseif (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
								elseif ($itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
								else { $null }
								if (!!$iname)
								{
									$subkeyValuenode.Text = "$($subkeyValuenode.Text) - $($iname)"
								}
							}
						}
					}
					catch { $itemIDlist = $null }
					
					$MRUcontents = [PSCustomObject]@{
						'Key' = ($registrykey.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
						'SubKey' = $name
						'LastWriteTime' = $LastWriteTime
						'Data' = ([System.BitConverter]::ToString($subkeyvalue, 0).replace('-', ''))
						'TargetName' = $TargetName
						'ItemID' = $itemIDlist
					}
					
					[System.Windows.Forms.Application]::DoEvents()
					
					# Add Node
					$subkeyValuenode.Tag = @($null, $null, $MRUcontents)
					$subkeyValuenode.ImageIndex = 3
					$subkeyValuenode.SelectedImageIndex = 4
				}
			}
		}
		$Registry.Close()
		$Registry.Dispose()
	} # End Get-SubKeysClassesRoot
	
	function Process-MRUlist
	{
		[OutputType([System.Boolean])]
		param ()
		$false
		$toolstripRefresh.Visible = $false
		$treeview1.BeginUpdate()
		$treeview1.Nodes.Clear()
		$treeview2.Nodes.Clear()
		
		if (!!$Script:AppListIdx)
		{
			$Script:AppListIdx.Clear()
		}
		$TreeSearch.Visible = $false
		$TreeSearch.Text = "Search"
		[System.GC]::Collect()
		
		$Root = $treeview1.Nodes.Add('Registry', 'Registry (HKCU)')
		$Root.ImageIndex = 19
		$Root.SelectedImageIndex = 19
		$Root.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
		$Root.ForeColor = 'DarkTurquoise'
		
		$Status.Text = "Please wait - Collecting Registry entries ..."
		# Current User
		$RegistryKeys = @(
			'Software\Microsoft\Windows\Shell\BagMRU' #NTUser.dat
			'Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU' # UsrClass.dat
		)
		foreach ($Registrykey in $RegistryKeys)
		{
			$Status.Text = "Please wait - Processing: $($Registrykey)"
			$RegistrykeyName = Split-Path $Registrykey -Leaf
			$HKCUnode = $Root.Nodes.Add("$($RegistrykeyName)", "$($RegistrykeyName)")
			$HKCUnode.ToolTipText = "$($Registrykey)"
			$HKCUnode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
			$HKCUnode.ImageIndex = 19
			$HKCUnode.SelectedImageIndex = 19
			[System.Windows.Forms.Application]::DoEvents()
			Get-SubKeysHKCU -Node $HKCUnode -key $Registrykey
		}
		
		# Get RecentDocs
		$RegistryKeys = @(
			'Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\TWinUI\FilePicker\LastVisitedPidlMRU'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\StreamMRU'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\Streams'
			'Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery'
		)
		#$RegistryKey = 'Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs'
		foreach ($Registrykey in $RegistryKeys)
		{
			$RegistrykeyName = Split-Path $Registrykey -Leaf
			$RecentNode = $Root.Nodes.Add("$($RegistrykeyName)", "$($RegistrykeyName)")
			$RecentNode.ToolTipText = "$($Registrykey)"
			$RecentNode.ImageIndex = 19
			$RecentNode.SelectedImageIndex = 19
			$RecentNode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
			$Status.Text = "Please wait - Processing: $($Registrykey)"
			Get-RecentDocs -Node $RecentNode -key $Registrykey
			[System.Windows.Forms.Application]::DoEvents()
		}
		
		$Status.Text = "Ready"
		$Root.Expand()
		$Root.Nodes[0].Expand()
		$treeview1.EndUpdate()
	} # End Process-MRUlist
	
	function Process-NavPane
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[Byte[]]$ValueData
		)
		
		$count = $ValueData.count
		$NavPane = [System.Collections.ArrayList]::new()
		$idx = 4
		while ($idx -lt $count)
		{
			$Status.Text = "Please wait - Data size: $($count.ToString('N0')) - Collecting entries .."
			$IDlist = Get-EmbeddedIdlist -ByteArray $ValueData[$idx..($count - 1)] -index 2
			[System.Windows.Forms.Application]::DoEvents()
			if (!!$IDlist)
			{
				$ic = ($IDlist.ItemIDSize | Measure-Object -Sum).sum + 4
			}
			else
			{
				break
			}
			$Unknown = [System.BitConverter]::ToString($ValueData[($idx + $ic) .. ($idx + $ic + 3)]).replace('-', '')
			$idx = $idx + $ic + 6
			$sl = [System.BitConverter]::ToUInt32($ValueData[$idx .. ($idx + 3)], 0)
			$1SPS = Get-Ext_SPS1 -ByteArray ($ValueData[$idx .. ($idx + $sl + 4)])
			if (!!$1SPS)
			{
				$PropertyStoreEntries = [System.Collections.ArrayList]::New()
				foreach ($property in $1SPS)
				{
					$PropertyStoreEntry = [PSCustomObject]::new()
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'Storage Size' -Value $property.'Storage Size'
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'FormatID' -Value $property.FormatID
					$PropertyStoreEntry | Add-Member -MemberType NoteProperty -Name 'TypedProperty' -Value $property.PropertyStore
					$null = $PropertyStoreEntries.Add($PropertyStoreEntry)
				}
				
				$Properties = [psCustomObject]@{
					'idx' = $idx + $sl
					'IDlist' = @($IDlist)
					'IDlist_size' = $ic
					'1SPS_size' = $sl
					'Unknown' = $Unknown
					'SerialisedPS' = $PropertyStoreEntries
				}
				$null = $NavPane.Add($Properties)
			}
			else
			{
				break
			}
			$idx = $idx + $sl + 4
			if ($idx -ge $count) { break }
		}
		
		return $NavPane
	} # End Process-NavPane
	
	function Process-TaskBand
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$key,
			[Parameter(Mandatory = $true)]
			[System.String]$ValueName,
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.TreeNode]$Root,
			[Parameter(Mandatory = $false)]
			[int]$Index = 0
		)
		
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		$registrykey = $Registry.OpenSubKey($key)
		$linkkeys = @('.lnk', 'LNK', '.url') -join '|'
		
		if (!$registrykey) { return }
		
		if ($registrykey.ValueCount -gt 0)
		{
			$ValueNames = $registrykey.GetValueNames()
			if ($ValueName -in $ValueNames)
			{
				$ValueData = $registrykey.GetValue("$($ValueName)")
			}
			else { $null = $ValueData }
		}
		$Status.Text = "Data size: $($ValueData.Count)"
		$Registry.Close()
		$Registry.Dispose()
		
		if (!!$ValueData -and $ValueName -eq 'FavoritesResolve')
		{
			$FavoritesResolve = [System.Collections.ArrayList]::New()
			
			# Read the File & search for LNKs
			$dataoffsets = New-Object System.Collections.Generic.List[uint64]
			
			# Search for valid header size (0x0000004C) and LinkCLSID (00021401-0000-0000-C000-000000000046)
			# https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/c3376b21-0931-45e4-b2fc-a48ac0e60d15
			[System.Text.RegularExpressions.Regex]$regex = "(\x4C\x00\x00\x00\x01\x14\x02\x00\x00\x00\x00\x00\xC0\x00\x00\x00\x00\x00\x00\x46)"
			
			# Find LNK records
			$bufferstring = [System.Text.Encoding]::GetEncoding(28591).GetString($ValueData)
			
			if (!!($regex.Matches($bufferstring).success))
			{
				foreach ($match in $regex.Matches($bufferstring))
				{
					$null = $dataoffsets.Add($match.index)
				}
			}
			
			$ResNode = $Root.Nodes.Add("Root", "HKCU $($key)\$($ValueName)")
			$ResNode.ImageIndex = 19
			$ResNode.SelectedImageIndex = 19
			$ResNode.Forecolor = 'Orange'
			
			if ($dataoffsets.Count -ge 1)
			{
				$offsets = for ($r = 0; $r -lt $dataoffsets.Count; $r++)
				{
					$of = $dataoffsets[$r]
					$length = [System.BitConverter]::ToUInt32($ValueData[($of - 4) .. ($of - 1)], 0)
					
					[PSCustomObject]@{
						'Start' = [UInt64]$of
						'Length' = $length
					}
				}
				
				$Status.Text = "Found $($dataoffsets.Count) LNK Signature matches"
				
				$o = 1
				$timer = [system.Diagnostics.Stopwatch]::StartNew()
				foreach ($offset in $offsets)
				{
					$data = $ValueData[$offset.start .. ($offset.start + $offset.Length - 1)]
					[System.Windows.Forms.Application]::DoEvents()
					if (!!$data)
					{
						try
						{
							[System.Windows.Forms.Application]::DoEvents()
							$LNKData = Get-ShellLinkfrombyteArray -bytearray $data
						}
						catch [System.Management.Automation.MethodInvocationException] {
							if ($offsets.count -eq 1)
							{
								$Status.Text = "[ShellLink] $($Error[0].Exception.InnerException.Message)"
							}
							else
							{
								$Status.Text = "Offset: $($offset) - $($Error[0].Exception.InnerException.Message)"
								
							}
							$Error.Clear()
							$LNKData = $null
							
							$o = $o + 1
							continue
						}
						catch
						{
							$LNKData = $null
							write-host "Error processing Offset: $($offset) as a ShellLNK"
							$o = $o + 1
							continue
						}
					}
					else
					{
						$LNKData -eq $null
						$o = $o + 1
						continue
					}
					
					$Status.Text = "Please wait - populating LNK $($o) of $($dataoffsets.Count)"
					if (!!$LNKData)
					{
						Populate-LNKData -LNKData $LNKData -offset $offset -o $o -Node $ResNode -ShellLink_data $data
					}
					
					$o = $o + 1
				}
			} # End if ValueData
			else
			{
				continue
			}
		}
		elseif (!!$ValueData -and $ValueName -eq 'Favorites')
		{
			$FavNode = $Root.Nodes.Add("Root", "HKCU $($key)\$($ValueName)")
			$FavNode.ImageIndex = 19
			$FavNode.SelectedImageIndex = 19
			$FavNode.Forecolor = 'Orange'
			$IDList = [System.Collections.ArrayList]::new()
			$n = 1
			for ($idx = 1; $idx -lt $ValueData.count)
			{
				$Status.Text = "Please wait - Reading entry #$($n) at offset #$($idx)"
				[System.Windows.Forms.Application]::DoEvents()
				$size = [System.BitConverter]::ToUInt32($ValueData[($idx) .. ($idx + 3)], 0)
				$itemidlist = Get-EmbeddedIDList -ByteArray ($ValueData[($idx + 4) .. ($idx + 4 + $size - 1)]) -Index 0
				# Add to tree
				$iDnode = $FavNode.Nodes.Add("ID_$($n)", "[$($idx.ToString('D5'))] Favorite #$($n.ToString('D3'))")
				Populate-ItemIdListItems -ItemIDListNode $iDnode -ItemIdList @($itemidlist)
				$n++
				if (!!$itemidlist)
				{
					$ic = $itemIDlist.Count
					$iname = if (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
					elseif (!! $itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
					elseif (!!$itemIDlist[0].CLSID) { $itemIDlist[0].CLSID }
					elseif (!!$itemIDlist[0].GUID) { $itemIDlist[0].GUID }
					else { $null }
					
					if (!!$iname)
					{
						$iDnode.Text = "$($iDnode.Text) - $($iname)"
						if ($iDnode.Text -match $linkkeys)
						{
							$iDnode.ImageIndex = 11
							$iDnode.SelectedImageIndex = 12
						}
						else
						{
							$iDnode.ImageIndex = 1
							$iDnode.SelectedImageIndex = 2
						}
					}
				}
				
				if (($idx + $size + 5) -ge $ValueData.count) { break }
				$idx = $idx + $size + 5
			}
		}
		elseif (!!$ValueData -and $ValueName.StartsWith('ProgramsCache'))
		{
			$ProgNode = $Root.Nodes.Add("Root", "HKCU $($key)\$($ValueName)")
			$ProgNode.ImageIndex = 19
			$ProgNode.SelectedImageIndex = 19
			$ProgNode.Forecolor = 'Orange'
			
			if ($ValueName -eq 'ProgramsCache')
			{
				$GUID = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ValueData[4 .. 19]).Replace('-', ''))"
				$CLSID = if (!!$GUID) { Get-CLSID -CLSIDstring $GUID }
				$CLSIDNode = $ProgNode.Nodes.Add("CLSID", "CLSID: $($CLSID)")
				$CLSIDNode.ForeColor = 'LimeGreen'
				$CLSIDNode.ImageIndex = 5
				$CLSIDNode.SelectedImageIndex = 6
			}
			$IDList = [System.Collections.ArrayList]::new()
			$p = 1
			for ($idx = $index; $idx -lt $ValueData.count)
			{
				[System.Windows.Forms.Application]::DoEvents()
				if ($ValueName -eq 'ProgramsCache')
				{
					$size = [System.BitConverter]::ToInt32($ValueData[($idx) .. ($idx + 3)], 0)
					if ($size -le 0)
					{
						$GUID = Get-GUIDfromHexString -Hex "$([System.BitConverter]::ToString($ValueData[($idx) .. ($idx + 15)]).Replace('-', ''))"
						$CLSID = if (!!$GUID) { Get-CLSID -CLSIDstring $GUID }
						$unknown = [System.BitConverter]::ToString($ValueData[($idx + 16) .. ($idx + 23)]).Replace('-', '')
						$CLSIDNode = $ProgNode.Nodes.Add("CLSID", "CLSID: $($CLSID)")
						$CLSIDNode.ForeColor = 'LimeGreen'
						$CLSIDNode.ImageIndex = 5
						$CLSIDNode.SelectedImageIndex = 6
						if ($unknown -ne '0002000000000001') { $idx = $idx + 16 + 1 }
						else { $idx = $idx + 16 + 8 }
					}
				}else{ $CLSIDNode = $ProgNode}
	
				$Status.Text = "Please wait - Reading entry #$($p) at offset #$($idx)"
				
				$size = [System.BitConverter]::ToUInt32($ValueData[($idx) .. ($idx + 3)], 0)
				if ($size -eq 0 -or $size -gt ($ValueData.count - $idx)) { break }
				
				$itemidlist = Get-EmbeddedIDList -ByteArray ($ValueData[($idx + 4) .. ($idx + 4 + $size - 1)]) -Index 0
				$list = [pscustomobject]@{
					'Offset' = $idx
					'Size'   = $size
					'ItemID' = $itemidlist
				}
				$null = $IDList.Add($list)
				# Add Entry to Node
				$iDnode = $CLSIDNode.Nodes.Add("ProgramID_$($p)", "[$($idx)] Entry #$($p.ToString('D3'))")
				Populate-ItemIdListItems -ItemIDListNode $iDnode -ItemIdList @($itemidlist)
				if (!!$itemidlist)
				{
					$ic = $itemIDlist.Count
					$iname = if (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
					elseif (!! $itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
					elseif (!!$itemIDlist[0].CLSID) { $itemIDlist[0].CLSID }
					elseif (!!$itemIDlist[0].GUID) { $itemIDlist[0].GUID }
					else { $null }
					
					if (!!$iname)
					{
						$iDnode.Text = "$($iDnode.Text) - $($iname)"
						if ($iname -match $linkkeys)
						{
							$iDnode.ImageIndex = 11
							$iDnode.SelectedImageIndex = 12
						}
						else
						{
							$iDnode.ImageIndex = 1
							$iDnode.SelectedImageIndex = 2
						}
					}
				}
				$p++
				if (($idx + $size + 5) -ge $ValueData.count) { break }
				$idx = $idx + $size + 5
			}
		}
		else
		{
			$treeview2.ImageList = $null
			return
		}
	} # End Process-TaskBand
	
	function Get-NavPane
	{
		$toolstripRefresh.Visible = $false
		$treeview1.Nodes.Clear()
		$treeview2.Nodes.Clear()
		$treeview2.ImageList = $null
		[System.GC]::Collect()
		$treeview2.BeginUpdate()
		
		# Just in case some other key fits the .. same profile
		$keylist = @(
			'Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\NavPane'
		)
		foreach ($key in $keylist)
		{
			$keyparent = split-path $key -Parent
			$Timestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
			$LastWriteTime = $Timestamps['NavPane']
			# Add Main Node
			$Root = $treeview2.Nodes.Add("$($key)", "$($key)")
			$Root.ImageIndex = 18
			$Root.SelectedImageIndex = 19
			$null = $Root.Nodes.Add('LastWriteTime', "LastWriteTime: $LastWriteTime")
			$Root.Nodes["LastWriteTime"].ForeColor = 'Yellow'
			# Open Registry
			$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
			$registrykey = $Registry.OpenSubKey($key)
			# $TreeSearch.Visible = $true
			$Status.Text = "Please wait .."
			
			if ($registrykey.ValueCount -gt 0)
			{
				$ValueNames = $registrykey.GetValueNames()
			}
			
			if (!!$ValueNames)
			{
				foreach ($vname in $ValueNames)
				{
					$ValueNode = $Root.Nodes.Add($vname, $vname)
					$ValueNode.ForeColor = 'LimeGreen'
					[System.Windows.Forms.Application]::DoEvents()
					$ValueData = $registrykey.GetValue([System.String]$vname)
					$Values = @(Process-NavPane -ValueData $ValueData)
					$vc = $Values.count
					if (!!$Values)
					{
						$n = 0
						foreach ($NValue in $Values)
						{
							$Status.Text = "Please wait - Populating tree with $($vname) entry $($n)/$($vc) "
							$ValueDataNode = $ValueNode.Nodes.Add("$($vname)_$($n))", "Entry: [$($n.ToString('D4'))]")
							Populate-ItemIdListItems -ItemIDListNode $ValueDataNode -ItemIdList ($NValue.IDlist)
							Populate-SPS1 -Node $ValueDataNode -SPS1properties ($NValue.SerialisedPS)
							try
							{
								if (!!$NValue.IDlist)
								{
									$itemIDlist = $NValue.IDlist
									$ic = $itemIDlist.count
									$iname = if (!!$itemIDlist[0].CLSID) { $itemIDlist[0].CLSID }
									elseif (!!$itemIDlist[0].SortOrderIndex) { $itemIDlist[0].SortOrderIndex }
									elseif (!!$itemIDlist[0].GUID) { $itemIDlist[0].GUID }
									elseif (!!$itemIDlist[$ic - 1].ItemIdExtensions -and !!$itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name) { $itemIDlist[$ic - 1].ItemIdExtensions[0].Unicode_Name }
									elseif (!! $itemIDlist[$ic - 1].Ansi_Name) { $itemIDlist[$ic - 1].Ansi_Name }
									else { $null }
									if (!!$iname)
									{
										$ValueDataNode.Text = "$($ValueDataNode.Text) - $($iname)"
									}
								}
							}
							catch { $ValueDataNode.Text = "Entry: [$($n.ToString('D4'))]" }
							$n++
						}
					}
				}
				$Status.Text = "Done"
			}
			$Registry.Close()
			$Registry.Dispose()
		}
		# Show Treeview
		$Root.Expand()
		$Root.Nodes[1].Expand()
		$Root.Nodes[0].EnsureVisible()
		$treeview2.EndUpdate()
		$TreeSearch.Visible = $true
	} # End Get-NavPane
	
	function Populate-MRUitem
	{
		param
		(
			[Parameter(Mandatory = $true)]
			$ItemProperties
		)
		
		if ($null -ne $ItemProperties)
		{
			$treeview2.Nodes.Clear()
			$treeview2.ImageList = $null
			[System.GC]::Collect()
			$treeview2.BeginUpdate()
					
			# Add Root branch
			$Root2 = $treeview2.Nodes.Add("Root", "Local Registry")
			# Add MRU item Node
			$mrunode = $Root2.Nodes.Add("$($ItemProperties.key)", "$($ItemProperties.key)")
			$mrunode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
			$mrunode.Tag = @($null, $null, $null, $null, $ItemProperties.ItemID)
			# Add Properties
			$null = $mrunode.Nodes.Add("SubKey", "SubKey: $($ItemProperties.SubKey)")
			if (!!$ItemProperties.LastWriteTime)
			{
				$null = $mrunode.Nodes.Add("LastWriteTime", "SubKey LastWriteTime: $($ItemProperties.LastWriteTime)")
				$mrunode.Nodes["LastWriteTime"].ForeColor = 'Yellow'
			}
			Populate-ItemIdListItems -ItemIDListNode $mrunode -ItemIdList @($ItemProperties.ItemID)
			$null = $mrunode.Nodes.Add("RawData", "Data")
			$mrunode.Nodes["RawData"].Tag = @($ItemProperties.Data)
			$mrunode.Nodes["RawData"].ToolTipText = "Right click to copy the raw (Hex) data ($($ItemProperties.Data.length))"
			$mrunode.Nodes["RawData"].ForeColor = 'Peru'
			# End
			$Root2.Expand()
			$Root2.Nodes[0].ExpandAll()
			$Root2.Nodes[0].EnsureVisible()
			$TreeSearch.Visible = $true
			$treeview2.EndUpdate()
		}
		else
		{
			Show-ErrorMessage -ErrorMessage "Oops 🤐"
			[System.Console]::Beep(500, 150)
		}
	} # End Populate-MRUitem
	
	function Process-SearchJumplistData
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$key
		)
		
		$JumplistData = [System.Collections.ArrayList]::New()
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		
		$registrykey = $Registry.OpenSubKey($key)
		
		if (!$registrykey) { return }
		
		if ($registrykey.ValueCount -ge 1)
		{
			$keyValueNames = $registrykey.GetValueNames()
			foreach ($keyValueName in $keyValueNames)
			{
				
				$Application = if ($keyValueName -eq '') { '(Default)' }
				else { $keyValueName }
				$LAT = $registrykey.GetValue($keyValueName)
				$LastAccessedUtc = if (!!$LAT) { [datetime]::FromFileTimeUtc($LAT) }
				else { $null }
				
				$keyItem = [PSCustomObject]@{
					'AppUserModelID'  = $Application
					'LastAccessedUtc' = $LastAccessedUtc
				}
				$null = $JumplistData.Add($keyItem)
				
			}
		}
		else { $null = $JumplistData }
		
		$Registry.Close()
		$Registry.Dispose()
		
		return $JumplistData
	} # Process-SearchJumplistData
	
	function Process-SearchRecent
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$key
		)
		
		$RecentApps = [System.Collections.ArrayList]::New()
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		
		$registrykey = $Registry.OpenSubKey($key)
		
		if (!$registrykey) { return }
		
		if ($registrykey.SubKeyCount -ge 1)
		{
			$subkeyNames = $registrykey.GetSubKeyNames()
			foreach ($subkeyName in $subkeyNames)
			{
				$subkey = $Registry.OpenSubKey($key + "\" + $subkeyName)
				if ($subkey.ValueCount -ge 1)
				{
					$subkeyValueNames = $subkey.GetValueNames()
					$LAT = $subkey.GetValue('LastAccessedTime')
					$LastAccessedUtc = if (!!$LAT) { [datetime]::FromFileTimeUtc($LAT) }
					else { $null }
					$AppID = $subkey.GetValue('AppId')
					$AppPath = $subkey.GetValue('AppPath')
					$Path = $subkey.GetValue('Path')
					$DisplayName = $subkey.GetValue('DisplayName')
					$LaunchCount = $subkey.GetValue('LaunchCount')
					$RecentItems = if ($subkey.SubKeyCount -ge 1 -and 'RecentItems' -in $subkey.GetSubKeyNames())
					{
						$Recentkey = "$($key + "\" + $subkeyName + "\RecentItems")"
						Process-SearchRecent -key $Recentkey
					}
					else { $null }
					
					$subkeyItem = [PSCustomObject]@{
						'Subkey'		  = $subkeyName
						'LastAccessedUtc' = $LastAccessedUtc
						'AppID'		      = $AppID
						'AppPath'		  = $AppPath
						'Path'		      = $Path
						'DisplayName'	  = $DisplayName
						'LaunchCount'	  = $LaunchCount
						'RecentItems'	  = @($RecentItems)
					}
					$null = $RecentApps.Add($subkeyItem)
				}
				else { continue }
				
			} # End foreach
		}
		else
		{
			$null = $RecentApps
		}
		$Registry.Close()
		$Registry.Dispose()
		
		return $RecentApps
	} # End Process-SearchRecent
	
	function Process-LockScreen
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[System.String]$key
		)
		$treeview1.BeginUpdate()
		$Root = $treeview1.Nodes.Add('Registry', 'Registry')
		$Root.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
		$Root.ForeColor = 'DarkTurquoise'
		$Root.ImageIndex = 19
		$Root.SelectedImageIndex = 19
		$RegistrykeyName = Split-Path $key -Leaf
		$Locknode = $Root.Nodes.Add("$($key)", "$($RegistrykeyName)")
		$Locknode.ToolTipText = "$($key)"
		$Locknode.NodeFont = New-Object Drawing.Font($treeview1.Font, [Drawing.FontStyle]::Bold)
		$Locknode.ImageIndex = 19
		$Locknode.SelectedImageIndex = 19
		[System.Windows.Forms.Application]::DoEvents()
		$keyname = split-path $key -Leaf
		$keyparent = split-path $key -Parent
		$ParentTimestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
		
		$Registry = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Default)
		$registrykey = $Registry.OpenSubKey($key)
		if (!$registrykey) { return }
		
		$ValuesNames = $registrykey.GetValueNames().Where{ $_.startswith('OriginalFile_') }
		
		if ($ValuesNames -gt 0)
		{
			$LastWriteTime = if (!!$ParentTimestamps[[System.String]$keyname]) { $ParentTimestamps[[System.String]$keyname] }
			$Status.Text = "Please wait - Processing $($key)"
			
			foreach ($name in $ValuesNames)
			{
				$KeyValue = $registrykey.GetValue([System.String]$name)
				$Valuenode = $Locknode.Nodes.Add("$($KeyValue)", "$($name)")
				$Valuenode.ImageIndex = 3
				$Valuenode.SelectedImageIndex = 4
				if ($null -ne $keyValue)
				{
					try
					{
						$itemIDlist = Get-EmbeddedIDList -ByteArray $KeyValue -Index 2
					}
					catch { $itemIDlist = $null }
					
					$MRUcontentsS = [PSCustomObject]@{
						'Key' = ($registrykey.Name -replace 'HKEY_CURRENT_USER', 'HKCU')
						'SubKey' = $name
						'LastWriteTime' = $LastWriteTime
						'Data' = ([System.BitConverter]::ToString($KeyValue, 0).replace('-', ''))
						'ItemID' = $itemIDlist
					}
					
					[System.Windows.Forms.Application]::DoEvents()
					
					# Add Node
					$Valuenode.Tag = @($null, $null, $MRUcontentsS)
					$Valuenode.ImageIndex = 3
					$Valuenode.SelectedImageIndex = 4
				}
			}
		}
		$treeview1.EndUpdate()
	} # End Process-LockScreen
	
	$treeview1_NodeMouseClick = [System.Windows.Forms.TreeNodeMouseClickEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.TreeNodeMouseClickEventArgs]
		
		# $status.Text = $_.Node.Tag
		if ($_.Node.Level -eq 1 -and $_.Button -eq 'Left')
		{
	<#	$treeview1.Nodes[0].Collapse()#>
			$_.Node.Toggle()
			$this.SelectedNode = $_.Node
			#	$treeview1.SelectedNode.LastNode.EnsureVisible()
		}
		elseif ($_.Button -eq 'Right')
		{
			$this.SelectedNode = $_.Node
		}
		
	}
	
	$treeview1_AfterSelect = [System.Windows.Forms.TreeViewEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.TreeViewEventArgs]
		$SaveStream.Visible = $false
			
		if ($treeview1.SelectedNode.Nodes.Count -ne 0 -and !$treeview1.Nodes["Registry"])
		{
			$CopyFullFilePath.Visible = $true
		}
		else
		{
			$CopyFullFilePath.Visible = $false
		}
		
		# Show ADS menu(s)
		if (!!$treeview1.SelectedNode -and !!$treeview1.SelectedNode.Tag -and $treeview1.SelectedNode.Tag.count -le 2)
		{
			$OpenFileWith.Visible = $true
			$toolstripseparator8.Visible = $true
			if ($treeview1.SelectedNode.Nodes.Count -ne 0 -and $treeview1.SelectedNode.LastNode.Name.StartsWith('Stream Name') -and !$treeview1.SelectedNode.IsExpanded)
			{
				$treeview1.SelectedNode.Expand()
			}
			
			if ($treeview1.SelectedNode.Name.StartsWith('Stream Name'))
			{
				if (!$treeview1.SelectedNode.Text.EndsWith('Zone.Identifier'))
				{
					$OpenFileWith.Visible = $false
				}
				$CopyFullFilePath.Visible = $false
				$SaveStream.Visible = $true
				$status.Text = "Selected: $($treeview1.SelectedNode.Text)"
				$tx = $treeview1.SelectedNode.Bounds.Location.X
				$ty = $treeview1.SelectedNode.Bounds.Location.Y
				$contextmenustrip1.Show($treeview1, $tx + 50, $ty + 50)
			}
			else
			{
				$SaveStream.Visible = $false
				$status.Text = "Selected: $($treeview1.SelectedNode.Name)"
			}
		}
		else
		{
			$CopyFullFilePath.Visible = $false
			$OpenFileWith.Visible = $false
			$toolstripseparator8.Visible = $false
			$status.Text = "$($treeview1.SelectedNode.Text)"
		}
		
		$node = $treeview1.SelectedNode
		$Status.Text = "$($_.Node.Text)"
		# automaticDestinations-ms
		if (!$node.Text.StartsWith('[') -and $node.Name.EndsWith(".automaticDestinations-ms") -and !!$node.Tag)
		{
			try
			{
				$Tree1Search.Text = "Select Jumplist by App Name"
				$FileName = "$($treeview1.SelectedNode.Name)"
				if ([System.IO.FileInfo]::New($FileName).Exists)
				{
					Process-Automatic -File $FileName
				}
				else
				{
					Show-ErrorMessage -ErrorMessage "Can not find: $($FileName)"
				}
			}
			catch
			{
				if (!!$Error[0].Exception.InnerException.Message)
				{
					Show-ErrorMessage -ErrorMessage $Error[0].Exception.InnerException.Message
					$Error.Clear
					try { Process-Link -File "$($treeview1.SelectedNode.Name)" }
					catch
					{
						if (!!$Error[0].Exception.InnerException.Message)
						{
							Show-ErrorMessage -ErrorMessage $Error[0].Exception.InnerException.Message
							$Error.Clear
						}
					}
				}
				else
				{
					$status.Text = "Error processing $($treeview1.SelectedNode.Name)"
					$null
				}
			}
		} # customDestinations-ms
		elseif (!$node.Text.StartsWith('[') -and $node.Name.EndsWith(".customDestinations-ms") -and !!$node.Tag)
		{
			try
			{
				$Tree1Search.Text = "Select Jumplist by App Name"
				$FileName = "$($treeview1.SelectedNode.Name)"
				if ([System.IO.FileInfo]::New($FileName).Exists)
				{
					Process-Custom -File $FileName
				}
				else
				{
					Show-ErrorMessage -ErrorMessage "Can not find: $($FileName)"
				}
			}
			catch
			{
				if (!!$Error[0].Exception.InnerException.Message)
				{
					Show-ErrorMessage -ErrorMessage $Error[0].Exception.InnerException.Message
					$Error.Clear
					try { Process-Link -File "$($treeview1.SelectedNode.Name)" }
					catch
					{
						if (!!$Error[0].Exception.InnerException.Message)
						{
							Show-ErrorMessage -ErrorMessage $Error[0].Exception.InnerException.Message
							$Error.Clear
						}
					}
				}
				else
				{
					$status.Text = "Error processing $($treeview1.SelectedNode.Name)"
					$null
				}
			}
		}
		# LNK / customDestinations-ms
		elseif (!!$node.Tag -and $node.Tag.count -lt 3 -and !$node.Name.StartsWith('Stream Name'))
		{
			try
			{
				$Tree1Search.Text = "Select Jumplist by App Name"
				$FileName = "$($treeview1.SelectedNode.Name)"
				if ([System.IO.FileInfo]::New($FileName).Exists)
				{
					[System.Windows.Shell.JumpList]::AddToRecentCategory($FileName)
					Process-Link -File $FileName
				}
				else
				{
					Show-ErrorMessage -ErrorMessage "Can not find: $($FileName)"
				}
			}
			catch
			{
				if (!!$Error[0].Exception.InnerException.Message)
				{
					Show-ErrorMessage -ErrorMessage $Error[0].Exception.InnerException.Message
					$Error.Clear
				}
			}
		}
		# Registry
		elseif (!!$node.Tag -and $node.Tag.count -eq 3)
		{
			try
			{
				Populate-MRUitem -ItemProperties ($node.Tag[2])
			}
			catch
			{
				[System.Console]::Beep(500, 150)
			}
		}
		$Status.Text = "$($_.Node.Text)"
		[System.GC]::Collect()
	}
	
	$Collapse_Expand1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			$treeview1.SelectedNode.Toggle()
		}
	}
	
	$CopyNode1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			try
			{
				$treeview1.SelectedNode.Text | Set-Clipboard
			}
			catch
			{
				[System.Console]::Beep(500, 150)
			}
		}
	}
	
	$Exit1_Click = {
		$Jumplist_Browser.Close()
	}
	
	$CopyNode2_Click = {
		if (!!$treeview2.SelectedNode)
		{
			try
			{
				$treeview2.SelectedNode.Text | Set-Clipboard
			}
			catch
			{
				[System.Console]::Beep(500, 150)
			}
		}
	}
	
	$CopyNode2Tag_Click = {
		if (!!$treeview2.SelectedNode.Tag -and $treeview2.SelectedNode.Tag.count -ge 1)
		{
			try
			{
				$treeview2.SelectedNode.Tag[0] | Set-Clipboard
			}
			catch
			{
				[System.Console]::Beep(500, 150)
			}
		}
	}
	
	$CopyAll2_Click = {
		$node = $treeview2.SelectedNode
		If (!!$node -and $node.GetNodeCount($true) -ge 1)
		{
			try
			{
				$Status.Text = 'Please wait ..'
				$Jumplist_Browser.Cursor = 'AppStarting'
				$nodes = (Get-Nodes -nodes $node)
				($nodes.text -replace '\x00', '').trim() | Out-String | Set-Clipboard
				$nodes = $null
				$Jumplist_Browser.Cursor = 'Default'
				$Status.Text = 'Ready'
			}
			catch
			{
				[System.Console]::Beep(500, 150)
			}
		}
		else
		{
			$Jumplist_Browser.Cursor = 'Default'
			[System.Console]::Beep(500, 150)
		}
	}
	
	$Expand2_Click = {
		if (!!$treeview2.SelectedNode)
		{
			$treeview2.SelectedNode.Toggle()
		}
	}
	
	$Exit2_Click = {
		$Jumplist_Browser.Close()
	}
	
	$Jumplist_Browser_FormClosing = [System.Windows.Forms.FormClosingEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.FormClosingEventArgs]
		
		$id = [System.Diagnostics.Process]::GetCurrentProcess().Id
		$process = Get-Process -id $id
		switch ([System.Windows.Forms.MessageBox]::Show($Jumplist_Browser, "Are you sure you want to Exit?", "LNK & Jumplist Browser", "YesNo", "Question", 'Button2'))
		{
			'Yes' {
				$Status.Text = "Exiting .."
				try
				{
					$Cancel = $false
					$treeview1.Nodes.Clear()
					$treeview2.Nodes.Clear()
					$notifyicon1.Dispose()
					[GC]::Collect()
					$RunningThreads = [System.Diagnostics.Process]::GetCurrentProcess().threads
					if ($RunningThreads.count -ge 1)
					{
						$RunningThreads.foreach{ (Get-Process -id $_.id -ErrorAction SilentlyContinue).Kill()	}
					}
					# $process.Kill()
				}
				catch
				{
					$process.Kill()
				}
				
			}
			'No' {
				$Cancel = $true
			}
		}
		if (!!$Cancel) { $_.Cancel = $true }
		else { $_.Cancel = $false }
	}
	
	$About_Click = {
		# Check for latest release on Github
		$JumplistBrowserVersion = "v." + [System.Windows.Forms.Application]::ProductVersion
		$repo = "kacos2000/Jumplist-Browser"
		$latestR = "https://api.github.com/repos/$($repo)/releases/latest"
		$releases = "https://api.github.com/repos/$($repo)/releases"
		$aboutmessage = "Jumplist Browser $($JumplistBrowserVersion)`nCostas Katsavounidis © 2022-2024`nhttps://github.com/kacos2000"
		$downlink = "https://github.com/kacos2000/Jumplist-Browser/releases/latest"
		
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		if (test-connection -ComputerName 8.8.8.8 -Count 1 -Quiet -ErrorAction SilentlyContinue)
		{
			$Status.Text = "Checking releases on GitHub"
			try
			{
				$rlist = (Invoke-RestMethod -Uri $releases -UserAgent 'https://github.com/kacos2000/Jumplist-Browser' -TimeoutSec 30).tag_name
				$latest = (Invoke-RestMethod -Uri $latestR -UserAgent 'https://github.com/kacos2000/Jumplist-Browser' -TimeoutSec 30)
				
				$tag = $latest[0].tag_name
				$published = $latest[0].published_at
			}
			catch { $rlist = $latest = $null }
			if (!!$rlist -and !!$latest)
			{
				if ($JumplistBrowserVersion -ne $tag -and $JumplistBrowserVersion -in $rlist)
				{
					$latestmessage = "$($aboutmessage)`n`nThere is a new update ($($tag)) of Jumplist Browser at:`n'$($downlink)'`nreleased on $($published). Check it out .. "
					$Status.Text = "Latest version: JumplistBrowser $($tag)"
					Show-WarningMessage -WarningMessage $latestmessage
				}
				elseif ($JumplistBrowserVersion -eq $tag)
				{
					$Status.Text = "Latest version: JumplistBrowser $($tag)"
					Show-InfoMessage -InfoMessage "$($aboutmessage)`nYou are using the latest version of Jumplist Browser."
				}
				else
				{
					$Status.Text = "Latest version: JumplistBrowser $($tag)"
					Show-InfoMessage -InfoMessage $aboutmessage
				}
			}
			else
			{
				Show-InfoMessage -InfoMessage $aboutmessage
			}
		}
		else
		{
			$Status.Text = "Session TimeOut"
			Show-InfoMessage -InfoMessage $aboutmessage
		}
		$Status.Text = "Ready"
		
	}
	
	$OpenFolder_Click = {
		
		$currentuser_recentfolder = [System.Environment]::GetFolderPath("Recent")
		$folderbrowserdialog1.SelectedPath = "$($currentuser_recentfolder)"
		
		$toolstripRefreshState = $toolstripRefresh.Visible
		if ($folderbrowserdialog1.ShowDialog() -eq 'OK')
		{
			Open-Folder -Folder "$($folderbrowserdialog1.SelectedPath)"
		}
		else
		{
			$toolstripRefresh.Visible = $toolstripRefreshState
			[System.Console]::Beep(500, 150)
		}
	}
	
	$Open_Click = {
		
		$toolstripRefreshState = $toolstripRefresh.Visible
		$openfiledialog1.Filter = "Link file (*.lnk)|*.lnk|Automatic Destinations Jumplist (*.automaticDestinations-ms)|*.automaticDestinations-ms|Custom Destinations Jumplist (*.customDestinations-ms)|*.customDestinations-ms|Raw Image file (001, raw, dd, img, ima)|*.001;*.raw;*.dd;*.img;*.ima|All files (*.*)|*.*"
		if ($openfiledialog1.ShowDialog() -eq 'OK')
		{
			$FileName = "$($openfiledialog1.FileName)"
			Open-File -Filename $FileName
		}
		else
		{
			$toolstripRefresh.Visible = $toolstripRefreshState
			[System.Console]::Beep(500, 150)
		}
	}
	
	$Collapse2_Click = {
		if (!!$treeview2.SelectedNode)
		{
			$treeview2.SelectedNode.Collapse()
		}
	}
	
	$ExpandAll2_Click = {
		if (!!$treeview2.SelectedNode)
		{
			$treeview2.SelectedNode.ExpandAll()
			$treeview2.SelectedNode.EnsureVisible()
		}
	}
	
	$CollapseAll2_Click = {
		if (!!$treeview2.SelectedNode)
		{
			$treeview2.CollapseAll()
			$treeview2.Nodes[0].Expand()
		}
	}
	
	$Expand1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			$treeview1.SelectedNode.Expand()
		}
		
	}
	
	$Collapse1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			$treeview1.SelectedNode.Collapse()
		}
	}
	
	$ExpandAll1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			$treeview1.SelectedNode.ExpandAll()
		}
		
	}
	
	$CollapseAll1_Click = {
		if (!!$treeview1.SelectedNode)
		{
			$treeview1.CollapseAll()
			$treeview1.Nodes[0].Expand()
		}
		
	}
	
	$OpenFileWith_Click = {
		if (!!$treeview1.SelectedNode -and !!$treeview1.SelectedNode.Tag -and $treeview1.SelectedNode.Tag.count -le 2)
		{
			try
			{
				$filename = $treeview1.SelectedNode.Tag[0].ToString()
				if ([System.IO.FileInfo]::New($filename).Exists)
				{
					[ShellOpenWith]::DoOpenFileWith($filename)
				}
				
			}
			catch [System.Management.Automation.MethodInvocationException]{
				if ($treeview1.SelectedNode.Text.Contains('Stream Name: Zone.Identifier'))
				{
					Start-Process notepad.exe "$($filename)"
				}
			}
			catch { [System.Console]::Beep(500, 150) }
		}
	}
	
	$CopyFullFilePath_Click = {
		if (!!$treeview1.SelectedNode -and !!$treeview1.SelectedNode.Tag -and $treeview1.SelectedNode.Tag.count -le 2)
		{
			try
			{
				$filename = $treeview1.SelectedNode.Tag[0].ToString()
				$filename | Set-Clipboard
			}
			catch { [System.Console]::Beep(500, 150) }
		}
		else
		{
			$treeview1.SelectedNode.FullPath | Set-Clipboard
		}
	}
	
	$SaveStream_Click = {
		if (!!$treeview1.SelectedNode -and $treeview1.SelectedNode.Text.Contains('Stream Name:') -and !!$treeview1.SelectedNode.Tag -and $treeview1.SelectedNode.Tag.count -le 2)
		{
			$filename = $treeview1.SelectedNode.Tag[0].ToString()
			try
			{
				$StreamData = Get-Content -Path "$($filename)" -Encoding Byte -ErrorAction Stop
				$StreamName = (Split-Path -Path $filename -leaf).Split(':')[1]
				#	$savefiledialog1.AddExtension = $true
				$savefiledialog1.InitialDirectory = [Environment]::GetFolderPath('Desktop')
				$savefiledialog1.Filter = "All files (*.*)|*.*"
				$savefiledialog1.FilterIndex = 0
				$savefiledialog1.FileName = "ADS_$($StreamName)"
				
				if ($savefiledialog1.ShowDialog() -eq 'OK')
				{
					$OutputFileStream = [IO.File]::OpenWrite($savefiledialog1.FileName)
					$OutputFileStream.Write($StreamData, 0, $StreamData.count)
					$OutputFileStream.Dispose()
					$Status.Text = 'Ready'
				}
				else { [System.Console]::Beep(500, 150) }
				
			}
			catch { [System.Console]::Beep(500, 150) }
		}
	}
	
	$SaveNodestoTxt_Click = {
		$node = $treeview2.Nodes[0]
		$InvalidChars = [System.IO.Path]::GetInvalidFileNameChars()
		$LinkName = "$($node.Text.Split($InvalidChars) -join '_').txt"
		
		If (!!$node -and $node.GetNodeCount($false) -ge 1)
		{
			$savefiledialog1.AddExtension = $true
			$savefiledialog1.InitialDirectory = [Environment]::GetFolderPath('Desktop')
			$savefiledialog1.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*"
			$savefiledialog1.FilterIndex = 0
			$savefiledialog1.FileName = $LinkName
			$savefiledialog1.DefaultExt = 'txt'
			$savefiledialog1.OverwritePrompt = $true
			if ($savefiledialog1.ShowDialog() -eq 'OK')
			{
				$Status.Text = 'Please wait ..'
				$Jumplist_Browser.Cursor = 'AppStarting'
				$nodes = (Get-Nodes -nodes $node)
				[System.IO.File]::WriteAllLines($savefiledialog1.FileName, $nodes.text, [System.Text.Encoding]::UTF8)
				#	$nodes.text | Out-String | Out-File -FilePath $savefiledialog1.FileName -Encoding utf8 -NoClobber -Force -ErrorAction SilentlyContinue
				$nodes = $null
				$Jumplist_Browser.Cursor = 'Default'
				$Status.Text = 'Ready'
			}
			else
			{
				$Jumplist_Browser.Cursor = 'Default'
				[System.Console]::Beep(500, 150)
			}
		}
		else
		{
			$Jumplist_Browser.Cursor = 'Default'
			[System.Console]::Beep(500, 150)
		}
	}
	
	$exitToolStripMenuItem_Click = {
		$Jumplist_Browser.Close()
	}
	
	$Process1_Click = {
		$node = $treeview1.SelectedNode
		if (!!$node -and $node.Name -notcontains 'Stream Name')
		{
			if (!$node.Name.StartsWith('[') -and $node.Name.EndsWith(".automaticDestinations-ms") -and !!$node.Tag)
			{
				Process-Automatic -File "$($treeview1.SelectedNode.Name)"
			}
			elseif (!!$node.Tag)
			{
				Process-Link -File "$($treeview1.SelectedNode.Name)"
			}
			else { [System.Console]::Beep(500, 150) }
		}
		else { [System.Console]::Beep(500, 150) }
	}
	
	$treeview2_NodeMouseClick = [System.Windows.Forms.TreeNodeMouseClickEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.TreeNodeMouseClickEventArgs]
		if ($_.Button -eq 'Right')
		{
			$treeview2.SelectedNode = $_.Node
			if (!!$_.Node.Tag)
			{
				$CopyNode2Tag.Visible = $true
			}
			else
			{
				$CopyNode2Tag.Visible = $false
			}
			if ($_.Node.Text.StartsWith("Stream Name") -and $_.Tag.count -gt 1 -and !!$_.Node.Tag[1])
			{
				$SaveStreamToFile.Visible = $true
			}
			else
			{
				$SaveStreamToFile.Visible = $false
			}
		}
		
	}
	
	$SaveStreamToFile_Click = {
		if (!!$treeview2.SelectedNode.Tag -and !!$treeview2.SelectedNode.Tag[1])
		{
			$savefiledialog1.AddExtension = $true
			$savefiledialog1.InitialDirectory = [Environment]::GetFolderPath('Desktop')
			$savefiledialog1.Filter = "LNK files (*.lnk)|*.lnk|All files (*.*)|*.*"
			$savefiledialog1.FilterIndex = 0
			$savefiledialog1.FileName = "Stream"
			$savefiledialog1.DefaultExt = 'lnk'
			
			if ($savefiledialog1.ShowDialog() -eq 'OK')
			{
				$data = $treeview2.SelectedNode.Tag[1]
				$OutputFileStream = [IO.File]::OpenWrite($savefiledialog1.FileName)
				$OutputFileStream.Write($data, 0, $data.count)
				$OutputFileStream.Dispose()
				$Status.Text = 'Ready'
			}
			else { [System.Console]::Beep(500, 150) }
		}
		else { [System.Console]::Beep(500, 150) }
	}
	
	$toolstripRefresh_Click = {
		if (!!$script:recentfolder)
		{
			if ($treeview1.Nodes) { $treeview1.Nodes.Clear() }
			else { $null }
			if ($treeview2.Nodes) { $treeview2.Nodes.Clear() }
			else { $null }
			
			$Status.Text = $null
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			[System.GC]::Collect()
			try
			{
				$Status.Text = "Selected Folder: $($script:recentfolder) "
				if (!!(Get-Files -Folder "$($script:recentfolder)"))
				{
					$toolstripRefresh.Visible = $true
				}
				else
				{
					$toolstripRefresh.Visible = $false
				}
			}
			catch
			{
				$toolstripRefresh.Visible = $false
				[System.Console]::Beep(500, 150)
				return
			}
		}
		else
		{
			$toolstripRefresh.Visible = $false
			[System.Console]::Beep(500, 150)
		}
	}
	
	$GetMRUlist_Click = {
		try
		{
			$toolstripRefresh.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			[System.GC]::Collect()
			$Status.Text = "Please wait - Collecting Registry entries ..."
			Process-MRUlist
			if (!!$treeview1.Nodes)
			{
				[System.Console]::Beep(2500, 300)
			}
			else
			{
				[System.Console]::Beep(500, 150)
				$Status.Text = "☹️"
			}
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			$treeview1.EndUpdate()
		}
	}
	
	$GetSearchMRU_Click = {
		try
		{
			$toolstripRefresh.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$treeview1.Nodes.Clear()
			$treeview2.Nodes.Clear()
			[System.GC]::Collect()
			$Status.Text = "Please wait - Collecting Registry entries ..."
			$key = 'Software\Microsoft\Windows\CurrentVersion\Search'
			$key1 = 'Software\Microsoft\Windows\CurrentVersion\Search\JumplistData'
			$key2 = 'Software\Microsoft\Windows\CurrentVersion\Search\RecentApps'
			$treeview2.BeginUpdate()
			# Add Root Node
			$Root = $treeview2.Nodes.Add("$($key)", "$($key)")
			
			if (Test-Path "HKCU:$($key1)" -ErrorAction SilentlyContinue)
			{
				
				$Root1 = $Root.Nodes.Add("$($key1)", "$($key1)")
				$Root1.ImageIndex = 19
				$Root1.SelectedImageIndex = 19
				$Root1.ForeColor = 'Lime'
				$keyname = split-path $key1 -Leaf
				$keyparent = split-path $key1 -Parent
				$Timestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
				$LastWriteTime = if (!!$Timestamps[[System.String]$keyname]) { $Timestamps[[System.String]$keyname] }
				if (!!$LastWriteTime)
				{
					$null = $Root1.Nodes.Add("LastWriteTime", "SubKey LastWriteTime: $($LastWriteTime)")
					$Root1.Nodes["LastWriteTime"].ForeColor = 'Yellow'
					$Root1.Nodes["LastWriteTime"].ImageIndex = 17
					$Root1.Nodes["LastWriteTime"].SelectedImageIndex = 18
				}
				try
				{
					$JumplistItems = @(Process-SearchJumplistData -key $key1)
				}
				catch
				{
					$JumplistItems = $null
				}
				
				# Populate tree
				if (!!$JumplistItems)
				{
					$JumplistItems = $JumplistItems | Sort-Object -Property LastAccessedUtc -Descending
					$JumplistNode = $Root1.Nodes.Add("Root", "JumplistData")
					$JumplistNode.ImageIndex = 19
					$JumplistNode.SelectedImageIndex = 19
					$JumplistNode.Forecolor = 'Orange'
					$j = 1
					foreach ($JumplistItem in $JumplistItems)
					{
						$JumplistItemNode = $JumplistNode.Nodes.Add("JumpItem$($j)", "[#$($j.ToString('D3'))] AppUserModelID: $($JumplistItem.AppUserModelID)")
						$null = $JumplistItemNode.Nodes.Add("LastAccessedUtc", "LastAccessedUtc: $($JumplistItem.LastAccessedUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff"))")
						$JumplistItemNode.Nodes["LastAccessedUtc"].ForeColor = 'Cyan'
						$j = $j+1
					}
				}
			}
			
			if (Test-Path "HKCU:$($key2)" -ErrorAction SilentlyContinue)
			{
				$Root2 = $Root.Nodes.Add("$($key2)", "$($key2)")
				$Root2.ImageIndex = 19
				$Root2.SelectedImageIndex = 19
				$Root2.ForeColor = 'Lime'
				$keyname = split-path $key2 -Leaf
				$keyparent = split-path $key2 -Parent
				$Timestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
				$LastWriteTime = if (!!$Timestamps[[System.String]$keyname]) { $Timestamps[[System.String]$keyname] }
				if (!!$LastWriteTime)
				{
					$null = $Root2.Nodes.Add("LastWriteTime", "SubKey LastWriteTime: $($LastWriteTime)")
					$Root2.Nodes["LastWriteTime"].ForeColor = 'Yellow'
					$Root2.Nodes["LastWriteTime"].ImageIndex = 17
					$Root2.Nodes["LastWriteTime"].SelectedImageIndex = 18
				}
					
				$Status.Text = "Please wait - Processing $($key2)"
				try
				{
					$SearchItems = @(Process-SearchRecent -key $key2)
				}
				catch
				{
					$SearchItems = $null
				}
				# Populate tree
				if (!!$SearchItems)
				{
					$SearchItems = $SearchItems | Sort-Object -Property LastAccessedUtc -Descending
					$SearchNode = $Root2.Nodes.Add("Root", "RecentApps")
					$SearchNode.ImageIndex = 19
					$SearchNode.SelectedImageIndex = 19
					$SearchNode.Forecolor = 'Orange'
					$n = 1
					foreach ($SearchItem in $SearchItems)
					{
						$RecentAppNode = $SearchNode.Nodes.Add("Recent$($n)", "[#$($n.ToString('D3'))] $($SearchItem.AppID)")
						$RecentAppNode.ToolTipText = $SearchItem.Subkey
						if (!!$SearchItem.AppId)
						{
							$null = $RecentAppNode.Nodes.Add("AppId", "AppID: $($SearchItem.AppId)")
							$RecentAppNode.Nodes["AppID"].ForeColor = 'PaleGreen'
						}
						if (!!$SearchItem.AppPath)
						{
							$null = $RecentAppNode.Nodes.Add("AppPath", "AppPath: $($SearchItem.AppPath)")
							$RecentAppNode.Nodes["AppPath"].ForeColor = 'PaleGreen'
						}
						if (!!$SearchItem.LastAccessedUtc)
						{
							$null = $RecentAppNode.Nodes.Add("LastAccessedUtc", "LastAccessedUtc: $($SearchItem.LastAccessedUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff"))")
							$RecentAppNode.Nodes["LastAccessedUtc"].ForeColor = 'Cyan'
						}
						if (!!$SearchItem.LaunchCount) { $null = $RecentAppNode.Nodes.Add("LaunchCount", "LaunchCount: $($SearchItem.LaunchCount)") }
						if (!!$SearchItem.RecentItems)
						{
							$RecentItems = $RecentAppNode.Nodes.Add("RecentItems", "RecentItems ($($SearchItem.RecentItems.count))")
							$RecentItems.ForeColor = 'Tomato'
							$RecentAppNode.ForeColor = 'PapayaWhip' #'LightGoldenrodYellow' # 'Tomato'
							$r = 1
							$RecentItemsSorted = $SearchItem.RecentItems | Sort-Object -Property LastAccessedUtc -Descending
							foreach ($RecentItem in $RecentItemsSorted)
							{
								$RecentItemNode = $RecentItems.Nodes.Add("RecentItem$($r)", "[#$($r.ToString('D3'))] $($RecentItem.DisplayName)")
								if (!!$RecentItem.DisplayName)
								{
									$null = $RecentItemNode.Nodes.Add("DisplayName", "DisplayName: $($RecentItem.DisplayName)")
									$RecentItemNode.Nodes["DisplayName"].ForeColor = 'PaleGreen'
								}
								if (!!$RecentItem.Path)
								{
									$null = $RecentItemNode.Nodes.Add("AppPath", "Path: $($RecentItem.Path)")
									$RecentItemNode.Nodes["AppPath"].ForeColor = 'PaleGreen'
								}
								if (!!$RecentItem.LastAccessedUtc)
								{
									$null = $RecentItemNode.Nodes.Add("LastAccessedUtc", "LastAccessedUtc: $($RecentItem.LastAccessedUtc.ToString("dd-MMM-yyyy HH:mm:ss.fffffff"))")
									$RecentItemNode.Nodes["LastAccessedUtc"].ForeColor = 'Cyan'
								}
								$r = $r + 1
							}
						}
						$n = $n + 1
					}
				}
				# End
			}
			
			$treeview2.EndUpdate()
			
			if (!!$treeview2)
			{
				[System.Console]::Beep(2500, 300)
				$TreeSearch.Visible = $true
				$treeview2.Nodes[0].Expand()
				$no = $treeview2.Nodes[0].GetNodeCount($false)
				$treeview2.Nodes[0].Nodes[0..($n0-1)].Expand()
				$treeview2.Nodes[0].EnsureVisible()
				$Status.Text = "Ready"
			}
			else
			{
				[System.Console]::Beep(500, 150)
				$Status.Text = "☹️"
			}
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			$treeview2.EndUpdate()
		}
	}
	
	$GetNavPane_Click = {
		$toolstripRefresh.Visible = $false
		$Tree1Search.Visible = $false
		$Tree1Search.Visible = $false
		$Tree1Search.Text = "Select Jumplist by App Name"
		$Tree1Search.Items.Clear()
		$TreeSearch.Visible = $false
		$TreeSearch.Text = "Search"
		[System.GC]::Collect()
		$Status.Text = "Please wait - Collecting Registry entries ..."
		
		try
		{
			Get-NavPane
		}
		catch
		{
			$Registry.Dispose()
		}
		if (!!$treeview2.Nodes)
		{
			$Status.Text = "Ready"
			$TreeSearch.Visible = $true
			[System.Console]::Beep(2500, 300)
			$Status.Text = ''
		}
		else
		{
			[System.Console]::Beep(500, 150)
			$Status.Text = "☹️"
		}
	}
	
	$GetTaskBand_Click = {
		try
		{
			$toolstripRefresh.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$treeview1.Nodes.Clear()
			$treeview2.Nodes.Clear()
			[System.GC]::Collect()
			$Status.Text = "Please wait - Collecting Registry entries ..."
			$key = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband'
			# Add Root branch
			$treeview2.BeginUpdate()
			$Root2 = $treeview2.Nodes.Add("$($key)", "$($key)")
			$Root2.ImageIndex = 19
			$Root2.SelectedImageIndex = 19
			
			$keyname = split-path $key -Leaf
			$keyparent = split-path $key -Parent
			$Timestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
			$LastWriteTime = if (!!$Timestamps[[System.String]$keyname]) { $Timestamps[[System.String]$keyname] }
			if (!!$LastWriteTime)
			{
				$null = $Root2.Nodes.Add("LastWriteTime", "SubKey LastWriteTime: $($LastWriteTime)")
				$Root2.Nodes["LastWriteTime"].ForeColor = 'Yellow'
				$Root2.Nodes["LastWriteTime"].ImageIndex = 17
				$Root2.Nodes["LastWriteTime"].SelectedImageIndex = 18
			}
			$Status.Text = "Please wait - Processing $($key)\Favorites"
			Process-TaskBand -key $key -ValueName 'Favorites' -Root $Root2
			$Status.Text = "Please wait - Processing $($key)\FavoritesResolve"
			Process-TaskBand -key $key -ValueName 'FavoritesResolve' -Root $Root2
			# End
			$treeview2.EndUpdate()
			
			if (!!$Root2)
			{
				[System.Console]::Beep(2500, 300)
				$TreeSearch.Visible = $true
				$Root2.Expand()
				$Root2.Nodes[0].Expand()
				$Root2.Nodes[(1 .. 2)].Expand()
				$Root2.Nodes[0].EnsureVisible()
				$Status.Text = "Ready"
			}
			else
			{
				[System.Console]::Beep(500, 150)
				$Status.Text = "☹️"
			}
		}
		catch
		{
				[System.Console]::Beep(500, 150)
				$treeview2.EndUpdate()
			}
	}
	
	$GetStartPage2_Click = {
		try
		{
			$toolstripRefresh.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$treeview1.Nodes.Clear()
			$treeview2.Nodes.Clear()
			[System.GC]::Collect()
			$Status.Text = "Please wait - Collecting Registry entries ..."
			$key = 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage2'
			# Add Root branch
			$treeview2.BeginUpdate()
			if ($script:dpi -gt 96)
			{
				$treeview2.ImageList = $imagelist1 # HighDPI (24*24)
			}
			else
			{
				$treeview2.ImageList = $imagelist2
			}
			$Root2 = $treeview2.Nodes.Add("$($key)", "$($key)")
			$Root2.ImageIndex = 19
			$Root2.SelectedImageIndex = 19
			$keyname = split-path $key -Leaf
			$keyparent = split-path $key -Parent
			$Timestamps = Get-RegKeyLastWriteTime -SubKey $keyparent
			$LastWriteTime = if (!!$Timestamps[[System.String]$keyname]) { $Timestamps[[System.String]$keyname] }
			if (!!$LastWriteTime)
			{
				$null = $Root2.Nodes.Add("LastWriteTime", "SubKey LastWriteTime: $($LastWriteTime)")
				$Root2.Nodes["LastWriteTime"].ImageIndex = 17
				$Root2.Nodes["LastWriteTime"].SelectedImageIndex = 18
				$Root2.Nodes["LastWriteTime"].ForeColor = 'Yellow'
			}
			$Status.Text = "Please wait - Processing $($key)\Favorites"
			Process-TaskBand -key $key -ValueName 'Favorites' -Root $Root2
			$Status.Text = "Please wait - Processing $($key)\FavoritesResolve"
			Process-TaskBand -key $key -ValueName 'FavoritesResolve' -Root $Root2
			$Status.Text = "Please wait - Processing $($key)\ProgramsCache"
			Process-TaskBand -key $key -ValueName 'ProgramsCache' -Root $Root2 -Index 28
			$Status.Text = "Please wait - Processing $($key)\ProgramsCache"
			Process-TaskBand -key $key -ValueName 'ProgramsCacheSMP' -Root $Root2 -Index 9
			$Status.Text = "Please wait - Processing $($key)\ProgramsCacheTBP"
			Process-TaskBand -key $key -ValueName 'ProgramsCacheTBP' -Root $Root2 -Index 9
			# End
			$treeview2.EndUpdate()
			
			if (!!$Root2)
			{
				[System.Console]::Beep(2500, 300)
				$TreeSearch.Visible = $true
				$Root2.Expand()
				$Root2.Nodes[0].Expand()
				$Root2.Nodes[(1 .. 3)].Expand()
				$Root2.Nodes[0].EnsureVisible()
				$Status.Text = "Ready"
			}
			else
			{
				[System.Console]::Beep(500, 150)
				$Status.Text = "☹️"
			}
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			$treeview2.EndUpdate()
		}
	}
	
	$GetLockScreen_Click = {
		try
		{
			$toolstripRefresh.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Visible = $false
			$Tree1Search.Text = "Select Jumplist by App Name"
			$Tree1Search.Items.Clear()
			$TreeSearch.Visible = $false
			$TreeSearch.Text = "Search"
			$treeview1.Nodes.Clear()
			$treeview2.Nodes.Clear()
			$treeview2.ImageList = $null
			[System.GC]::Collect()
			$Status.Text = "Please wait - Collecting Registry entries ..."
			$key = 'Software\Microsoft\Windows\CurrentVersion\Lock Screen'
			Process-LockScreen -key $key
			if (!!$treeview1.Nodes)
			{
				$treeview1.Nodes[0].ExpandAll()
				$Status.Text = 'Ready'
				[System.Console]::Beep(2500, 300)
			}
			else
			{
				[System.Console]::Beep(500, 150)
				$Status.Text = "☹️"
			}
		}
		catch
		{
			[System.Console]::Beep(500, 150)
			$treeview1.EndUpdate()
		}
	}
	
	# Items to remove from Json
	$PropList = @('Data', 'Tbytes', 'Raw', 'extData', 'LinkInfoData', 'LinkTargetIDListData', 'StringDataData', 'ExtraDataData', 'LinkSlackLength', 'LinkSlack', 'Unknown', 'Unknown_1', 'Unknown_2', 'Unknown_3')
	
	# Original source: https://stackoverflow.com/a/63379522/12925530
	Function Remove-Property
	{
		param (
			# A PSCustomObject
			[Parameter(Mandatory, ValueFromPipeline)]
			$Object,
			# A list of property names to remove
			[Parameter(Mandatory)]
			[string[]]$PropList,
			# recurse?
			[Parameter()]
			[Switch]$Recurse
		)
		# Write-Host $Object  -ForegroundColor Cyan
		foreach ($Prop in $PropList)
		{
			if (!!$prop)
			{
				$Object.PSObject.Properties.Remove($prop)
			}
		}
		foreach ($Obj in $Object.PSObject.Properties)
		{
			if ([System.String]::IsNullOrEmpty($Obj.Value) -or $Obj.Value -eq '00000000' -and $Obj.Name -notin ('ItemIdListItems', 'ItemIdExtensions', 'PropertyStoreEntries', 'EmbeddedIdList', 'EmbeddedItems', 'TargetMetadata') -and $Obj.Name -notcontains 'ID List' -and $Obj.Name -notcontains 'TypedProperty' -and $Obj.Name -notcontains 'Serialized Property' -and $Obj.Name -notcontains 'Entension')
			{
				$Object.PSObject.Properties.Remove($Obj.Name)
			}
		}
		# Write-Host $Object  -ForegroundColor Green
		if ($Recurse.IsPresent)
		{
			foreach ($Obj in $Object.PSObject.Properties)
			{
				# Write-Host $ObjValue  -ForegroundColor Yellow
				if ($Obj.Value -is [System.Management.Automation.PSCustomObject])
				{
					$Obj.Value | Remove-Property -PropList $PropList -Recurse
				}
				elseif ($Obj.Value -is [System.Collections.ArrayList] -or $Obj.Value -is [System.Object[]])
				{
					foreach ($item in $Obj.Value)
					{
						$item | Remove-Property -PropList $PropList -Recurse
					}
				}
			}
		}
	} # End Remove-Property
	
	function Get-NodesForJason
	{
		param
		(
			[Parameter(Mandatory = $false)]
			$nodes = $treeview2.Nodes[0].Nodes
		)
		
		$nodePS = [PSCustomObject]@{ }
		
		foreach ($node in $nodes)
		{
			[System.Windows.Forms.Application]::DoEvents()
			$NodeFields = $node.Text -split ': '
			
			if ($node.Nodes.count -eq 0)
			{
				if ($NodeFields.count -eq 1)
				{
					$Name = $node.Text
					$Value = ''
				}
				elseif ($NodeFields.count -eq 2)
				{
					$Name = $NodeFields[0]
					$Value = $NodeFields[1].TrimStart(' ')
				}
				
				$nodePS | Add-Member -MemberType NoteProperty -Name $Name -Value $Value
			}
			else
			{
				$Name = $node.Text
				$Value = Get-NodesForJason -nodes $node.Nodes
				$nodePS | Add-Member -MemberType NoteProperty -Name $Name -Value $Value
			}
		}
		$nodePS
	}
	
	$SaveLnkToJson_Click = {
		if (!!$treeview2)
		{
			$Jumplist_Browser.Cursor = 'AppStarting'
			$Status.Text = 'Please wait - Collecting Nodes ...'
			$NodeCollection = Get-NodesForJason
			$InvalidChars = [System.IO.Path]::GetInvalidFileNameChars()
			$LinkName = "$($treeview2.Nodes[0].Text.Split($InvalidChars) -join '_').json"
			# Convert the result to json with max depth
			$json = ($NodeCollection | ConvertTo-Json -Depth 100)
			$Status.Text = ''
			
			# Save the result
			if (!!$json)
			{
				$savefiledialog1.AddExtension = $true
				$savefiledialog1.InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
				$savefiledialog1.Filter = "Json files (*.json)|*.json|All files (*.*)|*.*"
				$savefiledialog1.FilterIndex = 0
				if (!!$LinkName)
				{
					$savefiledialog1.FileName = "$($LinkName)"
				}
				else
				{
					$savefiledialog1.FileName = "Link"
				}
				$savefiledialog1.DefaultExt = 'json'
				
				if ($savefiledialog1.ShowDialog() -eq 'OK')
				{
					$OutputFileStream = [IO.File]::WriteAllText($savefiledialog1.FileName, $json, [System.Text.Encoding]::UTF8)
					$Status.Text = 'Ready'
					$json = $null
					$NodeCollection = $null
					$Jumplist_Browser.Cursor = 'Default'
					[System.GC]::Collect()
				}
				else
				{
					$Jumplist_Browser.Cursor = 'Default'
					$NodeCollection = $null
					[System.GC]::Collect()
					[System.Console]::Beep(500, 150)
				}
			}
			else
			{
				$Jumplist_Browser.Cursor = 'Default'
				[System.Console]::Beep(500, 150)
			}
		}
		else
		{
			$Jumplist_Browser.Cursor = 'Default'
			[System.Console]::Beep(500, 150)
		}
	}
	
	$treeview2_AfterSelect = [System.Windows.Forms.TreeViewEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.TreeViewEventArgs]
		$Status.Text = "$($_.Node.Text)"
		
		if (!!$treeview2.SelectedNode -and $treeview2.SelectedNode.BackColor -eq 'DarkBlue')
		{
			$treeview2.SelectedNode.BackColor = 'Black'
		}
		
		# SaveLNK to JSON
		$RootNames = @('NavPane', 'Taskband', 'StartPage2', 'Search') -join '|'
		if ($treeview2.Nodes[0].Text.EndsWith('.lnk') -or $treeview2.Nodes[0].Text.EndsWith('-ms') -or $treeview2.Nodes[0].Text -eq 'Local Registry' -or $treeview2.Nodes[0].Text -match $RootNames)
		{
			$toolstripseparator11.Visible = $true
			$SaveLnkToJson.Visible = $true
		}
		else
		{
			$SaveLnkToJson.Visible = $false
			$toolstripseparator11.Visible = $false
		}
	}
	
	$toolstrip3_About_Click = {
		$About.PerformClick()
	}
	
	$toolstrip3_Exit_Click = {
		$Jumplist_Browser.Close()
	}
	
	$toolstrip3_GitHub_Click = {
		$NotifyIcon1.ShowBalloonTip(0, "LNK & Jumplist Browser", "Opening 'https://kacos2000.github.io/Jumplist-Browser/'", "Info")
		[system.Diagnostics.Process]::start("https://kacos2000.github.io/Jumplist-Browser/")
	}
	
	# Treeview2 Search
	function Find-Nodes
	{
		[CmdletBinding()]
		param
		(
			[Parameter(Mandatory = $true)]
			$Nodes,
			[Parameter(Mandatory = $true)]
			[System.String]$Term
		)
		
		$found = $Nodes.where{ $_.Text.ToLower().Contains($Term.ToLower()) }
		if ($found.count -ge 1)
		{
			foreach ($f in $found)
			{
				$f.BackColor = 'DarkBlue' # "Indigo"
				$f.EnsureVisible()
				$f.Expand()
			}
		}
		else
		{
			$TreeSearch.PerformClick()
		}
	}
	
	$TreeSearch_Click = {
		$TreeSearch.Text = $null
		$treeview2.BeginUpdate()
		$Nodes = Get-Nodes -nodes $treeview2.Nodes
		$treeview2.EndUpdate()
		$treeview2.SelectedNode = $treeview2.Nodes[0]
		$treeview2.CollapseAll()
		$treeview2.Nodes[0].Expand()
	}
	
	$TreeSearch_KeyPress = [System.Windows.Forms.KeyPressEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.KeyPressEventArgs]
		$_.Handled = ![char]::IsLetterOrDigit($_.KeyChar) -and ![char]::IsPunctuation($_.KeyChar) -and ![char]::IsControl($_.KeyChar) -and $_.KeyChar -notin ([char][int]'32')
		
		if ($_.Handled -eq $false)
		{
			$TreeSearch.BackColor = 'Honeydew'
		}
		else
		{
			$_.Handled = $true
			$TreeSearch.BackColor = 'Tomato'
		}
	}
	
	$TreeSearch_KeyDown = [System.Windows.Forms.KeyEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.KeyEventArgs]
		if ($_.KeyCode -eq 'Enter' -and !!$TreeSearch.Text)
		{
			$treeview2.BeginUpdate()
			$Nodes = Get-Nodes -nodes $treeview2.Nodes
			Find-Nodes -Nodes $Nodes -Term $TreeSearch.Text.ToString()
			$treeview2.EndUpdate()
		}
	}
	
	$Tree1Search_SelectedIndexChanged = {
		$idx = $Tree1Search.SelectedIndex
		if ($idx -in $Script:AppListIdx.keys)
		{
			$filename = $Script:AppListIdx[$idx]
			$TreeSearch.Text = "Search"
			$node = $treeview1.Nodes.Find("$($filename)", $true)
			$treeview1.SelectedNode = $node[0]
			$treeview1.SelectedNode.Expand()
			
		}
	}
	
	$MinimizeWindow_Click = {
		$Jumplist_Browser.WindowState = 'Minimized'
	}
	
	$RestoreWindow_Click = {
		$Jumplist_Browser.WindowState = 'Normal'
	}
	
	$statusstrip1_ItemClicked = [System.Windows.Forms.ToolStripItemClickedEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.ToolStripItemClickedEventArgs]
		if ($_.ClickedItem.Name -eq 'Status')
		{
			if (![String]::IsNullOrEmpty($Status.Text))
			{
				$oldText = $Status.Text
				$Status.Text | Set-Clipboard
				$Status.Text = "Copied to clipboard: $($Status.Text)"
				Start-Sleep -Milliseconds 400
				$Status.Text = $oldText
			}
		}
		else
		{
			[System.Windows.Forms.Clipboard]::Clear()
		}
		
	}
	
	$Jumplist_Browser_Shown = {
		# Get Arguments
		try
		{
			$Args = [System.Environment]::GetCommandLineArgs()
			$extensions = @('.lnk', '.automaticDestinations-ms', '.customDestinations-ms', '.001', '.raw', '.dd', '.img', '.ima')
			if ($Args.Length -gt 1)
			{
				$L = $Args.Length
				$Attr = [System.IO.File]::GetAttributes("$($Args[(1 .. $L)])")
				if ($Attr.HasFlag([System.IO.FileAttributes]::Directory))
				{
					Open-Folder -Folder "$($Args[(1 .. $L)])"
				}
				elseif ([System.IO.FileInfo]::New("$($Args[(1 .. $L)])").Extension -in $extensions)
				{
					Open-File -Filename "$($Args[(1 .. $L)])"
				}
				else
				{
					$null
				}
			}
			else
			{
				$null
			}
		}
		catch { $null }
		
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$Jumplist_Browser.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		if($treeview1.SelectedNode -ne $null)
		{
			$script:MainForm_treeview1 = $treeview1.SelectedNode.Text
		}
		else
		{
			$script:MainForm_treeview1 = $null
		}
		if($treeview2.SelectedNode -ne $null)
		{
			$script:MainForm_treeview2 = $treeview2.SelectedNode.Text
		}
		else
		{
			$script:MainForm_treeview2 = $null
		}
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$statusstrip1.remove_ItemClicked($statusstrip1_ItemClicked)
			$Jumplist_Browser.remove_FormClosing($Jumplist_Browser_FormClosing)
			$Jumplist_Browser.remove_Load($Jumplist_Browser_Load)
			$Jumplist_Browser.remove_Shown($Jumplist_Browser_Shown)
			$OpenFolder.remove_Click($openfolder_Click)
			$exitToolStripMenuItem.remove_Click($exitToolStripMenuItem_Click)
			$treeview1.remove_AfterSelect($treeview1_AfterSelect)
			$treeview1.remove_NodeMouseClick($treeview1_NodeMouseClick)
			$treeview2.remove_AfterSelect($treeview2_AfterSelect)
			$treeview2.remove_NodeMouseClick($treeview2_NodeMouseClick)
			$CopyNode1.remove_Click($CopyNode1_Click)
			$Exit1.remove_Click($Exit1_Click)
			$Process1.remove_Click($Process1_Click)
			$CopyNode2.remove_Click($CopyNode2_Click)
			$CopyAll2.remove_Click($CopyAll2_Click)
			$Expand2.remove_Click($Expand2_Click)
			$Exit2.remove_Click($Exit2_Click)
			$Open.remove_Click($Open_Click)
			$About.remove_Click($About_Click)
			$Expand1.remove_Click($Expand1_Click)
			$Collapse1.remove_Click($Collapse1_Click)
			$ExpandAll1.remove_Click($ExpandAll1_Click)
			$CollapseAll1.remove_Click($CollapseAll1_Click)
			$Collapse2.remove_Click($Collapse2_Click)
			$ExpandAll2.remove_Click($ExpandAll2_Click)
			$CollapseAll2.remove_Click($CollapseAll2_Click)
			$SaveNodestoTxt.remove_Click($SaveNodestoTxt_Click)
			$OpenFileWith.remove_Click($OpenFileWith_Click)
			$CopyFullFilePath.remove_Click($CopyFullFilePath_Click)
			$CopyNode2Tag.remove_Click($CopyNode2Tag_Click)
			$SaveStreamToFile.remove_Click($SaveStreamToFile_Click)
			$toolstripRefresh.remove_Click($toolstripRefresh_Click)
			$GetMRUlist.remove_Click($GetMRUlist_Click)
			$SaveLnkToJson.remove_Click($SaveLnkToJson_Click)
			$SaveStream.remove_Click($SaveStream_Click)
			$toolstrip3_About.remove_Click($toolstrip3_About_Click)
			$toolstrip3_Exit.remove_Click($toolstrip3_Exit_Click)
			$toolstrip3_GitHub.remove_Click($toolstrip3_GitHub_Click)
			$TreeSearch.remove_KeyDown($TreeSearch_KeyDown)
			$TreeSearch.remove_KeyPress($TreeSearch_KeyPress)
			$TreeSearch.remove_Click($TreeSearch_Click)
			$Tree1Search.remove_SelectedIndexChanged($Tree1Search_SelectedIndexChanged)
			$GetNavPane.remove_Click($GetNavPane_Click)
			$MinimizeWindow.remove_Click($MinimizeWindow_Click)
			$RestoreWindow.remove_Click($RestoreWindow_Click)
			$GetTaskBand.remove_Click($GetTaskBand_Click)
			$GetStartPage2.remove_Click($GetStartPage2_Click)
			$GetLockScreen.remove_Click($GetLockScreen_Click)
			$GetSearchMRU.remove_Click($GetSearchMRU_Click)
			$Jumplist_Browser.remove_Load($Form_StateCorrection_Load)
			$Jumplist_Browser.remove_Closing($Form_StoreValues_Closing)
			$Jumplist_Browser.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$Jumplist_Browser.SuspendLayout()
	$splitcontainer1.SuspendLayout()
	$menustrip1.SuspendLayout()
	$statusstrip1.SuspendLayout()
	$contextmenustrip1.SuspendLayout()
	$contextmenustrip2.SuspendLayout()
	$contextmenustrip3.SuspendLayout()
	#
	# Jumplist_Browser
	#
	$Jumplist_Browser.Controls.Add($splitcontainer1)
	$Jumplist_Browser.Controls.Add($menustrip1)
	$Jumplist_Browser.Controls.Add($statusstrip1)
	$Jumplist_Browser.AutoScaleDimensions = New-Object System.Drawing.SizeF(10, 20)
	$Jumplist_Browser.AutoScaleMode = 'Font'
	$Jumplist_Browser.ClientSize = New-Object System.Drawing.Size(1883, 1294)
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAIZEAAACAAABAAQAMDAAAAEAIACoJQAARgAAACAgAAABACAA
qBAAAO4lAAAYGAAAAQAgAIgJAACWNgAAEBAAAAEAIABoBAAAHkAAACgAAAAwAAAAYAAAAAEAIAAA
AAAAgCUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAADg4OCBUVFSMpKSlZQ0NDh1RUVKVVVVWzUVFRnkJCQnorKytGGhoaFhQU
FAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAEBAR8BAQFLERERlUtLS+Z/f3/+k5OT/pmZmf+g
oKD+pqam/qKiov6EhIT9QUFB2AsLC3oCAgI4AgICEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
/rKUDP/LqRL+y6kS/s+vHP+skBj+hm8M3IFrCwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAs6A6AaeVN3zXwlD72Lgk/+DG
Qv/lz1T/3MRG/82xK//Fpxv/yKcT/8yqE//MqhP/zKoT/8mnE/+bfw3+eWUMYwAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAClki9BvaxOz9a9P/3RsRz+0K8Z/tCwHf/NrBf+zKoT/syqE//LqRL+zKoS/rCS
D/96Zgubg20MAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtKA5A6qXNES1o0Kmvqk85MmvMvzL
riX+yqsd/sanGf+3mhT+l38O435pDHaIcQwDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAArJgvCKGMJiidiSNGm4cfV5B8FlGQeREwjncPCQAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD///////8AAP4AP////wAA8AAP////AADAAAP///8AAIAAAP///wAAAAAAf///AAAAAAB/
//8AAAAIAH///wAAwD4A////AADAfwB///8AAMB/gD///wAAwH/AH///AADAf+AP//8AAMA/8Af/
/wAAwB/4A///AADgD/wB//8AAOAH/gD//wAA8AP/AH//AAD4Af8Af/8AAPwA/AB//wAA/gB4AD//
AAD/ADAAP/8AAP+AEAAf/wAA/8AAAA//AAD/4AAAB/8AAP/wAAAD/wAA//gAAAH/AAD//AAAAP8A
AP/+AAEAfwAA//8AA4A/AAD//4ADwB8AAP//4AHgDwAA///8APAHAAD///8AeAMAAP///wA8AQAA
////gB4BAAD////gDwAAAP///+ADgAAA////8AAAAAD////4AAAAAP////wAAAAA/////gABAAD/
////gAEAAP/////AAwAA//////gPAAD///////8AAP///////wAA////////AAAoAAAAIAAAAEAA
AAABACAAAAAAAIAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKSkp
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
RcOtP8TRtC7+0LAd/8yrFP/MqhL/y6kS/6mMD/OBawxHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAKmWMiesmTNkrJYoiKOMHIyRehFqhnANGgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPw////gA///gAH//wAAf/8AAH//gYD//4PAf/+D4D//g/Af
/4H4D//A/Af/wH4D/+A+A//wHAP/+AgB//wAAP/+AAB//wAAP/+AAB//wAAP/+AEB//4AgP//wEB
//+AgP//wED//+AA///wAP//+AD///wB////A///////////KAAAABgAAAAwAAAAAQAgAAAAAABg
CQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUFBQIZGRkfQ0NDS01NTVQvLy8wDg4OBgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAHAAAANCgoKKZ0dHT4gICA/oaGhv+SkpL+Xl5e0ggICFIAAAARAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0AAAA/LS0tsnZ2dv5+
fn7+m5ub/sHBwf7ExMT+l5eX/nt7e+cICAheAAAAGgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABEXFxddiIiI/nd3d/9/f3/6W1tbilxcXGySkpLY4eHh
/paWlv99fX3fDw8PMAQEBAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABwcHCegYGB/oODg/9TU1NiAAAAAAAAAABQUFAWioqK0eHh4f+Wlpb/h4eH1U9PTxgA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACRkZHCgYGB/nt7
e/VNTU0DAAAAAAAAAAAAAAAAUlJSFYuLi9Lh4eH+l5eX/o2NjdVcXFwYAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACLi4urpqam/pGRkf5XV1c1AAAAAAAAAAAAAAAA
AAAAAFNTUxaMjIzR4uLi/5eXl/6Ojo7VXl5eGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABfX19Z5OTk/oiIiP+Li4viVlZWJQAAAAAAAAAAAAAAAAAAAABVVVUWjY2N0eLi
4v6YmJj/kJCQ1V9fXxgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABISEgCioqK
tuLi4v6MjIz+jIyM4ldXVyQAAAAAAAAAAAAAAAAAAAAAVlVTFoqKiNTi4uL+mJiY/oiIiMNQUFAC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVVVVCo+Pj7vi4uL/jIyM/o2NjeJa
WlolAAAAAAAAAAAAAAAAc2EPNHlnG5qOgUb+mZFv/oaFf/5TUk9DAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAFdXVwqQkJC74uLi/o2Njf+Ojo7iW1tbJQAAAACGcA1UspMP
+7ydFf69oyr/rZQo/pJ5Ff9rXiSUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABXV1cKkZGRu+Pj4/+Ojo7/kJCQ4mtlRyixlRXjzKoT/8yqE/7SsRr/4MU9/tbEXv+i
hxj+hG4OcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWVlZCZGR
kbvi4uL+j4+P/pKRjO2okCP+w6IS/pyEG9eZkWzwvK1e/ubKPP7gz2f+p4wb/ohxEHMAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFpaWgqUlJS74+Pj/o2Njf+fnZj/
jYds/4mHf/6EhIT/mJiY/rOqcNju00L849Jq/qqPHf6JchBzAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABbW1sKkpKSuujo6P6jo6P+jIyM/pGRkf6pqan+e3p0yYaA
XA/z4Glm9NhG/eTTa/6pjhz9hnAPcwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAVlZWBXJycm+mpqbMs7Ks9b24nP6fkUv/hW4N14ZwFxkAAAAA+OVrZvLWRPzi0Wr/
pYob/oJsDXMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAkIRCIdO7RN/izVr/oIcR/ohwCdeOdhMaAAAAAPXhaGbrz0D8385n/p+EGP56ZQtyAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKqYNiHVvkXf5M9b
/qCHEf6HbwnXinISGgAAAADv22Nm4sY6/NrJYv6VexH7cF0JNAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACtmzgg1r9G3uPPW/+fhhD/hGwI14FrFBwA
AAAA2MNOcti7L/+9p0D/hG0LkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAq5k2IdS9Rd/gy1j/nYUQ/oNsBfN6ZQq0h3EQp8upE//FrDL/inIM
mwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAKmXNiHPuEPd38dK/sOqMP6njRL+s5UN/supEv64mRX+f2kLUQAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACikDEQvKg/hcWr
LeLMriP+yqkX/rmbEveMdQ2FAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIx8JAKUgSEbjnsaKoFtDw4AAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOB//wCAH/8AAA//AAAH
/wCGB/8AhwP/AIeB/wCDwP8AgeB/AMDgfwDgQH8A8AA/APgAHwD8AA8A/gAHAP8AgwD/4EEA//Ag
AP/4EAD//AAA//4AAP//AQD//8MA////ACgAAAAQAAAAIAAAAAEAIAAAAAAAQAQAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAxAQEDdVVVWAZWVliCUlJUwBAQEIAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAERQUFHZtbW33iYmJ/6mpqf+goKD+PT09pAAAABwAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgICBNzc3PnfX19/VpaWntZWVlYubm566Ojo/5GRkaDAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAyMjIolJSU/3FxcbEAAAAAAAAAAE9PTy66urrr
pKSk/nFxcXUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMTExFLOzs/yDg4PdPj4+EAAAAAAA
AAAAUVFRL7u7u+ulpaX+c3NzdQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACOjo6YtbW1/4OD
g8k/Pz8QAAAAAAAAAABTUlEvurq57Kampv5xcXFiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANDQ0
BJmZmam1tbX/hYWFyUFBQRAAAAAAe2cNVol0HdKcjEv/dnBX4gAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAA2NjYEmpqaqbW1tf+GhobJdWkxQcSjEvzPrhj/1rw5/7egNv6DbQ93AAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAADc3NwSbm5uptra2/5eTffeojyP+kIJI56efc//kzVL/wqxA/op0
EHcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAODg4BJycnKm+vr7/l5eX/5SUlP+PjovnrKJj
UvTbVOrFrkL+iXMQdwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAyMjICcXFxW6GekK3Hu3v+
kXsV7ZR9HzLq12Ut8tlT6sGrQP6CbA13AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAvag9gNnDTf6UewztlX0cM+TRYC3oz0zquKI5/nRgClkAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAC+qj6A2MJM/pF4C+2HchtPuaQ9Tde9OP+PdxK5AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALunPH/UvUT+qZEb/52DCf7Nqxb/j3cQmgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAApJIzQr2lLKK6nhrEo4gQnmNTCREA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAgf8AAAD/AAAA/wAAGH8AAAw/AACGHwAAgh8AAMAPAADgBwAA8AMAAPgBAAD/AAAA/4AA
AP/AAAD/4AAA//8AAAs='))
	#endregion
	$Jumplist_Browser.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Jumplist_Browser.MainMenuStrip = $menustrip1
	$Jumplist_Browser.Margin = '6, 6, 6, 6'
	$Jumplist_Browser.MinimumSize = New-Object System.Drawing.Size(1905, 1348)
	$Jumplist_Browser.Name = 'Jumplist_Browser'
	$Jumplist_Browser.StartPosition = 'CenterScreen'
	$Jumplist_Browser.Text = 'Lnk (SHLLINK) & Jumplist Browser'
	$Jumplist_Browser.add_FormClosing($Jumplist_Browser_FormClosing)
	$Jumplist_Browser.add_Load($Jumplist_Browser_Load)
	$Jumplist_Browser.add_Shown($Jumplist_Browser_Shown)
	#
	# splitcontainer1
	#
	$splitcontainer1.BackColor = [System.Drawing.Color]::White 
	$splitcontainer1.CausesValidation = $False
	$splitcontainer1.ContextMenuStrip = $contextmenustrip2
	$splitcontainer1.Dock = 'Fill'
	$splitcontainer1.Location = New-Object System.Drawing.Point(0, 35)
	$splitcontainer1.Margin = '0, 0, 0, 50'
	$splitcontainer1.Name = 'splitcontainer1'
	[void]$splitcontainer1.Panel1.Controls.Add($treeview1)
	$splitcontainer1.Panel1.Margin = '0, 0, 0, 5'
	[void]$splitcontainer1.Panel2.Controls.Add($treeview2)
	$splitcontainer1.Panel2.Margin = '0, 0, 0, 5'
	$splitcontainer1.Size = New-Object System.Drawing.Size(1883, 1231)
	$splitcontainer1.SplitterDistance = 626
	$splitcontainer1.SplitterWidth = 7
	$splitcontainer1.TabIndex = 2
	#
	# menustrip1
	#
	$menustrip1.Font = [System.Drawing.Font]::new('Segoe UI', '9')
	[void]$menustrip1.Items.Add($fileToolStripMenuItem)
	[void]$menustrip1.Items.Add($toolstripRefresh)
	[void]$menustrip1.Items.Add($Tree1Search)
	[void]$menustrip1.Items.Add($About)
	[void]$menustrip1.Items.Add($TreeSearch)
	$menustrip1.Location = New-Object System.Drawing.Point(0, 0)
	$menustrip1.Name = 'menustrip1'
	$menustrip1.Padding = '10, 3, 0, 3'
	$menustrip1.RenderMode = 'System'
	$menustrip1.ShowItemToolTips = $True
	$menustrip1.Size = New-Object System.Drawing.Size(1883, 35)
	$menustrip1.TabIndex = 0
	#
	# statusstrip1
	#
	$statusstrip1.BackColor = [System.Drawing.SystemColors]::Control 
	$statusstrip1.Font = [System.Drawing.Font]::new('Segoe UI', '10')
	[void]$statusstrip1.Items.Add($Status)
	$statusstrip1.Location = New-Object System.Drawing.Point(0, 1266)
	$statusstrip1.Margin = '0, 5, 0, 0'
	$statusstrip1.MinimumSize = New-Object System.Drawing.Size(0, 28)
	$statusstrip1.Name = 'statusstrip1'
	$statusstrip1.Padding = '2, 0, 23, 0'
	$statusstrip1.ShowItemToolTips = $True
	$statusstrip1.Size = New-Object System.Drawing.Size(1883, 28)
	$statusstrip1.TabIndex = 1
	$statusstrip1.add_ItemClicked($statusstrip1_ItemClicked)
	#
	# fileToolStripMenuItem
	#
	[void]$fileToolStripMenuItem.DropDownItems.Add($Open)
	[void]$fileToolStripMenuItem.DropDownItems.Add($toolstripseparator1)
	[void]$fileToolStripMenuItem.DropDownItems.Add($OpenFolder)
	[void]$fileToolStripMenuItem.DropDownItems.Add($toolStripSeparator)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetMRUlist)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetSearchMRU)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetNavPane)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetTaskBand)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetStartPage2)
	[void]$fileToolStripMenuItem.DropDownItems.Add($GetLockScreen)
	[void]$fileToolStripMenuItem.DropDownItems.Add($toolstripseparator2)
	[void]$fileToolStripMenuItem.DropDownItems.Add($exitToolStripMenuItem)
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAA+AIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAACmklEQVQ4T42Sb0hTURiHz770pRoGgV+CPkShNZMQFCFC0TKUNpQ1IgzCUEsmODYiFEMj
WaKpbYbTsIb/QtMiRLzNQhpqyhxJQ8FIKYSUia4tL9vNur/ee+9yEH7wBw/ncM95n/Oew2UNzmFr
ja2Xr7H3YQdb709bH2dme0nD01eiCGCN8BMbhJTmruGYcIfe7Qcdg0+ipUoc/S65aJQMrk1gXADm
FceuIYkQLVUiCXbLFhH4DylVTU5ES5U4+jmElnsw0cjgtsaYH0gFv9gIfqkTW18c+D5Zhsnm2Drt
H5MFj3tG8PHZEYDnyB87S+A3YbGYodEkyUjz7TDdUb5wAFNNTOnkbq0F3vb99PEb9V1JlU5EAj5o
kjQwVd7BW98s3vs8sFTeJpEGYmgBWO1EnYG9UwSWXHweSiHBNIlLaZxBhbEIZWYTFsUgJiIhfNoO
0ZsEUWEqh9FYgvXZKhjOsEeyoN6sweq4AQjbgIVTgDiC+Ph4cB4XJoIr4DZW4A2tYP03jd5Rec33
UoeEA6xYFthNaoQXaqn9BmD5PHUwDrVaDde0C76IH17ej6+CH2H6SzweDnHqOIzZjkn3T5MF7UYG
BF8DETuwaSbBKIqvX4HeoKe2Q/RcPAQCNL9sKEBWjhadZlWESg/Jgo4bJMASIb2w8sqiEIBKpUJe
fj7cMzMyeTqddCoSdTYkX33+J+dWT4EsaC1mb9oKmdheyPCPrnKGubF70Gsz5SKJtPR0JOY2oWYg
iP5ZIEnfF75Qxl2UVlUnGdtHmw4ScYTUmsTh6urqlJaW1qzauvrMazfv55y+5PxlHdrC8CLQPQUc
z25bo317j7Z0KD852yFYXwRRUjeHxAz7h+jS3nNO3609kVr/I+HsQ3dm0eDRv8Y8Op7Vrgl5AAAA
AElFTkSuQmCCCw=='))
	#endregion
	$fileToolStripMenuItem.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$fileToolStripMenuItem.Name = 'fileToolStripMenuItem'
	$fileToolStripMenuItem.Size = New-Object System.Drawing.Size(66, 29)
	$fileToolStripMenuItem.Text = '&File'
	#
	# OpenFolder
	#
	$OpenFolder.BackColor = [System.Drawing.Color]::Honeydew 
	$OpenFolder.Font = [System.Drawing.Font]::new('Segoe UI', '9', [System.Drawing.FontStyle]'Bold')
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAsgIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAABc1JHQgCuzhzpAAAABGdBTUEAALGPC/xhBQAAAAlw
SFlzAAAWJQAAFiUBSVIk8AAAAkdJREFUOE/FkF1I02EUxv8XXXRlkRWFUGB54c0gKKK6CCmiUBTL
LEjShJofVBgLc360qenm5ubUlS5rm66p00ozCvuQCkUi1NSRZmpWFJViZqjk16+/LtShhHcdeHjh
cJ7fec4rLLeUBjuX1FYyjQ7+tpZfETKjmylVhM284bJ8hE99b6m06Repo+XpPzeFxGYTFJ2DMDPc
1WZhbKhiVr8H7Uz0m3FYs+lofbYk5EiMjqAoAwHSPISKYh2jg6Vu5qmvBUw44yi9qaakMANzfiqm
nBSuaeXkqeLdoWUWDaPfLXPmadFMlxyc0iW1CHCrSMWvL6Y5c22lZlYPHVnU2FXcLcnAYU7DblJi
NV7mhiGJQp0coybBBSsxZTD8IXc2dm+9gqpSHVO9SuhLd9d7sdeTCJ0yeBNLa3kotut6BLMxjZ/d
aviopbosm8ZHWtfQwuivw6EphMkGf8Ye+/GuWIJMGuw6pcig4EeHkr6GZKrsWqZ7FNAe5TK2RorG
40w2BjJWd4DhB3sYqNyGMtpHPEfuAhTokhloS+C2TUPzCzFJZ5wIOA3NYUy/DGb8+SFGavcyWLWd
b2W+NF1ZzQl/7/mPNGbJaa9L4Y4tC7pToEWM++oo4/UBjDzxY6hmJ/0OCZ8tW3FqPVFIt3A2+uQ8
IDczngqrGue9GJr0wpwatSuoU63kfuoqypPWYY734uqFzYQt3D5T+vSL6BVnyEyIIPHcMc5HBnIq
dD+HD+5i324JOyQ++Hp7sWnjWtav8WCDp4c74D+XIPwBF8beaT1+/VgAAAAASUVORK5CYIIL'))
	#endregion
	$OpenFolder.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$OpenFolder.ImageTransparentColor = [System.Drawing.Color]::Magenta 
	$OpenFolder.Name = 'OpenFolder'
	$OpenFolder.ShortcutKeys = [System.Windows.Forms.Keys]::F -bor [System.Windows.Forms.Keys]::Control 
	$OpenFolder.Size = New-Object System.Drawing.Size(252, 30)
	$OpenFolder.Text = 'Open &Folder'
	$OpenFolder.ToolTipText = 'Open folder with LNKs and/or Jumplists'
	$OpenFolder.add_Click($openfolder_Click)
	#
	# toolStripSeparator
	#
	$toolStripSeparator.Name = 'toolStripSeparator'
	$toolStripSeparator.Size = New-Object System.Drawing.Size(249, 6)
	#
	# exitToolStripMenuItem
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAPAEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAA3klEQVQ4T62TQQrCMBBFk43iOayL4tIbKSpCTyBY1LPpSqF1oYuSU5Tsx5l0qkka2iAO
fCjT/34yAxF/KTUViyqRRTWTECX0EsO4ENh4BI19QoZxDAgZIsR4N6DeL0Gl428vHWFv5XhIjLsB
9WENpsprE4IwFBfT0vl2OEDNJwDPmwEopIXhdTf/bC/j3RGcEKoATGI8sETr2qbacTwf416ADePJ
9jh+COPeEvNNA/C17XH0cTccQNKnzJmZvvU5czwkxgM7iBTjGJDIMmToFTKMfx5TfAh6ncf0ewnx
BuWSu6CElvwDAAAAAElFTkSuQmCCCw=='))
	#endregion
	$exitToolStripMenuItem.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$exitToolStripMenuItem.Name = 'exitToolStripMenuItem'
	$exitToolStripMenuItem.Size = New-Object System.Drawing.Size(252, 30)
	$exitToolStripMenuItem.Text = 'E&xit'
	$exitToolStripMenuItem.add_Click($exitToolStripMenuItem_Click)
	#
	# folderbrowserdialog1
	#
	$folderbrowserdialog1.Description = 'Select Folder'
	$folderbrowserdialog1.ShowNewFolderButton = $False
	#
	# Status
	#
	$Status.Font = [System.Drawing.Font]::new('Segoe UI', '10')
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAA1QEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABd0lEQVQ4T41QsUoDQRBdkoCIICqKP6Bg4QckoKCdFiFNPHeyh9HGyhP8DcFPUOwEqztj
iEUKg6VYigRR8A8iCjbK+WadMxtzah4MO7Pz3szbVYyMDvdsAmQoukZ9KeX/yNFZIUtRjOhkdfho
cx3dSnswZChsivAgS+ETBj1IazBgwA2Ex7bQ0bQ4ele64dm7v4D3Xn1tD99yJsrDxYmiWqyoEStd
22eOIe+FiGIr+AkITsX2HQ9i8fj64WpRV+srJhhlDpGOeQBilmtjzJHv+yOc9wAD2orq8TLtnm/Q
WozNEH2LbWitn+W8F5mDzeaioosdTkls/xZwMGM1aahWS2Pu5kqlsg3BFrZ+JHflcnlY6L3wDRO6
Yoh8acEVFZN7iY60usAHuQTeXpIW95bcHoe0egF7UwkBDl5xLkCcx9lJ7hEFofcjCIIhh5gaQk0H
PqyVJnIDT2sIvR/sAJYtAeS5ROR53jyeNwFxG/WkJQ+CZICUDpT6BFa396VSSYX0AAAAAElFTkSu
QmCCCw=='))
	#endregion
	$Status.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Status.Margin = '0, 0, 0, 0'
	$Status.Name = 'Status'
	$Status.Size = New-Object System.Drawing.Size(16, 28)
	$Status.TextAlign = 'MiddleLeft'
	#
	# treeview1
	#
	$treeview1.BackColor = [System.Drawing.Color]::Black 
	$treeview1.BorderStyle = 'None'
	$treeview1.ContextMenuStrip = $contextmenustrip1
	$treeview1.Dock = 'Fill'
	$treeview1.Font = [System.Drawing.Font]::new('Calibri', '10')
	$treeview1.ForeColor = [System.Drawing.SystemColors]::Window 
	$treeview1.HideSelection = $False
	$treeview1.Location = New-Object System.Drawing.Point(0, 0)
	$treeview1.Margin = '5, 5, 5, 5'
	$treeview1.Name = 'treeview1'
	$treeview1.ShowNodeToolTips = $True
	$treeview1.Size = New-Object System.Drawing.Size(626, 1231)
	$treeview1.TabIndex = 0
	$treeview1.add_AfterSelect($treeview1_AfterSelect)
	$treeview1.add_NodeMouseClick($treeview1_NodeMouseClick)
	#
	# treeview2
	#
	$treeview2.BackColor = [System.Drawing.Color]::Black 
	$treeview2.BorderStyle = 'None'
	$treeview2.ContextMenuStrip = $contextmenustrip2
	$treeview2.Dock = 'Fill'
	$treeview2.Font = [System.Drawing.Font]::new('Consolas', '9.5')
	$treeview2.ForeColor = [System.Drawing.SystemColors]::Window 
	$treeview2.HideSelection = $False
	$treeview2.Location = New-Object System.Drawing.Point(0, 0)
	$treeview2.Margin = '5, 5, 5, 5'
	$treeview2.Name = 'treeview2'
	$treeview2.ShowNodeToolTips = $True
	$treeview2.Size = New-Object System.Drawing.Size(1250, 1231)
	$treeview2.TabIndex = 0
	$treeview2.add_AfterSelect($treeview2_AfterSelect)
	$treeview2.add_NodeMouseClick($treeview2_NodeMouseClick)
	#
	# contextmenustrip1
	#
	$contextmenustrip1.ImageScalingSize = New-Object System.Drawing.Size(32, 32)
	[void]$contextmenustrip1.Items.Add($CopyNode1)
	[void]$contextmenustrip1.Items.Add($CopyFullFilePath)
	[void]$contextmenustrip1.Items.Add($toolstripseparator6)
	[void]$contextmenustrip1.Items.Add($Process1)
	[void]$contextmenustrip1.Items.Add($OpenFileWith)
	[void]$contextmenustrip1.Items.Add($SaveStream)
	[void]$contextmenustrip1.Items.Add($toolstripseparator8)
	[void]$contextmenustrip1.Items.Add($Expand1)
	[void]$contextmenustrip1.Items.Add($Collapse1)
	[void]$contextmenustrip1.Items.Add($toolstripseparator7)
	[void]$contextmenustrip1.Items.Add($ExpandAll1)
	[void]$contextmenustrip1.Items.Add($CollapseAll1)
	[void]$contextmenustrip1.Items.Add($toolstripseparator5)
	[void]$contextmenustrip1.Items.Add($Exit1)
	$contextmenustrip1.Name = 'contextmenustrip1'
	$contextmenustrip1.Size = New-Object System.Drawing.Size(331, 408)
	#
	# CopyNode1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAANgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAA2ElEQVQ4T6WSQQqDMBBFhV7AtotC6bVcCxN14z16gK5q7yGuXOi60GWhh4nODxF0krRK
H3wicXx8oxERXTm1jFLqVpblMfpFnue11noR7HVdB8mDc7CjfkICrH3fo809TdPYjrtMwzE1Jri2
t9bha4B9rj74wo1eWZZdzMMg1KAoikGCPT4biD4sOi8E84QEPGtWPhs0ebPo5DRA5oK9akzAJABW
8tzUoKoq50w2NZBgZlMDiRHwezi/sq+BDDCCEKsb+EiSZPdXg7ngG0EB4LNo5SeTIaJ2BBNZGvIe
WvGrAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CopyNode1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CopyNode1.Name = 'CopyNode1'
	$CopyNode1.Size = New-Object System.Drawing.Size(330, 38)
	$CopyNode1.Text = 'Copy Selected Node Text'
	$CopyNode1.add_Click($CopyNode1_Click)
	#
	# toolstripseparator6
	#
	$toolstripseparator6.Name = 'toolstripseparator6'
	$toolstripseparator6.Size = New-Object System.Drawing.Size(327, 6)
	#
	# toolstripseparator7
	#
	$toolstripseparator7.Name = 'toolstripseparator7'
	$toolstripseparator7.Size = New-Object System.Drawing.Size(327, 6)
	#
	# Exit1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAPAEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAA3klEQVQ4T62TQQrCMBBFk43iOayL4tIbKSpCTyBY1LPpSqF1oYuSU5Tsx5l0qkka2iAO
fCjT/34yAxF/KTUViyqRRTWTECX0EsO4ENh4BI19QoZxDAgZIsR4N6DeL0Gl428vHWFv5XhIjLsB
9WENpsprE4IwFBfT0vl2OEDNJwDPmwEopIXhdTf/bC/j3RGcEKoATGI8sETr2qbacTwf416ADePJ
9jh+COPeEvNNA/C17XH0cTccQNKnzJmZvvU5czwkxgM7iBTjGJDIMmToFTKMfx5TfAh6ncf0ewnx
BuWSu6CElvwDAAAAAElFTkSuQmCCCw=='))
	#endregion
	$Exit1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Exit1.Name = 'Exit1'
	$Exit1.Size = New-Object System.Drawing.Size(330, 38)
	$Exit1.Text = 'Exit'
	$Exit1.add_Click($Exit1_Click)
	#
	# Process1
	#
	$Process1.BackColor = [System.Drawing.Color]::Honeydew 
	$Process1.Enabled = $False
	$Process1.Name = 'Process1'
	$Process1.Size = New-Object System.Drawing.Size(330, 38)
	$Process1.Text = 'Process '
	$Process1.Visible = $False
	$Process1.add_Click($Process1_Click)
	#
	# toolstripseparator8
	#
	$toolstripseparator8.Name = 'toolstripseparator8'
	$toolstripseparator8.Size = New-Object System.Drawing.Size(327, 6)
	$toolstripseparator8.Visible = $False
	#
	# contextmenustrip2
	#
	$contextmenustrip2.ImageScalingSize = New-Object System.Drawing.Size(32, 32)
	[void]$contextmenustrip2.Items.Add($CopyNode2)
	[void]$contextmenustrip2.Items.Add($CopyNode2Tag)
	[void]$contextmenustrip2.Items.Add($CopyAll2)
	[void]$contextmenustrip2.Items.Add($toolstripseparator11)
	[void]$contextmenustrip2.Items.Add($SaveStreamToFile)
	[void]$contextmenustrip2.Items.Add($SaveLnkToJson)
	[void]$contextmenustrip2.Items.Add($toolstripseparator9)
	[void]$contextmenustrip2.Items.Add($Expand2)
	[void]$contextmenustrip2.Items.Add($Collapse2)
	[void]$contextmenustrip2.Items.Add($toolstripseparator4)
	[void]$contextmenustrip2.Items.Add($ExpandAll2)
	[void]$contextmenustrip2.Items.Add($CollapseAll2)
	[void]$contextmenustrip2.Items.Add($toolstripseparator10)
	[void]$contextmenustrip2.Items.Add($SaveNodestoTxt)
	[void]$contextmenustrip2.Items.Add($toolstripseparator3)
	[void]$contextmenustrip2.Items.Add($Exit2)
	$contextmenustrip2.Name = 'contextmenustrip2'
	$contextmenustrip2.Size = New-Object System.Drawing.Size(394, 452)
	#
	# CopyNode2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAUwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB9UlEQVQ4T5WTy2sTURTGb3wgRf+E/C8hkCwD2WTjIuDCuAqRvAl5k+cmkIBjEie1OOME
KajFiiUJFUsRoQvXSlssLS6KKBQkSu0cv3NjQtImUD/4uDPcud/5nZkzol6v3y+Xy08qlYrGLpVK
0oVCQYvFYivJZPK2x+O5KoSwwBeFwyumaWrzrCiKhgKa1+u94/P5ruPxiyFzAnT4KWzUajWDrznE
7Xbf9fv9NzKZzJV/R0caB3w7MbX13iddefj4EK2YMLGxT8VikdASRaPR00AgUJuhwcY0gVGtVs9o
gZrNJoGGHA5H02q1LsmQccDJ0NRevvpooOrCgE6nI1cOcTqdywi4eZ6gC2QZ8OMn0eb2AW29P6Tt
D0fyoKqOAliNRoPsdrsq8vm8DBj+MrXVFztd9LuQQNd1arXb1Gq16YGiUDAYPBO5XG6GYBwwPCVU
P5LVeZ2ncDhMAp9lQvDs+U4XRAsJzisej5NIpVIzBOOA33/wDrYOpAfvvlBvc582Bnv0ur9Lx9/l
+VEARnU6wEBL/0eQSCSWpwL0bDY7IeDK/bf7svqb/h6t93ZpbeMzfT3GJoR/hUQ6nb6HpEe4USOR
iAqiSxNgMomH0WKz2a5h5cm6BSK8/8tJfoUp8WxbQLIGIpP7Y0SuwuaH2aFQaGKXyzX4CxZw19hB
z+7oAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CopyNode2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CopyNode2.Name = 'CopyNode2'
	$CopyNode2.Size = New-Object System.Drawing.Size(393, 38)
	$CopyNode2.Text = 'Copy Selected Node Text'
	$CopyNode2.add_Click($CopyNode2_Click)
	#
	# CopyAll2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAANgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAA2ElEQVQ4T6WSQQqDMBBFhV7AtotC6bVcCxN14z16gK5q7yGuXOi60GWhh4nODxF0krRK
H3wicXx8oxERXTm1jFLqVpblMfpFnue11noR7HVdB8mDc7CjfkICrH3fo809TdPYjrtMwzE1Jri2
t9bha4B9rj74wo1eWZZdzMMg1KAoikGCPT4biD4sOi8E84QEPGtWPhs0ebPo5DRA5oK9akzAJABW
8tzUoKoq50w2NZBgZlMDiRHwezi/sq+BDDCCEKsb+EiSZPdXg7ngG0EB4LNo5SeTIaJ2BBNZGvIe
WvGrAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CopyAll2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CopyAll2.Name = 'CopyAll2'
	$CopyAll2.Size = New-Object System.Drawing.Size(393, 38)
	$CopyAll2.Text = 'Copy Selected Node''s Child Nodes'
	$CopyAll2.ToolTipText = 'Copy all the Child Nodes of the selected Node'
	$CopyAll2.add_Click($CopyAll2_Click)
	#
	# toolstripseparator9
	#
	$toolstripseparator9.Name = 'toolstripseparator9'
	$toolstripseparator9.Size = New-Object System.Drawing.Size(390, 6)
	#
	# Expand2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAuQEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABW0lEQVQ4T2Ooqqp6VF1d/Z8UDNLDAAMggX///j36TyQAqQXpgWqHGAACmVMRGBlM3YLA
MDBIDUAG2DSBwJnr/8A02QbAwKFDB4kzYMZ2CP/kwz3/k2e6/9cvE/ifOd/3/4KtU0Gx0YpiAC5b
0+eE/ZdpYPivu5Lhf8EZ7/+6yxn+S9cy/E+a5XoJaEgtXgOO3N3+X6qO4b/HHUawZhAA0R53GP5L
VDH8X3SifzpeAyIn2/5XnAWxGWZA7mn3/7Zb+P7Lz2D479WhfQ9rGMBCWz4LohkbAInLZTF8ABuA
KymHTDT7L9SK6gIYW6iF4b9rm+otnJnp0JFD/ydvaP0vkM/wX2oiwiUgWmoSw3++HIb/mYv8msAx
gQsAXdbv06VzjzeT4T8n0CCQZhAN4js2K5x27dbjhirFCSQDk9z9GtfmrjevEXkukszwzbJW7JFb
lc4EBlYGAwYGBgkA/k2qEIW0rPkAAAAASUVORK5CYIIL'))
	#endregion
	$Expand2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Expand2.Name = 'Expand2'
	$Expand2.Size = New-Object System.Drawing.Size(393, 38)
	$Expand2.Text = 'Expand'
	$Expand2.ToolTipText = 'The Selected Node'
	$Expand2.add_Click($Expand2_Click)
	#
	# toolstripseparator10
	#
	$toolstripseparator10.Name = 'toolstripseparator10'
	$toolstripseparator10.Size = New-Object System.Drawing.Size(390, 6)
	#
	# Exit2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAPAEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAA3klEQVQ4T62TQQrCMBBFk43iOayL4tIbKSpCTyBY1LPpSqF1oYuSU5Tsx5l0qkka2iAO
fCjT/34yAxF/KTUViyqRRTWTECX0EsO4ENh4BI19QoZxDAgZIsR4N6DeL0Gl428vHWFv5XhIjLsB
9WENpsprE4IwFBfT0vl2OEDNJwDPmwEopIXhdTf/bC/j3RGcEKoATGI8sETr2qbacTwf416ADePJ
9jh+COPeEvNNA/C17XH0cTccQNKnzJmZvvU5czwkxgM7iBTjGJDIMmToFTKMfx5TfAh6ncf0ewnx
BuWSu6CElvwDAAAAAElFTkSuQmCCCw=='))
	#endregion
	$Exit2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Exit2.Name = 'Exit2'
	$Exit2.Size = New-Object System.Drawing.Size(393, 38)
	$Exit2.Text = 'Exit'
	$Exit2.add_Click($Exit2_Click)
	#
	# openfiledialog1
	#
	$openfiledialog1.ReadOnlyChecked = $True
	$openfiledialog1.ShowReadOnly = $True
	#
	# Open
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAFAIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABtklEQVQ4T5WS0UtTURzHv5IweqgHX0MI6o+ooN5C8EHqoRd7qAwUYxFjl1kbW6KriOHG
3VjR2FrrrmAQISx0NEgZtgb2EAiJEiNZYBROWkKG83773et9yDR29z18Hs73nvM938M9sKUhHIUC
wmvSlPlVXMABDGPVWtFSHWaIwYCM6xJyBVkJ2La+tyHj5Et4IB0oUTomMnl3IJptCPwbv6r9VLPT
t6xtpi4/Hu5Gv9S+iC2hKfyGP5r9wf8oqr3aFWrgVdMciTxaOz1+9gxuoxOjYhq6WSb978ngIhmq
kal1095XlYXPDD68u9MuoGqWvVdbwq9/MFRZqFLTVJ8Z4A8/ob7xgSX1MN/cQ1vMTBwswBtKcjHf
R35JSrbR2y51zobkNyp34ixFHGJ8lM4p6Xm/NbpcWy+zGMQyPD6Fb2OHJGCFbCiCuzXMsVkNcy7i
eIZRpZdLL0+J+Zqs9diDk6wVzxsH30DYfYz1eadUi5HLJ+3BeZbjXawkjpxAwgXy+3MJiJLfhlpT
90hAlS/c2JxSjzuQuQad/CTmmn2+asw58c58B2kXCplB6E8HwTZYL4zhHAD8Ad1Qd/Ir+3S0AAAA
AElFTkSuQmCCCw=='))
	#endregion
	$Open.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Open.Name = 'Open'
	$Open.ShortcutKeys = [System.Windows.Forms.Keys]::O -bor [System.Windows.Forms.Keys]::Control 
	$Open.Size = New-Object System.Drawing.Size(252, 30)
	$Open.Text = '&Open File'
	$Open.add_Click($Open_Click)
	#
	# About
	#
	$About.Alignment = 'Right'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAugEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABXElEQVQ4T4WTO0sDQRSFRxRbd802EoiooBb+nbQWs2YLEdRSRHxXioX+BLtgI8rMxogJ
Wgl2Yu+j01JRAivjmfEOJMMVD3zs49x7ZvburggVy8ZMnOrDKNUPUao+IqnecbyPpD4oZfk0lTGq
1gdjqY5iqb8RYCxJlpuklrtzokDgvlhvDVAXCc0wLroKHUwAoU57Quz2wqLxxUvjVZ5v9ngOqXdc
c0nqKdwowoLJ5Ra1G1NZYAJS3Ynk+ajAsPYY02FDJpauWM8h1Ramru5YE/wXgMVvEKDfONPixXkW
DP5J4OQ1NDxenEc84g2oW8ZweHGeQ6oWdqB2WRN4cZ4FX+iqGJprjOGiE5oWL87DAD+Tmh5x3wJ2
sc0VWRV/B6y4ZqdqvR/bOeEKWaQ+FsL0UTcJITA2UcA+jgWLfP2uHDZ3Kc6aFRRvYMLX+Ede0PSM
6zYa14Znz8pURhLiB6He59HTFA2SAAAAAElFTkSuQmCCCw=='))
	#endregion
	$About.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$About.Name = 'About'
	$About.Size = New-Object System.Drawing.Size(90, 29)
	$About.Text = 'About'
	$About.add_Click($About_Click)
	#
	# Expand1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAuQEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABW0lEQVQ4T2Ooqqp6VF1d/Z8UDNLDAAMggX///j36TyQAqQXpgWqHGAACmVMRGBlM3YLA
MDBIDUAG2DSBwJnr/8A02QbAwKFDB4kzYMZ2CP/kwz3/k2e6/9cvE/ifOd/3/4KtU0Gx0YpiAC5b
0+eE/ZdpYPivu5Lhf8EZ7/+6yxn+S9cy/E+a5XoJaEgtXgOO3N3+X6qO4b/HHUawZhAA0R53GP5L
VDH8X3SifzpeAyIn2/5XnAWxGWZA7mn3/7Zb+P7Lz2D479WhfQ9rGMBCWz4LohkbAInLZTF8ABuA
KymHTDT7L9SK6gIYW6iF4b9rm+otnJnp0JFD/ydvaP0vkM/wX2oiwiUgWmoSw3++HIb/mYv8msAx
gQsAXdbv06VzjzeT4T8n0CCQZhAN4js2K5x27dbjhirFCSQDk9z9GtfmrjevEXkukszwzbJW7JFb
lc4EBlYGAwYGBgkA/k2qEIW0rPkAAAAASUVORK5CYIIL'))
	#endregion
	$Expand1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Expand1.Name = 'Expand1'
	$Expand1.Size = New-Object System.Drawing.Size(330, 38)
	$Expand1.Text = 'Expand'
	$Expand1.add_Click($Expand1_Click)
	#
	# Collapse1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAApwEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABSUlEQVQ4T2Ooqqp6VF1d/Z8UDNLDAAMggX///j36TyQAqQXpgWqHGAACmVMRGBlM3YLA
MDBIDUAG2DSBwJnr/8A02QbAwOmTJ4kzYNZWCP/1/v3/N/v6/p8sIv5/e0jI/4MzZoBiox/FAFy2
bgyN/j+XgeH/XTa2/+95ef/fAdJzgPxN3t6XgNIdeA14sWvX/1lAxe9YWP5/BGqEYRB/JlD8xqRJ
0/EasNbZ+f9+oMKD3Nz/P06dCscg/h6g+DIjo3tYwwAW2j3MLP9XAhViAyDxHkbGD2ADcCXl1TY2
YP/PZWT8f7enB45BYQDCi3R0buHMTGeAUbW7owMYSgz/p2HB7UC8LSSkCRwTuADQZTOWGRvfA6r6
34qEQfz5GhqngfJVUKU4gWSuj4/vkri4LbOkpZ+3MTB8my0n96hFR2caFwODPgMDgwQA5fqgNsaN
05UAAAAASUVORK5CYIIL'))
	#endregion
	$Collapse1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Collapse1.Name = 'Collapse1'
	$Collapse1.Size = New-Object System.Drawing.Size(330, 38)
	$Collapse1.Text = 'Collapse'
	$Collapse1.add_Click($Collapse1_Click)
	#
	# toolstripseparator5
	#
	$toolstripseparator5.Name = 'toolstripseparator5'
	$toolstripseparator5.Size = New-Object System.Drawing.Size(327, 6)
	#
	# ExpandAll1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAATAIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB7klEQVQ4T2NwqLi9zar45n9s2LHy9hYGQsC58Ob/7ff+/z/0HBVvv/v/v0P+9f9QZbiB
V871/1P3//8/aR8qBol5ZF4jbEBg5rVtfsnX/mPDARk3CHsBBEJDQ9n4+Pj+g2ioEGmgrKxse0VF
xf/y8vK/VVVVq6HCDA4l17AGsFMFWuDW1dX9hwGgId9BYh6529hdCiAB/BYqBwOLdn1FDRtkA0pK
Sv6DvCMgIPI/sPDa/9d//v9fdnrP/5CJ7v+1SwT+h03y+t+/YfP/f//+tUK1o3qhtLQU7IX//+uZ
Hr789yy0O/C/TAPDf92VDP8Lznj/113O8F+6luF/0izXS0BDasEGYAtEoGTjyjNTt0nVMfz3uMMI
1gwCINrjDsN/iSqG/4tO9E8HK8YWiEADDjo3GX1XnAWxGWZA7mn3/7Zb+P7Lz2D479WhfQ9sQG0t
JAyA3oUHItCA41JpEM3YAEhcLovhA9gAbIF4/eb1/7a1+v+FWlFdAGMLtTD8d21TvQU2oKGhAe4F
IIZ5oaRr7fTXAvkM/6UmIlwCoqUmMfzny2H4n7nIrwlsAC4ANKTfp0vnHm8mw39OoEEgzSAaxHds
Vjjt2q3HDVWKE0gGJrn7Na7NXW9eI/JcJJnhm2Wt2CO3Kp0JDKwMBgwMDBIAgcOxdR/eHc8AAAAA
SUVORK5CYIIL'))
	#endregion
	$ExpandAll1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$ExpandAll1.Name = 'ExpandAll1'
	$ExpandAll1.Size = New-Object System.Drawing.Size(330, 38)
	$ExpandAll1.Text = 'Expand All'
	$ExpandAll1.add_Click($ExpandAll1_Click)
	#
	# CollapseAll1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAOwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB3UlEQVQ4T2NwqLi9zar45n9s2LHy9hYGQsC58Ob/7ff+/z/0HBVvv/v/v0P+9f9QZbiB
V871/1P3//8/aR8qBol5ZF4jbEBg5rVtfsnX/mPDARk3CHsBBEJDQ9n4+Pj+g2ioEGmgrKxse0VF
xf/y8vK/VVVVq6HCDA4l17AGsFMFWuDW1dX9hwGgId9BYh6529hdCiAB/AkqBwNrD/5ADRtkA0pK
Sv6DvCMgIPI/pODa/0///v8/sXL//8XOvv/7hcT/L3H3/79h4pb///7964dqR/VCaWkp2Av/6+uZ
nr/992K+S+j/uUDuXTa2/+95ef/fAdJzgPxN3t6XgPZ1gA3AFohAG7pvz5q1bRZQ8TsWlv8fgRph
GMSfCRS/MWnSdLBibIEINOD0DH2z7/uBCg9yc///OHUqHIP4e4Diy4yM7oENqK2FhMEfIIYFItCA
8+0MzP9XAhViAyDxHkbGD2ADsAXik4eP/0/VNAH7fy4j4/+7PT1wDAoDEF6ko3MLbEBDQwPcC0AM
80L99pY5r4Gh9H8aFtwOxNtCQprABuACQENmLDM2vgdU9b8VCYP48zU0TgPlq6BKcQLJXB8f3yVx
cVtmSUs/b2Ng+DZbTu5Ri47ONC4GBn0GBgYJANEup2CwHtGOAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CollapseAll1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CollapseAll1.Name = 'CollapseAll1'
	$CollapseAll1.Size = New-Object System.Drawing.Size(330, 38)
	$CollapseAll1.Text = 'Collapse All'
	$CollapseAll1.add_Click($CollapseAll1_Click)
	#
	# Collapse2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAApwEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABSUlEQVQ4T2Ooqqp6VF1d/Z8UDNLDAAMggX///j36TyQAqQXpgWqHGAACmVMRGBlM3YLA
MDBIDUAG2DSBwJnr/8A02QbAwOmTJ4kzYNZWCP/1/v3/N/v6/p8sIv5/e0jI/4MzZoBiox/FAFy2
bgyN/j+XgeH/XTa2/+95ef/fAdJzgPxN3t6XgNIdeA14sWvX/1lAxe9YWP5/BGqEYRB/JlD8xqRJ
0/EasNbZ+f9+oMKD3Nz/P06dCscg/h6g+DIjo3tYwwAW2j3MLP9XAhViAyDxHkbGD2ADcCXl1TY2
YP/PZWT8f7enB45BYQDCi3R0buHMTGeAUbW7owMYSgz/p2HB7UC8LSSkCRwTuADQZTOWGRvfA6r6
34qEQfz5GhqngfJVUKU4gWSuj4/vkri4LbOkpZ+3MTB8my0n96hFR2caFwODPgMDgwQA5fqgNsaN
05UAAAAASUVORK5CYIIL'))
	#endregion
	$Collapse2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Collapse2.Name = 'Collapse2'
	$Collapse2.Size = New-Object System.Drawing.Size(393, 38)
	$Collapse2.Text = 'Collapse'
	$Collapse2.add_Click($Collapse2_Click)
	#
	# toolstripseparator4
	#
	$toolstripseparator4.Name = 'toolstripseparator4'
	$toolstripseparator4.Size = New-Object System.Drawing.Size(390, 6)
	#
	# ExpandAll2
	#
	$ExpandAll2.BackColor = [System.Drawing.Color]::PapayaWhip 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAATAIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB7klEQVQ4T2NwqLi9zar45n9s2LHy9hYGQsC58Ob/7ff+/z/0HBVvv/v/v0P+9f9QZbiB
V871/1P3//8/aR8qBol5ZF4jbEBg5rVtfsnX/mPDARk3CHsBBEJDQ9n4+Pj+g2ioEGmgrKxse0VF
xf/y8vK/VVVVq6HCDA4l17AGsFMFWuDW1dX9hwGgId9BYh6529hdCiAB/BYqBwOLdn1FDRtkA0pK
Sv6DvCMgIPI/sPDa/9d//v9fdnrP/5CJ7v+1SwT+h03y+t+/YfP/f//+tUK1o3qhtLQU7IX//+uZ
Hr789yy0O/C/TAPDf92VDP8Lznj/113O8F+6luF/0izXS0BDasEGYAtEoGTjyjNTt0nVMfz3uMMI
1gwCINrjDsN/iSqG/4tO9E8HK8YWiEADDjo3GX1XnAWxGWZA7mn3/7Zb+P7Lz2D479WhfQ9sQG0t
JAyA3oUHItCA41JpEM3YAEhcLovhA9gAbIF4/eb1/7a1+v+FWlFdAGMLtTD8d21TvQU2oKGhAe4F
IIZ5oaRr7fTXAvkM/6UmIlwCoqUmMfzny2H4n7nIrwlsAC4ANKTfp0vnHm8mw39OoEEgzSAaxHds
Vjjt2q3HDVWKE0gGJrn7Na7NXW9eI/JcJJnhm2Wt2CO3Kp0JDKwMBgwMDBIAgcOxdR/eHc8AAAAA
SUVORK5CYIIL'))
	#endregion
	$ExpandAll2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$ExpandAll2.Name = 'ExpandAll2'
	$ExpandAll2.Size = New-Object System.Drawing.Size(393, 38)
	$ExpandAll2.Text = 'Expand All'
	$ExpandAll2.add_Click($ExpandAll2_Click)
	#
	# CollapseAll2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAOwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB3UlEQVQ4T2NwqLi9zar45n9s2LHy9hYGQsC58Ob/7ff+/z/0HBVvv/v/v0P+9f9QZbiB
V871/1P3//8/aR8qBol5ZF4jbEBg5rVtfsnX/mPDARk3CHsBBEJDQ9n4+Pj+g2ioEGmgrKxse0VF
xf/y8vK/VVVVq6HCDA4l17AGsFMFWuDW1dX9hwGgId9BYh6529hdCiAB/AkqBwNrD/5ADRtkA0pK
Sv6DvCMgIPI/pODa/0///v8/sXL//8XOvv/7hcT/L3H3/79h4pb///7964dqR/VCaWkp2Av/6+uZ
nr/992K+S+j/uUDuXTa2/+95ef/fAdJzgPxN3t6XgPZ1gA3AFohAG7pvz5q1bRZQ8TsWlv8fgRph
GMSfCRS/MWnSdLBibIEINOD0DH2z7/uBCg9yc///OHUqHIP4e4Diy4yM7oENqK2FhMEfIIYFItCA
8+0MzP9XAhViAyDxHkbGD2ADsAXik4eP/0/VNAH7fy4j4/+7PT1wDAoDEF6ko3MLbEBDQwPcC0AM
80L99pY5r4Gh9H8aFtwOxNtCQprABuACQENmLDM2vgdU9b8VCYP48zU0TgPlq6BKcQLJXB8f3yVx
cVtmSUs/b2Ng+DZbTu5Ri47ONC4GBn0GBgYJANEup2CwHtGOAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CollapseAll2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CollapseAll2.Name = 'CollapseAll2'
	$CollapseAll2.Size = New-Object System.Drawing.Size(393, 38)
	$CollapseAll2.Text = 'Collapse All'
	$CollapseAll2.add_Click($CollapseAll2_Click)
	#
	# SaveNodestoTxt
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAkwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAACNUlEQVQ4T6WSX2iSURjGjzD8wJFs4aCLQKYY1RYNHIlDJelCSTAaJot1IQYNQ8FwiTAG
GgmDomIjWV2JnyzwIpC6kIouomBDIjFGTHZh7KYCdzVxEvj0nqObuYIFPfDwnfP++Z3zHj4m9Z9+
yfoMYEyN7cL6oWaMQdmvxYDGUKA1iZrvPVikRN9fGw6aA6Kxeag1/NAOQFKpaKPAv4gDguFoL2A+
nhQJLvvHUXjOMqSSM5iLRURMVWI4utHO8zoOGBzSdwG3orF9ANfKUgQvUn7cuWHE9LlunIvXHQDo
EaIAT+zpTeE57gbGkZo9hdo7M7xjlGs1RI7XBYLh3wBKPa5O+3sAXEE7Q/3TCLDrRqtkxZSRodXc
FnWeK9egHtJ1AW63lzYKkdxzvd5AwELQbz6CTAKfbfCcYSiursLhvESPONwF2C+4YJpw/GGum1YO
8QONy6h9sGGSHrharRJA2wWYzHboDEYKSGR1j8vlL+Imu5vXeyDrZfFPkCQdxk02aI6dgMvlFaeu
FYvYqFTEOhKJ0Dh1zNBNOCQnLyCZXICvPSpNTgDreYcAXOwA8vk8Xr1+K9aJRALxeBzNZlNAnq3k
IKeWsWaxdCDS8I7Z4oRWNyYAO01g+clTyNkcWgSQZRmZTAbpdFoAZ6mpEphCzedEqH2Lgbkjgydb
I6MTAsCbKptfUd36IRqy2ey+OaTR+In3oTDi1Hz/4ZIYQyLfVkjH6/TlgUOsRIke8NHi4++0/18x
9gu56xvVOQsp2AAAAABJRU5ErkJgggs='))
	#endregion
	$SaveNodestoTxt.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$SaveNodestoTxt.Name = 'SaveNodestoTxt'
	$SaveNodestoTxt.Size = New-Object System.Drawing.Size(393, 38)
	$SaveNodestoTxt.Text = 'Save Nodes to TXT'
	$SaveNodestoTxt.add_Click($SaveNodestoTxt_Click)
	#
	# toolstripseparator3
	#
	$toolstripseparator3.Name = 'toolstripseparator3'
	$toolstripseparator3.Size = New-Object System.Drawing.Size(390, 6)
	#
	# savefiledialog1
	#
	#
	# OpenFileWith
	#
	$OpenFileWith.BackColor = [System.Drawing.Color]::Gainsboro 
	$OpenFileWith.ForeColor = [System.Drawing.Color]::Red 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAArAIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAACTklEQVQ4T5WSTUhUcRTFj2mWjcJEE4pSIVpNfqMuNLQWFVRDhc080QozB5NkwDYR9DW6
CBRjoEUilBgKgYsiWokFbty4iCIhsSYZstQiF8aIhoOn8+ZNRB9iHfjx/tx77v/e9+7Dahq8ir29
Bt731uDtw0sojoX/TcN+JPTUYGxx4jrDL0+w24NX/v3YGEuvrQEfvE/bQLJP1HHoBlicjGbDQHzM
srqe+LGpy4Mpzjao+IFoJ6cq2XEY08mAQ5Y4y7mKes+hdeR2fLS7nLQlmZO0cSQAltnRXgKsj1n/
1P0mZASOI8ywuke6qFAU8ib5OZe3jmEhBdip2N+nCHjQ86LPoYLWaJE5QXqqecEVUc7n90DXNvTn
AImxkp+660VB50ksc6VZ5kbRxKMHHGyozdS5XlSS8/nsrMKy7GV+YJ1VGdO1gxgKPs6S8TK5VKSn
i4G2Uvbf2UeuHCIX94giBgfiWePEsEo2WJVSpxtHAtUaNXyGnKsgQ4nkbBbHBl0MjVTpvMOKfUjT
086AAWojbgNaq36QhJYyjM0NOnXBWXLSRgbjVKSOEZ/FzC4r9k6XhBycewSeysHrLUAKWl1o7G5Q
9/k67TuPHNd5XOZ5LzfbwK12czKvFTNzQTv5xsauOq0Y8KG+EMHIkLpOl6tDhkgV6Xrfiyx0JrE0
X7mlFsU0/o/c5HYuPkujOxsTOJ2HmW+jJeRXz68sndeH7BD6E83zb/mF0XIaTnxERQaMaic+1eaC
/4MnG1/0/S+YS0gQdpEp8kShKFqDArEbQNp36wSQdSmzmr4AAAAASUVORK5CYIIL'))
	#endregion
	$OpenFileWith.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$OpenFileWith.Name = 'OpenFileWith'
	$OpenFileWith.Size = New-Object System.Drawing.Size(330, 38)
	$OpenFileWith.Text = 'Open File with'
	$OpenFileWith.ToolTipText = 'Open the selected file with another tool '
	$OpenFileWith.Visible = $False
	$OpenFileWith.add_Click($OpenFileWith_Click)
	#
	# CopyFullFilePath
	#
	$CopyFullFilePath.Name = 'CopyFullFilePath'
	$CopyFullFilePath.Size = New-Object System.Drawing.Size(330, 38)
	$CopyFullFilePath.Text = 'Copy Full File Path'
	$CopyFullFilePath.Visible = $False
	$CopyFullFilePath.add_Click($CopyFullFilePath_Click)
	#
	# CopyNode2Tag
	#
	$CopyNode2Tag.BackColor = [System.Drawing.Color]::PapayaWhip 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAUwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAB9UlEQVQ4T5WTy2sTURTGb3wgRf+E/C8hkCwD2WTjIuDCuAqRvAl5k+cmkIBjEie1OOME
KajFiiUJFUsRoQvXSlssLS6KKBQkSu0cv3NjQtImUD/4uDPcud/5nZkzol6v3y+Xy08qlYrGLpVK
0oVCQYvFYivJZPK2x+O5KoSwwBeFwyumaWrzrCiKhgKa1+u94/P5ruPxiyFzAnT4KWzUajWDrznE
7Xbf9fv9NzKZzJV/R0caB3w7MbX13iddefj4EK2YMLGxT8VikdASRaPR00AgUJuhwcY0gVGtVs9o
gZrNJoGGHA5H02q1LsmQccDJ0NRevvpooOrCgE6nI1cOcTqdywi4eZ6gC2QZ8OMn0eb2AW29P6Tt
D0fyoKqOAliNRoPsdrsq8vm8DBj+MrXVFztd9LuQQNd1arXb1Gq16YGiUDAYPBO5XG6GYBwwPCVU
P5LVeZ2ncDhMAp9lQvDs+U4XRAsJzisej5NIpVIzBOOA33/wDrYOpAfvvlBvc582Bnv0ur9Lx9/l
+VEARnU6wEBL/0eQSCSWpwL0bDY7IeDK/bf7svqb/h6t93ZpbeMzfT3GJoR/hUQ6nb6HpEe4USOR
iAqiSxNgMomH0WKz2a5h5cm6BSK8/8tJfoUp8WxbQLIGIpP7Y0SuwuaH2aFQaGKXyzX4CxZw19hB
z+7oAAAAAElFTkSuQmCCCw=='))
	#endregion
	$CopyNode2Tag.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$CopyNode2Tag.Name = 'CopyNode2Tag'
	$CopyNode2Tag.Size = New-Object System.Drawing.Size(393, 38)
	$CopyNode2Tag.Text = 'Copy Selected Node''s Tag Data (Hex)'
	$CopyNode2Tag.Visible = $False
	$CopyNode2Tag.add_Click($CopyNode2Tag_Click)
	#
	# SaveStreamToFile
	#
	$SaveStreamToFile.BackColor = [System.Drawing.Color]::Lavender 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAGgIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABvElEQVQ4T5XSQUjCYBQH8E8KB0pDwyBIkBQjqkNQIEmK0UFJsEsJUYeogwSGhSRhKPPQ
KejQqXYS56mb0EEKuodeI5IORbeiojBqF1/v+9wmxIj14M/etvf9tvGNcNaRM9LtBUJ4eK1eGwoh
BMxWF9gc3iqhiw8Oj/Bit+6wXiiQ2c0B76APRoCzWLAxgdGiQHIr0wFywj67SOv9own1el03siyz
GRWw93nawHZmVwOM1C/AA5t4ogJf39+6T6d5eXtnM3R2I7mlAGYPrCeSGvBXtZQjnV1dSwDf524D
S8trhgC16OzC4koHiMXi2JjYDaMJR+ZxFwaxR2BmNgo+f/hfCYYiCLjagG9qBtzeCTzhMLxOfr+B
HYE56Ol1Ys+5YdIXBEf/EESjcfaNV7Ua3DYarKeVTqe1pFIphgSCkTZgQiAQCjNgTgEqlQqcX1yy
nlahUABBECCfz0M2m+0ADvYGg82p6Qi43OMMaOLPdnwiglQ+hWfcdrp1kiRBqVSCYrEIoihqAM8A
YtvrsQ+3Rsf8DKALGncPcP/4BLKy8eVyWQtFKBCajakA4TA7Js75SW8YixmsvQNAuiw3PwhUWzMK
5g6uAAAAAElFTkSuQmCCCw=='))
	#endregion
	$SaveStreamToFile.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$SaveStreamToFile.Name = 'SaveStreamToFile'
	$SaveStreamToFile.Size = New-Object System.Drawing.Size(393, 38)
	$SaveStreamToFile.Text = 'Save Stream to File'
	$SaveStreamToFile.Visible = $False
	$SaveStreamToFile.add_Click($SaveStreamToFile_Click)
	#
	# toolstripRefresh
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAHgIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAABwElEQVQ4T41TOyxDYRT+b3pRBmHAIulgM0kkYrMJXUxX0FJsXlPFJmWQSDwWMYjRhLBK
LMLkum26WEhDIo0O1KtSbT2O89170ki09EtO7v3P+f5zzz3nO6oQtAErrvnCL66hyIfmt7Iuv5Vq
mr1tlXBpKBuLjeiD4c/xXaKpfaKKQJSqJ682O0KkC+V/NARj9ZrPygxvvdPyCVHVaJRqJy4XJFwa
PKFrNyfJzR+SnUQfsr7aV24qJVwcTh+spOY7y+Dd2HilJU5QGYgQ+7Livxd6YTAp1bP2SIvH9Mu6
Vu+IEzwL1YEncOTW+k+f5KhU6EjXBsw3Yz1JcweUN+9ygqsw08rYcQlTqWbjvFzrM9/aZi6Ik7yL
m5NGa/ic6V17oOk9vrwY57iZ7uDkQlEKBzgRBAlkXMJloSgktZPzR/AxcTO4DJSDsn6WibJRPn5D
mEjyhN+UowM0Ag0p1Cg0EI0UamFgFPZIeDQYEUaFkWF0jp9Hye9CLw6IAyKBWCAaiAciknBpgEwh
VySBfCFjyFnC/wOLgoXB4mCBsEhYKCyWUP5EHVujbS3BbuXde2XLKe/+Bz9TqnM7kY87xnylvgFe
cjMncFhmHQAAAABJRU5ErkJgggs='))
	#endregion
	$toolstripRefresh.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$toolstripRefresh.Name = 'toolstripRefresh'
	$toolstripRefresh.Size = New-Object System.Drawing.Size(98, 33)
	$toolstripRefresh.Text = 'Refresh'
	$toolstripRefresh.ToolTipText = 'Refresh selected folder'
	$toolstripRefresh.Visible = $False
	$toolstripRefresh.add_Click($toolstripRefresh_Click)
	#
	# GetMRUlist
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetMRUlist.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetMRUlist.Name = 'GetMRUlist'
	$GetMRUlist.Size = New-Object System.Drawing.Size(252, 30)
	$GetMRUlist.Text = 'Get MRU lists'
	$GetMRUlist.ToolTipText = 'Read Curent User''s MRU from HKCU'
	$GetMRUlist.add_Click($GetMRUlist_Click)
	#
	# toolstripseparator2
	#
	$toolstripseparator2.Name = 'toolstripseparator2'
	$toolstripseparator2.Size = New-Object System.Drawing.Size(249, 6)
	#
	# imagelist1
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFdTeXN0ZW0uV2luZG93cy5Gb3JtcywgVmVyc2lvbj00LjAu
MC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWI3N2E1YzU2MTkzNGUwODkFAQAA
ACZTeXN0ZW0uV2luZG93cy5Gb3Jtcy5JbWFnZUxpc3RTdHJlYW1lcgEAAAAERGF0YQcCAgAAAAkD
AAAADwMAAADWoQAAAk1TRnQBSQFMAgEBFAEAAcgBAAHIAQABGAEAARgBAAT/ASEBAAj/AUIBTQE2
BwABNgMAASgDAAFgAwABkAMAAQEBAAEgBgAB2P8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/
AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AHIAAwYBCAMbASYBVwFZ
AVcBuQEhAV4BIQH7A1EB9wNPAZkDDwEUAwUBBhgAAwYBBwMPARQDKgFAAzwBZQNHAYIDTQGRA04B
mANOAZgDSwGKA0IBdAM2AVcDHgErAwsBDigAAwsBDgMRARYDGAEgAx4EKwFBAzgBXAM/AW0DQgF1
A0IBdAM9AWkDOAFbA0ABbwJVAVMBqgJiAV4B1wJqAWEB5gJgAV0BzgNLAY0DKAE7AwcBCQgAAwQB
BQcCAQMDAgEDAwIBAwMCAQMEAgMEAQUEAQMCAQMDAgEDAwIBAwMCAQMDAgEDBAEDBAEFBwIBAwMC
AQMDAgEDAwIBAwQCAwQBBQwAAwIBAwMHAQkDCAEKAwgBCgMIAQoDCAEKAwgBCgMIAQoDCAEKAwgB
CgMIAQoDCAEKA0cBgQEAAWABCQH/AQABeAEQAf8BAAF3ARAB/wEAAXgBEAH/AQABeAEQAf8BAAFf
AQkB/wMQARUQAAQBAxYBHQMqAT8DPQFnA04BlANaAboDXgHXA2EB5gNkAe0DZAHtA14B3wNdAckD
VQGsA0YBfwM0AVQDHwEsAwwBEAQBHAAEAgMJAQsDJAE1A00BkgFdAlsBygFlAV8BXgHiAmcBWQHv
Am8BYAHzAmsBXgHyAmMBWgHpAmMBXQHfAmoBXgHtAXgBfQFNAfoBgAGuAUAB/QFhAakBQAH9AXUB
fgErAfwBYwFtAUgB9gJfAVsB0AM5AV8DBwEJBAADNgFZAasBdAEHAf8BqwF0AQcB/wGrAXQBBwH/
AasBdAEHAf8BqwF0AQcB/wM7AWMEAgGuAXcBCgH/AasBdAEHAf8BqwF0AQcB/wGrAXQBBwH/AasB
dAEHAf8BrgF4AQ0B/wMKAQ0DNgFZAasBdAEHAf8BqwF0AQcB/wGrAXQBBwH/AasBdAEHAf8BqwF0
AQcB/wM7AWMEAgMGAQcDDwQUARsBcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8B
bAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/Aa0BrgGq
Af8BAAFmAQsB/wEAAYkBFwH/AQABcwEJBf8BAAF7AQ4B/wEAAYkBFwH/AQABiQEXAf8BAAFjAQoB
/wwABAEDAgEDAzYBVwNUAakDaAH5A0AB/QNcAf8DYAH/A3AB/wN4Af8DeAH/A2gB/wNeAf8DWgH/
A14B+wNeAdIDSQGFAyEBLwMCAQMYAAQCAw0BEQNEAXkBfgIrAfwB3gGVAXUC/wHDAZsC/wHBAZYC
/wHFAZwC/wHJAaAC/wHIAZ8B/wHVAboBeAH/AYYBrAE5Af8BdgGoAS0B/wGfAcIBbAH/Ac8B4QG2
Af8BgAGWAYAB/gKAAUkB/gKAAUQB/gF1AX4BKwH8AmABXQHOAycBOgQAAbABdwEJAf8B4AGkASMB
/wHgAaQBIwH/AeABpAEjAf8B4AGkASMB/wHgAaQBIwH/AbwBhwEbAf8DAgEDAeABpAEjAf8B4AGk
ASMB/wHgAaQBIwH/AeABpAEjAf8B4AGkASMB/wHcAaIBJQH/AwsBDgGwAXcBCQH/AeABpAEjAf8B
4AGkASMB/wHgAaQBIwH/AeABpAEjAf8B4AGkASMB/wG8AYcBGwH/AwIBAwgAAwkBCyz/AaQB0AG0
Af8BAAGaAR4B/wEAAYQBEA3/AQABjAEVAf8BAAGaAR4B/wEAAZoBHgH/AUABQQFAAXEEAAQBAx0B
KANCAXQDVwG1A2AB4gNKAf0DgAH+A64B/wPHAf8DzgH/A9IB/wPSAf8DywH/A7sB/wOjAf8DgAH+
A14B8ANcAdYDTwGXAzMBUAMCAQMEAQwABAIDGQEiAVICUQGkAYgBagFoAfkB/wHBAZkC/wHMAaMB
/wH8AcwBpgH/AewBwgGhAf8B4AG4AZoB/wHbAbIBlQH/AdwBtAGWAf8BoAG2AVsB/wF9AawBNwH/
AZ8BwwFtAf8B4AHrAc8B/wH2AfkB8gH/AeUB7QHYAf8BgAGZAYAB/gKAAVIB/gKAAUQB/gJvAV4B
8wJLAUoBigQAAboBgQENAv8BxgE+Av8BxgE+Av8BxgE+Av8BxgE+Av8BxgE+Af8BwgGMASIB/wMC
AQMB/wHGAT4C/wHGAT4C/wHGAT4C/wHGAT4C/wHGAT4B/wH8AcEBOgH/AwsBDgG6AYEBDQL/AcYB
PgL/AcYBPgL/AcYBPgL/AcYBPgL/AcYBPgH/AcIBjAEiAf8DAgEDCAADCQELLP8BAAFiARwB/wEA
AaYBIgn/ASIBpwFHBf8B+wP/AQABoAEfAf8BAAGtASYB/wNfAeUEAAMXAR8DOwFiA1wByANjAe0D
eQH/A5wB/wPFAf8D5QH/A/wB/wP+Cf8D/QH/A/EB/wPaAf8DsgH/A4wB/wNoAf8DYQHcA04BmAMi
ATEDDAEQCAAEAQMYASEBXAJZAcEBvgGVAVwB/QH8AcEBmAL/AcwBpAH/AeABoQGBAf8BvwF/AWgB
/wHKAZkBjQH/AdEBrgGlAf8B0gG0Aa0B/wHRAbIBqwH/AYABpgE5Af8BnwHCAWwB/wHiAe0B0wH/
Ae0B8wHjAf8B2gHnAccB/wHtAfMB5AH/AeMB7AHUAf8BgAGZAYAB/gFhAaoBQAH9AXQBfQFNAfoC
XQFaAccEAAG+AYcBFQL/AdkBUgL/AdkBUgL/AdkBUgL/AdkBUgL/AdkBUgH/AcYBkgElAf8DAgED
Af8B2QFSAv8B2QFSAv8B2QFSAv8B2QFSAv8B2QFSAv8B1wFPAf8DCwEOAb4BhwEVAv8B2QFSAv8B
2QFSAv8B2QFSAv8B2QFSAv8B2QFSAf8BxgGSASUB/wMCAQMIAAMJAQsI/wMABf8DAAH/AwAB/wMA
Af8DAAH/AwAB/wMAAf8DHgH/AQABVQEQAf8BAAG+ATIB/wEXAaoBQAH/AQABnQElAf8BAAG+ATIB
/wEvAbQBVAX/Ae8B/wH4Af8BAAGzASsB/wNeAfAEAAM2AVkDVgGuA1oB/wN1Af8DqAH/A/UB/wP8
If8D+QH/A9AB/wOEAf8DaAH/A1sB2ANLAYsDIAEuCAADCQELAVICUQGkAecBnwF9Av8BwwGaAv8B
wQGYAf8BuwFqAU8B/wG3AYIBdQH/Ae4B5wHlAf8D8QH/A+sB/wPTAf8D6wH/AXsBqwE1Af8BqwHK
AX8B/wHsAfIB4QH/AboB0gGVAf8BkAG5AVYB/wG3AdEBjwH/AewB8wHiAf8B5gHvAdkB/wGoAb4B
YwH9AV8BiQE0AfsCYwFdAd8EAAG+AYsBGwL/AeoBZgL/AeoBZgL/AeoBZQL/AeoBZgL/AeoBZgH/
AcYBlQEoAf8DAgEDAf8B6gFmAv8B6gFlAv8B6gFmAv8B6gFmAv8B6gFlAv8B6gFjAf8DCwEOAb4B
iwEbAv8B6gFmAv8B6gFmAv8B6gFlAv8B6gFmAv8B6gFmAf8BxgGVASgB/wMCAQMIAAMGAQcs/wGq
AdMBuAH/AQABzwE+Af8BAAHPAT4B/wEAAc8BPgH/AQABzwE+Af8BAAHNAT0B/wFBAcQBZgX/AQAB
tAEtAf8DTQGRAxIBGANOAZUDXgHiA2UB/wOrAf8D3QH/A/wB/wP+If8D/QH/A+0B/wPPAf8DigH/
A2UB8QNcAdYDNgFZAw4BEgQAAzQBUwFmAWUBXQHsAf8BwgGYAf8B9wGpAX4B/wHDAXgBXAH/Ac8B
rQGkAf8B8ALuAf8D6QH/A+MB/wPMAf8DegH/A8AB/wF/AawBPgH/AYEBrwE/Af8BoAHDAW4B/wGD
AbEBQwH/AXYBqQEuAf8BgQGvAT4B/wG2AdABjwH/AegB8AHcAf8B5QHuAdgB/wGGAY8BXwH7Al8B
XAHIBAABvwGRAR4C/wH3AXQC/wH3AXQC/wH1AXQC/wH3AXQC/wH3AXQB/wHGAZkBLAH/BAIB/wH3
AXQC/wH1AXQC/wH3AXQC/wH3AXQC/wH1AXQC/wH0AW8B/wMKAQ0BvwGRAR4C/wH3AXQC/wH3AXQC
/wH1AXQC/wH3AXQC/wH3AXQB/wHGAZkBLAH/BAIIAAMGAQcw/wEAAYABGwH/AQEB3gFLAf8BAQHe
AUsB/wEBAd4BSwH/AQEB3gFLAf8BAQHeAUsB/wEAAckBPQH/AQABewEaAf8DBwEJAy4BRgNaAb8D
SgH9A4YB/wPSAf8D+i3/A/0B/wP4Af8DrgH/A4AB/gNaAfwDSQGGAyMBMgQCAVcCVgG1Ae0BqgGE
Av8BrwGCAf8B0gF+AVsB/wHSAa4BogH/A/AB/wPmAf8D4AH/A90B/wPZAf8DxgH/A88B/wGGAagB
VgH/AXQBpQEsAf8BdwGpATAB/wF1AagBLgH/AXUBqAEtAf8BdQGoASwB/wGEAbEBQgH/AbMBzwGK
Af8B2QHnAcYB/wJuAWoB9QNMAZAEAAM4AVsBuAGMARwB/wG4AYwBHAH/AbgBjAEcAf8BuAGMARwB
/wG4AYwBHAH/AzYBWQMEAQUBvgGPAR8B/wG4AYwBHAH/AbgBjAEcAf8BuAGMARwB/wG4AYwBHAH/
Ab8BkQEcAf8EAQM4AVsBuAGMARwB/wG4AYwBHAH/AbgBjAEcAf8BuAGMARwB/wG4AYwBHAH/AzYB
WQMEAQUIAAMGAQcI/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wFwAXYBcwH/
AQABggEeAf8BCwHtAVYB/wELAe0BVgH/AQsB7QFWAf8BCwHtAVYB/wEAAYABHAH/Az8BbQQAA0sB
igNbAdgDewH/A7wB/wPpOf8D1QH/A54B/wNaAf8DVwG1AzoBYAMWAR4BvgFcAUAB/QH/AboBjgL/
AaQBdgH/AboBfQFoAf8B8AHrAeoB/wPqAf8D4wH/A+AB/wPgAf8D4AH/A94B/wO4Af8BUgFiATwB
/wFuAZsBLgH/AXYBqAEtAf8BdQGoAS0B/wF1AagBLQH/AXUBpwEsAf8BdQGoASwB/wF8AasBNQH/
AYkBtAFKAf8DYgHhAy4BSAQABAEDCgENAwsBDgMLAQ4DCwEOAwsBDgMKAQ0EAQMFAQYDCwEOAwsB
DgMLAQ4DCwEOAwsBDgMFAQYoAAMGAQc4/wGqAdUBuAH/AQABXwEbAf8BWgFeAVoB8gNZAbsDNgFY
CAADWAG4A1wB5wOIAf8D4QH/A/UO/wL+Af8B/gL9Af8B9AHsAeQB/wHvAeQB2QH/AfAB5gHbAf8B
8gHpAd8B/wH0AewB5AH/AfYB8AHqAf8B+gH2AfIB/wH9AfsB+QX/A+0B/wO2Af8DWwH/A1sB0wNG
AX4DRQF8Ad4BlwFxAv8BuQGLAf8B0QF8AVYB/wHYAbgBrQH/A/UB/wPrAf8D6AH/A+YB/wPmAf8D
5AH/A8wB/wNjAf8BNAE3AS8B/wGXAa8BdAH/AYMBsAFDAf8BeAGqATIB/wF2AagBLgH/AXUBqAEt
Af8BdgGoAS0B/wF6AagBLwH/AYwBrAE+Af8CYQFdAdQDJAE1BAABqwF0AQkB/wHQAZgBHgH/AdAB
mAEeAf8B0AGYAR4B/wHQAZgBHgH/AdABmAEeAf8BvAGFARsB/wMCAQMB0AGYAR4B/wHQAZgBHgH/
AdABmAEeAf8B0AGYAR4B/wHQAZgBHgH/Ac8BlQEcAf8DCwEOKAADBgEHPP8DfQH6AyMBMhAAA18B
2gNgAfMDkwH/A/gB/wP9Df8B/QH7AfoB/wH4AfMB7wH/AeABxwGxAf8B1AGzAZIB/wHVAbQBlQH/
AdYBuAGaAf8B2QG9AaEB/wHdAcQBqgH/AeMBzQG4Af8B6QHYAcgB/wHwAeUB2QH/AfUB8QHtAf8C
xgHFAf8DYgH/A10B6gNOAZUBWgJXAcIB9AGtAYQC/wG8AY4B/wGsAVcBNgH/AfcB7gHrAf8D9wH/
A/AB/wPuAf8D6QH/A90B/wPPAf8DjwH/AxAB/wN6Af8B4gHlAd0B/wHHAdcBrwH/AZwBvwFrAf8B
gQGuAT8B/wF3AakBMAH/AYABpQE2Af8BpAGpAUwB/wHaAbkBdwH/AmUBXgHiAy0BRAQAAbMBegEN
Af8B7QG0ATAB/wHtAbQBMAH/Ae0BswEwAf8B7QG0ATAB/wHtAbQBMAH/Ab8BiAEcAf8DAgEDAe0B
tAEwAf8B7QGzATAB/wHtAbQBMAH/Ae0BtAEwAf8B7QGzATAB/wHtAbABMAH/AwsBDigAAwMBBAj/
AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMABf8DagH5AwcBCRAAA2UB
8QNNAfoDnRX/AfoB9QHxAf8B7wHhAdUB/wHCAZIBZAH/AawBawEsAf8BrAFrASwB/wGsAWwBLQH/
Aa4BcAE0Af8BswF5AT8B/wG6AYUBUAH/AcQBlwFrAf8B0gGwAY4B/wHuAeEB1AH/Ac0BzAHKAf8D
bwH/A2gB+QNSAaQBZQJdAewB/wG9AZEC/wG7AY4B/wGpAVgBOgH/A/wB/wPVAf8D8QH/A9sB/wPJ
Af8DxgH/A7UB/wM2Af8DEAH/A8kB/wPzAf8D9wH/A/MB/wPSBf8B4gHBAbQB/wHiAZ0BcwL/Ab8B
kQH/AWYCYgHuAzMBUQQAAbwBhQESAv8B0AFKAv8B0AFKAv8B0AFIAv8B0AFKAv8B0AFKAf8BxgGP
ASIB/wMCAQMB/wHQAUoC/wHQAUgC/wHQAUoC/wHQAUoC/wHQAUgC/wHPAUgB/wMLAQ4oAAMDAQQ8
/wNqAfkDBwEJEAADWwHyA18B+wOdFf8B+gH2AfMB/wHwAeUB2gH/AcMBlAFmAf8BvAGHAVQB/wHb
Ab4BowH/AeAByAGxAf8B5AHPAboB/wHmAdIBvwH/AegB1gHFAf8B6wHcAc4B/wHwAeUB2QH/AfkB
9QHxAf8BzwLOAf8DcAH/A00B+gNTAaUBbwFgAV0B8wH/AcMBlgH/Af4BvQGRAf8BsQFjAUQB/wPu
Af8DmgH/A8AB/wO+Af8DjAH/A0sB/wMcAf8DJwH/AkQBfwH/ArIB4AH/AtsB4QH/A+0B/wPjAf8D
lAH/A+QB/wHiAcUBugH/AeIBoAF3Av8BxgGXAf8CaAFmAfADMwFSBAABvgGIARcC/wHjAVwC/wHj
AVwC/wHjAVwC/wHjAVwC/wHjAVwB/wHGAZMBJgH/AwIBAwH/AeMBXAL/AeMBXAL/AeMBXAL/AeMB
XAL/AeMBXAL/AeMBWwH/AwsBDigAAwMBBDz/A2oB+QMHAQkQAANaAekDXAH4A5kB/wP8Af8D/g3/
AfsB+AH1Af8B8wHrAeIB/wHEAZYBaQH/AcQBlwFqAf8B9QHuAeYB/wH7AfgB9gL/Av4R/wP+Af8D
zAH/A2oB/wNkAfQDUQGfAWUCXgHdAf4BwAGTAv8BxgGaAf8BrgFZATUB/wP+Af8D7gH/A6IB/wN4
Af8DdQH/A5YB/wO1Af8DygH/AsMB6QH/AnoB5gH/AnkB5gH/AuIB8gH/A+kB/wPmBf8B5gHCAbIB
/wHnAaYBfgL/AcsBnQH/A2MB6QMvAUkEAAG+AY8BHAL/AfIBbAL/AfIBbAL/AfIBbAL/AfIBbAL/
AfIBbAH/AcgBmQEpAf8DAgEDAf8B8gFsAv8B8gFsAv8B8gFsAv8B8gFsAv8B8gFsAv8B7wFqAf8D
CwEOCAADBwEJHAADAwEECP8DAAX/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/
AwAF/wNqAfkDBwEJEAADXwHVA2UB8QOQAf8D9wH/A/wN/wH8AfsB+QH/AfcB8wHtAf8BxQGYAWwB
/wHHAZsBbwH/AfwB+gH2Af8B/gH9AfwV/wP8Af8DxgH/A10B/wNhAeYDTQGRAlUBUwGqAfIBsQGF
Av8BygGgAf8BwgFwAUcB/wH7AesB5CX/ArsB/QH/AiMB7QH/AroC/wP+Bf8B4QGtAZQB/wHwAbEB
iAL/Ac0BogH/AmMBXwHaAyUBNgQAAcEBkQEeAv8B+wF3Av8B+wF3Av8B+wF3Av8B+wF3Av8B+wF3
Af8ByQGcAS8B/wQBAf8B+AF3Av8B+wF3Av8B+wF3Av8B+wF3Av8B+wF3Av8B9wFwAf8DBQEGBAAD
CAEKAaoBbwEAAf8BfgFtASsB/AQBFAADAgEDPP8DagH5AwcBCRAAA1UBqgNgAeMDgwH/A9UB/wPx
Df8B/gL9Af8B/AH6AfgB/wHJAaABdwH/AcoBoQF4Af8B/gH9AfwC/wL+Ff8D5QH/A64B/wNbAf8D
WwHKA0MBdQM1AVYB3QGXAWwC/wHNAaIB/wHrAaMBegH/Ad0BsQGdKf8C/QL/ApMC/wKuA/8B+AH1
Af8B0wGLAWcB/wH7AcQBmgL/AcoBnQH/AlkBVwG8AxIBFwQAAwQBBQcCAQMDAgEDAwIBAwMCAQME
AgMEAQUEAQMCAQMDAgEDAwIBAwMCAQMDAgEDBAEDCAEKAbABdAEGAf8B6AGuASwB/wHQAZYBHwH/
AmUBYAHjBAEUADz/A2oB+QMHAQkQAANCAXMDWwHQA3QB/wOpAf8D4QH/A/0N/wP+Af8B0AGsAYgB
/wHQAawBiBX/A/4B/wP9Af8DxwH/A5AB/wNaAf8DUwGlAzMBUAMKAQ0CYwFbAeQB/AHIAZ4C/wHF
AZwB/wHXAZQBcAH/AfUB6AHhKf8C/AL/AusC/wHYAaABhAH/AegBogF4Av8BzwGkAf8B6wGlAXkB
/wNHAYIDAwEEBAADNgFZAasBdAEHAf8BqwF0AQcB/wGrAXQBBwH/AasBdAEHAf8BqwF0AQcB/wM7
AWMEAhgAAwoBDQGxAXgBCgL/AdkBTgH/Af4BxgE8Af8B5gGtASkB/wHPAZYBHAH/AmUBYAHjBAEQ
ADz/A2oB+QMHAQkQAAMhATADWQG5A4AB/gNzAf8DzAH/A/oR/wHaAbwBoAH/AdoBvAGgFf8D/QH/
A/oB/wOhAf8DbAH/A3kB/gNEAXcDGgEjBAACSwFKAYoB7AGwAYUC/wHSAakB/wHsAakBfwH/Ad4B
pAGGFf8D7BX/AegBwgGwAf8B0gGAAVIC/wHKAaEC/wHMAaMB/wGNAV8BNgH7AxkBIgQBBAABsAF3
AQkB/wHgAaQBIwH/AeABpAEjAf8B4AGkASMB/wHgAaQBIwH/AeABpAEjAf8BvAGHARsB/wMCAQMU
AAQBAbUBfgERAv8B6gFnAv8B4QFcAv8B1gFKAv8BxgE+Af8B6gGrAS0B/wHVAZYBHAH/AmQBYAHb
EAA8/wNqAfkDBwEJEAADDAEQA0gBgwNeAdMDYgH/A5gB/wPLAf8D/QH/A/4J/wHsAd0BzgH/AewB
3QHOEf8D/gH/A+UB/wO2Af8DfwH/A18B6gNaAcADMQFMAwkBDAQAAyABLgJhAVwB1gH/AdABpwL/
AcwBpAH/AeMBmQFuAf8B3QGjAYQB/wH0AeYB3gL/Av4F/wPxAf8DqgH/A/EK/wH5AfcB/wHmAcIB
rQH/AdoBkgFpAv8BxgGdAf8B/gHRAagB/wGEAXwBXAH4AUECQAFwBAIIAAG6AYEBDQL/AcYBPgL/
AcYBPgL/AcYBPgL/AcYBPgL/AcYBPgH/AcIBjAEiAf8DAgEDFAADIAEtAf8B6wFjAv8B7wFwAv8B
7QFjAv8B4QFYAv8B1QFOAv8BxgFAAf8B6AGtASwB/wGuAXMBBAH/EAAB/wG7AZIC/wG+AZIC/wG+
AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC/wG+AZIC
/wG+AZIC/wG+AZIC/wG+AZIB/wKAAXwB/gMGAQgUAAMuAUgDTgGWA2EB6wNzAfgDmgH/A9IB/wPo
Af8D9wX/AfgB8wHuAf8B+AHzAe4J/wP7Af8D8wH/A90B/wO3Af8DgQH/A2AB8wNcAcMDQAFvAxsB
JQgAAwMBBAM5AV4BoQF+AVoB/AH/AdQBrAL/Ac0BpQH/Ae0BqgF/Af8B2gGVAW4B/wHdAbABlwH/
AfQB5AHbBf8D9AX/AfsB8wHuAf8B5AHCAa8B/wHWAZYBcwH/AeQBnQFyAf8B+gHCAZkC/wHaAbMB
/wG+AbABhQH9A1EBngMGAQgMAAG+AYcBFQL/AdkBUgL/AdkBUgL/AdkBUgL/AdkBUgL/AdkBUgH/
AcYBkgElAf8DAgEDGAADQwF1Af4B5wFjAv8B9AFxAv8B7gFnAv8B4QFYAv8B0gFNAf8BsAF2AQkB
/xQAAf8B2gGzAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHG
Av8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAf8CgAF/Af4EAhQAAwYBBwMuAUgD
WgHEA2EB6wNmAf8DfQH/A7sB/wPmFf8D8wH/A9wB/wOeAf8DcwH/A1oB/wNfAdoDSQGIAwkBCwMD
AQQQAAM7AWIBpAF+AV0B/AH/AdsBtAL/AdcBsAL/AcUBnAH/Ae8BpgF7Af8BzwF6AUoB/wHAAWgB
NgH/AcIBcAFCAf8BvwFsATwB/wHHAW8BPQH/AeQBlQFnAv8BxAGaAv8BzwGmAv8B4QG6Af8B/AG8
AZIB/wJcAVkBvgMTARoQAAG+AYsBGwL/AeoBZgL/AeoBZgL/AeoBZQL/AeoBZgL/AeoBZgH/AcYB
lQEoAf8DAgEDHAADQAFuAfkB4AFgAv8B9AFwAv8B8QFqAf8BtQF9AQ4B/xgAAwkBDAMKAQ0DCgEN
AwoBDQMKAQ0DCgENAwoBDQMKAQ0DCgENAwoBDQMKAQ0DCgENAwoBDQMKAQ0DCgENHAAEAgMTARoD
LgFIA04BmANfAdUDgAH+A3oB/wOOAf8DoAH/A6wB/wOyAf8DsgH/A6YB/wOXAf8DhQH/A3EB/wNj
AeoDWgHCA0IBcgMjATMDAwEEBAEUAAM5AV0CYwFfAdUB7wHEAZoC/wHbAbUC/wHYAbIC/wHSAaoC
/wHMAaQC/wHGAZ0C/wHJAaEC/wHRAakC/wHVAa4C/wHeAbkB/wH4Ac8BqAH/A2wB6wNSAaADFAEb
FAABvwGRAR4C/wH3AXQC/wH3AXQC/wH1AXQC/wH3AXQC/wH3AXQB/wHGAZkBLAH/BAIgAANAAW8B
9QHdAVgB/wG1AYABFAH/eAAEAgMGAQcDLwRJAYYDWQG8A1sB0wNhAeYDaQH1A3UB/AN7Af8DewH/
A2oB+QNiAe4DYAHgA1wByANTAaIDPwFtAx4BKgMEAQUcAAMDAQQDIAEuAksBSgGKAmUBYAHjAegB
rQGCAf8B/gHMAaQC/wHdAbcC/wHkAb8C/wHhAb4B/wH+AdQBrQH/AfIBuwGRAf8BpAF+AWYB/AJX
AVYBsgMyAU8DBgEIGAADOAFbAbgBjAEcAf8BuAGMARwB/wG4AYwBHAH/AbgBjAEcAf8BuAGMARwB
/wM2AVkDBAEFJAADGAEhAwgBCoQAAw4BEgMlATcDRQF8A1cBtQNeAeIDWgH1A3kB/gN5Af4DXQHs
A1sBzQNSAaEDOAFcAxwBJzQAAwkBCwM0AVMCVAFSAagCYwFfAdoBaAFmAV4B8AFpAWYBYAHoAlwB
WQG+A0MBdgMSARi4AAQBAwIBAwFAAUEBQAFxAVIBVAFSAagBUwFVAVMBqgFTAVUBUwGqA0wBkAM5
AV0DFwEfNAAEAQMIAQoDCQEMAwYBCAMCAQMkAAQBAwMBBAMDBAQBBQMEAQUDBAEFAwMBBAMDAQQE
AQwABAEDAwEEAwMEBAEFAwQBBQMEAQUDAwEEAwMBBAQBQAADBgEIAxsBJgFZAlcBuQFfATABIQH7
AW8CUQH3A08BmQMPARQDBQEGCAAEAQMDAQQDBwEJAwoBDQMaASMDMAFLAyUBNgMZASIDDAEQAwwB
DwMJAQwDBwEJAwQBBQMXAR8DNgFYAVkBXAFZAcYDQAH9AVUBnwFcAf8BHAGCASgB/wFfAWYBXwHl
AVYBVwFWAbIDNwFaAxcBHywABAEDAwEEAy0BRAM5AV4DMwFSAxYBHgQCHAADHAEnAy0BRAM2AVkD
NgFZAzcBWgM3AVoDNwFaAzYBWQM2AVkDGAEgAwIBAwQAAxwBJwMtAUQDNgFZAzYBWQM3AVoDNwFa
AzcBWgM2AVkDNgFZAxgBIAMCAQMMAAMCAQMDBwEJAwgBCgMIAQoDCAEKAwgBCgMIAQoDCAEKAwgB
CgMIAQoDCAEKAwgBCgNHAYEBqgEyAQAB/wGwATYBAAH/AZ0BMgEAAf8BnQEyAQAB/wGuATYBAAH/
AaoBMgEAAf8DEAEVCAADAgEDAwkBCwMTARoDHAEnAz4BaQNiAeEDUQGhAzwBZgMhATADHwEsAxsB
JQMVARwDCwEOAzcBWgEAAWYBCwH/AQABfAESAf8BVQGvAWMF/wFVAbABZAH/AQABiQEXAf8BAAGJ
ARcB/wFVAVcBVQGxAzgBXCwAAwIBAwMHAQkDVQGtA2gB9AFhAlsB3gMzAVEDBgEHHAADQgF0A18B
yRz/AzkBXQMGAQgEAANCAXQDXwHJHP8DOQFdAwYBCAMGAQcDDwQUARsBcQFvAWwB/wFxAW8BbAH/
AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8B
cQFvAWwB/wFxAW8BbAH/AbEBrQGqAf8BsAE3AQAB/wHJAUoBBgH/AaoBQAEBCf8BqwFDAQYB/wHJ
AUoBBgH/Aa4BNgEAAf8IAAQBAwQBBQMJAQwDRgF/A14BzQNuAfUDZgHgA1cBsgM/AW0DIQEvAwsB
DgMHAQkDKgE/AUwBTQFMAZEBAAGPARoB/wFxAb8BfwH/AcYB5AHLBf8BxgHlAcsB/wFxAcMBgQH/
AQABmwEeAf8BXwFmAV8B5QNMAZAoAAMDAQQDKQE+A1UBrQNjAeQDXwH7A2gB9ANZAbYDPQFnAwYB
BwQCFAADTgGYA2oB7QL/AfwD/wH8A/8B/AP/AfwD/wH8A/8B/AP/AfwB/wM5AV4DBwEJBAADTgGY
A2oB7QL/AfwD/wH8A/8B/AP/AfwD/wH8A/8B/AP/AfwB/wM5AV4DBwEJCAADCQELLP8B8QHCAasB
/wHXAVsBEgH/AdcBWwESAf8B1wFbARID/wH4Bf8B1wFbARIB/wHXAVsBEgH/AdcBWwESAf8BQQJA
AXEEAAQBAxYBHgM2AVgDXQHHA2oB7QNfAckDagHtA2YB5QNXAbIDOAFbAxgBIAQBAzYBWQNVAa0B
AAGtAScB/wGPAdwBoQH/AcgB8AHSAf8BqgHpAbsB/wHjAfgB6AH/AcUB6wHNAf8BUAHCAWkB/wEb
AaYBOAH/AVMBVQFTAaogAAQBAwIBAwMpAT4DTQGSAeQBsgGYAf8B1AHAAbYB/wHXAcYBvgH/Ae0B
xAGuAf8DaAHwA1kBtgMzAVADFgEdBAIQAANVAaoBzgG1AaQD/wH8A/8B/AP/AfwD/wH8A/8B/AP/
AfwD/wH8Af8DOQFeAwcBCQQAA1UBqgHOAbUBpAP/AfwD/wH8A/8B/AP/AfwD/wH8A/8B/AP/AfwB
/wM5AV4DBwEJCAADCQELLP8BqwFAAQsB/wHkAWoBHwH/AeQBagEfAf8B5AFqAR8D/wH+Bf8B4QFp
AR8B/wHkAWoBHwH/AeQBagEfAf8BZgJfAeUEAAQCAzYBVwH5AvgB/wL9AfsB/wNfAckDOAFdA18B
yQHsAeQB3gH/AfwB9AHuAf8DVwGxAzkBXQMCAQMDNwFaAVUBVgFVAa4BAAG+ATIB/wFZAdIBeQH/
AVkB0gF5Af8BAAG+ATIB/wGqAekBuwH/AfoB/wH9Af8B7wH/AfgB/wFQAcsBcAH/AVMBVQFTAaog
AAMCAQMDBwEJA1UBrQHkAbIBmAH/AbUBrgGrAf8B5gHkAeMJ/wHtAcQBrgH/A2gB9AFlAl4B3QMz
AVADBgEHEAADVQGqAdQBugGqHf8DOQFeAwcBCQQAA1UBqgHUAboBqh3/AzkBXgMHAQkIAAMJAQsI
/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DHgH/AZ0BMwEAAf8B7gF2ASkB/wHuAXYBKQH/
AcgBXgEYCf8B6AFxASgB/wHuAXYBKQH/Ae4BdgEpAf8BaAJeAfAEAANAAW4DXAHDAfQB6wHlAf8D
VwG0Az4BaQMXAR8DLgFHA00BkgHsAeQB4AH/A2YB5QNVAa8DOQFdA0IBcwFTAVQBUwGpAQABxwE6
Af8BHgHTAVQB/wEeAdUBVgH/AQABzwE+Af8BOQHdAWwB/wFoAeMBjwH/AY8B4gGoAf8BKwF+ASsB
/ANTAaccAAMDAQQDKQE+A1UBrQNjAeQB1wHDAbkB/wHmAeQB4wH/AfcC9gn/AfkB6wHkAf8DXwH7
A2gB9ANXAbUDPAFmAwYBBwQCCAADVQGqAdoBvwGuHf8DOQFdAwYBCAQAA1UBqgHaAb8Brh3/AzkB
XQMGAQgIAAMGAQcs/wHxAcYBsQH/AfcBfgEyAf8B9wF+ATIB/wH3AX4BMgH/AcgBYAEbAf8ByAFf
ARsB/wH3AX4BMgH/AfcBfgEyAf8B9wF+ATIB/wNNAZEEAANLAYoDYwHfAfYB6QHiAf8DWAGzAzoB
YAMEAQUDKgE/A00BkgG+Ab0BugH9A4AB/gNmAeUDVwGxA0MBdQFHAUgBRwGDAVwBYQFcAdkBWgFr
AVoB8gEDAdsBSAH/AQQB3gFKAf8BBAHeAUoB/wEYAdEBUQH/AT8BtwFfAf8BWgFcAVoBxANAAW8U
AAQBAwIBAwMpAT4DTQGSAfABvQGjAf8B2gHGAbwB/wHfAdwB2xX/AfkB6wHkAf8B7gHEAa4B/wNn
Ae8DVwG1AzMBUAMUARsIAANDAXUDXQHKAfAB4gHZAf8B8AHiAdkB/wHwAeIB2QH/AfAB4gHZAf8B
8AHiAdkB/wO+Af0DfQH6AzYBWAMDAQQEAANDAXUDXQHKAfAB4gHZAf8B8AHiAdkB/wHwAeIB2QH/
AfAB4gHZAf8B8AHiAdkB/wO+Af0DfQH6AzYBWAMDAQQIAAMGAQcw/wG/AUoBCQH/Af4BhwE5Af8B
6gF4AS8J/wHoAXcBLQH/Af4BhwE5Af8BvAFHAQcB/wMHAQkEAAM2AVcDVQGsAf8B9AHuAf8DgAH+
A1YBrgMMAQ8DVQGvA74B/QJ9AXsB+gG+Ab0BuwH9Ae4B5QHiAv8B9wHyAf8DOgFgAycBOgNLAY0B
XAFhAVwB2QEIAeIBUAH/AQsB7QFWAf8BCwHtAVYB/wEHAckBQwH/AQABgAEcAf8DNQFWBAEUAAMC
AQMDBwEJA1UBrQHxAb4BowH/AdcB0AHNAf8B8gHvAe4h/wHuAcQBrgH/A28B8wFkAmAB2wMwAUoE
AQQAAwkBCwM6AWAB0wGpAYwB/wHTAakBjAH/AdMBqQGMAf8B0wGpAYwB/wHTAakBjAH/A30B+gNn
Ae8DMwFQCAADCQELAzoBYAHTAakBjAH/AdMBqQGMAf8B0wGpAYwB/wHTAakBjAH/AdMBqQGMAf8D
fQH6A2cB7wMzAVAMAAMGAQcI/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wF6
AXQBcQH/AcEBSwEKAv8BjAFAAf8B2QFvASkB/wHXAW8BKAL/AYwBQAH/Ab8BSAEJAf8DPwFtCAAD
FgEdAzoBYANdAcoDagHtA2UB4wNWAa4DUwGlA1sBwAO+Af0DfgH8AbYBsgGwAf0B4AHbAdkB/wM3
AVoDEwEZAykBPQNIAYQBUwFUAVMBqQFVAVYBVQGuA1UBrQFLAUwBSwGPAzUBVQEVAhYBHRQAAwMB
BAMpAT4DVQGtA2MB5AHtAdkBzwH/AfIB7wHuAf8B+wH6AfkN/wP1Af8B4QLgAf8D9Qn/AdMBwQG4
Af8DXwH7Am8BYAHzAzMBUQgAAwMBBAMYASADNQFVAzUBVQNMAY4BbgFgAVcB/wNMAY4DNAFTAzMB
UAMUARsIAAMDAQQDGAEgAzUBVQM1AVUDSwGKAW4BaAFaAfUDSwGKAzQBUwMzAVADFAEbDAADBgEH
OP8B8QHGAbEB/wGnAT4BCgH/AWsCWgHyA1kBuwM2AVgQAAMcAScDQwF1A1oBvwNqAe0DgAH+A1oB
vwNbAcAB8QHkAd4B/wG+AbgBtQH9A34B/AG2AbMBsgH9A0wBjgM4AVsDOwFjA0QBdwNCAXMDNwFa
AzYBWAMnAToUAAQBAwIBAwMpAT4DTQGSAfYBwgGnAf8B7gHaAdAB/wHxAe8B7RH/AvUB9AH/AesC
6gH/AeEC4AH/A/UB/wH1AvQB/wHhAd8B3gH/Ac0BtgGqAf8DZQHjA1UBqgMnATkYAAM1AVUDQAH/
A0wBjgM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQNIAYMDYAHgAzABSxgAAwYB
Bzz/A30B+gMjATIgAANDAXUDXQHKAf8B+QH0Af8DgAH+A4AB/gHkAdwB2QH/AfIB5wHiAf8DvgH9
A30B+gGfAZkBlwH9AckBxAHCBf8DVwGyAzkBXgMCAQMEARgAAwIBAwMHAQkDVQGtAfYBxAGnAf8B
4wHdAdoB/wH2AfQB8xX/AuAB3wH/AuAB3wn/AeEB3wHeAf8BpgGgAZwB/wHbAaIBhAH/A1UBqgQB
HAADNQFVA0cB/wNHAf8DRwH/A0cB/wNHAf8DRwH/A0cB/wNHAf8DRwH/A0cB/wNHAf8DXQHqA1kB
wAMqAUAYAAMDAQQI/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAX/
A2oB+QMHAQkgAAMcAScDPgFqA10BygNqAe0DgAH+AaIBngGdAf0DgAH+A4AB/gO+Af0DfgH8AbIB
rAGrAf0B9AHuAesB/wNmAeUDVQGvAzkBXgMYASEEARQAAycBOgNVAa0DYwHkAfAB3QHTAf8B9gH0
AfMB/wH8AvsN/wH1AvQB/wHgAd8B3gH/AuoB6QH/AvUB9AX/AdcB1AHSAf8BywG3AaoB/wHdAacB
iAH/A0wBjgMnATkgAAMVARwDNQFVAzUBVQM1AVUDNQFVAzUBVQNLAY0DKwH8A0sBjQM1AVUDNQFV
AzUBVQMxAU4DKgFAAxABFRgAAwMBBDz/A2oB+QMHAQkkAAMcAScDQwF1A04BmANUAakDVAGoA2UB
4gHaAdIBzQH/AfgB7QHnAf8CvgG7Af0DfgH8A74B/QOAAf4DZgHlA1cBsgM4AVsDGAEhBAEQAAM1
AVUB/wG+AZMB/wHzAdABtwH/AfMB5gHbEf8D9AH/AeoC6QH/AeAB3wHeAf8B9QL0Af8C9gH1Af8B
5QHjAeIB/wHOAboBrQH/A2UB4wNVAaoDJwE5LAADGwElAysBQgM1AVUDNQFVA0sBjQFtAWIBWgH8
A0sBjQM1AVUDNQFVAxoBIwMGAQcgAAMDAQQ8/wNqAfkDBwEJOAADVQGqAbABqQGlAf8B6wHkAd4B
/wH4AfEB6wH/A74B/QN9AfoDvgH9AfYB8AHtA/8B/AH/A1cBsgM5AV4DAgEDBAEIAAQBAzUBVgH/
AcwBnAL/AcsBnwL/AdwBwBH/Ad8C3gH/Ad8C3gn/AeUB4wHiAf8BsQGrAakB/wHlAbABkQH/A1UB
qgQBMAADQQFwAl0BWwHFAZ8BfQFlAf8BnwF9AWUB/wGfAX0BZQH/AZ8BfQFlAf8BnwF9AWUB/wGf
AX0BZQH/AZ8BfQFlAf8DPgFqAxABFSAAAwMBBAj/AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAB
/wMAAf8DAAH/AwAB/wMABf8DagH5AwcBCTgAA1UBqgHSAc4BywH/AcABuQG3Af8B4gHbAdYB/wOA
Af4DvgH9A0wBjgNMAY8B+AHyAe4B/wNmAeUDVAGmAysBQgMRARYIAAQBAzUBVgH/Ac4BoAL/Ac4B
oQL/AdMBrAL/Ad4BwgL/AfQB6wn/A/QB/wP0Bf8B6gHnAeUB/wHhAc0BwQH/AeUBsgGSAf8DTAGO
AycBOTQAA08BlwNlAewB3wHLAakB/wHfAcsBqQH/Ad8BywGpAf8B3wHLAakB/wHfAcsBqQH/Ad8B
ywGpAf8B3wHLAakB/wNdAcwDRAF3IAADAgEDPP8DagH5AwcBCTgAA04BmANqAe0BxgLCAf8BzwHJ
AcYB/wNjAeQDVQGvAygBOwMvAUkDYgHXA2sB8gNhAdYDRwGDAx8BLAgABAEDNQFWAf8BzwGjAf8B
+wHCAZMB/wH7AcMBlQL/AdABpwL/AeUBzwL/AfQB7An/AfoC+QH/Ae8B7QHsAf8B5AHRAcUB/wNl
AeMDVQGqAycBOTgAA1UBqgH/AfwB8AL/AfUB0QL/AfUB0QL/AfUB0QL/AfUB0QL/AfUB0QL/AfUB
0QL/AfUB0QH/A34B/ANTAackADz/A2oB+QMHAQk4AANDAXUDXQHKBP8DgAH+A1YBrgMMAQ8DBAEF
AyABLQNJAYcDYgHXA2wB6wNaAcQDKwFBCAAEAQM1AVYB/wHQAaQB/wH0AacBdgH/AfQBqgF5Av8B
1wGtAv8B0gGqAv8B3wHGCf8B7wHtAewB/wHPAckBxQH/Ae8BvgGdAf8DVQGqBAE8AANVAaoB/wH+
AfQC/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4B/wN+AfwDUwGnJAA8
/wNqAfkDBwEJOAADHAEnAz4BagNdAcoDagHtA2MB5ANWAa4DRAF3A0kBhQNiAdcDawHyA1sBwAMr
AUIDEQEWDAADNQFVAf8BzwGkAf8DZQHiA2UB4gH+AboBjQL/AckBnwL/AdYBsgL/Ad8BxgH/AekB
3AHSAf8B4wHRAcQB/wHvAb8BnQH/A0wBjgMnATlAAANVAaoC/wH7Av8B/gH0Av8B/gH0Av8B/gH0
Av8B/gH0Av8B/gH0Av8B/gH0Av8B/gH0Af8DfgH8A1MBpyQAPP8DagH5AwcBCTwAAxwBJwNDAXUD
WgG/A2oB7QOAAf4DXQHKA18BywH5AfcB9QH/A10BxwNCAXIEARAAAzUBVQH/AdQBqwH/A2UB4gNl
AeIB/gG9AZIC/wHOAaUC/wHWAa4C/wHVAa8B/wHpAckBsAH/A2UB4wNVAaoDJwE5RAADVQGqIP8D
fQH6A1MBpSQAAf8BuwGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGS
Av8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAv8BvgGSAf8CgAF8Af4DBgEIRAAD
QwF1A10Bygj/AfkB9wH1Af8B7QHmAeAB/wM1AVYEARQAAzUBVQH/Ad4BuAL/AeABuwL/AeEBvAL/
AeEBvAL/AeEBvAL/AeEBvAL/AeEBvAL/AccBmgH/A1UBqgQBSAADVQGqIP8DbgH1A1IBoCQAAf8B
2gGzAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHG
Av8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAf8CgAF/Af4EAkQAAxwBJwM4AVsDUQGcA1wB
xgNWAa4DNQFVAxYBHRgAAxUBHAM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUDNQFVAycBOUwA
AycBOQM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUDNQFVAzMBUgMkATUkAAMJAQwDCgENAwoB
DQMKAQ0DCgENAwoBDQMKAQ0DCgENAwoBDQMKAQ0DCgENAwoBDQMKAQ0DCgENAwoBDVAAAxIBGAMu
AUcDQQFxAzYBWf8A/wDCAAEmAScBJgE5A1MBqgNTAaoDUwGqA1MBqgNTAaoDUwGqAVMBVQFTAaoB
UwJVAaoBUwJVAaoBUwJVAaoBUwJVAaoBUwJVAaoBUwFVAVMBqgNTAaoDUwGqA1MBqgNTAaoDUwGq
A1MBqgEmAScBJgE5FAADBgEHAwoBDQMPARMDEAEVAxEBFgMSARcDEgEYAxYEHQEoAxYBHQMTARkD
EwEaA0QBeQFUAlMBqQFVAlMBqgFVAlMBqgNMAZADOQFdAxcBHxQAAwYBBwMKAQ0DDwETAxABFQMR
ARYDEgEXAxIBGAMWBB0BKAMWAR0DEwEZAxMBGgNEAXkBUwFUAVMBqQFTAVUBUwGqAVMBVQFTAaoD
TAGQAzkBXQMXAR8YAAQCAwYBBwMJAQwDCQEMAwMBBAQBPAADNQFVAQABLAEAAf8BAAEsAQAB/wEA
ASwBAAH/AQABLAEAAf8BAAEsAQAB/wEAAVABAAH/AQABmQEAAf8BAAHEAaoB/wEAAdkC/wEAAdkC
/wEAAdkC/wEAAcQBqgH/AQABmQEAAf8BAAFQAQAB/wEAASwBAAH/AQABLAEAAf8BAAEsAQAB/wEA
ASwBAAH/AQABLAEAAf8DNQFVFAADBgEHAwoBDQMPARMDMQFOAz4BawM/AWwDPwFtA0IBcgNGAX0D
QgFyA0ABbgNAAW8BYAJdAc4DgAH+AcQBdAFVAf8BxAFzAVEB/wJmAV8B5QFXAlYBsgM3AVoDFwEf
EAADBgEHAwoBDQMPARMDMQFOAz4BawM/AWwDPwFtA0IBcgNGAX0DQgFyA0ABbgNAAW8BXQFgAV0B
zgOAAf4BVQGfAVwB/wEcAYIBKAH/AV8BZgFfAeUBVgFXAVYBsgM3AVoDFwEfEAAEAQMYASADOAFc
AzoBYQMvAUkDDwEUAwYBBzwAAzUBVQEAASwBAAH/AQABLAEAAf8BAAEsAQAB/wEAASwBAAH/AQAB
LAEAAf8BAAFQAQAB/wEAAZkBAAH/AQABvgGqAf8BAAHQAv8BAAHQAv8BAAHQAv8BAAG+AaoB/wEA
AZkBAAH/AQABUAEAAf8BAAEsAQAB/wEAASwBAAH/AQABLAEAAf8BAAEsAQAB/wEAASwBAAH/AzUB
VSAAA1UBqgGoAaQBogn/AfoB/wH1Af8B7wH/AeEB/wHqAf8B3gH/AdUBvAGTAf8BsAE3AQAB/wHB
AUQBBAH/AdsBhgFZBv8B+gHyAf8B7QG+AZ8B/wHJAUoBBgH/AVcCVQGxAzgBXBwAA1UBqgGoAaQB
ogn/AfoB/wH1Af8B7wH/AeEB/wHqAf8B3gH/AZsBzAGXAf8BAAFmAQsB/wEAAXwBEgH/AVUBrwFj
Bf8BVQGwAWQB/wEAAYkBFwH/AQABiQEXAf8BVQFXAVUBsQM4AVwQAAMCAQMDNgFYAeYC5AH/AfUC
9AH/A1oBugMhAS8DDQERBAE4AAMVARwDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUDNQFVAUMCRAF3
A1UBrwEzAeMBjAH/A0wBjgM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUDNQFVAxUBHBQAAxsB
JQM5AV4DVQGqA2UB4wHiAeEB4An/AfkB/wH1Af8B7gH/AeAB/wH0Af8B6wH/AeoBxgGmAf8BzwFU
AREB/wHUAVkBEwH/AeQBkQFhA/8B/QH/Ad4BsAGQAf8B0QF5AUIB/wHXAVsBEwH/AWYCXwHlA0wB
kBAAAxsBJQM5AV4DVQGqA2UB4wHiAeEB4An/AfkB/wH1Af8B7gH/AeAB/wH0Af8B6wH/AaUB2gGp
Af8BAAGPARoB/wFxAb8BfwH/AcYB5AHLBf8BxgHlAcsB/wFxAcMBgQH/AQABmwEeAf8BXwFmAV8B
5QNMAZAIAAQBAwIBAwNCAXQDXQHHAfcB9QHyAf8B/AH7AfoB/wNpAegDWgG6AzIBTwMNARFYAAMk
ATQDSgGJAT8B6QFEAf8DNQFVCAEoAAMCAQMDBgEIAzoBYANYAbMU/wH5Af8B9AH/Ae4B/wHfAf8B
+QH/AfAB/wH2Ac0BsAH/AeMBaQEfAf8B4wFpAR8B/wHtAZsBaQP/Af0B/wHSAZEBZwH/AckBXwEd
Af8B4wFpAR8B/wHaAWABGAH/AlUBUwGqCAADAgEDAwYBCAM6AWADWAGzFP8B+QH/AfQB/wHuAf8B
3wH/AfkB/wHwAf8BqgHkAbMB/wEAAa0BJwH/AY8B3AGhAf8ByAHwAdIB/wGqAekBuwH/AeMB+AHo
Af8BxQHrAc0B/wFQAcIBaQH/ARsBpgE4Af8BUwFVAVMBqggAAxYBHQM2AVgDXQHHA2cB6gNcAcED
WgG3A10BzAT/A1EBngMxAU0DCQEMAwMBBFAAAyQBNQFKAUsBSgGKASIB4QEoAf8DNQFWCAIEASQA
AwYBCAMTARkDVwGyGP8B+QH/AfQB/wHtAf8B3gH/AfkB/wHwAf8B+QHRAbQB/wHuAXYBKQH/Ae4B
dgEpAf8B9AGkAXAF/wHaAZ0BdQH/AdUBbwEuAf8B7gF2ASkB/wHpAW8BJAH/AlUBUwGqCAADBgEI
AxMBGQNXAbIY/wH5Af8B9AH/Ae0B/wHeAf8B+QH/AfAB/wGqAekBtwH/AQABvgEyAf8BWQHSAXkB
/wFZAdIBeQH/AQABvgEyAf8BqgHpAbsB/wH6Af8B/QH/Ae8B/wH4Af8BUAHLAXAB/wFTAVUBUwGq
CAADNQFVAfkC+AH/Av0B+wH/A1wBwQMtAUUDHAEnAzwBZQj/A1kBtgMbASUDCQEMLAADNAFTA0sB
iwNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDWQG8A18B2AFSAZIBVAH/A10BxwNWAasDVgGr
A1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqAycBOQwAAygBOwNXAbIDZgHlGP8B+QH/AfQB/wHsAf8B
3QH/AfgB/wHxAf8B+gHSAbYB/wHxAXkBLQH/AfUBfAEwAf8B+AGeAWQB/wH7Ad0ByAH/AdoBjwFe
Af8B2QFwASwB/wH3AX4BMgH/AX4BXgErAfwDUwGnCAADKAE7A1cBsgNmAeUY/wH5Af8B9AH/AewB
/wHdAf8B+AH/AfEB/wGqAewBugH/AQABxwE6Af8BHgHTAVQB/wEeAdUBVgH/AQABzwE+Af8BOQHd
AWwB/wFoAeMBjwH/AY8B4gGoAf8BKwF+ASsB/ANTAacEAAMEAQUDNwFaAfQB6wHnAf8DbgH1A1QB
qAMTARkDEgEXAy4BRgNSAaQDYgHhA2UB5wNZAbYDMAFLAwsBDigAA0sBiwNmAeADnAH/AX8CfgH/
AX8CfgH/A5wB/wF+An0B/wF+An0B/wOcAf8BfQJ8Af8BfQJ7Af8BnAKaAf8BnAKbAf8BnAKbAf8B
nAKZAf8BnAKZAf8BhwGSAY4B/wFcAYUBeQH/AV0BcwGLAf8BcgF5AZUB/wGaApYB/wM1AVUIAAME
AQUDNwFaAeoC5gH/AfgC9xX/AfsB/QH8Af8B8AH4AewB/wHbAfIBzgH/AeIB6QHgAf8B6wHOAcEB
/wH2AaIBcgH/AfkBjAFKAf8B9gGQAU8B/wHuAa0BgQH/AeABhAFIAf8B3QFvASoB/wHnAW8BJwH/
AVwCWgHEA0ABbwQAAwQBBQM3AVoB6gLmAf8B+AL3Ff8B+wH9AfwB/wHwAfgB7AH/AdsB8gHOAf8B
4gHpAeAB/wG0AeABxQH/AVMB2QF9Af8BHQHZAVkB/wEDAdsBSAH/AQQB3gFKAf8BBAHeAUoB/wEY
AdEBUQH/AT8BtwFfAf8BWgFcAVoBxANAAW8EAAMEAQUDNwFaAeQB1wHSAf8DbgH1A1UBrwMhAS8D
MwFSA0QBeQNSAaQDXQHHA2YB5QT/A0sBjQMmATgoAANVAaoDoAX/AagCpwH/AagCpwX/AaUCpAH/
AaUCpAX/AaICoAH/AaICngL/AvkC/wL8Av8C/AL/AvgC/wL2Af8BwAHhAdUB/wFBAboBlgH/AUQB
hgHOAf8BgQGXAesB/wH5Au0B/wM1AVUIAAMMARADPAFlHP8B9AH4AfYB/wHeAesB3AH/AbwB1wGw
Af8BtgG8Ab0B/wHMAcUB1gL/AfIB+QH/AfsBpwF3Af8B7gF7ATIB/wHZAW8BKQH/AesBewEyAf8B
4gFuASgB/wG/AUgBCQH/AzUBVgQBBAADDAEQAzwBZRz/AfQB+AH2Af8B3gHrAdwB/wG8AdcBsAH/
AbYBvAG9Af8BygHFAdYB/wH4AfQB+wH/AVcB5AGHAf8BCAHiAVAB/wELAe0BVgH/AQsB7QFWAf8B
BwHJAUMB/wEAAYABHAH/AzUBVgQBCAADNQFVAcgBvgG7Af8B7QHkAeEB/wNiAdcDSQGHA2IB1wH/
AfkB9wL/AfgB9wH/A1cBsQNXAbEE/wNhAdQDRgF/KAADVQGqA6YF/wHcAtsB/wHaAtgB/wH4AvYB
/wHVAtMB/wHUAtEB/wHzAu8B/wHQAssB/wHOAsgB/wHuAuYB/wH5AvYC/wL8Av8C+AL/AvYB/wHq
Ae4B6gH/Ab8B3wHTAf8BvgHMAeQB/wLRAe0B/wH5Au0B/wM1AVUIAAM7AWIDWgG3Av8B+gP/AfsD
/wH8A/8B/QP/Af4B/wH7AvcB/wH0AegB5gH/AdcB0wHRAf8DaAH0A2MB3wNoAfQB1wHFAckB/wHi
AcYBwgH/AfQB0AG7Af8B+QHTAbcB/wHyAc8BtwH/AfgB0wG6Af8B9QHJAa8B/wHqAbIBlAH/AzUB
VQgAAzsBYgNaAbcC/wH6A/8B+wP/AfwD/wH9A/8B/gH/AfsC9wH/AfQB6AHmAf8B1wHTAdEB/wNo
AfQDYwHfA2gB9AHWAcUByQH/Ad8BxwHCAf8BvQHkAcAB/wGtAfUBwQH/Aa4B+QHGAf8BrgH5AcYB
/wGsAegBuAH/AaoBxQGbAf8DNQFVDAADFQEcAzUBVQNcAcYDawHyA2IB1wNcAcMDYQHRAf8B/QH8
Af8DZgHlA18BywNXAbEDPQFnAzMBUgNBAXEDJAE0AwsBDhwAA1UEqgX/AfkC+AH/AfcC9QH/AfgC
9gH/AfMC8QH/AfIC7wH/AfMC7wH/Ae8C6wH/Ae0C6AH/Ae4C6AH/AfkC9wL/Av0C/wL6Av8C+QL/
AvcB/wH+AvYB/wH8AvUB/wH7AvQB/wH7AvMB/wM1AVUIAANOAZUDZwHqAf8B+gHzAv8B+gHzAv8B
+QHzAv8B+QHzAv8B+QH0Af8B9wHrAeYB/wHnAdEBywH/A1wBxgNRAZ8DSwGKA14BzQNoAfQB2wG8
AbUB/wHzAegB4QL/Af0B9wL/AfwB+QL/AfsB+AL/AfYB8AL/AesB4AH/AzgBWwMFAQYEAANOAZUD
ZwHqAf8B+gHzAv8B+gHzAv8B+QHzAv8B+QHzAv8B+QH0Af8B9wHrAeYB/wHnAdEBywH/A1wBxgNR
AZ8DSwGKA14BzQNoAfQB2wG8AbUB/wHzAegB4QL/Af0B9wL/AfwB+QL/AfsB+AL/AfYB8AL/AesB
4AH/AzgBWwMFAQYQAANBAXEDXAHGAe8B6AHjAf8DYQHRA10BxQNiAdwDbwHzA2YB5QNXAbEDOAFb
AzsBYgNcAcYDSgGJAzABSwMJAQwDAwEEFAADVQGqA65N/wM1AVUIAANVAaoBmgGPAYoC/wHvAegC
/wHvAecC/wHuAeUC/wHtAeEC/wHsAd8B/wHzAdsBzgH/AdoBugGuAf8DNQFVCAADSwGKA2MB3wHr
AdUB0gH/AfgB7gHpAv8B+QHyAv8B9QHuAv8B9AHtAv8B8wHsAv8B8gHrAf8DPQFoAw8BEwQAA1UB
qgGaAY8BigL/Ae8B6AL/Ae8B5wL/Ae4B5QL/Ae0B4QL/AewB3wH/AfMB2wHOAf8B2gG6Aa4B/wM1
AVUIAANLAYoDYwHfAesB1QHSAf8B+AHuAekC/wH5AfIC/wH1Ae4C/wH0Ae0C/wHzAewC/wHyAesB
/wM9AWgDDwETFAADNQFVAc8BxgHCAf8B7wHqAeYB/wNiAdwDTgGXA2IB3AL/Af0C/wH+AfkB/wNV
Aa8DVQGvCP8DWQG2AxsBJQMJAQwUAANLAYsDZgHgA5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB
/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB/wM1AVUIAAJU
AVMBpgNfAfsB/wHoAd4C/wHmAdwC/wHkAdoC/wHiAdcC/wHgAdQB/wHuAc8BxgH/Ac0BrwGuAf8D
WQG2AzoBYQQAA1EBnwNoAfQB8gHoAekB/wH7AfcB9QL/Af0B+wL/AfwB+QL/AfsB+QL/AfsB+AL/
AfsB9gH/AzgBWwMFAQYEAAJUAVMBpgNfAfsB/wHoAd4C/wHmAdwC/wHkAdoC/wHiAdcC/wHgAdQB
/wHuAc8BxgH/Ac0BrwGuAf8DWQG2AzoBYQQAA1EBnwNoAfQB8gHoAekB/wH7AfcB9QL/Af0B+wL/
AfwB+QL/AfsB+QL/AfsB+AL/AfsB9gH/AzgBWwMFAQYUAAMVARwDNQFVA1wBxgNvAfMDYgHcA0sB
jANOAZgC/wH9Af8DYwHkA10BygNXAbEDZgHlA2UB5wNZAbYDMQFNAwwBEBAAA0sBiwNmAeADnAH/
AX8CfgH/AX8CfgH/A5wB/wF+An0B/wF+An0B/wOcAf8BfQJ8Af8BfQJ7Af8BnAKaAf8BnAKbAf8B
nAKbAf8BnAKZAf8BnAKZAf8BhwGSAY4B/wFcAYUBeQH/AV0BcwGLAf8BcgF5AZUB/wGaApYB/wM1
AVUIAANHAYIDYgHXAf8B4gHXAv8B3wHUAv8B3AHRAf8B/gHaAdAB/wH7AdgB0QH/AegByAHKAf8B
xQGrAboB/wNnAe8DWQG2AzUBVQNcAcYC0AHNAf8B+AH2AfgB/wH9AfwB/Q//Af4D/wH9Af8DNQFV
CAADRwGCA2IB1wH/AeIB1wL/Ad8B1AL/AdwB0QH/Af4B2gHQAf8B+wHYAdEB/wHoAcgBygH/AcUB
qwG6Af8DZwHvA1kBtgM1AVUDXAHGAtABzQH/AfgB9gH4Af8B/QH8Af0P/wH+A/8B/QH/AzUBVSAA
A0EBcQNVAaoDVQGqA0UBfANMAY4DZQHiA24B9QNmAeUDVwGxA1sBwANjAdoE/wNRAZ4DMQFNAwkB
DAMDAQQIAANVAaoDoAX/AagCpwH/AagCpwX/AaUCpAH/AaUCpAX/AaICoAH/AaICngL/AvkC/wL8
Av8C/AL/AvgC/wL2Af8BwAHhAdUB/wFBAboBlgH/AUQBhgHOAf8BgQGXAesB/wH5Au0B/wM1AVUI
AAMqAUADTgGVAf8B3QHSAv8B2gHOAf8B/gHXAcwB/wH7AdMBzAH/AfMB0gHXAf8B4QHHAdoB/wHE
AbAB0wH/AbcBswHEAf8BtgHBAbsB/wHBAdkBuAH/AdYB6AHTAf8B6wH0Aesd/wM1AVUIAAMqAUAD
TgGVAf8B3QHSAv8B2gHOAf8B/gHXAcwB/wH7AdMBzAH/AfMB0gHXAf8B4QHHAdoB/wHEAbAB0wH/
AbcBswHEAf8BtgHBAbsB/wHBAdkBuAH/AdYB6AHTAf8B6wH0Aesd/wM1AVUsAANVAaoDZQHiA1IB
qANlAeII/wNMAZADTAGQCP8DWQG2AxsBJQMJAQwIAANVAaoDpgX/AdwC2wH/AdoC2AH/AfgC9gH/
AdUC0wH/AdQC0QH/AfMC7wH/AdACywH/Ac4CyAH/Ae4C5gH/AfkC9gL/AvwC/wL4Av8C9gH/AeoB
7gHqAf8BvwHfAdMB/wG+AcwB5AH/AtEB7QH/AfkC7QH/AzUBVQgAAxABFQM+AWoB/wHfAdcB/wH8
AdgB0gH/AfgB1AHTAf8B8gHSAdgB/wHtAdIB5QH/AeMBzgHrAf8B1QHHAewB/wHRAdMB2QH/AdIB
4QHOAf8B2AHyAc0B/wHrAfcB6AH/AfgB+wH4Ff8B5QHjAeIB/wGwAaoBpwH/AzUBVQgAAxABFQM+
AWoB/wHfAdcB/wH8AdgB0gH/AfgB1AHTAf8B8gHSAdgB/wHtAdIB5QH/AeMBzgHrAf8B1QHHAewB
/wHRAdMB2QH/AdIB4QHOAf8B2AHyAc0B/wHrAfcB6AH/AfgB+wH4Ff8B5QHjAeIB/wGwAaoBpwH/
AzUBVSwAA1UBqgNuAfUDZQHiA10BzANhAdYE/wM+AWoDJQE2AzwBZQNdAcwDZQHnA1kBtgMpAT4E
AQQAA1UEqgX/AfkC+AH/AfcC9QH/AfgC9gH/AfMC8QH/AfIC7wH/AfMC7wH/Ae8C6wH/Ae0C6AH/
Ae4C6AH/AfkC9wL/Av0C/wL6Av8C+QL/AvcB/wH+AvYB/wH8AvUB/wH7AvQB/wH7AvMB/wM1AVUM
AAMxAUwDZgHlA2MB9gHzAdMB3AH/AewB0gHjAf8B5wHSAe8B/wHiAdMB9QH/Ad4B1QH2Af8B3QHk
AeEB/wHfAfIB1wH/AeQB/wHWAf8B9gH/AfED/wH+Ff8DZQHjA1UBqgMnATkMAAMxAUwDZgHlA2MB
9gHzAdMB3AH/AewB0gHjAf8B5wHSAe8B/wHiAdMB9QH/Ad4B1QH2Af8B3QHkAeEB/wHfAfIB1wH/
AeQB/wHWAf8B9gH/AfED/wH+Ff8DZQHjA1UBqgMnATksAANBAXEDXAHGAfMB8AHvAf8DYQHWA18B
yQNhAdkDMAFKAxABFQMnATkDWgG9AfkB+AH2Af8B7gHpAeYB/wM1AVYEAQQAA1UBqgOuTf8DNQFV
DAADKAE7AlcBVgGyA2YB5QHvAdQB5wH/AegB0gHuAf8B4wHSAfUB/wHfAdUB9gH/Ad0B2gHvAf8B
3QHnAdwB/wHfAfQB0wH/AeQB/wHVAf8B9gH/Ae4D/wH8Ff8DVQGqFAADKAE7AlcBVgGyA2YB5QHv
AdQB5wH/AegB0gHuAf8B4wHSAfUB/wHfAdUB9gH/Ad0B2gHvAf8B3QHnAdwB/wHfAfQB0wH/AeQB
/wHVAf8B9gH/Ae4D/wH8Ff8DVQGqOAADNQFVAdwB0wHPAf8B8wHwAe8B/wNhAdkDSwGMAyIBMQMe
ASsDRQF8A18B0wHwAe0B6wH/AdMByAHCAf8DNQFVCAADJwE5A0QBewNcAcYDZQHsAe4C7AH/AfAC
7wH/Ae8C7QH/Ae4C6wH/AewC6AH/AesC5wH/AekC5QH/AeYC4wH/AeYC4gH/AeUC4AH/AeMC3gH/
AeIC3QH/AeEC3AH/AeEC2gH/AcwCyAH/A18B0ANCAXIDGwEmDAADDwEUAygBOwNZAbwBrgGhAa8B
/QHoAdUB9wH/AeIB1AH4Af8B3gHWAfMB/wHdAd4B6AH/Ad0B6gHYAf8B3wH1AdIB/wHkAf8B1QH/
AfQB/wHrAf8B/QH/AfkR/wNXAbIDOQFdFAADDwEUAygBOwNZAbwBrgGhAa8B/QHoAdUB9wH/AeIB
1AH4Af8B3gHWAfMB/wHdAd4B6AH/Ad0B6gHYAf8B3wH1AdIB/wHkAf8B1QH/AfQB/wHrAf8B/QH/
AfkR/wNXAbIDOQFdOAADFQEcAzUBVQNcAcYDawHyA2EB2QNaAbcDVwG1A18B0wNoAfADXQHHAzUB
VgMWAR0MAAMbASYDQQFxA08BlwNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNV
AaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNEAXsDFgEdAwgBChQAA0EBcANZAbwDYwHkA2MB9gHlAeIB
8wH/Ad0C4gH/Ad0B7QHVAf8B3wH3AdEB/wHkAf8B1QH/AfMB/wHoAf8B/AH/AfYF/wP7Af8DZgHl
A1cBsgM6AWADGgEkHAADQQFwA1kBvANjAeQDYwH2AeUB4gHzAf8B3QLiAf8B3QHtAdUB/wHfAfcB
0QH/AeQB/wHVAf8B8wH/AegB/wH8Af8B9gX/A/sB/wNmAeUDVwGyAzoBYAMaASRAAANBAXEDXAHG
AfUB8gHxAf8DfgH8A34B/AH5AfcB9QH/A10BxwNCAXIEAXwAAycBOgNVAa8DYwHkAfQB9wH0Af8B
3QHnAd4B/wHdAfAB0gH/Ad8B+AHPAf8B5AH/AdUB/wHxAf8B5gH/AfoB/wH0Bf8C9AHzAf8DVwGy
AxIBGAMGAQgkAAMnAToDVQGvA2MB5AH0AfcB9AH/Ad0B5wHeAf8B3QHwAdIB/wHfAfgBzwH/AeQB
/wHVAf8B8QH/AeYB/wH6Af8B9AX/AvQB8wH/A1cBsgMSARgDBgEISAADNQFVAeEB2QHVAf8B9QHy
AfEB/wH5AfcB9QH/Ae0B5gHgAf8DNQFWBAGAAAMPARMDJwE6AzEBTAM+AWkDTAGQA2EB1gNfAfsB
lgGZAYgB/wNnAeoDWgG3AzwBZQM3AVoDKAE7AwYBCAMCAQMkAAMPARMDJwE6AzEBTAM+AWkDTAGQ
A2EB1gNfAfsBlgGZAYgB/wNnAeoDWgG3AzwBZQM3AVoDKAE7AwYBCAMCAQNIAAMVARwDNQFVAzUB
VQM1AVUDNQFVAxYBHZAAAw8BFAMoATsDRwGBA1QBpgNVAaoDTgGVAzsBYgMMARADBAEFPAADDwEU
AygBOwNHAYEDVAGmA1UBqgNOAZUDOwFiAwwBEAMEAQX/AP8ADgADBgEIAwoBDQMMARADDAEQAwwB
EAMMARADDAEQAwwBEAMMARADDAEQAwwBEAMMARADDAEQAwwBEAMMARADDAEPAwgBCgQBHAADBAEF
AwsBDgMMAQ8DDAEPAwwBDwNDAXYDUwGqA1MBqgNQAZ0DPQFpAwwBDwMMAQ8DCgENAwYBCAMCAQMk
AAQCAwUEBgEHAwYBCAMGAQgDQgF0A1MBqgNVAaoDVQGqA0IBdAMGAQgDEwEaAxMBGgMGAQgDBgEI
AwQBBRQAAyYBOQNTAaoDUwGqA1MBqgNTAaoDUwGqA1MBqgNVAaoBUwJVAaoBUwJVAaoBUwJVAaoB
UwJVAaoBUwJUAakDVAGmA1IBpQNSAaUDUgGlA1IBpQNSAaUDUgGlAyUBNwwABAIDBAEFAysBQgM7
AWIDPAFlAzwBZQM8AWUDPAFlAzwBZQM8AWUDPAFlAzwBZQM8AWUDPAFlAzwBZQM8AWUDPAFlAzwB
ZAMsAUMEAgQBGAADBAEFAwsBDgMMAQ8DDAEPAwwBDwNVAa8DDgH/Aw0B/wNaAfIDUQGiAwwBDwMM
AQ8DCgENAwYBCAMCAQMkAAMWAR4DOAFbAzgBXAM4AV0DOARdAckDJQH/A1EB/wNMAf8DWAG9AycB
OQM7AWMDQAFvAzkBXQMaASQDBAEFFAADNQFVAxIB/wMSAf8DEgH/AxIB/wMSAf8DLgH/A2cB/wEi
AbMBzAH/AQAB2QL/AQAB2QL/AQAB2QL/A4AB/gNfAfsDTQH6A00B+gNNAfoDTQH6A00B+gNNAfoD
NAFTDAADBAEFAwsBDgNVAa88/wNWAasDAgEDBAEsAANTAaoDKgH/AyYB/wNAAf8DUwGqOAADNQFV
AwAB/wMQAf8DEAH/AwAB/wMdAf8DKwH/AygB/wMnAf8DYAHbA04BlANgAdsDNgH/A3MB/wM1AVUY
AAM1AVUDEgH/AxIB/wMSAf8DEgH/AxIB/wMuAf8DZwH/ASIBrQHMAf8BAAHQAv8BAAHQAv8BAAHQ
Av8BIgGtAcwB/wNnAf8DLgH/AxIB/wMSAf8DGAH/AxwB/wMeAf8DNQFVDAADBAEFAwsBDgNVAa88
/wNWAasDAgEDBAEUAANAAXEDUwGqA1MBqgNJAYgDSQGIA1MBqgNgAeMDJgH/AyYB/wM/Af8DYAHj
A1MBqgNTAaoDUwGqA1MBqgNTAacDPwFuIAADNQFVAx0B/wMiAf8DIgH/AxsB/wMiAf8DPgH/A28B
/wNUAf8DYAHzA2AB2wNgAfMDLwH/A0QB/wM1AVUYAAMVARwDNQFVAzUBVQM1AVUDNQFVAzUBVQM1
AVUDNQFVAUMCRAF3A1UBrwGKAc0B3QH/A0wBjgM1AVUDNQFVAzUBVQM1AVUDNQFVAzUBVQM1AVUD
NQFVAxUBHAwAAwQBBQMLAQ4DVQGvCP8B5gHxAekB/wHmAfEB6S3/A1YBqwMCAQMEAQwAAxUBHAM1
AVUDWQHGAy8B/wNFAf8DXgHdA14B3QMqAf8DJwH/AyYB/wMoAf8DOAH/Ay8B/wMOAf8DDgH/AxsB
/wM3Af8DKwH8A1MBpxQAAxUBHAM1AVUDNQFVA0wBjgNBAf8DOQH/Ay0B/wMbAf8DWQHGA1MBqgNV
AaoDVQGqA1YBtQNcAcsDYgHuA1QB/wMrAf8DTAGOAzUBVQM1AVUDFQEcLAADJAE0A0oBiQHBAr4B
/wM1AVUwAAMEAQUDCwEOA1UBrwj/AbQB1gG8Af8BtAHWAbwt/wNWAasDAgEDBAEMAAM1AVUDAAH/
AxsB/wMpAf8DKwH/AykB/wMpAf8DKwH/AysB/wMrAf8DKwH/AysB/wMrAf8DKwH/AyoB/wMqAf8D
KwH/AzQB/wNTAaoUAAM1AVUDAAH/A0MB/wNnAf8DbAH/A1YB/wMyAf8DAAH/AzUBVQwAAxgBIQM6
AWIDXwHLA6UB/wMoAf8DKwH/A0MB/wNxAf8DNQFVLAADJAE1A0sBigGkAqMB/wM1AVYEASgABAED
BgEIAw8BFANXAbEI/wF1AaUBdwH/ATwBjgFHAf8BVQG7AW4B/wHGAegBzyX/A1YBqwMCAQMEAQwA
AxUBHAM1AVUDWQHGA04B/wMxAf8DMAH/AzAB/wMxAf8DMQH/AzEB/wMxAf8DMQH/AzEB/wMxAf8D
MQH/AzAB/wMwAf8DIQH/A1MBqhQAAzUBVQMfAf8DOQH/A2QB/wOhAf8BKwF7AV4B/ANdAc4DQgF1
AxwBJwwAAwkBCwMYASEDLQFEA0wBjgNpAf8DRQH/AzsB/wNKAf8DWQHGA0ABcQQAAzQBUwNLAYsD
VQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1kBvANfAdgDfQH/A10BxwNVAaoDVQGqA1UBqgNV
AaoDVQGqA1UBqgNVAaoDVQGqAycBOQgAAwkBCwMYASEDKgFAA1oBvwHEAfgB1QH/AbcB9AHLAf8B
RAGnAVgB/wEKAY8BJQH/AQgBrgEyAf8BdAHPAYwB/wHGAeoB0CH/A1YBqwMCAQMEARQAA1UBqgNf
Af8DNwH/AzcB/wM3Af8DNgH/A14B/wNuAf8DZAH/A1wB/wNNAf8DNwH/AzcB/wM3Af8DNgH/AxcB
/wNTAaoMAAQCAwcBCQM5AV0DQwH/A1gB/wOBAf8DvgH/ASsBfgFpAfwBWwFeAVsBzQFBAUIBQQFz
AyMBMgMJAQwUAAMnATkDVQGqA2AB4wNHAf8DYQH/A1kBxgNAAXEEAANLAYsDZgHgA5wB/wF/An4B
/wF/An4B/wOcAf8BfgJ9Af8BfgJ9Af8DnAH/AX0CfAH/AX0CewH/AZwCmgH/AZwCmwH/AZwCmwH/
AZwCmQH/AZwCmQH/AYcBkgGOAf8BXAGFAXkB/wFdAXMBiwH/AXIBeQGVAf8BmgKWAf8DNQFVCAAD
FwEfAzMBUANNAZMBYAJkAdsBTwHpAYAB/wEoAd4BYwH/ASIB3QFeAf8BHQHbAVYB/wEYAdcBSgH/
AQgBsgE3Af8BVQHAAXMh/wNWAasDAgEDBAEUAANVAaoDWgH/Az0B/wM9Af8DPAH/AzkB/wOyAf8D
4QH/A8UB/wOsAf8DfwH/Az0B/wM9Af8DPQH/AzwB/wMWAf8DUwGqDAADBQEGAxQBGwNAAW4DagH/
A58B/wO9Af8DxAH/AVMB0gF3Af8BQAG1AUAB/QFNAWwBTQH6AUIBQwFCAXUDGQEiBAEYAANTAaoD
ZwH/A7QB/wM1AVUIAANVAaoDoAX/AagCpwH/AagCpwX/AaUCpAH/AaUCpAX/AaICoAH/AaICngL/
AvkC/wL8Av8C/AL/AvgC/wL2Af8BwAHhAdUB/wFBAboBlgH/AUQBhgHOAf8BgQGXAesB/wH5Au0B
/wM1AVUIAAMYASADMwFRA04BlAFgAmQB2wFUAesBgAH/AS8B4QFiAf8BKgHgAV4B/wEmAd8BWQH/
ASUB3gFVAf8BHwHRAU8B/wExAcsBXAH/AVsByQF+Af8ByAHtAdQZ/wNWAasDAgEDBAEIAANAAXED
UwGqA1UBqgNgAeMDTAH/A0QB/wNEAf8DSwH/A1kB/wNMAY4DNQFVAzUBVQM3AVoDTQGTA1oB/wNL
Af8DRAH/A0MB/wNAAf8DYAHjA1UBqgNPAZcDOQFeAw4BEgFGAUcBRgGAAV0BYQFdAc8BUwGkAWcB
/wFXAb8BcgH/AVcBzgF2Af8BUwHRAXMB/wEtAdUBWgH/A4AB/gFAAbUBQAH9AVsBXwFbAdADSQGH
AxoBJAMJAQwUAANTAaoDUAH/A3sB/wNZAcYDQAFxBAADVQGqA6YF/wHcAtsB/wHaAtgB/wH4AvYB
/wHVAtMB/wHUAtEB/wHzAu8B/wHQAssB/wHOAsgB/wHuAuYB/wH5AvYC/wL8Av8C+AL/AvYB/wHq
Ae4B6gH/Ab8B3wHTAf8BvgHMAeQB/wLRAe0B/wH5Au0B/wM1AVUIAAMYASADMwFSA04BlQNiAdwB
YQHxAYgB/wE9AekBbAH/ATkB6AFoAf8BNgHnAWYB/wE2AecBZgH/ATYB5wFmAf8BJwHTAVgB/wEJ
AasBPAH/Aa0B4wG+Gf8DVgGrAwIBAwQBCAADUwGqA1EB/wNnAf8DUgH/A0kB/wNLAf8DSgH/A00B
+gNeAe8DMwFQCAADBAEFAzcBWgNfAf8DUQH/A0sB/wNLAf8DVAH/A1sB/wNiAf8DXQHsA04BlwMS
ARcBVgFXAVYBsgE+AY4BVAH/AU0BxQFtAf8BOwHTAWMB/wEtAdsBWwH/ASMB3AFUAf8BIwHcAVQB
/wEkAd0BVQH/ASQB3gFWAf8DgAH+AVsBXwFbAdABQwFEAUMBdwMfASwDAwEEEAADUwGqAz0B/wNa
Af8DMAH/A1MBqgQAA1UEqgX/AfkC+AH/AfcC9QH/AfgC9gH/AfMC8QH/AfIC7wH/AfMC7wH/Ae8C
6wH/Ae0C6AH/Ae4C6AH/AfkC9wL/Av0C/wL6Av8C+QL/AvcB/wH+AvYB/wH8AvUB/wH7AvQB/wH7
AvMB/wM1AVUIAAMYASADMwFSA04BlQNiAdwBdAH7AZgB/wFUAfUBgAH/AU8B9AF9Af8BTQH0AXsB
/wFNAfQBewH/AU0B9AF7Af8BNgHZAWUB/wEJAaQBOQH/Aa0B4QG9Gf8DVgGrAwIBAwQBCAADVQGq
A1sB/wNSAf8DUgH/A1IB/wNSAf8DUQH/A1kB7wNbAdADLQFFDAADNQFVA0oB/wNPAf8DUgH/A1IB
/wNSAf8DUgH/A1IB/wMeAf8DUwGqAxEBFgNXAbEBYgGwAXgB/wFZAcwBegH/AUsB3AFzAf8BPwHl
AWwB/wE2AecBZgH/ATYB5wFmAf8BNgHnAWYB/wE2AecBZgH/ATYB5wFnAf8DgAH+ASEBXwEhAfsD
OgFgAwkBDBAAA1MBqgMuAf8DUgH/A08B/wNTAaoEAANVAaoDrk3/AzUBVQgAAxgBIAMzAVEDTgGU
A2QB2wGTAf4ByQH/AXkB/AG6Af8BdgH7AboB/wFtAfsBqgH/AV4B+wGLAf8BPgHaAW0B/wFZAdIB
fQH/Aa0B4QG9Af8B5AH1AekZ/wNWAasDAgEDBAEIAANVAaoDZwH/A28B/wNgAf8DWAH/A1kB/wNY
Af8DTQH6A1kB7wMzAVAMAAM1AVUDXwH/A1sB/wNZAf8DWQH/A1YB/wNgAf8DeAH/Ay8B/wNTAaoD
EQEWA1cBsQF/AckBlAH/AWsB1wGJAf8BXgHnAYQB/wFUAfEBfwH/AUsB8wF6Af8BSwHzAXoB/wFL
AfMBegH/AUsB8wF6Af8BLQHQAVwB/wFdAWMBXQHfA1EBngMoATsDBQEGEAADUwGqAzoB/wNRAf8D
kgH/A1UBqgQAA0sBiwNmAeADnAH/A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/
A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/A5wB/wOcAf8DnAH/AzUBVQgAAxABFQMnATkDPgFqA14B
zQHBAf8B6wH/AbIB/wHkAf8BeAHdAa0B/wFYAdcBjAH/AVEB7AGBAf8BYgHYAYcB/wGbAd4BsSH/
A1YBqwMCAQMEAQgAA0EBcQNVAaoDVQGqA2UB4wNiAf8DXwH/A18B/wNUAf8DPAH/A0wBjgMzAVAD
LgFGAzMBUANMAY4DaAH/A2IB/wNfAf8DXwH/A1MB/wNgAeMDVQGqA1MBqgNAAXEDEQEWA0wBkANi
AdwBaAJqAfkBQAG+AUAB/QE/AcoBYQH/ATkBxwFYAf8BUQHqAXoB/wFUAfMBgwH/AUUB5AF0Af8D
YgHhAVIBUwFSAaUDMQFMAxUBHAQCEAADUwGqA0sB/wNOAf8DXAHGA0EBcQQAA0sBiwNmAeADnAH/
AX8CfgH/AX8CfgH/A5wB/wF+An0B/wF+An0B/wOcAf8BfQJ8Af8BfQJ7Af8BnAKaAf8BnAKbAf8B
nAKbAf8BnAKZAf8BnAKZAf8BhwGSAY4B/wFcAYUBeQH/AV0BcwGLAf8BcgF5AZUB/wGaApYB/wM1
AVUIAAQBAwcBCQMSARcDVwGyCP8BVQGaAVcB/wENAYYBIQH/ASgBxQFeAf8BtwHsAckl/wNWAasD
AgEDBAEUAANVAaoDbwH/A2YB/wNmAf8DZgH/A2UB/wM/Af8DXgHwA10B0QNeAfADZQH/A2YB/wNm
Af8DZgH/A2UB/wNKAf8DUwGqDAADEgEXAzEETgGWA2IB7gFBAWoBQQH5AQABcQETAf8BAAFjAQAB
/wFGAcsBZQH/AVEB6AGBAf8BIgG6AVQB/wFSAVMBUgGlAzMBUQMDAQQEARQAA1UBqgNiAf8DRwH/
AzUBVQgAA1UBqgOgBf8BqAKnAf8BqAKnBf8BpQKkAf8BpQKkBf8BogKgAf8BogKeAv8C+QL/AvwC
/wL8Av8C+AL/AvYB/wHAAeEB1QH/AUEBugGWAf8BRAGGAc4B/wGBAZcB6wH/AfkC7QH/AzUBVQwA
AwUBBgMNAREDVgGwCP8BbQG1AYAB/wFWAa4BbgH/AbcB7AHJAf8B5wH5Ae0l/wNWAasDAgEDBAEU
AANVAaoDYgH/A20B/wNtAf8DbQH/A2wB/wNgAf8DTQH6A14B8ANqAfoDbAH/A20B/wNtAf8DbQH/
A2wB/wNfAdUDRgGADAADBgEIAyABLgNGAX4BVQFqAWgB+QNAAf0BYQGHAWcB/wGMAa0BjAH/AVkB
zAF8Af8BXgJlAeIBUgFUAVIBqAM0AVQDFgEdBAEQAAMmATkDUwGqA2AB4wNrAf8DYgH/A1kBxgNA
AXEEAANVAaoDpgX/AdwC2wH/AdoC2AH/AfgC9gH/AdUC0wH/AdQC0QH/AfMC7wH/AdACywH/Ac4C
yAH/Ae4C5gH/AfkC9gL/AvwC/wL4Av8C9gH/AeoB7gHqAf8BvwHfAdMB/wG+AcwB5AH/AtEB7QH/
AfkC7QH/AzUBVQwAAwQBBQMLAQ4DVQGvCP8BpgHXAbgB/wGmAdcBuC3/A1YBqwMCAQMEAQwAAxUB
HAM1AVUDWQHGA2QB/wNyAf8DcgH/A3IB/wNyAf8DcgH/A3IB/wNyAf8DcgH/A3IB/wNyAf8DcgH/
A3IB/wNyAf8DYwHVA0cBgBAAAw8BFAM+AWkDfQH/A3MB/wOGAf8DtwH/AXYBvAGOAf8BWQJcAcYD
NAFUAxYBHgQCEAADJgE5A0wBjgMzAf8DZQH/A3oB/wNxAf8DWQHGA0ABcQQAA1UEqgX/AfkC+AH/
AfcC9QH/AfgC9gH/AfMC8QH/AfIC7wH/AfMC7wH/Ae8C6wH/Ae0C6AH/Ae4C6AH/AfkC9wL/Av0C
/wL6Av8C+QL/AvcB/wH+AvYB/wH8AvUB/wH7AvQB/wH7AvMB/wM1AVUMAAMEAQUDCwEOA1UBrzz/
A1YBqwMCAQMEAQwAAzUBVQMmAf8DXAH/A3cB/wN2Af8DdgH/A3YB/wN2Af8DdgH/A3YB/wN2Af8D
dgH/A3YB/wN2Af8DdgH/A3YB/wN2Af8DbwH/A1UBqhQAAzUBVQOcAf8DeQH/A28B/wOAAf8BnAGd
AZwB/wNVAawDBAEFBAIUAANTAaoDNgH/A3QB/wOPAf8DjwH/A3QB/wM1AVUIAANVAaoDrk3/AzUB
VQwAAwQBBQMLAQ4DVQGvPP8DVgGrAwIBAwQBDAADFQEcAzUBVQNcAcYDngH/A3sB/wOHAf8DnAH/
A7gB/wOPAf8DewH/A3sB/wN6Af8DlAH/A8kB/wO/Af8DpAH/A3cB/wNtAf8DVQGqFAADFQEcAzUB
VQM1AVUDTAGOA1EB/wN4Af8DZQHjA1UBrANWAasDUwGqA1MBqgNTAaoDVQGqA1UBqgNgAeMDZgH/
A3wB/wNMAY4DPAFkA0gBgwMfASwIAAMnATkDRAF7A1wBxgNlAewB7gLsAf8B8ALvAf8B7wLtAf8B
7gLrAf8B7ALoAf8B6wLnAf8B6QLlAf8B5gLjAf8B5gLiAf8B5QLgAf8B4wLeAf8B4gLdAf8B4QLc
Af8B4QLaAf8BzALIAf8DXwHQA0IBcgMbASYMAAMEAQUDCwEOA1UBrzz/A1YBqwMCAQMEARQAA0EB
cQNcAcYDgAH+A1wBxgNVAaoDVQGqA2UB4wN/Af8DgAH/A3wB/wNlAeMDVQGqA1UBqgNcAcYDXQH/
A1wBxgNBAXEgAAM1AVUDbwH/A3kB/wOIAf8DnAH/A38B/wNmAf8DTwH/A1UB/wNtAf8DmAH/A4YB
/wN+Af8DfwH/AzwBZgMYBCABLgMMAQ8MAAMbASYDQQFxA08BlwNVAaoDVQGqA1UBqgNVAaoDVQGq
A1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNEAXsDFgEdAwgBCgwAAwQB
BQMLAQ4DVQGvPP8DVgGrBAIEARgAAzQBVANAAf0DNAFUCAADVQGqA4QB/wOFAf8DfAH/A1UBqggA
AzUBVQMoAf8DNQFVJAADNQFVA9oB/wOeAf8DnQH/A9cB/wO5Af8DnAH/A4EB/wN8Af8DlgH/A80B
/wOYAf8DfgH/A34B/wNJAYgDIwEzdAAEAgMEAQUDVQGsAsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/
AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYBxAH/AsYB
xAH/AsYBxAH/A1UBqgQBHAADFQEcAzQBVAMVARwIAANVAaoD1QH/A9QB/wOOAf8DVQGqCAADFQEc
AzUBVQMVARwkAAMVARwDNQFVA1kBxgNZAcYDNQFVA1wBxgNiAf8DegH/A4MB/wNcAcYDNQFVA1wB
xgNcAcYDNQFVAyABLQMNARF8AANBAXEDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNV
AaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDQQFxNAADQQFxA1UBqgNVAaoDVQGqA0EBcUAAA0AB
cQNAAXEEAANAAXEDUwGqA1UBqgNVAaoDQQFxBAADQAFxA0ABcf8A/wBiAFABEAADBgEIAxIBFwMW
AR4DFgEeAxYBHgMWAR4DFgEeAxYBHgMWAR4DFgEeAxYBHgMWAR4DFgEeAxYBHgMWAR4DFgEeAxYB
HgMRARYDBgEHHAADBgEIAwoBDQMMARADDAEQAwwBEAMMARADDAEQAwwBEAMMARADDAEQAwwBEAMM
ARADDAEQAwwBEAMMARADDAEPAwgBCgQBaAAEAQMGAQgDDwETAxIBGAMSARgDEgEYAxIBGAMSARgD
EgEYAxIBGAMSARgDEgEYAxIBGAMSARgDEgEYAxIBGAMSARgDEgEYAxIBGAMSARgDEgEYAxEBFgMJ
AQwDAgEDBAADQQFwAU8BfwGzAf8BTQF8AbAB/wFMAXoBrgH/AUsBeAGsAf8BSgF3AasB/wFJAXYB
qgH/AUkBdgGqAf8BSQF2AaoB/wFJAXYBqgH/AUkBdgGqAf8BSQF2AaoB/wFJAXYBqgH/AUkBdgGq
Af8BSQF2AaoB/wFJAXYBqgH/AUkBdgGqAf8BSQF2AaoB/wFJAXYBqgH/AxIBFwQBEAAEAgMEAQUD
KwFCAzsBYgM8AWUDPAFlAzwBZQM8AWUDPAFlAzwBZQM8AWUDPAFlAzwBZQM8AWUDPAFlAzwBZQM8
AWUDPAFkAywBQwQCBAFkAANTAacBKwFxAX4B/AEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB/wEHAXEB
mAH/AQcBcQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcBcQGY
Af8BBwFxAZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB
/wEHAXEBmAH/AQcBcQGYAf8BXQJfAckDIQEvBAIBWwGNAb8B/wFTAYUBuwH/AVwBzgHwAf8BWgHN
AfAB/wFYAcwB7wH/AVYBzAHvAf8BVAHLAe8B/wFSAcoB7wH/AVEByQHuAf8BTwHJAe4B/wFNAcgB
7gH/AUwByAHuAf8BSwHHAe4B/wFJAccB7QH/AUgBxgHtAf8BRwHGAe0B/wFHAcYB7QH/AUcBxgHt
Af8BRwGxAdwB/wFJAXYBqgH/BAEQAAMEAQUDCwEOA1UBrwH6Af8B9gH/AfUB/wHxAf8B8wH/Ae4B
/wHxAf8B7AH/Ae8B/wHqAf8B7gH/AegB/wHrAf8B5gH/AegB/wHjAf8B5wH/AeEB/wHlAf8B3wH/
AeMB/wHdAf8B4gH/AdsB/wHgAf8B2QH/Ad4B/wHXAf8B8gH/Ae4B/wNWAasDAgEDBAFkAAERAXgB
ngH/AdIB8gH+Af8BxgHvAf4B/wHGAe8B/gH/AcYB7wH+Af8BxgHvAf4B/wHGAe8B/gH/AcYB7wH+
Af8BxgHvAf4B/wHGAe8B/gH/AcYB7wH+Af8BxgHvAf4B/wHGAe8B/gH/AcYB7wH+Af8BxgHvAf4B
/wHGAe8B/gH/AcYB7wH+Af8BxgHvAf4B/wHGAe8B/gH/AcYB7wH+Af8BxgHvAf4B/wHHAe8B/gH/
An4BkQH8AzgBWwMCAQMBWQGLAbwB/wFbAZIBxgH/AaEB7QH2Af8BYAHPAfAB/wFeAc8B8AH/AVsB
zgHwAf8BWgHNAfAB/wFYAcwB7wH/AVYBywHvAf8BVAHLAe8B/wFSAcoB7wH/AVAByQHuAf8BTwHJ
Ae4B/wFNAcgB7gH/AUwByAHuAf8BSgHHAe4B/wFJAccB7QH/AUgBxgHtAf8BRwHEAewB/wFJAXkB
rAH/BAEQAAMEAQUDCwEOA1UBrwH4Af8B8wH/AfIB/wHtAf8B8AH/AesB/wHuAf8B6AH/AewB/wHm
Af8B6QH/AeQB/wHnAf8B4QH/AeUB/wHeAf8B4gH/AdsB/wHfAf8B2QH/Ad0B/wHWAf8B2wH/AdQB
/wHaAf8B0gH/AdgB/wHQAf8B8QH/AewB/wNWAasDAgEDBAFkAAEVAXwBogH/AcEB7QH+Af8BkwHg
AfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB
/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8
Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGWAeEB/AH/AZMByQHdAf8DOQFfBAEB
XQGQAcMB/wF2AcEB1gH/AX4BvQHfAf8BZgHSAfEB/wFkAdEB8QH/AWIB0AHxAf8BYAHQAfEB/wFe
Ac8B8AH/AVwBzgHwAf8BWgHNAfAB/wFYAcwB7wH/AVYBzAHvAf8BVAHLAe8B/wFSAcoB7wH/AVEB
ygHuAf8BTwHJAe4B/wFNAcgB7gH/AUwByAHuAf8BSgHHAe4B/wFIAa0B2AH/A0IBchAAAwQBBQML
AQ4DVQGvAfkB/wHzAf8B8gH/AewB/wHwAf8B6gH/Ae4B/wHoAf8B6wH/AeUB/wHpAf8B4wH/AeYB
/wHgAf8B5AH/Ad0B/wHhAf8B2gH/Ad4B/wHXAf8B2wH/AdQB/wHZAf8B0gH/AdcB/wHQAf8B1gH/
Ac4B/wHxAf8B7AH/A1YBqwMCAQMEAWQAARkBgAGmAf8BuQHqAf0B/wGAAdkB+gH/AYAB2QH6Af8B
gAHZAfoB/wGAAdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGA
AdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB
2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYMB2gH6Af8BkgHKAd4B/wM5AV8EAAFhAZYBygH/AX4BygHf
Af8BYAGbAdQB/wGLAeIB9AH/AWoB1AHyAf8BaAHTAfIB/wFmAdIB8QH/AWQB0QHxAf8BYgHQAfEB
/wFgAdAB8QH/AV0BzwHwAf8BWwHOAfAB/wFaAc0B8AH/AVcBzAHvAf8BVgHMAe8B/wFUAcsB7wH/
AVIBygHvAf8BUAHJAe4B/wFPAckB7gH/AUwBvQHmAf8BSQF2AaoB/xAAAwQBBQMLAQ4DVQGvAfsB
/wH2Af8B9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B7gH/AegB/wHrAf8B5QH/AekB/wHjAf8B5gH/
AeAB/wHkAf8B3QH/AeEB/wHaAf8B3gH/AdcB/wHbAf8B1AH/AdkB/wHSAf8B1wH/AdAB/wHyAf8B
7QH/A1YBqwMCAQMEAWQAAR0BhAGqAf8BsAHnAfwB/wFsAdIB+AH/AWwB0gH4Af8BbAHSAfgB/wFs
AdIB+AH/AWwB0gH4Af8BbAHSAfgB/wFsAdIB+AH/AWwB0gH4Af8BbAHSAfgB/wFsAdIB+AH/AWwB
0gH4Af8BbAHSAfgB/wFsAdIB+AH/AWwB0gH4Af8BbAHSAfgB/wFsAdIB+AH/AWwB0gH4Af8BbAHS
AfgB/wFsAdIB+AH/AW8B0wH5Af8BkQHKAd8B/wM5AV8EAAFjAZsB0QH/AYcB0wHnAf8BbQGyAdUB
/wGpAe8B9gH/AXAB1gHzAf8BbQHVAfIB/wFsAdQB8gH/AWoB0wHyAf8BZwHTAfIB/wFmAdIB8QH/
AWMB0QHxAf8BYQHQAfEB/wFfAc8B8AH/AV0BzwHwAf8BWwHOAfAB/wFZAc0B8AH/AVcBzAHvAf8B
VQHLAe8B/wFTAcsB7wH/AVIBygHvAf8BTAGUAcQB/wMEAQUMAAMEAQUDCwEOA1UBrwH8Af8B9wH/
AfcB/wHxAf8B9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B7gH/AegB/wHrAf8B5QH/AekB/wHjAf8B
5gH/AeAB/wHkAf8B3QH/AeEB/wHaAf8B3gH/AdcB/wHbAf8B1AH/AdkB/wHSAf8B8gH/Ae4B/wNW
AasDAgEDBAFkAAEgAYgBrwH/AagB5AH7Af8BWgHMAfYB/wFaAcwB9gH/AVoBzAH2Af8BWgHMAfYB
/wFaAcwB9gH/AVoBzAH2Af8BWgHMAfYB/wFaAcwB9gH/AVoBzAH2Af8BWgHMAfYB/wFaAcwB9gH/
AVoBzAH2Af8BWgHMAfYB/wFaAcwB9gH/AVoBzAH2Af8BWgHMAfYB/wFaAcwB9gH/AVoBzAH2Af8B
WgHMAfYB/wFeAc0B9wH/AZABywHhAf8DOQFfBAABZQGeAdUB/wGOAdwB7wH/AXwBxgHbAf8BYwGf
AdgB/wF7AdsB9AH/AXQB1wHzAf8BcgHXAfMB/wFwAdYB8wH/AW4B1QHzAf8BbAHUAfIB/wFqAdQB
8gH/AWgB0wHyAf8BZgHSAfEB/wFkAdEB8QH/AWIB0AHxAf8BXwHPAfAB/wFdAc8B8AH/AVwBzgHw
Af8BWQHNAfAB/wFYAcwB7wH/AU8BsQHbAf8BXgJqAe0MAAMEAQUDCwEOA1UBrwH9Af8B+QH/AfkB
/wHzAf8B9wH/AfEB/wH1Af8B7wH/AfIB/wHsAf8B8AH/AeoB/wHuAf8B6AH/AesB/wHlAf8B6QH/
AeMB/wHmAf8B4AH/AeQB/wHdAf8B4QH/AdoB/wHeAf8B1wH/AdsB/wHUAf8B8wH/Ae8B/wNWAasD
AgEDBAFkAAElAY0BswH/AaIB4wH7Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFO
AcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4B
yAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHI
AfYB/wFSAckB9gH/AZEBzAHiAf8DOQFfBAABZQGeAdUB/wGVAeIB9gH/AYUBzwHkAf8BZAGhAdcB
/wGpAfAB9wH/AXgB2QH0Af8BdwHZAfQB/wF1AdgB8wH/AXMB1wHzAf8BcQHXAfMB/wFvAdYB8wH/
AW4B1QHyAf8BbAHUAfIB/wFpAdMB8gH/AWgB0wHyAf8BZgHSAfEB/wFjAdEB8QH/AWEB0AHxAf8B
XwHPAfAB/wFdAc4B8AH/AVsBzgHwAf8BVAGIAb4B/wwAAwQBBQMLAQ4DVQGvAf4B/wH7Af8B+wH/
AfUB/wH5Af8B8wH/AfcB/wHxAf8B9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B7gH/AegB/wHrAf8B
5QH/AekB/wHjAf8B5gH/AeAB/wHkAf8B3QH/AeEB/wHaAf8B3gH/AdcB/wH0Af8B8QH/A1YBqwMC
AQMEAWQAASkBkQG4Af8BrgHoAf4B/wFpAdQB/AH/AWkB1AH8Af8BaQHUAfwB/wFpAdQB/AH/AWkB
1AH8Af8BaQHUAfwB/wFpAdQB/AH/AWkB1AH8Af8BaQHUAfwB/wFpAdQB/AH/AWkB1AH8Af8BaQHU
AfwB/wFpAdQB/AH/AWkB1AH8Af8BaQHUAfwB/wFpAdQB/AH/AWkB1AH8Af8BaQHUAfwB/wFpAdQB
/AH/AWsB1QH8Af8BlAHPAeUB/wM5AV8EAAFlAZ4B1QH/AZsB5gH5Af8BjgHZAe4B/wGBAcYB2gH/
AX0BvAHjAf8BfAHbAfQB/wF7AdoB9AH/AXoB2gH0Af8BeAHZAfQB/wF2AdkB9AH/AXUB2AHzAf8B
cwHXAfMB/wFxAdYB8wH/AW8B1gHzAf8BbQHVAfIB/wFrAdQB8gH/AWkB0wHyAf8BZwHSAfIB/wFl
AdIB8QH/AWMB0QHxAf8BYQHQAfEB/wFTAa8B2gH/A0IBcwgAAwQBBQMLAQ4DVQGvAf4B/wH8Af8B
/QH/AfcB/wH7Af8B9QH/AfkB/wHzAf8B9wH/AfEB/wH1Af8B7wH/AfIB/wHsAf8B8AH/AeoB/wHu
Af8B6AH/AesB/wHlAf8B6QH/AeMB/wHmAf8B4AH/AeQB/wHdAf8B4QH/AdoB/wH1Af8B8wH/A1YB
qwMCAQMEAWQAASwBlQG8Af8BtwHrAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHc
Av8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8B
fgHcAv8BfgHcAv8BfgHcAv8BfgHcAv8BgAHdAv8BmAHRAeYB/wM5AV8EAAFlAZ4B1QH/AaAB6QH7
Af8BlgHgAfUB/wGKAc8B4gH/AWIBngHXAf8BnAHqAfcB/wF/AdwB9QH/AX4B2wH1Af8BfQHbAfUB
/wF7AdoB9AH/AXoB2gH0Af8BeAHZAfQB/wF3AdkB9AH/AXUB2AHzAf8BcwHXAfMB/wFxAdcB8wH/
AW8B1gHzAf8BbgHVAfIB/wFrAdQB8gH/AWkB0wHyAf8BaAHTAfIB/wFfAcUB6AH/AV0BlgHOAf8I
AAMEAQUDCwEOA1UBrwL/Af0B/wH+Af8B+QH/Af0B/wH3Af8B+wH/AfUB/wH5Af8B8wH/AfcB/wHx
Af8B9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B7gH/AegB/wHrAf8B5QH/AekB/wHjAf8B5gH/AeAB
/wHkAf8B3QH/AfYB/wH0Af8DVgGrAwIBAwQBCAADSQGGA0sBigMxAUwDSwGKA0sBigMxAUwDSwGK
A0sBigMxAUwDSwGKA0sBigMxAUwDSwGKA0sBigMxAUwDSwGKA0sBigMxAUwDSwGKA0sBigMxAUwD
UQGcAyEBLwEwAZkBvwH/AbsB7AL/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+Af8BhgHd
Af4B/wGGAd0B/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B
/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+
Af8BiAHeAf4B/wGbAdIB6AH/AzkBXwQAAWUBngHVAf8BowHqAfwB/wGdAeYB+gH/AZMB2AHsAf8B
ewG6AdgB/wGwAfQB+AH/AYAB3AH1Af8BgAHcAfUB/wGAAdwB9QH/AX8B3AH1Af8BfQHbAfUB/wF8
AdsB9QH/AXsB2gH0Af8BeQHaAfQB/wF4AdkB9AH/AXYB2QH0Af8BdQHYAfMB/wFzAdcB8wH/AXEB
1gHzAf8BbwHWAfMB/wFtAdUB8gH/AWsB1AHyAf8BXQGmAdgB/wgAAwQBBQMLAQ4DVQGvAv8B/gP/
AfsB/wH+Af8B+QH/Af0B/wH3Af8B+wH/AfUB/wH5Af8B8wH/AfcB/wHxAf8B9QH/Ae8B/wHyAf8B
7AH/AfAB/wHqAf8B7gH/AegB/wHrAf8B5QH/AekB/wHjAf8B5gH/AeAB/wH3Af8B9QH/A1YBqwMC
AQMEAWQAATMBmwHDAf8BvwHtAf4B/wGOAd8B/QH/AY4B3wH9Af8BjgHfAf0B/wGOAd8B/QH/AY4B
3wH9Af8BjgHfAf0B/wGOAd8B/QH/AY4B3wH9Af8BjgHfAf0B/wGOAd8B/QH/AY4B3wH9Af8BjgHf
Af0B/wGOAd8B/QH/AY4B3wH9Af8BjgHfAf0B/wGOAd8B/QH/AY4B3wH9Af8BjgHfAf0B/wGOAd8B
/QH/AZAB3wH9Af8BnAHTAekB/wM5AV8EAAFlAZ4B1QH/AacB7AH9Af8BogHpAf0B/wGcAeIB9QH/
AZEB0gHkAf8BYgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8B
YgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFi
AZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8IAAMEAQUDCwEOA1UBrwL/Af4D
/wH7A/8B+gH/Af4B/wH5Af8B/QH/AfcB/wH7Af8B9QH/AfkB/wHzAf8B9wH/AfEB/wH1Af8B7wH/
AfIB/wHsAf8B8AH/AeoB/wHuAf8B6AH/AesB/wHlAf8B6QH/AeMB/wH4Af8B9gH/A1YBqwMCAQME
AWQAATQBnQHEAf8BwwHuAf0B/wGYAeEB+wH/AZgB4QH7Af8BmAHhAfsB/wGYAeEB+wH/AZgB4QH7
Af8BmAHhAfsB/wGYAeEB+wH/AZgB4QH7Af8BmAHhAfsB/wGYAeEB+wH/AZgB4QH7Af8BmAHhAfsB
/wGYAeEB+wH/AZgB4QH7Af8BmAHhAfsB/wGYAeEB+wH/AZgB4QH7Af8BmAHhAfsB/wGYAeEB+wH/
AZoB4QH7Af8BngHUAekB/wM5AV8EAAFlAZ4B1QH/AaoB7QH9Af8BpgHrAf4B/wGjAegB+wH/AZ8B
4wH1Af8BmgHeAfEB/wGZAd0B8QH/AZgB3QHwAf8BlgHcAfAB/wGVAdwB8AH/AZQB2wHvAf8BkgHb
Ae8B/wGRAdoB7wH/AY8B2gHuAf8BjwHZAe4B/wGNAdgB7gH/AYwB2AHtAf8BigHXAe0B/wFPAXcB
pAH/AxUBHQMJAQsDAwEEDAADBAEFAwsBDgNVAa8C/wH+A/8B+wP/AfsD/wH6Af8B/gH/AfkB/wH9
Af8B9wH/AfsB/wH1Af8B+QH/AfMB/wH3Af8B8QH/AfUB/wHvAf8B8gH/AewB/wHwAf8B6gH/Ae4B
/wHoAf8B6wH/AeUB/wH4Af8B9gH/A1YBqwMCAQMEAWQAATQBnQHEAf8BxwHuAf0B/wGiAeIB+gH/
AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8B
ogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB/wGi
AeIB+gH/AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaQB4wH6Af8BnwHUAekB/wM5AV8EAAFlAZ4B
1QH/AawB7gH9Af8BqAHsAf4B/wGoAewB/gH/AaYB6wH+Af8BpAHqAf0B/wGjAekB/AH/AaIB6QH8
Af8BoQHoAfwB/wGgAegB/AH/AZ4B5wH7Af8BnQHnAfsB/wGcAeYB+wH/AZoB5QH6Af8BmQHlAfoB
/wGYAeQB+gH/AZYB4wH6Af8BlAHjAfkB/wFUAX8BrgH/AwYBCBQAAwQBBQMLAQ4DVQGvAv8B/gP/
AfsD/wH7A/8B+wP/AfsB/wH+Af8B+QH/Af0B/wH3Af8B+wH/AfUB/wH5Af8B8wH/AfcB/wHxAf8B
9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B7gH/AegB/wH5Af8B9wH/A1YBqwMCAQMEAWQAAVsBgAGD
Af4BogHWAeoB/wGiAdYB6gH/AaIB1gHqAf8BogHWAeoB/wGiAdYB6gH/AaIB1gHqAf8BogHWAeoB
/wGiAdYB6gH/AaIB1gHqAf8BogHWAeoB/wGiAdYB6gH/AaIB1gHqAf8BogHWAeoB/wGiAdYB6gH/
AaIB1gHqAf8BogHWAeoB/wGiAdYB6gH/AaIB1gHqAf8BogHWAeoB/wGiAdYB6gH/AaIB1gHqAf8B
YQK+Af0DOQFeBAABZQGeAdUB/wGuAe8B/gH/AasB7QL/AaoB7QL/AakB7AH+Af8BqAHsAf4B/wGn
AewB/gH/AaYB6wH+Af8BpQHrAf4B/wGiAegB/AH/AWMBmwHQAf8BYgGYAc0B/wFgAZUBygH/AV8B
kwHHAf8BXQGPAcIB/wFbAYwBvgH/AVkBiQG7Af8BVwGFAbYB/wFcAmUB5wQBFAADBAEFAwsBDgNV
Aa8C/wH+A/8B+wP/AfsD/wH7A/8B+wP/AfoB/wH+Af8B+QH/Af0B/wH3Af8B+wH/AfUB/wH5Af8B
8wH/AfcB/wHxAf8B9QH/Ae8B/wHyAf8B7AH/AfAB/wHqAf8B+gH/AfgB/wNWAasDAgEDBAFkAAFh
AYABfwH7AbAB0AHYAf8BsgHMAc8B/wGyAcwBzwH/AbIBzAHPAf8BsgHMAc8B/wGyAcwBzwH/AbIB
zAHPAf8BsgHMAc8B/wGyAcwBzwH/AbIBzAHPAf8BsgHMAc8B/wGyAcwBzwH/AbIBzAHPAf8BsgHM
Ac8B/wGyAcwBzwH/AbIBzAHPAf8BsgHMAc8B/wGyAcwBzwH/AbIBzAHPAf8BsgHMAc8B/wGyAcwB
zwH/AYIBiAGLAfsDNgFZBAABZQGeAdUB/wG5AfcB+wH/AawB7gL/AawB7gL/AawB7QL/AasB7QL/
AaoB7QL/AakB7AH+Af8BqQHsAf4B/wF6AbgB4wH/AxsBJgQBHAADBQEGAw8BEwMRARYDDQERCAAD
BAEFAwsBDgNVAa8C/wH+A/8B+wP/AfsD/wH7A/8B+wP/AfsD/wH6Af8B/gH/AfkB/wH9Af8B9wH/
AfsB/wH1Af8B+QH/AfQB/wH5Af8B9AH/AfcB/wHzAf8B9gH/AfIB/wH8Af8B+wH/A1YBqwQCBAFk
AAGEAYABaQH7AfwB9AHtAf8B/QHwAeQB/wH9AfEB5gH/Af0B8gHmAf8B/QHyAecB/wH9AfIB5wH/
Af0B8wHnAf8B/QHzAecB/wH9AfMB5wH/Af0B7wHhAf8B/QHyAekB/wH9AfYB8AH/Af0B9gHwAf8B
/QH2AfAB/wH9AfYB8AH/Af0B9gHwAf8B/QH2AfAB/wH9AfYB8AH/Af0B9gHwAf8B/QH2AfAB/wH9
AfYB8AH/AYcBhQGEAfkDMwFSCAABawGlAdgB/wG4AfYB+wH/AbgB9gH7Af8BuAH2AfsB/wG4AfYB
+wH/AbgB9gH7Af8BuAH2AfsB/wG2AfQB/AH/AVwCfAH4BAEcAAEIAZkBPgH/ASABwwFIAf8BIAHC
AUcB/wEgAcIBRwH/AV0BYgFdAdwIAAMEAQUDCwEOA1UBrwL/Af4D/wH7A/8B+wP/AfsD/wH7A/8B
+wP/AfsD/wH7Af8B/gH/AfkB/wH9Af8B+AH/AfsB/wH3Af8B/gH/AfwN/wNVAaoEAWgAA30B+gH9
AfcB8AL/Ad0BwgL/AdEBqgL/AdQBqwL/AdcBrAL/AdoBrgL/Ad4BsAL/AeABsQL/AeMBtwH/Af0B
8wHpAf8DfQH6A1cBsgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNVAaoDVQGqA1UBqgNMAY8DGAEg
UAABXgFlAV4B4gEmAc0BSgH/ASYBzgFKAf8BUQFvAVEB9wgAAwQBBQMLAQ4DVQGvAv8B/gP/AfsD
/wH7A/8B+wP/AfsD/wH7A/8B+wP/AfsD/wH6Af8B/gH/AfkB/wH9Af8B+AH/Af0B/wH5Af8B/QH/
AfsF/wNWAbADOAFbbAADYQHUAfAB6gHjAv8B8gHmAv8B7wHgAv8B7wHgAv8B8AHhAv8B8QHhAv8B
8wHhAv8B8wHiAv8B9QHnAf8B6gHiAdoB/wNWAasDBgEIaAAEAQMCAQMEAgQBBAIBWgFrAVoB8gEm
Ac4BSgH/ASYBzgFKAf8BSAFjAUgB9ggAAwQBBQMLAQ4DVQGvAv8B/gP/AfsD/wH7A/8B+wP/AfsD
/wH7A/8B+wP/AfsD/wH7A/8B+wH/Af4B/wH6Af8B/QH/AfoB/wNsAesDXAHEAzwBZAMZASJsAAMd
ASgDYwHfAbIBpAGXAf8BswGlAZgB/wGzAaUBmAH/AbMBpQGYAf8BswGlAZgB/wGzAaUBmAH/AbMB
pQGYAf8BswGlAZgB/wNdAcoDHQEoaAAEAgENAbgBTAH/A14B0gMIBAoBDQEEAaQBQAH/AUAB3QFo
Af8BBwGcAT8B/wEIAZkBPgH/AVYBbgFaAfUIAAMEAQUDCwEOA1UBrwL/Af4D/wH7A/8B+wP/AfsD
/wH7A/8B+wP/AfsD/wH7A/8B+wP/AfsD/wH7A/8B/gH/A1wBxAMxAU4DEwEadAAEAgMGAQgDBwEJ
AwcBCQMHAQkDBwEJAwcBCQMHAQkDBwEJBAF1AAGwAUIB/wEyAc8BaAH/AUMB2wF1Af8BEQGzAU0B
/wFRAVIBUQGkFAAEAgMEAQUDUgGgA2IB7gNiAe4DYgHuA2IB7gNiAe4DYgHuA2IB7gNiAe4DYgHu
A2IB7gNiAe4DVgGrAzwBZAMTARoDBwEJ/wBBAAM8AWYDTwGZA08BmQNPAZkDTwGZA08BmQNPAZkD
TwGZA08BmQNPAZkDTwGZA08BmQM1AVYDGgEj/wCZAAFCAU0BPgcAAT4DAAEoAwABYAMAAZADAAEB
AQABAQUAAcABBhYAA///ACIAAf8B/gEBAfgBAAE/AfABAAEBAYACAAHgAQABAQHgAQABBwHwAgAB
gAQAAQEBwAEAAQcB4AIAAYACAAHAAgABgAEAAQEBwAIAAYACAAHAAgABgAEAAQEBgAIAAYACAAHA
AgABgAEAAQEBgAIAAYACAAHABQABgAIAAYACAAHACAABgAIAAcABAAEBBgABgAEAAf8BwAEAAQMG
AAGAAQAB/wHAAQABDwYAAYABAAH/AcABAAEPBgABgAEAAf8BwAEAAQ8GAAGAAQAB/wHAAQABDwYA
AYABAAHfAcABAAEPBgABgAEAAYcBwAEAAQ8GAAGAAQABAwHgAQABDwYAAYABfgEBAeABAAEPAwAB
gAIAAYABfAEBAeABAAEPAwABgAEAAQEBgAF8AQEB4AEAAQ8BgAEAAQEBgAEAAQMBgAF+AQMB4AEA
AQ8BgAEAAQEB4AEAAQcBgAF/AQcB4AEAAT8BgAEAAQEB8AEAAQ8BgAF/AY8D/wHAAQABBwHwAQAB
HwGAAX8BzwP/AfgBAAE/Af4BAAX/AfwBAQH/AfABfwHAARwBAQH/Af4BAQGAAgAB/wHgAT8BgAEI
AQAB4AEAAQEBgAIAAf8B4AE/AYABCAMAAQEBgAIAAf8BwAEPAYABCAEAAcACAAGAAgAB/wEAAQcB
gAEIAQABwAIAAYACAAH/AQABBwGAAQgBAAHAAgABgAIAAf4BAAEBAYABCAEAAcACAAGAAgAB+AEA
AQEBgAEIAQABwAIAAYACAAH4AgABgAEYAQEBwAEAAQEBgAEAAQEB8AEAAQEBgAEYAQEBwAEAAQMB
wAEAAQcBwAEAAQEB+AEAAQ8BwAEAAQ8B8AEAAQ8BwAEAAQMB+AEAAQ8BwAEAAQ8B8AEAAQcBwAEA
AQcB+AEAAQ8BwAEAAQ8B+AEAAQMBwAEAAQ8B/gEAAT8BwAEAAQ8B/wHAAQEBgAEAAR8B/gEAAT8B
wAEAAQ8B/wHAAQEBgAEAAT8B/gEAAT8BwAEAAQ8B/wHAAQEBgAEAAX8B/gEAAT8B4AEAAQ8B/wHA
AQEBgAEAAf8B/gEAAT8B4AEAAQ8B/wHAAQEBwAEBAf8B/gEAAT8B4AEAAQ8B/wHgAQMBwAEDAf8B
/gEAAT8B4AEAAQ8B/wH4AQcBwAEHAf8B/gEAAT8B4AEAAQ8B/wH4AQ8BwAEPAf8B/gEAAT8B4AEA
AT8B/wH8AT8V/wHAAQABAQHwAQABAQHwAQABAQH4AR8B/wHAAQABAQHwAgAB8AIAAfABHwH/AcAB
AAEBAf4CAAH+AgAB8AEPAf8BwAEAAQEB8AIAAfACAAHAAQ8C/wHAAf8BwAIAAcACAAHAAQMC/wHA
AX8BwAIAAcACAAHAAQMB/wGAAQABAQHAAgABwAIAAYABAQH/AYABAAEBAYACAAGAAgABgAEBAf8B
gAEAAQEBgAIAAYACAAHAAQEB/wGAAQABAQGAAQABAQGAAQABAQHAAQABPwGAAQABAQGAAgABgAIA
AfABAAEPAYABAAEBAYABGAEAAYABGAEAAfgBAAEPAYABAAEBAYABCAEAAYABCAEAAfgBAAEHAYAB
AAEBAYABAAEBAYABAAEBAf4BAAEBAYABAAEBAYABAAEBAYABAAEBAf8BwAEBAYABAAEBAYABAAEB
AYABAAEBAf8BwAEAAYABAAEBAcABAAEBAcABAAEBAf8BwAEAAYABAAEBAcABAAEHAcABAAEHAf8B
4AEBAYABAAEBAcABAAEHAcABAAEHAf8B4AEBAcABAAEBAfABAAEHAfABAAEHAf8B+AEDA/8B+AEA
AQ8B+AEAAQ8B/wH8AQcD/wH4AQABDwH4AQABDwH/AfwBDwT/AQABfwH/AQABfw//AfABAAEDAfgB
AAEPAfgBAAEHAcABAAEBAcABAAEBAfgBAAEPAfgBAAEHAcABAAEBAcABAAEBAf8BwQH/AfgBAAEP
AcABAAEBAcABAAEBAfABAAEHAfgBAAEPAcABAAEBAcABAAEBAcABAAEHAcABAAEBAf8BwwH/AcAB
AAEBAcABAAEHAcABHAEBAf8BwQH/AYABAAEBAcABAAEHAcABHAEAAYABAAEBAYABAAEBAfABAAEH
AQABDwKAAQABAQGAAQABAQHwAQABBwEAAQcB4QGAAQABAQGAAQABAQGAAwABAwHgAYABAAEBAYAB
AAEBAYABGAIAAQEB4AGAAQABAQGAAQABAQGAARwCAAEBAeABgAEAAQEBgAEAAQEBgAEcAgABAQHg
AYABAAEBAYABAAEBAYADAAEBAeABgAEAAQEBgAEAAQEB8AEAAQcBAAEDAeEBgAEAAQEBwAEAAQEB
8AEAAQcBAAEHAoABAAEBAcABAAEBAcABAAEHAYABDwEAAYABAAEBAcABAAEBAcABAAEHAcABHwEB
AYABAAEBAcABAAEBAcABAAEHAcABAAEBAYABAAEBAcABAAEBAfABAAEHAfgBAAEBAcABAAEBAcAB
AAEBAfgBwQGPAfgBAAEHA/8BwAEAAQMB+AHBAY8B+AEAAQcD/wHwAQABBwH/AcEB/wH+AUEBPxL/
AcABAAEDAcABAAEHAfABAAEDA/8DAAGAAQABAwHAAQABAQP/BQABAwHAAQABAQP/BQABAwHAAQAB
AQP/BQABAwHAAQABAQP/AwABgAEAAQMBwAEAAQED/wMAAYABAAEBAcABAAEBA/8DAAGAAQABAQHA
AQABAQP/AwABgAEAAQEBwAEAAQED/wMAAYACAAHAAQABAQP/AwABgAIAAcABAAEBAYAFAAGAAgAB
wAEAAQED/wMAAYACAAHAAQABAQP/AwABgAEAAQEBwAEAAQED/wMAAYABAAEHAcABAAEBA/8DAAGA
AQABBwHAAQABAQP/AwABgAEHAfABwAEAAQED/wMAAcABDwHgAcABAAEDA/8DAAL/AfABwAEAAQcD
/wEAAQcC/wH+AQABwAEAAQcD/wEAAQ8C/wH8AQABwAEAAQ8D/wGAAR8D/wEHAcABAAEPCf8B8AEA
AT8M/ws='))
	#endregion
	$imagelist1.ImageStream = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$imagelist1.TransparentColor = [System.Drawing.Color]::Transparent 
	$imagelist1.Images.SetKeyName(0,'grey-dotted1.ico')
	$imagelist1.Images.SetKeyName(1,'Folder Close.png')
	$imagelist1.Images.SetKeyName(2,'Open.png')
	$imagelist1.Images.SetKeyName(3,'document_color_green.ico')
	$imagelist1.Images.SetKeyName(4,'document_flat-import.ico')
	$imagelist1.Images.SetKeyName(5,'manufacturing_process_1_gear.ico')
	$imagelist1.Images.SetKeyName(6,'manufacturing_process_1_gear_empty-import.ico')
	$imagelist1.Images.SetKeyName(7,'storage_network.ico')
	$imagelist1.Images.SetKeyName(8,'storage_network_green.ico')
	$imagelist1.Images.SetKeyName(9,'storage_disc-info.ico')
	$imagelist1.Images.SetKeyName(10,'storage_disc-ok.ico')
	$imagelist1.Images.SetKeyName(11,'link.ico')
	$imagelist1.Images.SetKeyName(12,'link-ok.ico')
	$imagelist1.Images.SetKeyName(13,'tag_blue.ico')
	$imagelist1.Images.SetKeyName(14,'organization.ico')
	$imagelist1.Images.SetKeyName(15,'list-info.ico')
	$imagelist1.Images.SetKeyName(16,'list-ok.ico')
	$imagelist1.Images.SetKeyName(17,'Clock.ico')
	$imagelist1.Images.SetKeyName(18,'Clock-Selected.ico')
	$imagelist1.Images.SetKeyName(19,'registry_editor.ico')
	#
	# imagelist2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFdTeXN0ZW0uV2luZG93cy5Gb3JtcywgVmVyc2lvbj00LjAu
MC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWI3N2E1YzU2MTkzNGUwODkFAQAA
ACZTeXN0ZW0uV2luZG93cy5Gb3Jtcy5JbWFnZUxpc3RTdHJlYW1lcgEAAAAERGF0YQcCAgAAAAkD
AAAADwMAAABkQgAAAk1TRnQBSQFMAgEBFAEAAYABAwGAAQMBEAEAARABAAT/ASEBAAj/AUIBTQE2
BwABNgMAASgDAAFAAwABYAMAAQEBAAEgBgABYP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/AP8A/wD/
AP8ASgADBAEFASEBXgEhAfsBAAFvAQsB/wEAAWkBCgH/A0sBjBQAAxYBHgNHAYEDXAHDA1sB5ANb
AeQDWwHEA0cBggMYASAgAAMVARwDLQFEA1MBqQNcAdkDWwHYA1MBqQNdAcwBagF/AUEB+QFfAYgB
LAH7AWMBbQFIAfYCUAFPAZsIAAMFAQYDCwEOAwsBDgMLAQ4DBQEGAwUBBgMLAQ4DCwEOAwsBDgMF
AQYDBQEGAwsBDgMLAQ4DCwEOAwUEBgEHAxMBGQFxAW8BbAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8B
bAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8BAAFmAQsB/wEAAYcBFQX/AQABiQEX
Af8BAAGJARcB/wFKAUsBSgGKCAADAgEDA0cBgQNoAfkDWgH/A2AB/wN4Af8DeAH/A2AB/wNaAf8D
aAH5A0kBhQMDAQQQAAQCAxkBIgF+AisB/AH/AboBkwL/AcEBlgL/AcgBnwL/AcgBnwH/AZsBrwFJ
Af8BdgGoAS0B/wHGAdoBpwH/AYABlgGAAf4CgAFEAf4BdQF+ASsB/AJPAU4BlwQAAeABpAEjAf8B
4AGkASMB/wHgAaQBIwH/AeABpAEjAf8DCwEOAeABpAEjAf8B4AGkASMB/wHgAaQBIwH/AeABpAEj
Af8DCwEOAeABpAEjAf8B4AGkASMB/wHgAaQBIwH/AeABpAEjAf8DCwEOCAAg/wEAAaQBIg3/AQAB
pAEiAf8BAAGMARoB/wQAAwIBAwNVAa0DWgH/A3AB/wPGAf8D+wn/A/sB/wPIAf8DcQH/A1oB/wNX
AbEDAwEECAAEAQM1AVYB4wGaAXgC/wHFAZoC/wHcAbcB/wHGAX4BZgH/AZUBRAEwAf8BlgFFATMB
/wF3AacBLgH/AccB3AGqAf8B+QH7AfYB/wH3AfkB8wH/AYABmAGAAf4CgAFEAf4CZwFZAe8EAAH/
AdABSgL/AdABSgL/AdABSgL/AdABSgH/AwsBDgH/AdABSgL/AdABSgL/AdABSgL/AdABSgH/AwsB
DgH/AdABSgL/AdABSgL/AdABSgL/AdABSgH/AwsBDggABP8DAAX/AwAB/wMAAf8DAAH/AwAB/wN2
Af8BAAG+ATIB/wGFAdwBnQH/AQABvgEyBf8B7wH/AfgB/wEAAbEBLAH/BAADSQGGA1oB/wOCAf8D
9Rn/A/YB/wOEAf8DWgH/A0sBiwgAAxgBIAHnAZ8BfQL/AcIBmQH/AbsBagFPAf8B4AHLAcYB/wPx
Af8D5gH/A+sB/wF+Aa0BOgH/AewB8gHhAf8BlwG8AWAB/wG3AdEBjwH/AfcB+gHzAf8BqAG+AWMB
/QF0AXwBUQH4BAAB/wHqAWYC/wHqAWYC/wHqAWYC/wHqAWYB/wMLAQ4B/wHqAWYC/wHqAWYC/wHq
AWYC/wHqAWYB/wMLAQ4B/wHqAWYC/wHqAWYC/wHqAWYC/wHqAWYB/wMLAQ4IAAT/AwAF/wMAAf8D
AAH/AwAB/wMAAf8DZgH/AQABywE+Af8BAAHXAUQB/wEAAdcBRAH/AQAB1gFEAf8BXwHTAYAB/wFB
AWgBQQH5AxoBJANNAfoDawH/A/Qh/wP1Af8DbQH/A14B+wMdASgEAQGiAU8BNwL/AbsBjwH/AbcB
YAFBAf8D9wH/A+YB/wPeAf8DvgH/A88B/wF2AacBLgH/AXsBrAE3Af8BdQGoAS0B/wF1AagBLAH/
AbQB0AGMAf8B8gH2AesB/wJoAV4B8AQAAf8B+AF3Av8B+wF3Av8B+wF3Av8B+wF3Af8DBQEGAf8B
+AF3Av8B+wF3Av8B+wF3Av8B+wF3Af8DBQEGAf8B+AF3Av8B+wF3Av8B+wF3Av8B+wF3Af8DBQEG
CAAE/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wFwAXYBcwH/AQcB3AFNAf8BCwHtAVYB/wELAe0B
VgH/AQABgAEcAf8EAgNLAYoDWgH/A7wp/wPAAf8DWgH/A0wBkAMWAR4B/wHEAZoC/wGkAXYB/wHr
Ad0B2QH/A+oB/wPhAf8D4AH/A+AB/wO4Af8BWQF+ASMB/wF2AagBLQH/AXUBqAEtAf8BdQGnASwB
/wF2AagBLAH/AYkBtAFKAf8CVQFTAaoEAAMFAQYDCwEOAwsBDgMLAQ4DBQEGAwUBBgMLAQ4DCwEO
AwsBDgMFAQYcAAT/AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAF/wFpAmcB+wNIAYMIAANdAc8D
WwH/A/QN/wH9AvwB/wHnAdUBxAH/AekB2QHJAf8B7QHgAdMB/wHyAekB3wH/AfoB9QHyBf8D9gH/
A1wB/wNdAdQDUgGjAf8BvwGSAf8BuwFnAUQB/wP7Af8D7QH/A+oB/wPqAf8D3AH/AxwB/wLKAckB
/wGVAboBYAH/AXkBqgEzAf8BdQGoAS0B/wF5AaYBLgH/AaYBsAFRAf8DSwGNBAAB4AGkASMB/wHg
AaQBIwH/AeABpAEjAf8B4AGkASMB/wMLAQ4B4AGkASMB/wHgAaQBIwH/AeABpAEjAf8B4AGkASMB
/wMLAQ4cAAT/AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAF/wNqAfkMAANlAfEDbBH/Ae8B4QHV
Af8BrAFrASwB/wGsAWsBLAH/AawBbAEuAf8BswF5AT8B/wG9AYsBWQH/AdIBsAGOAf8B/AH6AfcB
/wNvAf8DYAH2AWUCXQHsAf8BwQGRAf8BqQFYAToB/wP3Af8D8QH/A88B/wPGAf8DjwH/AxAB/wPq
Af8D9wH/A+oF/wGpAVQBMgL/Ab8BkQH/A10BzAQAAf8B0AFKAv8B0AFKAv8B0AFKAv8B0AFKAf8D
CwEOAf8B0AFKAv8B0AFKAv8B0AFKAv8B0AFKAf8DCwEOHAAE/wMABf8DAAH/AwAB/wMAAf8DAAH/
AwAB/wMABf8DagH5DAADYAHzA20R/wHxAecB3QH/AawBawEsAf8B8gHoAd4B/wH+Av0R/wNxAf8D
XAH4AWMCYgHuAf8ByQGaAf8BsAFfAT4B/wP3Af8D6wH/AzMB/wMKAf8DQAH/AksBvgH/ArsB8QH/
A9cB/wPoBf8BrQFWATIC/wHJAZoB/wFeAlsBzQQAAf8B6gFmAv8B6gFmAv8B6gFmAv8B6gFmAf8D
CwEOAf8B6gFmAv8B6gFmAv8B6gFmAv8B6gFmAf8DCwEOHAAE/wMABf8DAAH/AwAB/wMAAf8DAAH/
AwAB/wMABf8DagH5DAADXwHVA1wB/wP3Df8B9wHzAe0B/wGsAWsBLAH/AfwB+gH2Ef8D+gH/A10B
/wNfAdoCVQFTAaoB/wHNAaIB/wHCAXABRx3/AiMB7Qn/AdIBggFZAv8BzQGiAf8DSwGPBAAB/wH4
AXcC/wH7AXcC/wH7AXcC/wH7AXcB/wMFAQYB/wH4AXcC/wH7AXcC/wH7AXcC/wH7AXcB/wMFAQYE
AQGqAW8BAAH/AwsBDhAABP8DAAX/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAX/A2oB+QwAA04BlQNa
Af8DxA3/A/4B/wGxAXYBOxX/A8cB/wNaAf8DUAGaAxsBJgH/AcwBogL/Ab8BliH/AuAD/wHrAeAC
/wHGAZ0C/wHEAZgB/wMRARYEAAMFAQYDCwEOAwsBDgMLAQ4DBQEGEAAEAQG0AXsBDgH/Ae8BvAE2
Af8B0AGWAR8B/wMJAQwMACj/A2oB+QwAAyEBMANAAf0DcwH/A/gN/wHHAZsBcRH/A/oB/wN1Af8D
eAH+AyQBNAQAAcUBcAFDAv8B0gGpAf8BxgFwAUQh/wHSAYABUgL/AdMBqgH/AY0BXwE2AfsEAgQA
AeABpAEjAf8B4AGkASMB/wHgAaQBIwH/AeABpAEjAf8DCwEOEAABtQF+AREC/wHnAWIC/wHWAUoB
/wHvAbsBMgH/AdUBlgEcAf8DHwEsCAABtAFRAT4B/wG0AU8BPQH/AbQBTwE9Af8BtAFPAT0B/wG0
AU8BPQH/AbQBTwE9Af8BtAFPAT0B/wG0AU8BPQH/AbQBTwE9Af8BtAFPAT0B/wNfAfsQAANRAZwD
WgH/A5AB/wP8Cf8B8AHkAdgN/wP8Af8DlAH/A1oB/wNSAaEIAAMaASQB/wHCAZkC/wHLAaMB/wHJ
AXQBRAL/AfkB9BH/Af4B7gHmAf8B0gF+AU8C/wHNAaQB/wH0AbEBhQH/AxABFQgAAf8B0AFKAv8B
0AFKAv8B0AFKAv8B0AFKAf8DCwEOEAABrgF3AQsC/wH0AXMC/wHkAWIC/wHSAU4B/wHqAa0BMAH/
DAAB/wHaAbMC/wHqAcYC/wHqAcYC/wHqAcYC/wHqAcYC/wHqAcYC/wHqAcYC/wHqAcYC/wHqAcYC
/wHqAcYB/wKAAX0B/hAAAwgBCgNbAcQDWgH/A30B/wPaEf8D3AH/A38B/wNaAf8DWwHHAwkBCwwA
AzsBYgH/AcgBnwL/AdcBsAL/Ab8BlgH/Ac8BegFKAf8BwQFtAT4B/wG/AWwBPAH/AdMBfgFOAv8B
xAGaAv8B2gGzAf8B/AG8AZIB/wMxAU0MAAH/AeoBZgL/AeoBZgL/AeoBZgL/AeoBZgH/AwsBDhQA
Aa0BdgEJAv8B9AFwAv8B4QFcAf9QAAMIAQoDUgGgA3gB/gNaAf8DcAH/A4wB/wOMAf8DcQH/A1oB
/wN4Af4DUgGkAwkBDBQAAxoBIwHQAX0BSwL/AesByAL/AeYBwQL/AdwBtQL/AdwBtwL/AecBxAL/
AegBxAH/AcsBdAFBAf8DEgEYEAAB/wH4AXcC/wH7AXcC/wH7AXcC/wH7AXcB/wMFAQYYAAG0AX0B
DQH/XAADJQE3A1EBnwNeAeIDeAH+A3gB/gNgAeMDUgGhAycBOiQAAxkBIgJUAVIBqAFsAWQBYQHr
AWkBZgFgAegCUgFRAaEDEgEYfAADBAEFASEBXgEhAfsBAAFvAQsB/wEAAWkBCgH/A0sBjCQABAED
EQEWAwkBDBwAAwUEBgEHAwYBBwMGAQcDBQEGDAADBQQGAQcDBgEHAwYBBwMFAQYsAAMEAQUBXwEw
ASEB+wGnAS8BAAH/AacBLwEAAf8DSwGMCAADAwEEAxMBGgMgAS0DYgHhA0YBgQMhATADHgEqAxUB
HAMGAQcBAAFmAQsB/wEAAYcBFQX/AQABiQEXAf8BAAGJARcB/wFKAUsBSgGKIAADBwEJAfsBswGO
Af8BYQJbAd4DCAEKFAADVgGuFP8DCQEMBAADVgGuFP8DCQEMAwYBBwMTARkBcQFvAWwB/wFxAW8B
bAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AXEBbwFsAf8BcQFvAWwB/wFxAW8BbAH/AbABNwEA
Af8ByQFKAQYG/wH4AesB/wHJAUoBBgH/AUsCSgGKCAADBAEFAfkC+AH/Ae0B4AHZAf8B+QHyAe4B
/wNKAYsDAgEDBAADSAGEAQABpAEiDf8BAAGkASIB/wEAAYwBGgH/HAADBwEJAfsBtAGOAf8BswGr
AakB/wHkAaYBhQH/AWUCXgHdAwgBChAAAbEBjAF0A/8B+wP/AfsD/wH7A/8B+wP/AfsB/wMLAQ4E
AAGxAYwBdAP/AfsD/wH7A/8B+wP/AfsD/wH7Af8DCwEOCAAg/wHeAWMBGgH/Ad4BYwEaA/8B/AH/
AbUBUQERAf8B3gFjARoB/wHMAVIBDgH/BAADAgEDAfkC+AP/AfwB/wM4AV0B5AHcAdYB/wH8AfQB
7gH/A0oBigMCAQMDSQGFAQABvgEyAf8BhQHcAZ0B/wEAAb4BMgX/Ae8B/wH4Af8BAAGxASwB/xgA
AwcBCQH8AbQBjgH/AbUBrgGrCf8B5AGnAYUB/wFlAl4B3QMIAQoMAAG+AZgBgBX/AwsBDgQAAb4B
mAGAFf8DCwEOCAAE/wMABf8DAAH/AwAB/wMAAf8DAAH/A3YB/wHuAXYBKQH/Ae4BdgEpBf8ByAFs
ATAB/wHuAXYBKQH/AeYBbAEiAf8EAANuAfUB8QHkAdwB/wM1AVYEAAMIAQoB5AHcAdkB/wH+AfQB
8QH/A0oBigNEAXsBAAHLAT4B/wEAAdcBRAH/AQAB1wFEAf8BAAHWAUQB/wFfAdMBgAH/AUEBaAFB
AfkUAAMHAQkB/AG0AY4B/wG4AbEBrhH/AeYBpwGFAf8BYgJdAdwDCAEKCAABzAGjAYkV/wMIAQoE
AAHMAaMBiRX/AwgBCggABP8DAAX/AwAB/wMAAf8DAAH/AwAB/wNmAf8B8gF6AS8B/wH7AYIBNgH/
AfkBzAGtAf8BywFnASUB/wH7AYIBNgH/AWoCQQH5BAADRwGCAf8B9AHuAf8BjgGIAYUB/QMMAQ8E
/wJ9AXsB+gHmAdwB2gL/AfcB8gH/Aw0BEQNLAY0BBwHcAU0B/wELAe0BVgH/AQsB7QFWAf8BAAGA
ARwB/wQCEAADBwEJAf4BtQGOAf8B1wHQAc0Z/wHmAacBhQH/AWQCYAHbBAIEAAMMARAB0wGpAYwB
/wHTAakBjAH/AdMBqQGMAf8B0wGpAYwB/wNnAe8IAAMMARAB0wGpAYwB/wHTAakBjAH/AdMBqQGM
Af8B0wGpAYwB/wNnAe8MAAT/AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AXoBdAFxAf8B+QGBATYB
/wHZAW8BKQH/AfQBgQE3Af8BvwFIAQkB/wQCCAADVQGvAf8B9wHxAf8BkQGLAYcB/QNCAXIB9wHo
AeEB/wN9AfoB0AHNAcwB/wMCAQMDEAEVA0QBewNJAYUDSAGDFAADBwEJAf8BtQGOAf8B4AHaAdcR
/wHSAtAJ/wGpAaABnQH/Ae8BlQFsAf8UAAM8Af8cAANeAfAUAAT/AwAF/wMAAf8DAAH/AwAB/wMA
Af8DAAH/AwAF/wFpAmcB+wNIAYMUAANVAa8B/wH5AfQB/wGSAYwBiwH9AeQB3AHZAf8B+QHtAeYB
/wN9AfoBrgGmAaQF/wNKAYsDAgEDFAADBwEJAf8BtwGOAf8B4wHdAdoR/wLQAc8J/wGmAaABnAH/
AfUBowF4Af8EARQAA0cB/wNHAf8DRwH/A0cB/wNHAf8DRwH/A0cB/wNHAf8DWQHAFAAE/wMABf8D
AAH/AwAB/wMAAf8DAAH/AwAB/wMABf8DagH5HAADVQGvBP8DfgH8AecB4AHcAv8B8gHrAf8DfQH6
Ae4B5gHhAv8B/gH5Af8DSgGLAwIBAxAAAf8BtwGOAf8B5AHgAd0R/wHQAc8BzQn/AaQBnwGaAf8B
+AGrAX4B/wQBKAADXgH7JAAE/wMABf8DAAH/AwAB/wMAAf8DAAH/AwAB/wMABf8DagH5KAABkgGM
AYgB/wHrAeQB3gL/AfcB8QH/A30B+gHxAegB5gP/AfwB/wNKAYsDAgEDCAAEAQH/AcwBnAL/AcsB
oA3/Ac8CzQn/AbEBqwGpAv8BswGFAf8EASAAAVQCUgGoAZ8BfQFlAf8BnwF9AWUB/wGfAX0BZQH/
AZ8BfQFlAf8BnwF9AWUB/wMYASAYAAT/AwAF/wMAAf8DAAH/AwAB/wMAAf8DAAH/AwAF/wNqAfko
AAL/AfwB/wGqAaQBowH/Ae4B5gHhBf8EAgH0AesB5wX/AzoBYggABAEB/wHPAaIC/wHQAaIC/wHN
AaQR/wHPAckBxQL/AbUBhwH/BAEkAAX/AfIBywL/AfIBywL/AfIBywL/AfIBywL/AfIBywH/A18B
+xgABP8DAAX/AwAB/wMAAf8DAAH/AwAB/wMAAf8DAAX/A2oB+SgAA1UBrwT/A4AB/gMMAQ8EAANJ
AYcC/wH5Af8DWgHECAAEAQH/AdABpAH/Ae8BkwFfAv8B1wGtAv8BzwGpCf8BzwHJAcUC/wG4AYkB
/wQBKAAF/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4C/wH7Ad4B/wNfAfsYACj/A2oB+SwAA1UBrwT/
AaABnAGYAf0DSgGJBP8B7gHmAeEB/wQBDAAB/wHPAaQB/wFaAlgBvQH+AasBfQL/AdIBpwL/Ac8B
qQH/Ac0ByAHEAv8BugGJAf8EASwAGP8DXwH7GAABtAFRAT4B/wG0AU8BPQH/AbQBTwE9Af8BtAFP
AT0B/wG0AU8BPQH/AbQBTwE9Af8BtAFPAT0B/wG0AU8BPQH/AbQBTwE9Af8BtAFPAT0B/wNfAfsw
AANVAa8I/wHtAeYB4AH/BAEQAAH/Ad4BuAL/AeEBvAL/AeEBvAL/AeEBvAL/AeEBvAL/AboBiQH/
BAEwABj/A2gB8BgAAf8B2gGzAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B6gHGAv8B
6gHGAv8B6gHGAv8B6gHGAf8CgAF9Af40AAM+AWsDXwHI/wDaAAEsAQAB/wEAASwBAAH/AQABLAEA
Af8BAAEsAQAB/wEAAZkBAAH/AQAB3gL/AQAB3gL/AQAB3gL/AQABmQEAAf8BAAEsAQAB/wEAASwB
AAH/AQABLAEAAf8BAAEsAQAB/xAAAwwBDwMVAR0DGAEhAxkBIwMaASQDKAE8AxoBJAMcAScBfgIr
AfwBpwEvAQAB/wGnAS8BAAH/A0sBjBAAAwwBDwMVAR0DGAEhAxkBIwMaASQDKAE8AxoBJAMcAScB
KwFWASsB/AEAAW8BCwH/AQABaQEKAf8DSwGMFAADCAEKAxIBFwMFAQYtAAEsAQAB/wEAASwBAAH/
AQABLAEAAf8BAAEsAQAB/wEAAZkBAAH/AQAB0AL/AQAB0AL/AQAB0AL/AQABmQEAAf8BAAEsAQAB
/wEAASwBAAH/AQABLAEAAf8BAAEsAQAB/xgAAX0BdgFzCf8B7wH/AeEB/wHoAf8B3QH/AbABNwEA
Af8ByQFKAQYG/wH4AesB/wHJAUoBBgH/AUsCSgGKFAABfQF2AXMJ/wHvAf8B4QH/AegB/wHdAf8B
AAFmAQsB/wEAAYcBFQX/AQABiQEXAf8BAAGJARcB/wFKAUsBSgGKDAADBAEFAeYC5AH/A/wB/wMh
AS8EAjwAAzEBTAFNAe0BUgH/KAADNAFTEP8B7gH/AeAD/wH5Af8B3gFjARoB/wHeAWMBGgP/AfwB
/wG1AVEBEQH/Ad4BYwEaAf8BzAFSAQ4B/wwAAzQBUxD/Ae4B/wHgA/8B+QH/AQABpAEiDf8BAAGk
ASIB/wEAAYwBGgH/CAADBAEFAfkC+AL/Af4B+Qn/AxsBJTwAAzMBUAEiAeEBKAH/CAIcAAMTARkU
/wHtAf8B3gP/AfkB/wHuAXYBKQH/Ae4BdgEpBf8ByAFsATAB/wHuAXYBKQH/AeYBbAEiAf8IAAMT
ARkU/wHtAf8B3gP/AfkB/wEAAb4BMgH/AYUB3AGdAf8BAAG+ATIF/wHvAf8B+AH/AQABsQEsAf8I
AAH5AvgD/wH8Af8DLQFFAxIBGAj/AxsBJSAAA1gBugNqAf8DagH/A2oB/wNqAf8DagH/A2oB/wNq
Af8DagH/A2oB/wNqAf8DagH/A2oB/wNqAf8MAAHgAdoB2RX/AesB/wHdAf8B/gH/AfsB/wHyAXoB
LwH/AfsBggE2Af8B+QHMAa0B/wHLAWcBJQH/AfsBggE2Af8BagJBAfkIAAHgAdoB2RX/AesB/wHd
Af8B/gH/AfsB/wEAAcsBPgH/AQAB1wFEAf8BAAHXAUQB/wEAAdYBRAH/AV8B0wGAAf8BQQFoAUEB
+QQAAwkBDAHyAeQB3gH/A2AB6AMCAQMDEQEWA0MBdgj/AxcBHxwAA3EF/wF9AnsF/wF4AncF/wF0
AnEC/wL5Av8C/gL/AvgC/wL1Af8BQQG6AZYB/wFFAWwB6gH/AfkC7QH/CAADEgEYFP8B7wH1AfIB
/wG8AdcBsAH/AbMBrgHEAv8B8gH5Af8B+QGBATYB/wHZAW8BKQH/AfQBgQE3Af8BvwFIAQkB/wQC
BAADEgEYFP8B7wH1AfIB/wG8AdcBsAH/AbMBrgHEAf8B+AH0AfsB/wEHAdwBTQH/AQsB7QFWAf8B
CwHtAVYB/wEAAYABHAH/BAIIAAHIAb4BuwL/AfcB9AH/A0kBhwH/AfkB9wL/AfgB9wH/A0oBigT/
A1kBvhwAA30F/wHyAu8B/wH0AvIB/wHqAucB/wHtAucB/wHjAt0B/wHmAt0C/wL+Av8C+AL/AvUB
/wH+AvEB/wH5Au8B/wH5Au0B/wgAA1sB0AL/AfgD/wH5A/8B/AX/Ae4B3QHaAf8BtQGxAbAB/wNd
Ac8B4ALQAf8B0wGwAaYD/wH4A/8B/gP/Af4C/wHnAdoB/wgAA1sB0AL/AfgD/wH5A/8B/AX/Ae4B
3QHaAf8BtQGxAbAB/wNdAc8B4ALQAf8B0wGwAaYD/wH4A/8B/gP/Af4C/wHnAdoB/xAAAckBwgG+
Av8B+QH0Af8DTgGXBf8B+QH3Af8DSgGKAwMBBANTAakDGAEgFAADhTX/CAABZwFfAVsC/wHvAegC
/wHvAecC/wHtAeEC/wHrAd4B/wHaAboBrgH/CAADXQHPAesB1QHSAv8B+wH0Av8B9QHuAv8B9AHt
Av8B8gHrAf8DFQEcBAABZwFfAVsC/wHvAegC/wHvAecC/wHtAeEC/wHrAd4B/wHaAboBrgH/CAAD
XQHPAesB1QHSAv8B+wH0Av8B9QHuAv8B9AHtAv8B8gHrAf8DFQEcEAABzwHGAcIC/wH8AfgB/wNO
AZcF/wH+AfkB/wNJAYcI/wMbASUQAANYAboDagH/A2oB/wNqAf8DagH/A2oB/wNqAf8DagH/A2oB
/wNqAf8DagH/A2oB/wNqAf8DagH/CAADWgH1Af8B5AHZAv8B4AHVAv8B3QHSAv8B2QHMAf8BxgGp
Aa4B/wNfAdoEAAGpAaQBowH/AfUB8gH0D/8B/AH/CAADWgH1Af8B5AHZAv8B4AHVAv8B3QHSAv8B
2QHMAf8BxgGpAa4B/wNfAdoEAAGpAaQBowH/AfUB8gH0D/8B/AH/GAABzAHGAcIB/wHhAdoB1gH/
AxIBFwb/AfwB/wNKAYoI/wMbASUMAANxBf8BfQJ7Bf8BeAJ3Bf8BdAJxAv8C+QL/Av4C/wL4Av8C
9QH/AUEBugGWAf8BRQFsAeoB/wH5Au0B/wgAAzoBYAH/Ad0B0gL/AdkBzAH/AfsB0wHMAf8B7wHS
Ad0B/wHEAbAB0wH/AbEBtQG8Af8BwQHZAbgB/wHhAe8B4RX/CAADOgFgAf8B3QHSAv8B2QHMAf8B
+wHTAcwB/wHvAdIB3QH/AcQBsAHTAf8BsQG1AbwB/wHBAdkBuAH/AeEB7wHhFf8gAAHCAb4BvAH/
A1IBqAj/AzYBWQj/AxsBJQgAA30F/wHyAu8B/wH0AvIB/wHqAucB/wHtAucB/wHjAt0B/wHmAt0C
/wL+Av8C+AL/AvUB/wH+AvEB/wH5Au8B/wH5Au0B/wwAAf8B4AHZAf8B+ALSAf8B7gHSAd4B/wHn
AdIB8gH/Ad4B0wH5Af8B3QHrAdkB/wHkAf8B1xX/AYgBgAF7Af8MAAH/AeAB2QH/AfgC0gH/Ae4B
0gHeAf8B5wHSAfIB/wHeAdMB+QH/Ad0B6wHZAf8B5AH/AdcV/wGIAYABewH/IAABxAG4AbUF/wNS
AaME/wQCAxIBGAL/Af4B/wH8AfkB+AH/BAIEAAOFNf8MAAJXAVYBsgHyAdUB5AH/AegB0gHuAf8B
4AHSAfkB/wHdAdoB7wH/Ad0B7gHSAf8B5AH/AdUD/wH7Ef8QAAJXAVYBsgHyAdUB5AH/AegB0gHu
Af8B4AHSAfkB/wHdAdoB7wH/Ad0B7gHSAf8B5AH/AdUD/wH7Ef8oAAHcAdMBzwX/A0sBjAMCAQMD
RQF8BP8B0wHIAcIB/wwAA1UBqgHkAuEB/wHoAucB/wHmAuMB/wHjAt0B/wHgAtoB/wHaAtUB/wHZ
AtIB/wHVAs0B/wHTAssB/wHSAsgB/wGiAp8B/wMfASwQAAJfAV4B+wHoAdcB+wH/Ad4B0wH5Af8B
3QHgAeQB/wHdAfIB0AH/AeQB/wHVAf8B+wH/AfQN/wMzAVIUAAJfAV4B+wHoAdcB+wH/Ad4B0wH5
Af8B3QHgAeQB/wHdAfIB0AH/AeQB/wHVAf8B+wH/AfQN/wMzAVIsAAHgAdYB0AX/A3wB+AT/Ae4B
5gHhAf8EAVQAA1UBrwT/Ad0B5wHeAf8B3QH1AcwB/wHkAf8B1QH/AfgB/wHuBf8C7wHtAf8DEgEY
HAADVQGvBP8B3QHnAd4B/wHdAfUBzAH/AeQB/wHVAf8B+AH/Ae4F/wLvAe0B/wMSARg0AAHhAdkB
1QX/Ae0B5gHgAf8EAWAAAzYBWQNaAfUBbwFmAWIB/wFfAlsB0AMSARgsAAM2AVkDWgH1AW8BZgFi
Af8BXwJbAdADEgEY/wBhAAMOBBIBGAMSARgDEgEYAxIBGAMSARgDEgEYAxIBGAMSARgDEgEYAxAB
FQQBFAADEAEVAxIBFwMSARcDAAH/AwAB/wNiAeEDEgEXAxIBFwMJAQwcAAMHBAkBDAMJAQwDAAH/
A2UB/wNcAf8DCQEMAyQBNAMJAQwDCQEMEAADEgH/AxIB/wMSAf8DEgH/A2cB/wEAAd4C/wEAAd4C
/wEAAd4C/wNqAfkDUQH3A1EB9wNRAfcDUQH3DAADCwEOLP8DAgEDIAADLAH/AyYB/wNNAf8rAAH/
AxgB/wMAAf8DLAH/AygB/wMmAf8DTgGUAxgB/wNzAf8UAAMSAf8DEgH/AxIB/wMSAf8DZwH/AQAB
0AL/AQAB0AL/AQAB0AL/A2cB/wMSAf8DEgH/AxsB/wMeAf8MAAMLAQ4s/wMCAQMQAAMiAf8DUgH/
A1YBsgMpAf8DIgH/AyYB/wNKAf8DAAH/AwAB/wM9Af8DXAH4GAADKwH/AysB/wMpAf8DIgH/A5MB
/wNWAf8DGAH/AysB/wMtAf8oAAMxAUwBzwLMAf8kAAMLAQ4I/wGOAcIBmiH/AwIBAw8AAf8DKAH/
AysB/wMoAf8DKwH/AysB/wMrAf8DKwH/AysB/wMpAf8DKwH/AzkB/xMAAf8DZQH/A2wB/wNLAf8D
AAH/DAADOgFiA+QB/wMoAf8DLAH/A3EB/yAAAzMBUAGkAqMB/wQCHAAEAgMSARcI/wEAAVIBAAH/
AQABmQEmHf8DAgEDEAADdwH/AzQB/wM0Af8DNAH/AzQB/wM0Af8DNAH/AzQB/wM0Af8DMwH/AwoB
/xAAAy8B/wM3Af8DuwH/AVwBdwFcAfgDIQEwBAEQAAOJAf8DNwH/AzcB/wMAAf8EAANYAboDagH/
A2oB/wNqAf8DagH/A2oB/wNqAf8DagH/A2oB/wNqAf8DagH/A2oB/wNqAf8DagH/CAADIQEvA00B
kwFiAe4BjwH/ASgB3gFjAf8BHwHdAVwB/wEYAdcBSgH/AQABoAEtGf8DAgEDEAADaQH/Az0B/wM9
Af8DOQH/A+8B/wPFAf8DoAH/Az0B/wM9Af8DPAH/AwMB/wgAAwUBBgMbASYDagH/A7oB/wPEAf8B
GwHZAVEB/wFNAWwBTQH6AyMBMwQBEAADQQH/A7QB/wgAA3EF/wF9AnsF/wF4AncF/wF0AnEC/wL5
Av8C/gL/AvgC/wL1Af8BQQG6AZYB/wFFAWwB6gH/AfkC7QH/CAADIQEwA04BlQFqAfEBjgH/ATIB
4wFiAf8BKwHhAVsB/wErAeEBWwH/ASsB4QFbAf8BCQGuAT0V/wMCAQMIAAM5Af8DcQH/A0MB/wNH
Af8DRwH/A2kB/wgAAwkBCwNpAf8DRwH/A0cB/wNbAf8DagH/A10B1AMSARgBHgFcAS8B/wFHAcEB
ZgH/ASkB1gFWAf8BGgHXAUsB/wEaAdcBSwH/ARsB2QFOAf8BKwFnASsB/AMkATUEAQwAAzcB/wNe
Af8DAQH/BAADfQX/AfIC7wH/AfQC8gH/AeoC5wH/Ae0C5wH/AeMC3QH/AeYC3QL/Av4C/wL4Av8C
9QH/Af4C8QH/AfkC7wH/AfkC7QH/CAADIQEwA04BlQGEAf4BpAH/AVQB9QGAAf8BTQH0AXsB/wFN
AfQBewH/AU0B9AF7Af8BCQGkATkV/wMCAQMIAANgAf8DUgH/A1IB/wNSAf8DUQH/A1sB0AwAA0oB
/wNSAf8DUgH/A1IB/wNSAf8DBAH/AxEBFgFmAaIBdwH/AVkBzAF6Af8BRAHkAW8B/wE2AecBZgH/
ATYB5wFmAf8BNgHnAWYB/wE2AecBZwH/ASEBXwEhAfsDDgESDAADHAH/A1IB/wNOAf8EAAOFNf8I
AAMhAS8DTQGTAa4B/wHnAf8BjAH/AdcB/wGJAf8B2QH/AWYB/wGTAf8BHwG1AU8Z/wMCAQMIAANl
Af8DfQH/A1sB/wNcAf8DXAH/AygB/wwAA2kB/wNcAf8DXAH/A1UB/wOLAf8DDgH/AxEBFgGaAdIB
qgH/AXQB3AGRAf8BYgH1AYsB/wFWAfkBhAH/AVYB+QGEAf8BVgH5AYQB/wERAaoBQQH/A0EBcAME
AQUMAAM3Af8DUQH/A+QB/wQAA1gBugNqAf8DagH/A2oB/wNqAf8DagH/A2oB/wNqAf8DagH/A2oB
/wNqAf8DagH/A2oB/wNqAf8IAAQCAxIBFwj/AQABZwEDAf8BKAHFAV4d/wMCAQMQAAN0Af8DZgH/
A2YB/wNlAf8DLAH/A10B0QNlAf8DZgH/A2YB/wNlAf8DPQH/CAADEgEXAz4BagNiAe4BAAF4ARwB
/wEAAWMBAAH/AWkB/wGYAf8BIgG6AVQB/wNEAXgDAwEEEAADbwH/A0cB/wgAA3EF/wF9AnsF/wF4
AncF/wF0AnEC/wL5Av8C/gL/AvgC/wL1Af8BQQG6AZYB/wFFAWwB6gH/AfkC7QH/DAADCwEOCP8B
NwGkAV8h/wMCAQMQAANRAf8DcAH/A3AB/wNwAf8DcAH/A3AB/wNwAf8DcAH/A3AB/wNwAf8DUgGg
DAADHwEsA20B/wNxAf8D0gH/ASsByQFiAf8DRQF8AwMBBBAAAxIB/wNvAf8DbwH/AyMB/wQAA30F
/wHyAu8B/wH0AvIB/wHqAucB/wHtAucB/wHjAt0B/wHmAt0C/wL+Av8C+AL/AvUB/wH+AvEB/wH5
Au8B/wH5Au0B/wwAAwsBDiz/AwIBAwwAAyYB/wN3Af8DdgH/A3YB/wN2Af8DdgH/A3YB/wN2Af8D
dgH/A3YB/wN2Af8DbAH/EAADnAH/A2cB/wOAAf8BqgGrAaoB/wMEAQUQAAMXAf8DdAH/A50B/wN0
Af8IAAOFNf8MAAMLAQ4s/wMCAQMQAAPMAf8DfQH/A5kB/wPZAf8DfQH/A30B/wN7Af8D8gH/A9wB
/wN3Af8DZgH/GAADOQH/A30B/wN+Af8DVQH/AzYB/wNHAf8DfgH/A30B/wOAAf8EAAMtAUUMAANV
AaoB5ALhAf8B6ALnAf8B5gLjAf8B4wLdAf8B4ALaAf8B2gLVAf8B2QLSAf8B1QLNAf8B0wLLAf8B
0gLIAf8BogKfAf8DHwEsDAADCwEOLP8EAhQAA0AB/QgAA4QB/wOFAf8DdwH/CAADKAH/HAAD2gH/
A4AB/wPXAf8DqgH/A4EB/wN6Af8DzQH/A34B/wN+Af8DMQFNVAACqQGmAf8CqQGmAf8CqQGmAf8C
qQGmAf8CqQGmAf8CqQGmAf8CqQGmAf8CqQGmAf8CqQGmAf8CqQGmAf8CqQGmAf8kAAT/A/wB/wNl
Af8sAAMUAf8EAAMsAf8DdgH/A44B/wQAA0AB//8AlQAEATQCCAADBQEGAx0BKQMkATQDJAE0AyQB
NAMkATQDJAE0AyQBNAMkATQDJAE0AyQBNAMjATMDFAEbBAEQAAMOBBIBGAMSARgDEgEYAxIBGAMS
ARgDEgEYAxIBGAMSARgDEgEYAxABFQQBRAADUwGnAQcBcQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcB
cQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFx
AZgB/wEHAXEBmAH/AQcBcQGYAf8BBwFxAZgB/wNGAX4EAgFgAZgBxgH/AVwBzgHwAf8BWQHNAfAB
/wFWAcwB7wH/AVMBywHvAf8BUQHJAe4B/wFOAckB7gH/AUwByAHuAf8BSgHHAe0B/wFIAcYB7QH/
AUcBxgHtAf8BRwHGAe0B/wFJAXgBrAH/BAEMAAMLAQ4B/AH/AfkB/wH1Af8B8QH/AfIB/wHtAf8B
7wH/AeoB/wHtAf8B5wH/AegB/wHjAf8B5gH/AeAB/wHjAf8B3QH/AeEB/wHaAf8B3gH/AdcB/wH8
Af8B+QH/AwIBA0QAARQBegGhAf8BnAHjAf0B/wGcAeMB/QH/AZwB4wH9Af8BnAHjAf0B/wGcAeMB
/QH/AZwB4wH9Af8BnAHjAf0B/wGcAeMB/QH/AZwB4wH9Af8BnAHjAf0B/wGcAeMB/QH/AZwB4wH9
Af8BnAHjAf0B/wGfAeQB/QH/ASsCgAH+BAIBjQHRAd0B/wGsAfIB9wH/AWIB0AHxAf8BXwHPAfAB
/wFcAc4B8AH/AVkBzQHwAf8BVgHMAe8B/wFTAcoB7wH/AVAByQHuAf8BTgHIAe4B/wFMAcgB7gH/
AUoBxwHtAf8BSAG1AeAB/wQBDAADCwEOAfsB/wH1Af8B8QH/AesB/wHuAf8B6AH/AeoB/wHkAf8B
5gH/AeAB/wHjAf8B3AH/Ad4B/wHXAf8B2gH/AdMB/wHXAf8B0AH/AdUB/wHNAf8B/gH/AfsB/wMC
AQNEAAEZAYABpgH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB
+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB2QH6Af8BgAHZAfoB/wGAAdkB+gH/AYAB2QH6
Af8BgwHaAfoB/wEwAoAB/gQAAZgB3gHpAf8BYAGbAdQB/wFrAdQB8gH/AWgB0wHyAf8BZQHSAfEB
/wFiAdAB8QH/AV8BzwHwAf8BWwHOAfAB/wFZAc0B8AH/AVYBzAHvAf8BUwHKAe8B/wFQAckB7gH/
AU4ByAHuAf8BSQF2AaoB/wwAAwsBDgH+Af8B+QH/AfUB/wHvAf8B8QH/AesB/wHuAf8B6AH/AeoB
/wHkAf8B5gH/AeAB/wHjAf8B3AH/Ad4B/wHXAf8B2gH/AdMB/wHXAf8B0AP/AfwB/wMCAQNEAAEe
AYYBrQH/AWMBzwH3Af8BYwHPAfcB/wFjAc8B9wH/AWMBzwH3Af8BYwHPAfcB/wFjAc8B9wH/AWMB
zwH3Af8BYwHPAfcB/wFjAc8B9wH/AWMBzwH3Af8BYwHPAfcB/wFjAc8B9wH/AWMBzwH3Af8BZgHQ
AfgB/wE2AoAB/gQAAaIB6AHzAf8BeAHCAdgB/wGhAe0B9wH/AXEB1gHzAf8BbgHVAfIB/wFrAdQB
8gH/AWgB0wHyAf8BZQHRAfEB/wFhAdAB8QH/AV4BzwHwAf8BWwHOAfAB/wFYAc0B7wH/AVUBywHv
Af8BTQGvAdoB/wwAAwsBDgL/AfsB/wH4Af8B8gH/AfUB/wHvAf8B8QH/AesB/wHuAf8B6AH/AeoB
/wHkAf8B5gH/AeAB/wHjAf8B3AH/Ad4B/wHXAf8B2gH/AdMD/wH8Af8DAgEDRAABJQGNAbMB/wFO
AcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4B
yAH2Af8BTgHIAfYB/wFOAcgB9gH/AU4ByAH2Af8BTgHIAfYB/wFOAcgB9gH/AVIByQH2Af8BPAKA
Af4EAAGoAe4B+QH/AYUBzwHkAf8BYgGeAdcB/wF4AdkB9AH/AXYB2AH0Af8BcwHXAfMB/wFwAdYB
8wH/AW4B1QHyAf8BawHUAfIB/wFoAdMB8gH/AWQB0QHxAf8BYQHQAfEB/wFeAc8B8AH/AVsBzgHw
Af8BXQJnAeoIAAMLAQ4C/wH+Af8B+wH/AfUB/wH4Af8B8gH/AfUB/wHvAf8B8QH/AesB/wHuAf8B
6AH/AeoB/wHkAf8B5gH/AeAB/wHjAf8B3AH/Ad4B/wHXA/8B/gH/AwIBA0QAASsBkwG6Af8BegHb
Av8BegHbAv8BegHbAv8BegHbAv8BegHbAv8BegHbAv8BegHbAv8BegHbAv8BegHbAv8BegHbAv8B
egHbAv8BegHbAv8BegHbAv8BfAHcAv8BQgKAAf4EAAGsAfAB+gH/AZMB3QHyAf8BbgGtAdcB/wGC
Ad4B9QH/AXwB2wH1Af8BegHaAfQB/wF4AdkB9AH/AXYB2AH0Af8BcwHXAfMB/wFwAdYB8wH/AW0B
1QHyAf8BagHUAfIB/wFnAdMB8gH/AWQB0QHxAf8BWwGUAcwB/wgAAwsBDgT/Af4B/wH4Af8B+wH/
AfUB/wH4Af8B8gH/AfUB/wHvAf8B8QH/AesB/wHuAf8B6AH/AeoB/wHkAf8B5gH/AeAB/wHjAf8B
3AX/AwIBAwgAAzEBTAMxAUwDMQFMAzEBTAMxAUwDMQFMAzEBTAMxAUwDMQFMAzEBTAMxAUwDMQFM
AzEBTAMxAUwDSwGKATABmQG/Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B
/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+Af8BhgHdAf4B/wGGAd0B/gH/AYYB3QH+
Af8BhgHdAf4B/wGIAd4B/gH/AUgCgAH+BAABrwHxAfsB/wGdAeYB+gH/AYsBzwHhAf8BsAH0AfgB
/wGAAdwB9QH/AYAB3AH1Af8BfgHcAfUB/wF8AdsB9QH/AXoB2gH0Af8BeAHZAfQB/wF2AdgB9AH/
AXMB1wHzAf8BcAHWAfMB/wFtAdUB8gH/AV4BvgHjAf8IAAMLAQ4G/wH7Af8B/gH/AfgB/wH7Af8B
9QH/AfgB/wHyAf8B9QH/Ae8B/wHxAf8B6wH/Ae4B/wHoAf8B6gH/AeQB/wHmAf8B4AX/AwIBA0QA
ATQBnAHEAf8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8B
kwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGTAeAB/AH/AZMB4AH8Af8BkwHgAfwB/wGV
AeAB/AH/AUwBgAGEAf4EAAGyAfMB/AH/AaQB6gH9Af8BnAHgAfMB/wGGAcYB4gH/AWIBngHXAf8B
YgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFiAZ4B1wH/AWIBngHXAf8BYgGeAdcB/wFi
AZ4B1wH/AWIBngHXAf8BYgGeAdcB/wgAAwsBDgb/AfsD/wH7Af8B/gH/AfgB/wH7Af8B9QH/AfgB
/wHyAf8B9QH/Ae8B/wHxAf8B6wH/Ae4B/wHoAf8B6gH/AeQF/wMCAQNEAAE0AZ0BxAH/AaIB4gH6
Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB
/wGiAeIB+gH/AaIB4gH6Af8BogHiAfoB/wGiAeIB+gH/AaIB4gH6Af8BpAHjAfoB/wFMAYABhQH+
BAABtAH0AfwB/wGoAewB/gH/AacB6wH+Af8BpAHqAf0B/wGjAekB/AH/AaEB6AH8Af8BnwHnAfsB
/wGdAecB+wH/AZsB5gH7Af8BmQHlAfoB/wGXAeQB+gH/AZQB4wH5Af8DDAEPEAADCwEOBv8B+wP/
AfsD/wH7Af8B/gH/AfgB/wH7Af8B9QH/AfgB/wHyAf8B9QH/Ae8B/wHxAf8B6wH/Ae4B/wHoBf8D
AgEDRAABNAJ+AfwBLQGZAcIB/wEtAZkBwgH/AS0BmQHCAf8BLQGZAcIB/wEtAZkBwgH/AS0BmQHC
Af8BLQGZAcIB/wEtAZkBwgH/AS0BmQHCAf8BLQGZAcIB/wEtAZkBwgH/AS0BmQHCAf8BLQGZAcIB
/wEtAZkBwgH/AWQCaAH0BAABtAHzAfoB/wGsAe4C/wGrAe0C/wGqAe0C/wGoAewB/gH/AacB6wH+
Af8BZAGdAdMB/wFiAZkBzwH/AWABlQHKAf8BXgGRAcQB/wFbAYwBvgH/AVgBhwG5Af8EAQMEAQUD
BAEFCAADCwEOBv8B+wP/AfsD/wH7A/8B+wH/Af4B/wH4Af8B+wH/AfUB/wH4Af8B8gH/AfUB/wHv
Af8B8QH/AesF/wMCAQNEAAGEAYABaQH7Af0B7wHhAf8B/QHxAeYB/wH9AfIB5wH/Af0B8gHnAf8B
/QHzAecB/wH9AfMB5wH/Af0B7QHeAf8B/QH2AfAB/wH9AfYB8AH/Af0B9gHwAf8B/QH2AfAB/wH9
AfYB8AH/Af0B9gHwAf8B/QH2AfAB/wNqAe0EAAFlAZ4B1QH/AbgB9gH7Af8BuAH2AfsB/wG4AfYB
+wH/AbgB9gH7Af8BtgH0AfwB/wQCFAABIAHDAUgB/wEgAcIBRwH/AR8BvwFHAf8IAAMLAQ4G/wH7
A/8B+wP/AfsD/wH7A/8B+wH/Af4B/wH4Af8B+wH/AfcN/wQBRAADfAH4Af8B8wHoAv8B1AGvAv8B
1wGxAv8B3AGzAv8B4QG1Av8B6AHEAf8B7AHnAeEB/wMTARkMAAgBQAABJgHOAUoB/wEkAcsBSQH/
CAADCwEOBv8B+wP/AfsD/wH7A/8B+wP/AfsD/wH7Af8B/gH/AfkB/wH7Af8B9wX/AzEBTUgAAx0B
KAOAAf4BswGlAZgB/wGzAaUBmAH/AbMBpQGYAf8BswGlAZgB/wGzAaUBmAH/A0QBd0gAAQ0BuAFM
Af8DBQEGAwoBDQEOAaoBRwH/AQcBnAE/Af8BJAHLAUkB/wgAAwsBDgb/AfsD/wH7A/8B+wP/AfsD
/wH7A/8B+wP/AfsF/wMxAU64AAMjATMBAgGsAUIB/xgAA2oB5gNqAeYDagHmA2oB5gNqAeYDagHm
A2oB5gNqAeYDMQFO/wARAAFCAU0BPgcAAT4DAAEoAwABQAMAAWADAAEBAQABAQYAAQMWAAP/gQAB
/wHBAfABDwHwAQEBgAMAAcABAwHAAQABgAEAAcABAAGAAQEBgAEAAYABAAHAAQABgAEBAYABAAGA
AQABwAUAAYABAAHABQABgAEfAcABAwQAAYABHwHAAQcEAAGAAR8BwAEHBAABgAEfAcABBwQAAYAB
AwHAAQcEAAGDAcEBwAEHAgABgAEAAYMCwAEHAYABAQGAAQEBgwHBAcABBwGAAQEBwAEDAYMB4wL/
AcABAwHgAQcBgwH3Av8B8AEPAfgBHwP/AcEB/wEfAsEB/wHBAYABAAH/AQ8CgAIAAcABgAH+AQcC
gAHAAQABgAEAAfwBAwKAAcABAAGIAQAB+AEBAoABwAEAAYABAAHwAQACgQHAAQABwAEDAeABAQL3
AcABAwHgAQcBwAEBAfABBwHAAQcB8AEDAcABAwH/AX8BwAEHAf4BAQGAAQcB+AEPAcABBwH+AQEB
gAEPAfgBDwHAAQcB/gERAYABHwH4AQ8BwAEHAf8BAQHAAT8B+AEPAcABBwH/AYMBwAF/AfgBDwHA
AQcB/wHPDv8BwAEBAeABAQHgAQEB8QH/AcABAQH4AQAB+AEAAeAB/wH+AX8B4AEAAeABAAHAAf8B
/gEfAcABAAHAAQABwAF/AYABAQHAAQABwAEAAYABPwGAAQEBgAEAAYABAAHAAT8BgAEBAYABAQGA
AQEB4AEPAYABAQGBAYABgQGAAfABBwGAAQEBgAGBAYABgQH4AQMBgAEBAYABAQGAAQEB/gEBAYAB
AQHAAQEBwAEBAf4BAAGAAQEBwAEDAcABAwH/AQEBwAEBAeABAwHgAQMB/wGBAv8B8AEHAfABBwH/
AcMC/wH8AR8B/AEfCv8B4AEBAfABBwHwAQMBwAEBAcABAQH+AT8B8AEHAcABAQHAAQEB4AEDAfAB
BwH+AX8BwAEBAcABAwLBAf4BPwGAAQEB4AEDAcAB8AGAAQEBgAEBAeABAwEAAXkBgAEBAYABAQGB
AYABAAE4AYABAQGAAQEBgQHAAQABOAGAAQEBgAEBAYEBwAEAATgBgAEBAYABAQHgAQMBAAF5AYAB
AQHAAQEB4AEDAYAB8AGAAQEBwAEBAcABAwHBAeEBgAEBAcABAQHgAQMB8AEFAcABAQHAAQEB9gE3
AfABAwL/AeABAwH+AT8B+gEvDP8BgAEBAYABAQHgAQEC/wMAAQEBwAEBAv8DAAEBAcABAQL/AgAB
gAEBAcABAQL/AgABgAEBAcABAQL/AgABgAEAAcABAQL/AgABgAEAAcABAQGAAwABgAEAAcABAQL/
AgABgAEAAcABAQL/AgABgAEDAcABAQL/AgABgAEAAcABAQL/AgABgAH4AcABAQL/AQABcwH/AfwB
wAEDAv8BAAL/AsABBwX/AecB4AEPCP8L'))
	#endregion
	$imagelist2.ImageStream = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$imagelist2.TransparentColor = [System.Drawing.Color]::Transparent 
	$imagelist2.Images.SetKeyName(0,'grey-dotted1.ico')
	$imagelist2.Images.SetKeyName(1,'Folder Close.png')
	$imagelist2.Images.SetKeyName(2,'Open.png')
	$imagelist2.Images.SetKeyName(3,'document_color_green.ico')
	$imagelist2.Images.SetKeyName(4,'document_flat-import.ico')
	$imagelist2.Images.SetKeyName(5,'manufacturing_process_1_gear.ico')
	$imagelist2.Images.SetKeyName(6,'manufacturing_process_1_gear_empty-import.ico')
	$imagelist2.Images.SetKeyName(7,'storage_network.ico')
	$imagelist2.Images.SetKeyName(8,'storage_network_green.ico')
	$imagelist2.Images.SetKeyName(9,'storage_disc-info.ico')
	$imagelist2.Images.SetKeyName(10,'storage_disc-ok.ico')
	$imagelist2.Images.SetKeyName(11,'link.ico')
	$imagelist2.Images.SetKeyName(12,'link-ok.ico')
	$imagelist2.Images.SetKeyName(13,'tag_blue.ico')
	$imagelist2.Images.SetKeyName(14,'organization.ico')
	$imagelist2.Images.SetKeyName(15,'list-info.ico')
	$imagelist2.Images.SetKeyName(16,'list-ok.ico')
	$imagelist2.Images.SetKeyName(17,'Clock.ico')
	$imagelist2.Images.SetKeyName(18,'Clock-Selected.ico')
	$imagelist2.Images.SetKeyName(19,'registry_editor.ico')
	#
	# toolstripseparator1
	#
	$toolstripseparator1.Name = 'toolstripseparator1'
	$toolstripseparator1.Size = New-Object System.Drawing.Size(249, 6)
	#
	# SaveLnkToJson
	#
	$SaveLnkToJson.BackColor = [System.Drawing.Color]::Honeydew 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAArQMAAAKJUE5HDQoaCgAA
AA1JSERSAAAAIAAAACAIBgAAAHN6evQAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAADT0lEQVRYR72XbUhTURzGr7W2UgrfIJBQVIKEidHrl6Cil43FEiJjYixZWBjIFkYMBdlk
oZIkfZG+FQRFHxKliWOKIZRMnBhFfogQxUgxUhRlCsun/znuLjennrvgPvDbuefuPOc+mw9HlSRJ
+5FeIPO9K6CYjX5ikNhFCAuDgWG8ePmGbzDhH8VEbyyTMXyKga1nvi6vHy7PYzlEFiEsNLc8hcF0
jZuTEfNZbffwsM4tBygkhIWOzm7cvHU3JoDf3wuv17uJ7u5uPgYCgcjKhAFKCGHxr49twK6TEfPF
BThBCGtTgCL9eXkjTqLi7cRGP7FtMdH1zoebldV8MRMb1Swm3nZ4cd1SyRfKAdQsJl697oDRfCP6
MDaqWUy0P3sO/dEz0YexUc1i4klbO3Lzi+WFHDWLiUfNbUjPzuMcyMzjC9QsJlzuZmh02VHYPTWL
ibp6D03SCJ38hqrFhLO+kSapkZsaPqpZzIQBRIrJ1NPTg87Ozi0ZGBiIrEwY4CQRH2B9FCmmiMJr
QGiFXkjMx/wPnC5+TawHuHiplCasAxI0mgw+ihSTyefzJfzkMn19/ZhfWuVrmY/5axxOfk3wAEOS
tA/pGbn8pkabyUeRYu6kpVAYvxdWMLe4wufMx/y37zjkPXmAHGKE/jTDbvbwlP38TZFiKhXzMf+V
q5bIvusB9hAFxAciTKwRwsVUCvOfu2CW5zxACqEjDhLFxGVix2L+D8dPRY91HiBeewmhYiZLkf70
tgHYNyJcTOWkoeBwiTzfMoBQMWUFgyMYHg5GZv9kNBphMBiirPt0yC/cPgCTUDGZfs2F0NraCo/H
g4Vlfiuq0tJSmM1mmEwmxQGEisk0PjWPhoYG2O12TE0vYyEEDjv7qqqqYLPZYLVaUV5eHvGJBYjX
pmJqtRlYovMlMDqJ6upqVFRUIPh1Bt+mVjmLFMLtdvNwTqcTtbW1kYcmF2BTMbW6TMzM0S+j92Ow
WCwoKytD/+A4hr7Mc2bn1tDS0oKmpiY0NjbC5ZLP/9SkA8QUM4WKuUSfcuLnMj6PTXImp0P4MbvK
mV8Mw+G4Tz8aB2pq7BzyI+fQETqM9HKAY4SwEhVTKX82ECQU/Q8ZX8yzBCunUSEGgnn1kiRl/QV8
A0bMkdCE2AAAAABJRU5ErkJgggs='))
	#endregion
	$SaveLnkToJson.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$SaveLnkToJson.Name = 'SaveLnkToJson'
	$SaveLnkToJson.Size = New-Object System.Drawing.Size(393, 38)
	$SaveLnkToJson.Text = 'Save Tree to Json'
	$SaveLnkToJson.Visible = $False
	$SaveLnkToJson.add_Click($SaveLnkToJson_Click)
	#
	# toolstripseparator11
	#
	$toolstripseparator11.Name = 'toolstripseparator11'
	$toolstripseparator11.Size = New-Object System.Drawing.Size(390, 6)
	$toolstripseparator11.Visible = $False
	#
	# SaveStream
	#
	$SaveStream.ForeColor = [System.Drawing.Color]::DarkGreen 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAkwIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAACNUlEQVQ4T6WSX2iSURjGjzD8wJFs4aCLQKYY1RYNHIlDJelCSTAaJot1IQYNQ8FwiTAG
GgmDomIjWV2JnyzwIpC6kIouomBDIjFGTHZh7KYCdzVxEvj0nqObuYIFPfDwnfP++Z3zHj4m9Z9+
yfoMYEyN7cL6oWaMQdmvxYDGUKA1iZrvPVikRN9fGw6aA6Kxeag1/NAOQFKpaKPAv4gDguFoL2A+
nhQJLvvHUXjOMqSSM5iLRURMVWI4utHO8zoOGBzSdwG3orF9ANfKUgQvUn7cuWHE9LlunIvXHQDo
EaIAT+zpTeE57gbGkZo9hdo7M7xjlGs1RI7XBYLh3wBKPa5O+3sAXEE7Q/3TCLDrRqtkxZSRodXc
FnWeK9egHtJ1AW63lzYKkdxzvd5AwELQbz6CTAKfbfCcYSiursLhvESPONwF2C+4YJpw/GGum1YO
8QONy6h9sGGSHrharRJA2wWYzHboDEYKSGR1j8vlL+Imu5vXeyDrZfFPkCQdxk02aI6dgMvlFaeu
FYvYqFTEOhKJ0Dh1zNBNOCQnLyCZXICvPSpNTgDreYcAXOwA8vk8Xr1+K9aJRALxeBzNZlNAnq3k
IKeWsWaxdCDS8I7Z4oRWNyYAO01g+clTyNkcWgSQZRmZTAbpdFoAZ6mpEphCzedEqH2Lgbkjgydb
I6MTAsCbKptfUd36IRqy2ey+OaTR+In3oTDi1Hz/4ZIYQyLfVkjH6/TlgUOsRIke8NHi4++0/18x
9gu56xvVOQsp2AAAAABJRU5ErkJgggs='))
	#endregion
	$SaveStream.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$SaveStream.Name = 'SaveStream'
	$SaveStream.Size = New-Object System.Drawing.Size(330, 38)
	$SaveStream.Text = 'Save AlternateDataStream As'
	$SaveStream.ToolTipText = 'Export the ADS to a file'
	$SaveStream.Visible = $False
	$SaveStream.add_Click($SaveStream_Click)
	#
	# notifyicon1
	#
	$notifyicon1.BalloonTipIcon = 'Info'
	$notifyicon1.BalloonTipTitle = 'LNK & Jumplist Browser'
	$notifyicon1.ContextMenuStrip = $contextmenustrip3
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAIZEAAACAAABAAQAMDAAAAEAIACoJQAARgAAACAgAAABACAA
qBAAAO4lAAAYGAAAAQAgAIgJAACWNgAAEBAAAAEAIABoBAAAHkAAACgAAAAwAAAAYAAAAAEAIAAA
AAAAgCUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAADg4OCBUVFSMpKSlZQ0NDh1RUVKVVVVWzUVFRnkJCQnorKytGGhoaFhQU
FAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAEBAR8BAQFLERERlUtLS+Z/f3/+k5OT/pmZmf+g
oKD+pqam/qKiov6EhIT9QUFB2AsLC3oCAgI4AgICEgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
/rKUDP/LqRL+y6kS/s+vHP+skBj+hm8M3IFrCwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAs6A6AaeVN3zXwlD72Lgk/+DG
Qv/lz1T/3MRG/82xK//Fpxv/yKcT/8yqE//MqhP/zKoT/8mnE/+bfw3+eWUMYwAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAClki9BvaxOz9a9P/3RsRz+0K8Z/tCwHf/NrBf+zKoT/syqE//LqRL+zKoS/rCS
D/96Zgubg20MAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtKA5A6qXNES1o0Kmvqk85MmvMvzL
riX+yqsd/sanGf+3mhT+l38O435pDHaIcQwDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAArJgvCKGMJiidiSNGm4cfV5B8FlGQeREwjncPCQAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD///////8AAP4AP////wAA8AAP////AADAAAP///8AAIAAAP///wAAAAAAf///AAAAAAB/
//8AAAAIAH///wAAwD4A////AADAfwB///8AAMB/gD///wAAwH/AH///AADAf+AP//8AAMA/8Af/
/wAAwB/4A///AADgD/wB//8AAOAH/gD//wAA8AP/AH//AAD4Af8Af/8AAPwA/AB//wAA/gB4AD//
AAD/ADAAP/8AAP+AEAAf/wAA/8AAAA//AAD/4AAAB/8AAP/wAAAD/wAA//gAAAH/AAD//AAAAP8A
AP/+AAEAfwAA//8AA4A/AAD//4ADwB8AAP//4AHgDwAA///8APAHAAD///8AeAMAAP///wA8AQAA
////gB4BAAD////gDwAAAP///+ADgAAA////8AAAAAD////4AAAAAP////wAAAAA/////gABAAD/
////gAEAAP/////AAwAA//////gPAAD///////8AAP///////wAA////////AAAoAAAAIAAAAEAA
AAABACAAAAAAAIAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKSkp
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
RcOtP8TRtC7+0LAd/8yrFP/MqhL/y6kS/6mMD/OBawxHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAKmWMiesmTNkrJYoiKOMHIyRehFqhnANGgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPw////gA///gAH//wAAf/8AAH//gYD//4PAf/+D4D//g/Af
/4H4D//A/Af/wH4D/+A+A//wHAP/+AgB//wAAP/+AAB//wAAP/+AAB//wAAP/+AEB//4AgP//wEB
//+AgP//wED//+AA///wAP//+AD///wB////A///////////KAAAABgAAAAwAAAAAQAgAAAAAABg
CQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUFBQIZGRkfQ0NDS01NTVQvLy8wDg4OBgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAHAAAANCgoKKZ0dHT4gICA/oaGhv+SkpL+Xl5e0ggICFIAAAARAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0AAAA/LS0tsnZ2dv5+
fn7+m5ub/sHBwf7ExMT+l5eX/nt7e+cICAheAAAAGgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABEXFxddiIiI/nd3d/9/f3/6W1tbilxcXGySkpLY4eHh
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
AP/AAAD/4AAA//8AAAs='))
	#endregion
	$notifyicon1.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$notifyicon1.Text = 'LNK & Jumplist Browser'
	$notifyicon1.Visible = $True
	#
	# contextmenustrip3
	#
	$contextmenustrip3.ImageScalingSize = New-Object System.Drawing.Size(32, 32)
	[void]$contextmenustrip3.Items.Add($toolstrip3_About)
	[void]$contextmenustrip3.Items.Add($toolstripseparator12)
	[void]$contextmenustrip3.Items.Add($MinimizeWindow)
	[void]$contextmenustrip3.Items.Add($RestoreWindow)
	[void]$contextmenustrip3.Items.Add($toolstripseparator14)
	[void]$contextmenustrip3.Items.Add($toolstrip3_GitHub)
	[void]$contextmenustrip3.Items.Add($toolstripseparator13)
	[void]$contextmenustrip3.Items.Add($toolstrip3_Exit)
	$contextmenustrip3.Name = 'contextmenustrip3'
	$contextmenustrip3.Size = New-Object System.Drawing.Size(243, 212)
	#
	# toolstrip3_About
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAA8gIAAAKJUE5HDQoaCgAA
AA1JSERSAAAAIAAAACAIBgAAAHN6evQAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABnVAAAZ1QG1
aOuAAAAClElEQVRYR+2WzWsTQRjGN35dtGY3UYofiAiCH+BJEfwnBKG32ppZE7EIghTUg8aLHgQt
4qXe9KBoEEVMdmIiVBFEUFAPHkQUevDgRRCpWqkd3+m+0NndZzbZkh4Ef/CwsO+87zMzO7Mzzr9L
5dXytSMTq5yB2gp+s7isKct1rpDHSQ3XDz57fjDr+VLNPUXwxRVBi54n88NyM6f0Bq/S3uQJeZ2K
/w4NO2qGOni3WGlu4xILxxONMo3sOzDpLCF/0eycchyV43JZUDka8VVYOKPok93W64ULdwcljsUL
xbV/7LU6c29SDV97B+OmaBZvdT0TbqkxhIqY2nfuuTIZHO/cCb1A2cJOUbTWu778BgsYOnDlDVuH
jN75CNvFNF0oBTvYCkNTNQ4SE9o40lbvv4bmk1NKbR99CtslFTxgqyR9B9tF2j4/cWKPJOSfvkOt
rWwZRW85mNSF+o804XskGuRZtoxC376GEmwyQXGbyOcZW0ahVfoBJdhkguI26R8bW0bJ+v1NUDxN
+aN1j22ZanUJapgmExRPU2Ho4QZ2nocC0/GGaTJB8TTpHce289Aa+IQa22SC4jbR2TAFf8sUvB9v
nCYTFLeJdsELtozi+s1jKMEmExS3KzjPllH0jSfDpYOtQ1AcK5il3baLLZNQoxvJJCwTFLfoMVth
8qX6FvpGP0BiQiYoDjRTLAd72MoOHRgnQHJCJigeF039RbboDP0ub6IiCxXVaznViWVcvgvoDqfv
cqhYVtHI2/2Dj1Zy5SyoHK2H01l2RkR09tMgLme+kMbxDsudNIq63kLQCOtJoVTfyyV6g+4IzcYF
Kv4yvPMbhnqWhHxLHb20WjR2c8oiMlBbqi+w+no1d7JlWmD/MXGcv6U8dwaagS5xAAAAAElFTkSu
QmCCCw=='))
	#endregion
	$toolstrip3_About.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$toolstrip3_About.Name = 'toolstrip3_About'
	$toolstrip3_About.Size = New-Object System.Drawing.Size(242, 38)
	$toolstrip3_About.Text = 'About'
	$toolstrip3_About.add_Click($toolstrip3_About_Click)
	#
	# toolstrip3_Exit
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAzwEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAIAAAACAIBgAAAHN6evQAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABnVAAAZ1QG1
aOuAAAABcUlEQVRYR+2WMU7DQBBFHVGDIBUHILREQEPPQSk4QBDU0HIFLDmiQDQIaKCBYthx/qK1
/b9jFEcuyJNek92ZP4k3yWYbNjAeJtl5fjC6D37lk5GtpPcIvbwn2reD8G/abBVDz05D+LS0QR+G
3ojRrOXdR8PjQIyGFvYoYjSsKFocbdPXU5ftQYyGFbnzk7HZy5PZzSVdd212Yfb6bPPTMV13EaNh
RcV0ZxEeIUOU4ZEwRDHdbexxEaNhRfnhltntDN1BMkQl3Lm7LmsqPSBiNKyoVAzxl3AXMRpW9Csb
ImVJuIsYDSuqqIboEO4iRsOK6tpV7WN3Wr4dqYjRsKLUxjNP6TAEYjSsKMoOXNu3g4kYDSty5Wln
Z6JlCMRoWJH/qNjHG7oH6geuPsTnuxXHe5UeUcRoWJH7eLa/GEKd9jhECPe9jXWIGA0rivr/AQ2P
hrVyD1uDiNGwoj5FjGb4C8nQV7LBL6UOhhjmWr7hn5FlP2yGEjmU89+wAAAAAElFTkSuQmCCCw=='))
	#endregion
	$toolstrip3_Exit.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$toolstrip3_Exit.Name = 'toolstrip3_Exit'
	$toolstrip3_Exit.Size = New-Object System.Drawing.Size(242, 38)
	$toolstrip3_Exit.Text = 'Exit'
	$toolstrip3_Exit.add_Click($toolstrip3_Exit_Click)
	#
	# toolstripseparator12
	#
	$toolstripseparator12.Name = 'toolstripseparator12'
	$toolstripseparator12.Size = New-Object System.Drawing.Size(239, 6)
	#
	# toolstripseparator13
	#
	$toolstripseparator13.Name = 'toolstripseparator13'
	$toolstripseparator13.Size = New-Object System.Drawing.Size(239, 6)
	#
	# toolstrip3_GitHub
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
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
rfK+AAAAAElFTkSuQmCCCw=='))
	#endregion
	$toolstrip3_GitHub.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$toolstrip3_GitHub.Name = 'toolstrip3_GitHub'
	$toolstrip3_GitHub.Size = New-Object System.Drawing.Size(242, 38)
	$toolstrip3_GitHub.Text = 'Visit Github'
	$toolstrip3_GitHub.add_Click($toolstrip3_GitHub_Click)
	#
	# TreeSearch
	#
	$TreeSearch.Alignment = 'Right'
	$TreeSearch.BackColor = [System.Drawing.Color]::Honeydew 
	$TreeSearch.BorderStyle = 'FixedSingle'
	$TreeSearch.Font = [System.Drawing.Font]::new('Consolas', '9')
	$TreeSearch.Margin = '1, 0, 50, 0'
	$TreeSearch.MaxLength = 50
	$TreeSearch.Name = 'TreeSearch'
	$TreeSearch.Size = New-Object System.Drawing.Size(400, 29)
	$TreeSearch.Text = 'Search'
	$TreeSearch.ToolTipText = 'Type Text and press ENTER to search
or click to clear'
	$TreeSearch.Visible = $False
	$TreeSearch.add_KeyDown($TreeSearch_KeyDown)
	$TreeSearch.add_KeyPress($TreeSearch_KeyPress)
	$TreeSearch.add_Click($TreeSearch_Click)
	#
	# Tree1Search
	#
	$Tree1Search.AutoCompleteMode = 'Suggest'
	$Tree1Search.BackColor = [System.Drawing.Color]::PapayaWhip 
	$Tree1Search.FlatStyle = 'Standard'
	$Tree1Search.Margin = '10, 0, 1, 0'
	$Tree1Search.Name = 'Tree1Search'
	$Tree1Search.Size = New-Object System.Drawing.Size(364, 33)
	$Tree1Search.Text = 'Select Jumplist by App Name'
	$Tree1Search.Visible = $False
	$Tree1Search.add_SelectedIndexChanged($Tree1Search_SelectedIndexChanged)
	#
	# GetNavPane
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetNavPane.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetNavPane.Name = 'GetNavPane'
	$GetNavPane.Size = New-Object System.Drawing.Size(252, 30)
	$GetNavPane.Text = 'Get NavPane'
	$GetNavPane.ToolTipText = 'Read Current User''s Explorer NavPane from HKCU'
	$GetNavPane.Visible = $False
	$GetNavPane.add_Click($GetNavPane_Click)
	#
	# MinimizeWindow
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAA2AMAAAKJUE5HDQoaCgAA
AA1JSERSAAAAIAAAACAIBgAAAHN6evQAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAADeklEQVRYR72Xa0hTYRzGX7Wy1OPUkmwVGZESFN0kU8IUlEJwqagopslg2gRhMptkmBqK
ntwXR4HK7JMQEwzDYEEf/JLgZQM1bBRdPig6NzbpMhS8/Pu/p9djRaZs6zzwY+f/7LDn2XtuG9lQ
/iMIUxrXuT8p7vx+6G/+Bgqe4uSSf8PGKZQDnFLBc3filRy/P5nj4xVc5dWGMBa3qYwml+7yXee3
lEY3pPqAvPYjcDqbCJ31JBgGCBFpIweBZmVo31ezeEKSNJ89/TaACY/3WL8CRKhHoXsFBLqWASJx
7sJQqL0isFqdCJ04m6YAkjSfvuBmgFAgWf0WjOMARqv3dFswMN8MqQMgkPIMIKrADPcw5UN4uMC7
0FCow9k4CpBYPg0k6lL4zwKl49D2EqD6qW+cVY1AdGa/yIWKcSgPOgllGLpBeWQi8JiVUDwCGH1E
KJCUNwSdw/hNRqSh8zUWyHlFC5wQCmQWmeBixnNJoZkYHSsU0Hc8BqnV1t6xWYDXG5gtnVra9JsF
Wnk9s6XTgxZ+s0BjcyuzpRPNFAvUNzYzWzrRTLFAXX0Ts6UTzRQL6OruM1s60UyxgFZXx2zpRDPF
AhqtjtnSiWaKBao0Wmb/Py0v4+PxF9FMsUBllYbZ/pPBYIDRUXzsoZxOJ8TFxYFcLhdmKpopFqio
rGK2f2QymaCmpkYI3koZ167TAseFAqqKSmZLI7fbDaGhHC2gQwJImaqCveWb6DLPzs6y6d+yWK2Q
lpam7OvrCyKlZSpme6/e3l5QqXb+OXa7AywWC9/Q0BBIikvLmO2bPB78cbhDORxOWFlZGcNDYCBF
xbeYLZ0ceIKur69PYQELKSi6yWzvhcvJtnYmugK0QHZ2djsp9EOBkJAQtrUz0QJra2tvbDZbPMnO
zZ9jvteiJ+DMzAybttfc/Pyaw+GYLCkpSSB5pbcVihu59hs5eeALmmqtcBnOz9uFm5DL5cZrfhEW
FxeFVzpTf2FhYRXPAbtarZ7Ac6AdEbQHiUIOI0e94BhyBu+Cw/TYbsOky+V6gfsPIucRUYFIELLL
C3Yj55Dhnp6ecQyxbsXS0pKpsLBQjvtGIzLEb6Jf4LRMJks3m83p09PTg3i46eUhgIdnKCsry4L7
GJEDCF3xYMSvoiu4D9mLPETGYmJinuAtNyw2NjYeZ/y7SE4hEQiGk8AfaDoL6RQX8XgAAAAASUVO
RK5CYIIL'))
	#endregion
	$MinimizeWindow.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$MinimizeWindow.Name = 'MinimizeWindow'
	$MinimizeWindow.Size = New-Object System.Drawing.Size(242, 38)
	$MinimizeWindow.Text = 'Minimize Window'
	$MinimizeWindow.add_Click($MinimizeWindow_Click)
	#
	# RestoreWindow
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAwgQAAAKJUE5HDQoaCgAA
AA1JSERSAAAAIAAAACAIBgAAAHN6evQAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAEZElEQVRYR72Wf0yUdRzHPyrR5HgITig6iEA5pTjExEEwBMtRRvPoCBwMQ4YBQlBHR3d1
DgQHwcUtR1kDuoarlsOGwVoDhdXYaoOhm6OQbBowtTUZ1hFsbrbefZ7nnjsk/ceDPe/ttef5vp/v
87zf9/y6h9zKPQ7/Yse/wv8paF949F6+G71NZFZIWcakoC/uFYr1NuGtLcWCbUOKYNuiFyrSj/jL
cUvKaJgzP/3O7N9p9TexawVoLFcgmCc9iGM7PYheIg8t9AjErAzTr9VyPFGycWqxZxK4sOg95+eB
wPJRdN6GRMctIIjHHRwKS6rEP9VJaOdx9ziQbPzNyatrpAIp5RfhGAMc572n8xwH5vZjVy8k0k4D
6n39OMwplwMCJC6pVLDy2DEKJJVOgNSJAa4ChWNoGQCqT66M+JIRhGT2eNheNobSdVoUcaib0qAk
2DhrR8EIODpcKpCc8z3af+RfMqIM7T9wAcOgWGCTVCAzvxsJGX2KImZydKRUwN72EZRWS2vbUgGb
/QPZVk5NLfalAs02u2wrp6NNtqUC9Y3Nsq2cxExPgdr6RtlWTmKmp4C1tkG2lZOY6SlgttbJtnIS
Mz0FTGarbCsnMdNTwGgyy7ZyEjM9BaqMJtlWTmKmp0BFlVG2V08z85OwfVuDnfXhiKokpDVEwD5g
wbXFK9L2assdZ6CsokoyV0tFHRnQWAmpZwmGaT/kzQm8XI/UAYLmbf5HdLyIvoFekD89KRUoKauQ
d125EqyBSPiKkD8vIH/hbvLmVdjeTdBV++HMaF+tVKCopEzefWUq79qLuC8I2bO+98Rwwxe7J9ZI
xJ4g6Fu2Tn891RVJhUUl8iG817WFywg2ETJnmKt3s4f9hO8IpnE9asazkDBE0vzWIVMlFRQWyYfx
Xs3fGKE7SXjmEmHXBCHlHK9PusbiMq6fYLmQI88Gnj+rgdbBX0mdu89QfsEB2fZeKXUa6RcmjhBi
+BrvH94BLd8LyVwkpo9QNbJHnunSE1w2nm/KrWbVddqXv1+2vZf4qG3jAlFfEoad/EXKar34BsK7
CAeH06SxWzq+T3T8hMTzZQh5lW5S3ioUSKkNxeYeQtin/Bl+h7qvLv/YieVC2tNcYJCw+RTB7xX6
mV7Kzv1d3u61mvgeCHufsIlPv6ZteQm3YjsIj3/OwVxAJMxOEErIQTmFh/T6rOw/sgw58IaGpkac
6OtAQDlfgs8I4Z18cNvyEroPfRD2MWEjFxAR54nzH6qkZ6V3AcuXUTNhzGP3SdSfzrn6F97VzQQf
JkS0E0KP8bLJVWJbmwohrS7fTTC/KdcfoAHed5nWMusYn/vl+Kn3Qp23bzRrX6e/1BYuwKc3mAsI
XEjd6Bq7UZs5vICmyEAP876rp2NdRwJnnL+8+Vyzdlp1kBDEQcF1zFHXMqiGIPq+eTRIO6Uzt3pK
T0/3IYE28OrG6Ojol5/aG/1J4muanyIPkTOwkG49YKDrFENDvN3MxDERTCARrf0PCqhDzxdPZKYA
AAAASUVORK5CYIIL'))
	#endregion
	$RestoreWindow.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$RestoreWindow.Name = 'RestoreWindow'
	$RestoreWindow.Size = New-Object System.Drawing.Size(242, 38)
	$RestoreWindow.Text = 'Restore Window'
	$RestoreWindow.add_Click($RestoreWindow_Click)
	#
	# toolstripseparator14
	#
	$toolstripseparator14.Name = 'toolstripseparator14'
	$toolstripseparator14.Size = New-Object System.Drawing.Size(239, 6)
	#
	# GetTaskBand
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetTaskBand.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetTaskBand.Name = 'GetTaskBand'
	$GetTaskBand.Size = New-Object System.Drawing.Size(252, 30)
	$GetTaskBand.Text = 'Get Task Band'
	$GetTaskBand.ToolTipText = 'Read Current User''s LNKs Pinned to Taskbar from HKCU'
	$GetTaskBand.Visible = $False
	$GetTaskBand.add_Click($GetTaskBand_Click)
	#
	# GetStartPage2
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetStartPage2.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetStartPage2.Name = 'GetStartPage2'
	$GetStartPage2.Size = New-Object System.Drawing.Size(252, 30)
	$GetStartPage2.Text = 'Get StartPage2'
	$GetStartPage2.ToolTipText = 'Read Current User''s LNKs Pinned to StartMenu from HKCU'
	$GetStartPage2.Visible = $False
	$GetStartPage2.add_Click($GetStartPage2_Click)
	#
	# GetLockScreen
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetLockScreen.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetLockScreen.Name = 'GetLockScreen'
	$GetLockScreen.Size = New-Object System.Drawing.Size(252, 30)
	$GetLockScreen.Text = 'Get LockScreen'
	$GetLockScreen.ToolTipText = 'Read Current User''s Lockscreen Wallpaper info from HKCU'
	$GetLockScreen.add_Click($GetLockScreen_Click)
	#
	# GetSearchMRU
	#
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABVTeXN0
ZW0uRHJhd2luZy5CaXRtYXABAAAABERhdGEHAgIAAAAJAwAAAA8DAAAAJgEAAAKJUE5HDQoaCgAA
AA1JSERSAAAAEAAAABAIBgAAAB/z/2EAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAABYlAAAWJQFJ
UiTwAAAAyElEQVQ4T2OgGPAWr5nkfejhf3TMVbRiMlCaEaIKD/Da/+x/yff/GNjvyPP/QGk2iCo8
wHHHw/+ZL/7/TwdiZNpjD9gALogqPMB83cP/YXf+Y2C7zc+IM0BnyZ3/zif+Y2CTlXeJM0B+0sn/
uqueYGC1aReIMwAU2qLt+/+Lt+/5j0xzZS2YDpKGqMIPQFEFCm2QYnRMOBZwpoP85VOA0kyE5Amm
A4LphFA6IJhOCKUDgumEUDogmE4IpQOC6YRQOgCFNm55Bi4AW/SimGtrwKkAAAAASUVORK5CYIIL'))
	#endregion
	$GetSearchMRU.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$GetSearchMRU.Name = 'GetSearchMRU'
	$GetSearchMRU.Size = New-Object System.Drawing.Size(252, 30)
	$GetSearchMRU.Text = 'Get Search MRU'
	$GetSearchMRU.Visible = $False
	$GetSearchMRU.add_Click($GetSearchMRU_Click)
	$contextmenustrip3.ResumeLayout()
	$contextmenustrip2.ResumeLayout()
	$contextmenustrip1.ResumeLayout()
	$statusstrip1.ResumeLayout()
	$menustrip1.ResumeLayout()
	$splitcontainer1.ResumeLayout()
	$Jumplist_Browser.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $Jumplist_Browser.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$Jumplist_Browser.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$Jumplist_Browser.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$Jumplist_Browser.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $Jumplist_Browser.ShowDialog()

}
#endregion Source: MainForm.psf

#Start the application
Main ($CommandLine)

# SIG # Begin signature block
# MIIviAYJKoZIhvcNAQcCoIIveTCCL3UCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAwBD1EmcS176q0
# RhINI5sgqtpdWLQAH9Vvc5H6aKqD5KCCKI0wggQyMIIDGqADAgECAgEBMA0GCSqG
# SIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJHcmVhdGVyIE1hbmNo
# ZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBMaW1p
# dGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAx
# MDAwMDAwWhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwS
# R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
# b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZp
# Y2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvkCd9G7h6naHHE1F
# RI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYLU+rLTCTA
# vHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PM
# NSyLXgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H
# 9Wu4+xQrr7eqzNZjX3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+f
# mUnxLd+sdE0bmLVHxeUp0fmQGMdinL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwN
# XugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQojPpbxB+zirynvgqV/0DCktDAO
# BgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8EdDByMDigNqA0
# hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
# LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRl
# U2VydmljZXMuY3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDO
# T8TF9gBYzKa2vBRJaAR26ObuXewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdP
# WvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG3S/G4GrDwzQDLH2W3VrCDqcKmcEF
# i6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnxWUgwIWUDbOzpIXPs
# mwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLXbLGj
# D56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphu
# MIIFbzCCBFegAwIBAgIQSPyTtGBVlI02p8mKidaUFjANBgkqhkiG9w0BAQwFADB7
# MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
# VQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
# AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTIxMDUyNTAwMDAwMFoXDTI4
# MTIzMTIzNTk1OVowVjELMAkGA1UEBhMCR0IxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDEtMCsGA1UEAxMkU2VjdGlnbyBQdWJsaWMgQ29kZSBTaWduaW5nIFJvb3Qg
# UjQ2MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAjeeUEiIEJHQu/xYj
# ApKKtq42haxH1CORKz7cfeIxoFFvrISR41KKteKW3tCHYySJiv/vEpM7fbu2ir29
# BX8nm2tl06UMabG8STma8W1uquSggyfamg0rUOlLW7O4ZDakfko9qXGrYbNzszwL
# DO/bM1flvjQ345cbXf0fEj2CA3bm+z9m0pQxafptszSswXp43JJQ8mTHqi0Eq8Nq
# 6uAvp6fcbtfo/9ohq0C/ue4NnsbZnpnvxt4fqQx2sycgoda6/YDnAdLv64IplXCN
# /7sVz/7RDzaiLk8ykHRGa0c1E3cFM09jLrgt4b9lpwRrGNhx+swI8m2JmRCxrds+
# LOSqGLDGBwF1Z95t6WNjHjZ/aYm+qkU+blpfj6Fby50whjDoA7NAxg0POM1nqFOI
# +rgwZfpvx+cdsYN0aT6sxGg7seZnM5q2COCABUhA7vaCZEao9XOwBpXybGWfv1Vb
# HJxXGsd4RnxwqpQbghesh+m2yQ6BHEDWFhcp/FycGCvqRfXvvdVnTyheBe6QTHrn
# xvTQ/PrNPjJGEyA2igTqt6oHRpwNkzoJZplYXCmjuQymMDg80EY2NXycuu7D1fkK
# dvp+BRtAypI16dV60bV/AK6pkKrFfwGcELEW/MxuGNxvYv6mUKe4e7idFT/+IAx1
# yCJaE5UZkADpGtXChvHjjuxf9OUCAwEAAaOCARIwggEOMB8GA1UdIwQYMBaAFKAR
# CiM+lvEH7OKvKe+CpX/QMKS0MB0GA1UdDgQWBBQy65Ka/zWWSC8oQEJwIDaRXBeF
# 5jAOBgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zATBgNVHSUEDDAKBggr
# BgEFBQcDAzAbBgNVHSAEFDASMAYGBFUdIAAwCAYGZ4EMAQQBMEMGA1UdHwQ8MDow
# OKA2oDSGMmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2Vy
# dmljZXMuY3JsMDQGCCsGAQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29j
# c3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4IBAQASv6Hvi3SamES4aUa1
# qyQKDKSKZ7g6gb9Fin1SB6iNH04hhTmja14tIIa/ELiueTtTzbT72ES+BtlcY2fU
# QBaHRIZyKtYyFfUSg8L54V0RQGf2QidyxSPiAjgaTCDi2wH3zUZPJqJ8ZsBRNraJ
# AlTH/Fj7bADu/pimLpWhDFMpH2/YGaZPnvesCepdgsaLr4CnvYFIUoQx2jLsFeSm
# TD1sOXPUC4U5IOCFGmjhp0g4qdE2JXfBjRkWxYhMZn0vY86Y6GnfrDyoXZ3JHFuu
# 2PMvdM+4fvbXg50RlmKarkUT2n/cR/vfw1Kf5gZV6Z2M8jpiUbzsJA8p1FiAhORF
# e1rYMIIFgzCCA2ugAwIBAgIORea7A4Mzw4VlSOb/RVEwDQYJKoZIhvcNAQEMBQAw
# TDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkds
# b2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMTQxMjEwMDAwMDAwWhcN
# MzQxMjEwMDAwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
# NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJUH6HPKZvnsFMp7PPcNCPG0RQss
# grRIxutbPK6DuEGSMxSkb3/pKszGsIhrxbaJ0cay/xTOURQh7ErdG1rG1ofuTToV
# Bu1kZguSgMpE3nOUTvOniX9PeGMIyBJQbUJmL025eShNUhqKGoC3GYEOfsSKvGRM
# IRxDaNc9PIrFsmbVkJq3MQbFvuJtMgamHvm566qjuL++gmNQ0PAYid/kD3n16qIf
# KtJwLnvnvJO7bVPiSHyMEAc4/2ayd2F+4OqMPKq0pPbzlUoSB239jLKJz9CgYXfI
# WHSw1CM69106yqLbnQneXUQtkPGBzVeS+n68UARjNN9rkxi+azayOeSsJDa38O+2
# HBNXk7besvjihbdzorg1qkXy4J02oW9UivFyVm4uiMVRQkQVlO6jxTiWm05OWgtH
# 8wY2SXcwvHE35absIQh1/OZhFj931dmRl4QKbNQCTXTAFO39OfuD8l4UoQSwC+n+
# 7o/hbguyCLNhZglqsQY6ZZZZwPA1/cnaKI0aEYdwgQqomnUdnjqGBQCe24DWJfnc
# BZ4nWUx2OVvq+aWh2IMP0f/fMBH5hc8zSPXKbWQULHpYT9NLCEnFlWQaYw55PfWz
# jMpYrZxCRXluDocZXFSxZba/jJvcE+kNb7gu3GduyYsRtYQUigAZcIN5kZeR1Bon
# vzceMgfYFGM8KEyvAgMBAAGjYzBhMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
# BTADAQH/MB0GA1UdDgQWBBSubAWjkxPioufi1xzWx/B/yGdToDAfBgNVHSMEGDAW
# gBSubAWjkxPioufi1xzWx/B/yGdToDANBgkqhkiG9w0BAQwFAAOCAgEAgyXt6NH9
# lVLNnsAEoJFp5lzQhN7craJP6Ed41mWYqVuoPId8AorRbrcWc+ZfwFSY1XS+wc3i
# EZGtIxg93eFyRJa0lV7Ae46ZeBZDE1ZXs6KzO7V33EByrKPrmzU+sQghoefEQzd5
# Mr6155wsTLxDKZmOMNOsIeDjHfrYBzN2VAAiKrlNIC5waNrlU/yDXNOd8v9EDERm
# 8tLjvUYAGm0CuiVdjaExUd1URhxN25mW7xocBFymFe944Hn+Xds+qkxV/ZoVqW/h
# pvvfcDDpw+5CRu3CkwWJ+n1jez/QcYF8AOiYrg54NMMl+68KnyBr3TsTjxKM4kEa
# SHpzoHdpx7Zcf4LIHv5YGygrqGytXm3ABdJ7t+uA/iU3/gKbaKxCXcPu9czc8FB1
# 0jZpnOZ7BN9uBmm23goJSFmH63sUYHpkqmlD75HHTOwY3WzvUy2MmeFe8nI+z1TI
# vWfspA9MRf/TuTAjB0yPEL+GltmZWrSZVxykzLsViVO6LAUP5MSeGbEYNNVMnbrt
# 9x+vJJUEeKgDu+6B5dpffItKoZB0JaezPkvILFa9x8jvOOJckvB595yEunQtYQEg
# fn7R8k8HWV+LLUNS60YMlOH1Zkd5d9VUWx+tJDfLRVpOoERIyNiwmcUVhAn21klJ
# wGW45hpxbqCo8YLoRT5s1gLXCmeDBVrJpBAwggYaMIIEAqADAgECAhBiHW0MUgGe
# O5B5FSCJIRwKMA0GCSqGSIb3DQEBDAUAMFYxCzAJBgNVBAYTAkdCMRgwFgYDVQQK
# Ew9TZWN0aWdvIExpbWl0ZWQxLTArBgNVBAMTJFNlY3RpZ28gUHVibGljIENvZGUg
# U2lnbmluZyBSb290IFI0NjAeFw0yMTAzMjIwMDAwMDBaFw0zNjAzMjEyMzU5NTla
# MFQxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxKzApBgNV
# BAMTIlNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBDQSBSMzYwggGiMA0GCSqG
# SIb3DQEBAQUAA4IBjwAwggGKAoIBgQCbK51T+jU/jmAGQ2rAz/V/9shTUxjIztNs
# fvxYB5UXeWUzCxEeAEZGbEN4QMgCsJLZUKhWThj/yPqy0iSZhXkZ6Pg2A2NVDgFi
# gOMYzB2OKhdqfWGVoYW3haT29PSTahYkwmMv0b/83nbeECbiMXhSOtbam+/36F09
# fy1tsB8je/RV0mIk8XL/tfCK6cPuYHE215wzrK0h1SWHTxPbPuYkRdkP05ZwmRmT
# nAO5/arnY83jeNzhP06ShdnRqtZlV59+8yv+KIhE5ILMqgOZYAENHNX9SJDm+qxp
# 4VqpB3MV/h53yl41aHU5pledi9lCBbH9JeIkNFICiVHNkRmq4TpxtwfvjsUedyz8
# rNyfQJy/aOs5b4s+ac7IH60B+Ja7TVM+EKv1WuTGwcLmoU3FpOFMbmPj8pz44MPZ
# 1f9+YEQIQty/NQd/2yGgW+ufflcZ/ZE9o1M7a5Jnqf2i2/uMSWymR8r2oQBMdlyh
# 2n5HirY4jKnFH/9gRvd+QOfdRrJZb1sCAwEAAaOCAWQwggFgMB8GA1UdIwQYMBaA
# FDLrkpr/NZZILyhAQnAgNpFcF4XmMB0GA1UdDgQWBBQPKssghyi47G9IritUpimq
# F6TNDDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADATBgNVHSUE
# DDAKBggrBgEFBQcDAzAbBgNVHSAEFDASMAYGBFUdIAAwCAYGZ4EMAQQBMEsGA1Ud
# HwREMEIwQKA+oDyGOmh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1B1Ymxp
# Y0NvZGVTaWduaW5nUm9vdFI0Ni5jcmwwewYIKwYBBQUHAQEEbzBtMEYGCCsGAQUF
# BzAChjpodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29QdWJsaWNDb2RlU2ln
# bmluZ1Jvb3RSNDYucDdjMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdv
# LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEABv+C4XdjNm57oRUgmxP/BP6YdURhw1aV
# cdGRP4Wh60BAscjW4HL9hcpkOTz5jUug2oeunbYAowbFC2AKK+cMcXIBD0ZdOaWT
# syNyBBsMLHqafvIhrCymlaS98+QpoBCyKppP0OcxYEdU0hpsaqBBIZOtBajjcw5+
# w/KeFvPYfLF/ldYpmlG+vd0xqlqd099iChnyIMvY5HexjO2AmtsbpVn0OhNcWbWD
# RF/3sBp6fWXhz7DcML4iTAWS+MVXeNLj1lJziVKEoroGs9Mlizg0bUMbOalOhOfC
# ipnx8CaLZeVme5yELg09Jlo8BMe80jO37PU8ejfkP9/uPak7VLwELKxAMcJszkye
# iaerlphwoKx1uHRzNyE6bxuSKcutisqmKL5OTunAvtONEoteSiabkPVSZ2z76mKn
# zAfZxCl/3dq3dUNw4rg3sTCggkHSRqTqlLMS7gjrhTqBmzu1L90Y1KWN/Y5JKdGv
# spbOrTfOXyXvmPL6E52z1NZJ6ctuMFBQZH3pwWvqURR8AgQdULUvrxjUYbHHj95E
# jza63zdrEcxWLDX6xWls/GDnVNueKjWUH3fTv1Y8Wdho698YADR7TNx8X8z2Bev6
# SivBBOHY+uqiirZtg0y9ShQoPzmCcn63Syatatvx157YK9hlcPmVoa1oDE5/L9Uo
# 2bC5a4CH2RwwggZZMIIEQaADAgECAg0B7BySQN79LkBdfEd0MA0GCSqGSIb3DQEB
# DAUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQK
# EwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTE4MDYyMDAwMDAw
# MFoXDTM0MTIxMDAwMDAwMFowWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
# bFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENB
# IC0gU0hBMzg0IC0gRzQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDw
# AuIwI/rgG+GadLOvdYNfqUdSx2E6Y3w5I3ltdPwx5HQSGZb6zidiW64HiifuV6PE
# Ne2zNMeswwzrgGZt0ShKwSy7uXDycq6M95laXXauv0SofEEkjo+6xU//NkGrpy39
# eE5DiP6TGRfZ7jHPvIo7bmrEiPDul/bc8xigS5kcDoenJuGIyaDlmeKe9JxMP11b
# 7Lbv0mXPRQtUPbFUUweLmW64VJmKqDGSO/J6ffwOWN+BauGwbB5lgirUIceU/kKW
# O/ELsX9/RpgOhz16ZevRVqkuvftYPbWF+lOZTVt07XJLog2CNxkM0KvqWsHvD9WZ
# uT/0TzXxnA/TNxNS2SU07Zbv+GfqCL6PSXr/kLHU9ykV1/kNXdaHQx50xHAotIB7
# vSqbu4ThDqxvDbm19m1W/oodCT4kDmcmx/yyDaCUsLKUzHvmZ/6mWLLU2EESwVX9
# bpHFu7FMCEue1EIGbxsY1TbqZK7O/fUF5uJm0A4FIayxEQYjGeT7BTRE6giunUln
# EYuC5a1ahqdm/TMDAd6ZJflxbumcXQJMYDzPAo8B/XLukvGnEt5CEk3sqSbldwKs
# DlcMCdFhniaI/MiyTdtk8EWfusE/VKPYdgKVbGqNyiJc9gwE4yn6S7Ac0zd0hNkd
# Zqs0c48efXxeltY9GbCX6oxQkW2vV4Z+EDcdaxoU3wIDAQABo4IBKTCCASUwDgYD
# VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFOoWxmnn
# 48tXRTkzpPBAvtDDvWWWMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH8H/IZ1Og
# MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2Jh
# bHNpZ24uY29tL3Jvb3RyNjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmds
# b2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMEcGA1UdIARAMD4wPAYEVR0gADA0MDIG
# CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
# LzANBgkqhkiG9w0BAQwFAAOCAgEAf+KI2VdnK0JfgacJC7rEuygYVtZMv9sbB3DG
# +wsJrQA6YDMfOcYWaxlASSUIHuSb99akDY8elvKGohfeQb9P4byrze7AI4zGhf5L
# FST5GETsH8KkrNCyz+zCVmUdvX/23oLIt59h07VGSJiXAmd6FpVK22LG0LMCzDRI
# RVXd7OlKn14U7XIQcXZw0g+W8+o3V5SRGK/cjZk4GVjCqaF+om4VJuq0+X8q5+dI
# ZGkv0pqhcvb3JEt0Wn1yhjWzAlcfi5z8u6xM3vreU0yD/RKxtklVT3WdrG9KyC5q
# ucqIwxIwTrIIc59eodaZzul9S5YszBZrGM3kWTeGCSziRdayzW6CdaXajR63Wy+I
# Lj198fKRMAWcznt8oMWsr1EG8BHHHTDFUVZg6HyVPSLj1QokUyeXgPpIiScseeI8
# 5Zse46qEgok+wEr1If5iEO0dMPz2zOpIJ3yLdUJ/a8vzpWuVHwRYNAqJ7YJQ5NF7
# qMnmvkiqK1XZjbclIA4bUaDUY6qD6mxyYUrJ+kPExlfFnbY8sIuwuRwx773vFNgU
# QGwgHcIt6AvGjW2MtnHtUiH+PvafnzkarqzSL3ogsfSsqh3iLRSd+pZqHcY8yvPZ
# HL9TTaRHWXyVxENB+SXiLBB+gfkNlKd98rUJ9dhgckBQlSDUQ0S++qCV5yBZtnjG
# pGqqIpswggZoMIIEUKADAgECAhABSJA9woq8p6EZTQwcV7gpMA0GCSqGSIb3DQEB
# CwUAMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEw
# LwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTM4NCAtIEc0
# MB4XDTIyMDQwNjA3NDE1OFoXDTMzMDUwODA3NDE1OFowYzELMAkGA1UEBhMCQkUx
# GTAXBgNVBAoMEEdsb2JhbFNpZ24gbnYtc2ExOTA3BgNVBAMMMEdsb2JhbHNpZ24g
# VFNBIGZvciBNUyBBdXRoZW50aWNvZGUgQWR2YW5jZWQgLSBHNDCCAaIwDQYJKoZI
# hvcNAQEBBQADggGPADCCAYoCggGBAMLJ3AO2G1D6Kg3onKQh2yinHfWAtRJ0I/5e
# L8MaXZayIBkZUF92IyY1xiHslO+1ojrFkIGbIe8LJ6TjF2Q72pPUVi8811j5bazA
# L5B4I0nA+MGPcBPUa98miFp2e0j34aSm7wsa8yVUD4CeIxISE9Gw9wLjKw3/QD4A
# QkPeGu9M9Iep8p480Abn4mPS60xb3V1YlNPlpTkoqgdediMw/Px/mA3FZW0b1XRF
# OkawohZ13qLCKnB8tna82Ruuul2c9oeVzqqo4rWjsZNuQKWbEIh2Fk40ofye8eEa
# VNHIJFeUdq3Cx+yjo5Z14sYoawIF6Eu5teBSK3gBjCoxLEzoBeVvnw+EJi5obPrL
# TRl8GMH/ahqpy76jdfjpyBiyzN0vQUAgHM+ICxfJsIpDy+Jrk1HxEb5CvPhR8toA
# Ar4IGCgFJ8TcO113KR4Z1EEqZn20UnNcQqWQ043Fo6o3znMBlCQZQkPRlI9Lft3L
# bbwbTnv5qgsiS0mASXAbLU/eNGA+vQIDAQABo4IBnjCCAZowDgYDVR0PAQH/BAQD
# AgeAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMB0GA1UdDgQWBBRba3v0cHQIwQ0q
# yO/xxLlA0krG/TBMBgNVHSAERTBDMEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIB
# FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAMBgNVHRMB
# Af8EAjAAMIGQBggrBgEFBQcBAQSBgzCBgDA5BggrBgEFBQcwAYYtaHR0cDovL29j
# c3AuZ2xvYmFsc2lnbi5jb20vY2EvZ3N0c2FjYXNoYTM4NGc0MEMGCCsGAQUFBzAC
# hjdodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3RzYWNhc2hh
# Mzg0ZzQuY3J0MB8GA1UdIwQYMBaAFOoWxmnn48tXRTkzpPBAvtDDvWWWMEEGA1Ud
# HwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2EvZ3N0c2Fj
# YXNoYTM4NGc0LmNybDANBgkqhkiG9w0BAQsFAAOCAgEALms+j3+wsGDZ8Z2E3JW2
# 318NvyRR4xoGqlUEy2HB72Vxrgv9lCRXAMfk9gy8GJV9LxlqYDOmvtAIVVYEtuP+
# HrvlEHZUO6tcIV4qNU1Gy6ZMugRAYGAs29P2nd7KMhAMeLC7VsUHS3C8pw+rcryN
# y+vuwUxr2fqYoXQ+6ajIeXx2d0j9z+PwDcHpw5LgBwwTLz9rfzXZ1bfub3xYwPE/
# DBmyAqNJTJwEw/C0l6fgTWolujQWYmbIeLxpc6pfcqI1WB4m678yFKoSeuv0lmt/
# cqzqpzkIMwE2PmEkfhGdER52IlTjQLsuhgx2nmnSxBw9oguMiAQDVN7pGxf+LCue
# 2dZbIjj8ZECGzRd/4amfub+SQahvJmr0DyiwQJGQL062dlC8TSPZf09rkymnbOfQ
# MD6pkx/CUCs5xbL4TSck0f122L75k/SpVArVdljRPJ7qGugkxPs28S9Z05LD7Mtg
# Uh4cRiUI/37Zk64UlaiGigcuVItzTDcVOFBWh/FPrhyPyaFsLwv8uxxvLb2qtuto
# I/DtlCcUY8us9GeKLIHTFBIYAT+Eeq7sR2A/aFiZyUrCoZkVBcKt3qLv16dVfLyE
# G02Uu45KhUTZgT2qoyVVX6RrzTZsAPn/ct5a7P/JoEGWGkBqhZEcr3VjqMtaM7WU
# M36yjQ9zvof8rzpzH3sg23IwggZyMIIE2qADAgECAhALYufvMdbwtA/sWXrOPd+k
# MA0GCSqGSIb3DQEBDAUAMFQxCzAJBgNVBAYTAkdCMRgwFgYDVQQKEw9TZWN0aWdv
# IExpbWl0ZWQxKzApBgNVBAMTIlNlY3RpZ28gUHVibGljIENvZGUgU2lnbmluZyBD
# QSBSMzYwHhcNMjIwMjA3MDAwMDAwWhcNMjUwMjA2MjM1OTU5WjB2MQswCQYDVQQG
# EwJHUjEdMBsGA1UECAwUS2VudHJpa8OtIE1ha2Vkb27DrWExIzAhBgNVBAoMGkth
# dHNhdm91bmlkaXMgS29uc3RhbnRpbm9zMSMwIQYDVQQDDBpLYXRzYXZvdW5pZGlz
# IEtvbnN0YW50aW5vczCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIxd
# u9+Lc83wVLNDuBn9NzaXp9JzWaiQs6/uQ6fbCUHC4/2lLfKzOUus3e76lSpnmo7b
# kCLipjwZH+yqWRuvrccrfZCoyVvBAuzdE69AMR02Z3Ay5fjN6kWPfACkgLe4D9og
# SDh/ZsOfHD89+yKKbMqsDdj4w/zjIRwcYGgBR6QOGP8mLAIKH7TwvoYBauLlb6aM
# /eG/TGm3cWd4oonwjiYU2fDkhPPdGgCXFem+vhuIWoDk0A0OVwEzDFi3H9zdv6hB
# bv+d37bl4W81zrm42BMC9kWgiEuoDUQeY4OX2RdNqNtzkPMI7Q93YlnJwitLfSrg
# GmcU6fiE0vIW3mkf7mebYttI7hJVvqt0BaCPRBhOXHT+KNUvenSXwBzTVef/9h70
# POF9ZXbUhTlJJIHJE5SLZ2DvjAOLUvZuvo3bGJIIASHnTKEIVLCUwJB77NeKsgDx
# YGDFc2OQiI9MuFWdaty4B0sXQMj+KxZTb/Q0O850xkLIbQrAS6T2LKEuviE6Ua7b
# QFXi1nFZ+r9XjOwZQmQDuKx2D92AUR/qwcpIM8tIbJdlNzEqE/2wwaE10G+sKuX/
# SaJFZbKXqDMqJr1fw0M9n0saSTX1IZrlrEcppDRN+OIdnQL3cf6PTqv1PTS4pZ/9
# m7iweMcU4lLJ7L/8ZKiIb0ThD9kIddJ5coICzr/hAgMBAAGjggGcMIIBmDAfBgNV
# HSMEGDAWgBQPKssghyi47G9IritUpimqF6TNDDAdBgNVHQ4EFgQUidoax6lNhMBv
# wMAg4rCjdP30S8QwDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARDMEEwNQYM
# KwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20v
# Q1BTMAgGBmeBDAEEATBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLnNlY3Rp
# Z28uY29tL1NlY3RpZ29QdWJsaWNDb2RlU2lnbmluZ0NBUjM2LmNybDB5BggrBgEF
# BQcBAQRtMGswRAYIKwYBBQUHMAKGOGh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1B1YmxpY0NvZGVTaWduaW5nQ0FSMzYuY3J0MCMGCCsGAQUFBzABhhdodHRw
# Oi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQwFAAOCAYEAG+2x4Vn8dk+Y
# w0Khv6CZY+/QKXW+aG/siN+Wn24ijKmvbjiNEbEfCicwZ12YpkOCnuFtrXs8k9zB
# PusV1/wdH+0buzzSuCmkyx5v4wSqh8OsyWIyIsW/thnTyzYys/Gw0ep4RHFtbNTR
# K4+PowRHW1DxOjaxJUNi9sbNG1RiDSAVkGAnHo9m+wAK6WFOIFV5vAbCp8upQPwh
# aGo7u2hXP/d18mf/4BtQ+J7voX1BFwgCLhlrho0NY8MgLGuMBcu5zw07j0ZFBvyr
# axDPVwDoZw07JM018c2Nn4hg2XbYyMtUkvCi120uI6299fGs6Tmi9ttP4c6pubs4
# TY40jVxlxxnqqvIA/wRYXpWOe5Z3n80OFEatcFtzLrQTyO9Q1ptk6gso/RNpRu3r
# ug+aXqfvP3a32FNZAQ6dUGr0ae57OtgM+hlLMhSSyhugHrnbi9oNAsqa/KA6UtD7
# MxWJIwAqACTqqVjUTKjzaaE+12aS3vaO6tEqCuT+DOtu7aJRPnyyMYIGUTCCBk0C
# AQEwaDBUMQswCQYDVQQGEwJHQjEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSsw
# KQYDVQQDEyJTZWN0aWdvIFB1YmxpYyBDb2RlIFNpZ25pbmcgQ0EgUjM2AhALYufv
# MdbwtA/sWXrOPd+kMA0GCWCGSAFlAwQCAQUAoEwwGQYJKoZIhvcNAQkDMQwGCisG
# AQQBgjcCAQQwLwYJKoZIhvcNAQkEMSIEICjRW8K229dyG85IB6oWX/oj+Ghmau1l
# tHEfGIilYFLjMA0GCSqGSIb3DQEBAQUABIICACXdvoNywsy9w3AbEfYAQjHj1mq7
# S1f0+utceXQlJn4jbUcVrUiA/SXvQv9ery6UL2Qk5F3FuOzLGUas/XsP/mnOH3qt
# xWsCnreQMAZ5JQdr3MCLQZqOzzjkGN5c/GCg368NNllEWCKXQ24pBeD0/N2I4r2Z
# cxrVtMwv0sm+RVb53PkH2qChyJj8Q7mSe8wlgvwIvlQ4oTF+CDw9l7HS1T98ZmaO
# uHFNUB334O2U9cijeVz9y31IKw67ux/UkcCB1p05XAxELsdtejMelKhYzpFUHzHh
# xiBpRWpjTSTI/tHQCyu0HOfa2dqfYO8dEoDWifxevrdjFCAkrs4m4gvCIiyaGY2i
# LQCC3xQrgsSOZh5OMBNFIly1zLEXPQNAOZot4yu5LIlMal/9R5408rc37yTH6lFO
# VvWTFBywcBynjDXylfnc4V4ZfbIFGu14b3ps3dP/+ro6X8jMRLxS5WD9psMWlaRi
# 8bU0I01EVzAgow2OJAVJx2FNkEUylUknJfDubIneVK4tJPL0eVJ9/LIv6O2YZ8Zw
# 9OJSSqRJ1nSikRqve+j3a/6hjz/PMyGtA63xb8OF5VPQ9zTUT1nCp8pX48oLgcfK
# U4c7A8kqclGT6C73JJhqzjM9D9TLEatEMQBPhAVjXf/yE8EgGTFBOLdXgycOBb03
# PZM54Ea52kK1zMyFoYIDbDCCA2gGCSqGSIb3DQEJBjGCA1kwggNVAgEBMG8wWzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMT
# KEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQCEAFIkD3C
# irynoRlNDBxXuCkwCwYJYIZIAWUDBAIBoIIBPTAYBgkqhkiG9w0BCQMxCwYJKoZI
# hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAyMTQxMjE2MDVaMCsGCSqGSIb3DQEJ
# NDEeMBwwCwYJYIZIAWUDBAIBoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEi
# BCDCmKiCaEMo0aUQDkd0FXhEUk0P8B0Mw/8SXyTMgr/W7TCBpAYLKoZIhvcNAQkQ
# AgwxgZQwgZEwgY4wgYsEFDEDDhdqpFkuqyyLregymfy1WF3PMHMwX6RdMFsxCzAJ
# BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
# bG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTM4NCAtIEc0AhABSJA9woq8
# p6EZTQwcV7gpMA0GCSqGSIb3DQEBCwUABIIBgJRFPQUsYERliPr6uTFayvtOzCZF
# 68aT2GEnah7SqZw9ULZV6Rwoy6K1gxuBVVufr8k+g81D73xLmj0yS78YIMc0tMbb
# MPofwDBF9z7asygis3MXb3KKtUMSGJXY0gjLh9l9uU7LrQelhm52vEvTo5CQIZbd
# ndc1WT6j9h7zO3IwHBxqJXS9YxNdAWtgSMxg6tNZQ3t+ycYG5hO406yBWC77oWfQ
# fr6h2pw6vKNBYftpWtCkrF2zFXPA6i5x8PVlL8QCmRYa7X/1ZueaTGu0LFXi9LH8
# pfOUqum99KSTK9gLtaAwgxBRj8PEEdTIYTnUWgBbbHlsrqqdyNaR3IeHnBxzOaXK
# AmMDqV+aDIQ09r5DBpmSfm/i6asiIAgczCD9x1suTfrWfqiwyM7tj8n5Q6mRZgjx
# BRetmxq94DXWh2/Ku3FRgqg4Wv8ICYsZJV6689kFZeyPoA4rrsIYBSsqKQ4Pat/g
# ixT9+FRlpdDFdSnO2am/Pm44l8ZMFbXtEoN1fQ==
# SIG # End signature block
