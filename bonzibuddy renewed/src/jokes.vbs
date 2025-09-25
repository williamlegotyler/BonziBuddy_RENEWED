Set x = CreateObject("Wscript.shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
jokesFilePath = objFSO.GetParentFolderName(WScript.ScriptFullName) & "\jokes.txt"
outputFilePath = x.SpecialFolders("appdata") & "\bonzibuddy renewed\random_joke.txt"

Set objFile = objFSO.OpenTextFile(jokesFilePath, 1)
arrJokes = Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrJokes(UBound(arrJokes) + 1)
    arrJokes(UBound(arrJokes)) = objFile.ReadLine
Loop
objFile.Close

Randomize
strRandomJoke = arrJokes(Int((UBound(arrJokes) + 1) * Rnd))

Set objTSO = objFSO.CreateTextFile(outputFilePath, True)
objTSO.WriteLine(strRandomJoke)
objTSO.Close
