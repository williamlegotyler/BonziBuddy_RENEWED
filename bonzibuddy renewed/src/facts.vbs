Set x=CreateObject("Wscript.shell")
Set objFSO=CreateObject("Scripting.FileSystemObject")
factpath=objFSO.GetParentFolderName(WScript.ScriptFullName) & "\facts.txt"
outpath=x.SpecialFolders("appdata") & "\bonzibuddy renewed\random_fact.txt"

Set objFile=objFSO.OpenTextFile(factpath, 1)
arrfacts=Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrfacts(UBound(arrfacts) + 1)
    arrfacts(UBound(arrfacts))=objFile.ReadLine
Loop
objFile.Close

Randomize
randomfact=arrfacts(Int((UBound(arrfacts) + 1) * Rnd))

Set objTSO=objFSO.CreateTextFile(outpath, True)
objTSO.WriteLine(randomfact)
Wscript.sleep 500
x.run "fact.exe"