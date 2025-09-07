Set x = CreateObject("Wscript.shell")

x.run "introduction.exe"
Wscript.sleep 14000

a = InputBox("Enter your Name or Salutation.", "Bonzibuddy renewed")

Set fso = CreateObject("Scripting.FileSystemObject")
Set textFile = fso.CreateTextFile("C:\Program Files\bonzibuddy renewed\username.txt", True)
textFile.WriteLine("Nice to meet you, " & a & "!")
textFile.Close

Set textFile = Nothing
Set fso = Nothing

wscript.sleep 1000
x.run "name.exe"