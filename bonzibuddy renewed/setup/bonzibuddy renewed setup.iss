[Setup]
AppName=Bonzibuddy RENEWED
AppPublisher=William Tyler (William_Tyler)
AppVersion=0.1.7
AppId={{D7FCEF36-EA7F-4265-868B-3AC766F8FFA6}}
DefaultDirName={pf}\bonzibuddy renewed
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\Bonzicon.ico
OutputDir=userdocs:Inno Setup Examples Output
LZMANumFastBytes=273

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

[Tasks]
Name: "additional_dependencies"; Description: "Install AgentPatch (Win 7 and up ONLY) -fix rendering issues for bonzibuddy"; GroupDescription: "Additional dependencies to install:"

[Files]
Source: "..\src\*"; DestDir: "{app}"; Flags: recursesubdirs;
Source: "..\data\*"; DestDir: "{userappdata}\bonzibuddy renewed"; Flags: onlyifdoesntexist
Source: "..\dependencies\*"; DestDir: "{tmp}"; Flags: deleteafterinstall; Excludes: Bonzi.acs, bonzicon.ico
Source: "..\dependencies\Bonzicon.ico"; DestDir: "{app}"
Source: "..\dependencies\Bonzi.acs"; DestDir: "{win}\msagent\chars"

[Dirs]
Name: "{userappdata}\bonzibuddy renewed"

[Icons]
Name: "{commondesktop}\bonzibuddy renewed"; Filename: "{app}\launch.bat"; IconFilename: "{app}\bonzicon.ico"

[Run]
Filename: "{tmp}\agentpatch.exe"; Tasks: additional_dependencies