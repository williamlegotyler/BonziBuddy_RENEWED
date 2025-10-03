[Setup]
AppName=Bonzibuddy RENEWED
AppPublisher=William Tyler (William_Tyler)
AppVersion=0.1.4
AppId={{D7FCEF36-EA7F-4265-868B-3AC766F8FFA6}}
DefaultDirName={pf}\bonzibuddy renewed
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\launch.bat
OutputDir=userdocs:Inno Setup Examples Output
LZMANumFastBytes=111

[Code]
procedure CurStepChanged(C: TSetupStep);
var R: Integer;
begin
  if C = ssInstall then
  begin
    ExtractTemporaryFile('MSagent.exe');
    Exec(ExpandConstant('{tmp}\MSagent.exe'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, R);
    ExtractTemporaryFile('spchapi.exe');
    Exec(ExpandConstant('{tmp}\spchapi.exe'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, R);
    ExtractTemporaryFile('tv_enua.exe');
    Exec(ExpandConstant('{tmp}\tv_enua.exe'), '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, R);
  end;
end;

[Files]
Source: "C:\Documents and Settings\williamtylertv\Desktop\Bonzi-0.1.4(decompiled)\bonzibuddy renewed\src\*"; DestDir: "{app}";
Source: "C:\Documents and Settings\williamtylertv\Desktop\Bonzi-0.1.4(decompiled)\bonzibuddy renewed\data\*"; DestDir: "{userappdata}\bonzibuddy renewed"
Source: "C:\Documents and Settings\williamtylertv\Desktop\Bonzi-0.1.4(decompiled)\bonzibuddy renewed\dependencies\*"; DestDir: "{tmp}"; Flags: deleteafterinstall; Excludes: Bonzi.acs
Source: "C:\Documents and Settings\williamtylertv\Desktop\Bonzi-0.1.4(decompiled)\bonzibuddy renewed\dependencies\Bonzi.acs"; DestDIr: "C:\WINDOWS\msagent\chars"

[Dirs]
Name: "{userappdata}\bonzibuddy renewed"

[Icons]
Name: "{commondesktop}\bonzibuddy renewed"; Filename: "{app}\launch.bat"