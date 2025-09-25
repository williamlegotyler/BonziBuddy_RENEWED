
[Setup]
AppName=Bonzibuddy RENEWED
AppVersion=0.1.1
DefaultDirName={pf}\bonzibuddy renewed
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\launch.bat
OutputDir=userdocs:Inno Setup Examples Output

[Code]
procedure CurStepChanged(C: TSetupStep);
var R: Integer;
begin
  if C = ssInstall then
  begin
    ExtractTemporaryFile('MSagent.exe');
    Exec(ExpandConstant('{tmp}\MSagent.exe'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, R);
  end;
end;

[Files]
Source: "C:\Documents and Settings\williamtylertv\Desktop\BonziBuddy_RENEWED-main\bonzibuddy renewed\src\*"; DestDir: "{app}"; Flags: recursesubdirs
Source: "C:\Documents and Settings\williamtylertv\Desktop\BonziBuddy_RENEWED-main\bonzibuddy renewed\data\*"; DestDir: "{userappdata}\bonzibuddy renewed"
Source: "C:\Documents and Settings\williamtylertv\Desktop\BonziBuddy_RENEWED-main\bonzibuddy renewed\src\install dependencies\MSagent.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "C:\Documents and Settings\williamtylertv\Desktop\BonziBuddy_RENEWED-main\bonzibuddy renewed\src\install dependencies\Bonzi.acs"; DestDIr: "C:\WINDOWS\msagent\chars"

[Dirs]
Name: "{userappdata}\bonzibuddy renewed"

[Icons]
Name: "{commondesktop}\bonzibuddy renewed"; Filename: "{app}\launch.bat"

[Run]
Filename: "{app}\install dependencies"; Flags: shellexec postinstall skipifsilent