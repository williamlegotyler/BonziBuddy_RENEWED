Set x = CreateObject("Wscript.shell")

x.run "introduction.exe"
Wscript.sleep 14000

a = InputBox("Enter your Name or Salutation.", "Bonzibuddy renewed")

Set fso = CreateObject("Scripting.FileSystemObject")
path=x.SpecialFolders("appdata") & "\bonzibuddy renewed\username.txt"
Set textfile=fso.CreateTextFile(path, True)
textFile.WriteLine("Nice to meet you, " & a & "!")
textFile.Close

Set textFile = Nothing
Set fso = Nothing

wscript.sleep 1000
x.run "name.exe"