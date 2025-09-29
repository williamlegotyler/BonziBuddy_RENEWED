Set x=CreateObject("Wscript.shell")
Set objFSO=CreateObject("Scripting.FileSystemObject")
jokepath=objFSO.GetParentFolderName(WScript.ScriptFullName) & "\jokes.txt"
outpath=x.SpecialFolders("appdata") & "\bonzibuddy renewed\random_joke.txt"

Set objFile=objFSO.OpenTextFile(jokepath, 1)
arrjokes=Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrjokes(UBound(arrjokes) + 1)
    arrjokes(UBound(arrjokes))=objFile.ReadLine
Loop
objFile.Close

Randomize
randomjoke=arrjokes(Int((UBound(arrJokes) + 1) * Rnd))

Set objTSO = objFSO.CreateTextFile(outpath, True)
objTSO.WriteLine(randomjoke)
Wscript.sleep 500
x.run "joke.exe"