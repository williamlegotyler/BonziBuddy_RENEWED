Set x=Createobject("Wscript.shell")
Set fso=CreateObject("Scripting.FileSystemObject")
path=x.SpecialFolders("appdata") & "\bonzibuddy renewed\speak.txt"

speak=inputbox("Enter what you want me to speak.", "bonzibuddy renewed")

Set file=fso.CreateTextFile(path, True)
file.WriteLine(speak)
file.Close
Wscript.sleep 500
x.run "speak.exe"