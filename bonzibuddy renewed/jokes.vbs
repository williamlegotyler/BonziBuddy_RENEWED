Dim objFSO, objFile, objTSO, arrJokes, strLine, strRandomJoke
Dim jokesFilePath, outputFilePath

Set x=CreateObject("Wscript.shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
jokesFilePath = objFSO.GetParentFolderName(WScript.ScriptFullName) & "\jokes.txt"
outputFilePath = objFSO.GetParentFolderName(WScript.ScriptFullName) & "\random_joke.txt"

If Not objFSO.FileExists(jokesFilePath) Then
    WScript.Echo "Error: The jokes.txt file was not found."
    WScript.Quit
End If

Set objFile = objFSO.OpenTextFile(jokesFilePath, 1)
arrJokes = Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrJokes(UBound(arrJokes) + 1)
    arrJokes(UBound(arrJokes)) = objFile.ReadLine
Loop
objFile.Close

Randomize
strRandomJoke = arrJokes(Int((UBound(arrJokes) + 1) * Rnd))

Set objTSO = objFSO.CreateTextFile(outputFilePath, True) ' True = Overwrite
objTSO.WriteLine(strRandomJoke)
objTSO.Close

Wscript.sleep 1000
x.run "joke.exe"