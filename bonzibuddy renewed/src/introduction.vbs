Set x = CreateObject("Wscript.shell")

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
Continue = False

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

    If RequestObject <> ContinueReq Then
        Continue = True

    End If
End Sub

Sub LoadError()
    Dim strMsg
    strMsg = "Error Loading Character: " & BonziID
    strMsg = strMsg & Chr(13) & Chr(13) & "This Microsoft Agent Script requires the character(s):"
    strMsg = strMsg & Chr(13) & UsedChars
    MsgBox strMsg, 48
End Sub

Sub InitAgentCommands()
    ' Purpose:  Initialize the Commands menu
    Bonzi.Commands.RemoveAll
    Bonzi.Commands.Caption = "MASH Menu"
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
        ' *** END MASH USER COMMANDS ***

        If UserInput.Name = "Exit" Then
            Bonzi.StopAll
            Set HideReq = Bonzi.Hide()
            Wscript.sleep 2000
            Wscript.Quit
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
    Bonzi.Show
    Bonzi.Play "Wave"
    Bonzi.Speak "Well!"
    Bonzi.Speak "Hello there!"
    Bonzi.Speak "I don't believe we've been properly introduced."
    Bonzi.Play "RestPose"
    Bonzi.Play "Greet"
    Bonzi.Speak "I'm Bonzi!"
    Bonzi.Play "RestPose"
    Set ContinueReq = Bonzi.Speak("What is your name?")
    Do
        WScript.Sleep 800
    Loop Until Continue
    Continue = False
    a = InputBox("Enter your Name or Salutation.", "Bonzibuddy renewed")

    Set fso = CreateObject("Scripting.FileSystemObject")
    path=x.SpecialFolders("appdata") & "\bonzibuddy renewed\username.txt"
    Set textfile=fso.CreateTextFile(path, True)

    textFile.Write(a)
    Wscript.sleep 1000

    name = fso.OpenTextFile(path, 1).ReadAll
    Bonzi.Speak "Nice to meet you, " & name & "!"
    Bonzi.Play "Write"
    Bonzi.Play "WriteReturn"
    Bonzi.Speak "Since this is the first time we've met, I'd like to tell you a little about myself."
    Bonzi.Speak "I am your friend and BonziBUDDY renewed! aiming to be better than the original one and especially...being free of malware! as of now my capabilities are very limited, but as the time goes on ill catch up on my original one and get even better! So don't be afraid to update me!"
    Bonzi.Play "PleasedSoft"
    Set ContinueReq = Bonzi.Speak("\mrk=999999999\")
    Do
        WScript.Sleep 999
    Loop Until Continue
    x.run "main.vbs"

    Wscript.sleep 1000
    AgentControl.Characters.Unload BonziID


End Sub
