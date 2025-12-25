Set x = CreateObject("Wscript.shell")
Set objFSO=CreateObject("Scripting.FileSystemObject")
path=x.SpecialFolders("appdata") & "\bonzibuddy renewed\username.txt"
path1=x.SpecialFolders("appdata") & "\bonzibuddy renewed\lastrungreet.txt"
name = objFSO.OpenTextFile(path, 1).ReadAll

' * Agent Object
Dim AgentControl

' * Character Objects
Dim Bonzi

' * Variables
Dim UsedChars
Dim BonziID
Dim BonziACS
Dim BonziLoaded
Dim HideReq
Dim Req
Dim ScriptComplete

' * Initialize
UsedChars = "Bonzi"

' * Bonzi
BonziID = "Bonzi"
BonziACS = "bonzi.acs"
BonziLoaded = False

ScriptComplete = False

Call Main

Function IsAgentInstalled()
    ' Purpose:  Returns True if Agent 2.0 is installed, else False
    On Error Resume Next

    If ScriptEngineMajorVersion < 2 Then
        IsAgentInstalled = False
    Else
        Set AgentControl = WScript.CreateObject("Agent.Control.2", "AgentControl_")
        IsAgentInstalled = (Not AgentControl Is Nothing)
    End If
End Function

Sub Main()
    On Error Resume Next

    ' * INSERT ANY NON-AGENT RELATED SCRIPTING HERE

    If Not IsAgentInstalled() Then
        Exit Sub
    End If

    AgentControl.Connected = True

    BonziLoaded = LoadLocalChar(BonziID, BonziACS)

    If Not BonziLoaded Then
        BonziLoaded = LoadLocalChar(BonziID, "")
    End If

    If BonziLoaded Then
        Call SetCharObj
        Call AgentIntro
    Else
        Call LoadError
    End If
End Sub

Function LoadLocalChar(ByVal CharID, ByVal CharACS)
    ' Purpose:  Attempts to load the specified character
    ' Returns:  True if successful, False if not
    On Error Resume Next

    If CharACS = "" Then
        AgentControl.Characters.Load CharID, CharACS
    Else
        AgentControl.Characters.Load CharID, CharACS
    End If

    If Err = 0 Then
        LoadLocalChar = True
        Exit Function
    End If
    LoadLocalChar = False
End Function

Sub SetCharObj()
    ' Purpose:  Sets the character reference and TTS Language ID
    On Error Resume Next

    Set Bonzi = AgentControl.Characters(BonziID)
    Bonzi.LanguageID = &H409
End Sub

Sub AgentControl_RequestComplete(ByVal RequestObject)
    ' Purpose:  Take action on completion or failure of requests
    On Error Resume Next

    If RequestObject <> EndReq Then
    Else
        If Not Bonzi.Visible Then
            ' Trigger the Script to Close
            ScriptComplete = True
        Else
            ' It is up to the user to close the script, by right-clicking
            ' the character and selecting 'Exit'
        End If
    End If

    If RequestObject <> HideReq Then
    Else
        AgentControl.Characters.Unload BonziID
        ScriptComplete = True
    End If
End Sub

Sub LoadError()
    Dim strMsg
    strMsg = "Error Loading Character: " & BonziID
    strMsg = strMsg & Chr(13) & Chr(13) & "This Microsoft Agent Script requires the character(s):"
    strMsg = strMsg & Chr(13) & UsedChars
    MsgBox strMsg, 48
End Sub

Sub AgentControl_Click(ByVal CharacterID, ByVal Button, ByVal Shift, ByVal X, ByVal Y)
    On Error Resume Next

    If Button = 1 Then
        Bonzi.StopAll
    End If
End Sub

Sub InitAgentCommands()

    ' Purpose:  Initialize the Commands menu
    Bonzi.Commands.RemoveAll
    Bonzi.Commands.Caption = "MASH Menu"
    Bonzi.Commands.Add "tellajoke", "Tell a joke", ""
    Bonzi.Commands.Add "Browse", "Browse", ""
    Bonzi.Commands.Add "Speak", "Speak", ""
    Bonzi.Commands.Add "tellanamazingfact", "Tell an amazing fact", ""
    Bonzi.Commands.Add "singasong", "Sing A Song", ""
    Bonzi.Commands.Add "Search", "Search", ""
    Bonzi.Commands.Add "info", "Info", ""
    Bonzi.Commands.Add "Exit", "Exit", "Exit"
End Sub

Sub AgentControl_Command(ByVal UserInput)
    ' Purpose:  Determine Command that was selected either by menu or voice
    '           and run the applicable Command Script
    On Error Resume Next

    Dim BadConfidence
    BadConfidence = 10

    If (UserInput.Confidence <= -40) Then
        ' Bad Recognition
        Exit Sub
    ElseIf (UserInput.Alt1Name <> "") And Abs(Abs(UserInput.Alt1Confidence) - Abs(UserInput.Confidence)) < BadConfidence Then
        ' Bad Confidence - too close to another command
        Exit Sub
    ElseIf (UserInput.Alt2Name <> "") And Abs(Abs(UserInput.Alt2Confidence) - Abs(UserInput.Confidence)) < BadConfidence Then
        ' Bad Confidence - too close to another command
        Exit Sub
    Else ' High Confidence
        ' *** BEGIN MASH USER COMMANDS ***
        Select Case UserInput.Name
        Case "tellajoke"
            Bonzi.StopAll
            jokepath=objFSO.GetParentFolderName(WScript.ScriptFullName) & "\jokes.txt"
            Set objFile=objFSO.OpenTextFile(jokepath, 1)
            arrjokes=Array()
            Do Until objFile.AtEndOfStream
                Redim Preserve arrjokes(UBound(arrjokes) + 1)
                arrjokes(UBound(arrjokes))=objFile.ReadLine
            Loop
            objFile.Close
            Randomize
            randomjoke=arrjokes(Int((UBound(arrJokes) + 1) * Rnd))
            Wscript.sleep 498
            Bonzi.Speak "I've got one for you."
            Bonzi.Speak randomjoke
            Bonzi.Play "Giggle"
        Case "Browse"
            Bonzi.StopAll
            Bonzi.Speak "OK " & name & "! Where do you want to go?"
            url=InputBox("Enter your url here!", "bonzibuddy renewed")
            if url="" Then Exit Sub
            x.run url, 0, False
            Bonzi.Play "Search"
        Case "Speak"
            Bonzi.StopAll
            speaktext=inputbox("Enter what you want me to speak.", "bonzibuddy renewed")
            Bonzi.Speak SpeakText
        Case "tellanamazingfact"
            Bonzi.StopAll
            factpath=objFSO.GetParentFolderName(WScript.ScriptFullName) & "\facts.txt"
            Set objFile=objFSO.OpenTextFile(factpath, 1)
            arrfacts=Array()
            Do Until objFile.AtEndOfStream
                Redim Preserve arrfacts(UBound(arrfacts) + 1)
                arrfacts(UBound(arrfacts))=objFile.ReadLine
            Loop
            objFile.Close
            Randomize
            randomfact=arrfacts(Int((UBound(arrfacts) + 1) * Rnd))
            Wscript.sleep 498
            Bonzi.Play "ReadLookUp"
            Bonzi.Speak randomfact
            Bonzi.Play "ReadReturn"
        Case "singasong"
            Bonzi.StopAll
            x.run ".\Songs"
        Case "info"
            Bonzi.StopAll
            MsgBox "BonziBuddy RENEWED version 0.1.7", 0, "Informations about BonziBuddy RENEWED"
        Case "Search"
            Bonzi.StopAll
            Bonzi.Speak "OK!"
            search=inputbox("Enter your search here!", "bonzibuddy renewed")
            if search="" Then Exit Sub
            searchfiltered = Replace(search, " ", "+")
            searchurl="https://www.google.com/search?q=" & searchfiltered
            x.run searchurl, 0, False
            Bonzi.Play "Search"
        End Select
        ' *** END MASH USER COMMANDS ***

        If UserInput.Name = "Exit" Then
            Bonzi.StopAll
            Set HideReq = Bonzi.Hide()
        End If
    End If
End Sub

Sub AgentControl_Bookmark(ByVal BookmarkID)
    On Error Resume Next

End Sub

Sub AgentIntro()
    On Error Resume Next

    Call InitAgentCommands

    ' *** BEGIN MASH USER SCRIPT ***

    Bonzi.TTSModeID = "{CA141FD0-AC7F-11D1-97A3-006008273001}"
    If Not Bonzi.Visible Then
        Bonzi.Show 
        Bonzi.Play "Wave"
        Bonzi.Speak "Nice to see you again, " & name & "!"
        Bonzi.Play "RestPose"
        If objfso.getfile(path1).size > 0 then lastrun=objfso.OpenTextFile(path1).ReadLine
        If month(date)=12 and day(date)=25 then
            If lastrun <> Cstr(date) then
            Bonzi.Speak "Ho ho ho! Merry christmas " & name & "!"
            objfso.CreateTextFile(path1).Write(date)
            End If
        End If
    else 
        Bonzi.Activate
    End If

    ' *** END MASH USER SCRIPT ***

    Set EndReq = Bonzi.Speak("\mrk=999999999\")

    Do
        WScript.Sleep 1000
    Loop Until ScriptComplete

End Sub


