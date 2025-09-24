
[Setup]
AppName=Bonzibuddy RENEWED
AppVersion=0.1.0
DefaultDirName={pf}\bonzibuddy renewed
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\launch.bat
OutputDir=userdocs:Inno Setup Examples Output
Compression=bzip

[Files]
Source: "C:\Documents and Settings\williamtylertv\Desktop\Copy of bonzibuddy-renewed-0.0.9-2\bonzibuddy renewed\*"; DestDir: "{app}"; Flags: recursesubdirs

[Dirs]
Name: "{userappdata}\bonzibuddy renewed"

[Icons]
Name: "{commondesktop}\bonzibuddy renewed"; Filename: "{app}\launch.bat"

[Run]
Filename: "{app}\install dependencies"; Flags: shellexec postinstall skipifsilent