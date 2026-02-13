## Jumplist-Browser
Automatic/Custom Destinations &amp; LNK (ShellLNK) Browser

==> [Latest version](https://github.com/kacos2000/Jumplist-Browser/releases/latest) <==

___________________________________________
Dependencies: 
- Operating system: Microsoft Windows 10+ 64 Bit
- [.NET Framework 4.8](https://dotnet.microsoft.com/en-us/download/dotnet-framework/net48)
- [Powershell Version:  5.1](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/install/windows-powershell-system-requirements?view=powershell-5.1)
___________________________________________
Additional info:  

- [ItemID & ItemID Extension Structures](https://github.com/kacos2000/Jumplist-Browser/blob/master/ItemID%20Structure%20Document.md)
- [`BEEF0004` ItemID extension with info on the embedded metadata](https://github.com/kacos2000/Jumplist-Browser/blob/master/ItemID%20Structure%20Document.md#41-beef0004---filefolder-extension)
- [LNK Target File Size (64bit).pdf](https://github.com/kacos2000/Jumplist-Browser/blob/master/LNK%20Target%20File%20Size%20(64bit).pdf)
- [ZIP file with 3 test LNK (Shortcut) files for testing of 64bit target File Size](https://github.com/kacos2000/Jumplist-Browser/releases/download/v.0.0.37.0/LNK.32-64bit.size.test.files.zip)  

   <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/83e52819-7da8-442f-a83b-a19a7d4f2b8f" width="290">  
   <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/21e11f88-7cfc-4526-8559-6b6fb3a7dc10" width="380">  
   
- [Structure of Windows `.customDestinations‑ms` Files](https://github.com/kacos2000/Jumplist-Browser/blob/master/CustomDestinations%E2%80%91ms.md)
___________________________________________
Supports:
   - Link: (.lnk) shortcut files
   - Frequent Places Lists: '.customDestinations-ms' and '.automaticDestinations-ms' files
   - Raw image files: '.001', '.raw','.dd', '.img', '.ima' *via the 'Open File' dialog* - *(carves and shows .lnk files and their offsets)* 
   - Current User (HKCU) keys which contain Shellink items:
      - 'Software\Microsoft\Windows\Shell\BagMRU'
      - 'Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\':
         - 'OpenSavePidlMRU'
         - 'LastVisitedPidlMRU'
         - 'LastVisitedPidlMRULegacy'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\TWinUI\FilePicker\LastVisitedPidlMRU'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\Streams'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\StreamMRU'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery'
      - 'Software\Microsoft\Windows\CurrentVersion\Search'
         - 'JumplistData' &
         - 'RecentApps'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband':
         - Favorites'
         - 'FavoritesResolve'
      - 'Software\Microsoft\Windows\CurrentVersion\Explorer\StartPage2':
         - 'Favorites'
         - 'FavoritesResolve'
         - 'ProgramsCache'
         - 'ProgramsCacheSMP'
         - 'ProgramsCacheTBP'
      - 'Software\Microsoft\Windows\CurrentVersion\Lock Screen' *(Lock screen background image(s))*
   
___________________________________________
Features:
   - Shows the [64-bit file size *(when a target file size is greater than 4Gb (0xFFFFFFFF))*](https://github.com/kacos2000/Jumplist-Browser/releases/tag/v.0.0.37.0)<br>
     *(DWORD nFileSizeHigh + DWORD nFileSizeLow)*
   - Shows [Reparse Point Tags](https://github.com/kacos2000/Jumplist-Browser/releases/tag/v.0.0.33.0) & their description
   - Shows customDestinations ['CustomCategory' titles](https://github.com/kacos2000/Jumplist-Browser/assets/11378310/0c1f9909-59ce-4330-b036-a21d995a1406)
   - Shows Pin Entry *(item order)* number of pinned items in automaticDestinations-ms
   - Shows Quick Access position *(item order)* in automaticDestinations-ms
   - Supports the 'DestListPropertyStore' stream in automaticDestinations-ms
   - Supports PropertyStore extensions in automaticDestinations-ms 'DestList' stream entries 
   - Shows Serialized Property descriptions for most [FormatID/PropertyID combinations](https://github.com/kacos2000/Jumplist-Browser/blob/master/FormatID-Descriptions.csv)
   - Shows the [Application name](https://github.com/kacos2000/Jumplist-Browser/blob/master/AppIdlist.csv) for known [CRC64 hashes](https://www.hexacorn.com/blog/2013/04/30/jumplists-file-names-and-appid-calculator/) in Destinations-ms files
   - Resolves CLSIDs, [SID](https://github.com/kacos2000/Jumplist-Browser/releases/tag/v.1.0.3.0)s, File Attribute & SFGAO flags, Stock Icon IDs, [MAC address/manufacturer](https://github.com/kacos2000/Jumplist-Browser/releases/tag/v.1.0.5.0) etc
   - [Single executable *(x64)*](https://github.com/kacos2000/Jumplist-Browser/releases/latest) => can be used with [Arsenal Image Mounter](https://arsenalrecon.com/products/arsenal-image-mounter) & [Virtual machines](https://github.com/kacos2000/Jumplist-Browser/assets/11378310/5371c027-3155-4d81-9d32-b7035ea510fa)
   - Can [export to .JSON](https://github.com/kacos2000/Jumplist-Browser/releases/tag/v.0.0.52.0)

___________________________________________
Sample screenshots:<br>

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/f2f7e462-9f1c-4c07-a4d3-3ce340730905" width="600"><br>

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/93336ab3-64a9-4c03-acfd-120c17327712" width="600"><br>

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/afa43473-6f70-4b76-b6ce-366458c6eb17" width="500">

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/d3f08278-59a0-404f-a95d-bde23d2432f1" width="600"><br>

  <img src="https://user-images.githubusercontent.com/11378310/220356910-0085c017-c4c1-45da-96a0-24f7be69f13f.png" width="500">

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/8c57f55f-1fc0-4f81-bcbf-b18207695243" width="500"><br>

  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/474966bd-a77b-4f9f-9775-b9f2dbb9abeb" width="500"><br>

  <img src="https://user-images.githubusercontent.com/11378310/220354146-a502d9bf-3b04-454a-ae37-a41db1899c15.png" width="500"><br>

<!-- Commented out -->
<!-- ![image](https://user-images.githubusercontent.com/11378310/212580495-e4c6afe8-68a3-4504-b831-b92c1728b36a.png) -->

---------------------------------------------------------------------------------------------------------------

### [TIP]:
In **'automaticDestinations-ms'** files, with the exception of *Windows Control Panel*, *Windows Explorer* and *Quick Access*, 
entries usually include a 'Hint' on which Application they are related to. 
These 'hints' are seen in the last IDlist entry (type [32] *(File)*):

either indirectly: <br>
MPC-HC *(Media Player Classic - Home Cinema)*:<br>
  <img src="https://user-images.githubusercontent.com/11378310/219865398-65ceda89-8e6c-4a53-9f20-228d1fda0458.png" width="300"><br>
MS Excel:<br>
  <img src="https://user-images.githubusercontent.com/11378310/219865245-1f6203be-08df-4499-bb70-27b13ce87ab1.png" width="300"><br>
Edge Browser:<br>
  <img src="https://github.com/kacos2000/Jumplist-Browser/assets/11378310/d4761eeb-5b1b-4aa9-8470-f5cf692a2a34" width="500"><br>
*(the "**AppX**d4nrz8ff68srnhf9t5a8sbjyar1cr723" type entries can be looked up in:<br>
'HKLM::Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs')*

or Directly:<br>
Windows Wordpad:<br>
  <img src="https://user-images.githubusercontent.com/11378310/219865461-223076e7-4195-4089-97e3-6a8b00baa5bd.png" width="300"><br>
Modern CSV:<br>
  <img src="https://user-images.githubusercontent.com/11378310/219865578-234ea46d-0ac0-4fca-afaa-64a870501137.png" width="300"><br>
Maël Hörz's [HxD Hex Editor](https://mh-nexus.de/en/hxd/)<br>
  <img src="https://user-images.githubusercontent.com/11378310/221018836-62cbc8e4-4dbf-4eda-8892-82230db48c0f.png" width="300"><br>

___________________________________________
References:
- [Shell Link (.LNK) Binary File Format](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-shllink/a6c2f32d-2297-4727-bcd3-5d3669573bcb)<br>
  *The most important component of a link target namespace is a link target in the form of an item ID list (IDList)*
- [Serialized Property Store](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-propstore/3453fb82-0e4f-4c2c-bc04-64b4bd2c51ec)
- [Shell Namespace](https://learn.microsoft.com/en-us/windows/win32/shell/namespace-intro?redirectedfrom=MSDN)
- [Windows Data Types](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dtyp/cca27429-5689-4a16-b2b4-9325d93e4ba2)
- [LnkSearchMachine](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dltw/6cbc37d6-c74a-4078-8030-19d4de1807bf)<br>
   *FileLocation: A VolumeID with an appended ObjectID, which together represent the location of a file at some point in time, though the file might no longer be there. FileLocation values are stored in droid (CDomainRelativeObjId) data structures.*
  
---------------------------------------------------------------------------------------------------------------
- **Note:** *Uses the following Libraries:*
   - [ShellLink .NET Class Library](https://github.com/securifybv/ShellLink) and
   - [PropertyStore .NET Class Library](https://github.com/securifybv/PropertyStore)
