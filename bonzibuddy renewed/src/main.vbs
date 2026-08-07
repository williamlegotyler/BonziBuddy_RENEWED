Set x=CreateObject("Wscript.shell")
Set objFSO=CreateObject("Scripting.FileSystemObject")
apppath=x.SpecialFolders("appdata") & "\bonzibuddy renewed"
path=apppath & "\username.txt"
path1=apppath & "\lastrungreet.txt"
name=objFSO.OpenTextFile(path, 1).ReadAll
currentpath=objFSO.GetParentFolderName(WScript.ScriptFullName)
jokepath=currentpath & "\jokes.txt"
factpath=currentpath & "\facts.txt"
holidaypath=currentpath & "\holidaygreetings.txt"
inipath=".\Bonzi.ini"
set ini=objFSO.OpenTextFile(inipath, 1)
Idle_Timer=0
Excluded_Jokes=Array()
Excluded_Facts=Array()
arr_jokenumber=Array()
arr_factnumber=Array()
firstrunjokes=1
firstrunfacts=1
d=0
a=0
e=0
f=0
Excluded_Jokes_Length=0
Excluded_Facts_Length=0

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
Dim envVar
Dim Random_JokeNumber
Dim Excluded_Jokes
Dim Random_FactNumber
Dim Excluded_Facts

envVar="process_" & Wscript.scriptName

If x.Environment("VOLATILE")(envVar) = "TRUE" Then
    WScript.Quit
End If

x.Environment("VOLATILE")(envVar) = "TRUE"
Do Until ini.AtEndOfStream
    line=ini.ReadLine
    If InStr(line, "=")>0 Then
        parts=Split(line, "=", 2)
        If Trim(LCase(parts(0)))="search_engine" Then
            search_engine=Trim(parts(1))
        ElseIf Trim(LCase(parts(0)))="free_speaking" Then
            Free_Speaking=Trim(parts(1))
        ElseIf Trim(LCase(parts(0)))="free_speaking_interval" Then
            Free_Speaking_Interval=CInt(Trim(parts(1)))
        ElseIf Trim(LCase(parts(0)))="sleeping_timer" Then
            Idle_Level_Multiplier=CInt(Trim(parts(1)))
            Sleeping_Timer=Idle_Level_Multiplier*60
            Idling_Level2_Finish_Time=45*Idle_Level_Multiplier
        ElseIf Trim(LCase(parts(0)))="anti_joke_repetition" Then
            Joke_Memory_Length=CInt(Trim(parts(1)))
        ElseIf Trim(LCase(parts(0)))="anti_fact_repetition" Then
            Fact_Memory_Length=CInt(Trim(parts(1)))
        ElseIf Trim(LCase(parts(0)))="web_browser_path" Then
            If Trim(LCase(parts(1)))="default" Then
                Web_Browser_Path="default"
            Else
                Web_Browser_Path="""" & Trim(LCase(parts(1))) & """"
            End If
        End If
    End If
Loop
Set objFile=objFSO.OpenTextFile(jokepath, 1)
arrjokes=Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrjokes(UBound(arrjokes)+1)
    arrjokes(UBound(arrjokes))=objFile.ReadLine
Loop
objFile.Close
Joke_Number=Ubound(arrjokes)
If Joke_Memory_Length>Joke_Number-1 Then
    Joke_Memory_Length=Joke_Number-1
End If
Redim Preserve Excluded_Jokes(Joke_Memory_Length-1)
Set objFile=objFSO.OpenTextFile(factpath, 1)
arrfacts=Array()
Do Until objFile.AtEndOfStream
    Redim Preserve arrfacts(UBound(arrfacts)+1)
    arrfacts(UBound(arrfacts))=objFile.ReadLine
Loop
objFile.Close
Fact_Number=Ubound(arrfacts)
If Fact_Memory_Length>Fact_Number-1 Then
    Fact_Memory_Length=Fact_Number-1
End If
Redim Preserve Excluded_Facts(Fact_Memory_Length-1)

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
    Bonzi.IdleOn=False
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

Sub tellajoke()
    Bonzi.StopAll
    If Joke_Memory_Length>0 Then
        Randomize
        If firstrunjokes=1 Then
            Random_JokeNumber=Int((Joke_Number+1)*Rnd)
            firstrunjokes=0
        Else
            Random_JokeNumber=arr_jokenumber(Int(((Ubound(arr_jokenumber)+1)*Rnd)))
        End If
        Erase arr_jokenumber
        If d=Joke_Memory_Length Then
            d=0
        End If
        Excluded_Jokes(d)=Random_JokeNumber
        If Excluded_Jokes_Length<Joke_Memory_Length Then
            Excluded_Jokes_Length=Excluded_Jokes_Length+1
        End If
        For b=0 to Joke_Number
            match=0
            For c=0 to Excluded_Jokes_Length-1
                If b<>Excluded_Jokes(c) Then
                    match=0
                Else
                    match=1
                    Exit For
                End If
            Next
            If match=0 Then
                Redim Preserve arr_jokenumber(a)
                arr_jokenumber(a)=b
                a=a+1
            End If
        Next
        d=d+1
        a=0
        RandomJoke=arrjokes(Random_JokeNumber)
    ElseIf Joke_Memory_Length=0 then
        Randomize
        RandomJoke=arrjokes(Int((UBound(arrJokes)+1)*Rnd))
    End If
    Wscript.sleep 50
    Bonzi.play "RestPose"
    Bonzi.Speak "I've got one for you."
    Bonzi.Play "Explain"
    Bonzi.Speak RandomJoke
    Bonzi.Play "Giggle"
End Sub

Sub tellanamazingfact()
    Bonzi.StopAll
    If Fact_Memory_Length>0 Then
        Randomize
        If firstrunfacts=1 Then
            Random_FactNumber=Int((Fact_Number+1)*Rnd)
            firstrunfacts=0
        Else
            Random_FactNumber=arr_Factnumber(Int(((Ubound(arr_Factnumber)+1)*Rnd)))
        End If
        Erase arr_Factnumber
        If e=Fact_Memory_Length Then
            e=0
        End If
        Excluded_Facts(e)=Random_FactNumber
        If Excluded_Facts_Length<Fact_Memory_Length Then
            Excluded_Facts_Length=Excluded_Facts_Length+1
        End If
        For b=0 to Fact_Number
            match=0
            For c=0 to Excluded_Facts_Length-1
                If b<>Excluded_Facts(c) Then
                    match=0
                Else
                    match=1
                    Exit For
                End If
            Next
            If match=0 Then
                Redim Preserve arr_Factnumber(f)
                arr_Factnumber(f)=b
                f=f+1
            End If
        Next
        e=e+1
        f=0
        RandomFact=arrfacts(Random_FactNumber)
    ElseIf Fact_Memory_Length=0 then
        Randomize
        RandomFact=arrfacts(Int((UBound(arrfacts)+1)*Rnd))
    End If
    Wscript.sleep 50
    Bonzi.Play "ReadLookUp"
    Bonzi.Speak RandomFact
    Bonzi.Play "ReadReturn"
End Sub

Sub AgentControl_Click(ByVal CharacterID, ByVal Button, ByVal Shift, ByVal X, ByVal Y)
    On Error Resume Next

    If Button = 1 Then
        Bonzi.StopAll
        Wscript.Sleep 50
        Bonzi.Play "RestPose"
        Idle_Timer=0
    End If
End Sub

Sub InitAgentCommands()

    ' Purpose:  Initialize the Commands menu
    Bonzi.Commands.RemoveAll
    Bonzi.Commands.Caption = "MASH Menu"
    Bonzi.Commands.Add "tellajoke", "Tell a joke", "Tell a joke"
    Bonzi.Commands.Add "Browse", "Browse", "Browse"
    Bonzi.Commands.Add "Speak", "Speak", "Speak"
    Bonzi.Commands.Add "tellanamazingfact", "Tell an amazing fact", "Tell an amazing fact"
    Bonzi.Commands.Add "singasong", "Sing A Song", "Sing a song"
    Bonzi.Commands.Add "Search", "Search", "Search"
    Bonzi.Commands.Add "info", "Info", "Info"
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
            Idle_Timer=0
            Call tellajoke()
        Case "Browse"
            Bonzi.StopAll
            Idle_Timer=0
            Wscript.Sleep 50
            Bonzi.play "RestPose"
            Bonzi.Speak "OK " & name & "! Where do you want to go?"
            url=InputBox("Enter your url here!", "bonzibuddy renewed")
            if url="" Then Exit Sub
            If InStr(url, "://")=0 Then
            url="https://" & url
            End If
            url=Replace(url, " ", "")
            If Web_Browser_Path="default" Then
                x.run url, 0, False
            Else
                BrowseCmd=Web_Browser_Path & " " & url
                x.run BrowseCmd, 0, False
            End If
            Bonzi.Play "Search"
        Case "Speak"
            Bonzi.StopAll
            Idle_Timer=0
            Wscript.Sleep 50
            Bonzi.play "RestPose"
            speaktext=inputbox("Enter what you want me to speak.", "bonzibuddy renewed")
            Bonzi.Speak SpeakText
        Case "tellanamazingfact"
            Idle_Timer=0
            Call tellanamazingfact()
        Case "singasong"
            Bonzi.StopAll
            Idle_Timer=0
            Wscript.Sleep 50
            Bonzi.play "RestPose"
            x.run "explorer .\Songs"
        Case "info"
            Bonzi.StopAll
            Idle_Timer=0
            Wscript.Sleep 50
            Bonzi.Play"RestPose"
            MsgBox "BonziBuddy RENEWED version 0.1.8", 0, "Informations about BonziBuddy RENEWED"
        Case "Search"
            Bonzi.StopAll
            Idle_Timer=0
            Wscript.Sleep 50
            Bonzi.Play"RestPose"
            Bonzi.Speak "OK!"
            search=inputbox("Enter your search here!", "bonzibuddy renewed")
            if search="" Then Exit Sub
            searchfiltered=Replace(search, " ", "+")
            searchurl=search_engine & searchfiltered
            If Web_Browser_Path="default" Then
                x.run searchurl, 0, False
            Else
                SearchCmd=Web_Browser_Path & " " & searchurl
                x.run SearchCmd, 0, False
            End If
            Bonzi.Play "Search"
        End Select
        ' *** END MASH USER COMMANDS ***

        If UserInput.Name = "Exit" Then
            Bonzi.StopAll
            Bonzi.Play "Wave"
            Bonzi.Speak "Hope to see you soon, " & name & "!"
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
        currentdate=Right(Day(Date)+100,2) & " " & Right(Month(Date)+100,2) & " " & Year(Date)
        currentdate1=Right(Day(Date)+100,2)
        currentdate2=Right(Month(Date)+100,2)
        set holidaygreetings=objfso.OpenTextFile(holidaypath)
        If lastrun <> currentdate then
             Do Until match=true or holidaygreetings.AtEndOfStream
                holidaygreeting=holidaygreetings.ReadLine
                words=Split(holidaygreeting)
                if words(0)=currentdate1 And words(1)=currentdate2 Then
                scriptline=Split(holidaygreeting, " ", 3)(2)
                Execute("result = " & scriptLine)
                Bonzi.Speak result
                objfso.CreateTextFile(path1).Write(currentdate)
                match=true
                end if
             Loop
        End If
    else 
        Bonzi.Activate
    End If

    Idle_1_Animations=Array("Idle1_1","Idle1_3","Idle1_5","Idle1_6","Idle1_9","Idle1_11","Idle1_13","Idle1_14","Idle1_15","Idle1_4","Idle1_4 (2)","Idle1_5 (2)","Idle1_24","Idle1_12","Idle1_25","Idle1_1 (2)","Idle1_1 (3)","Idle1_9 (2)","Idle1_9 (3)")
    Idle_2_Animations=Array("Idle1_1","Idle1_9","Idle1_3","Idle1_5","Idle1_6","Idle1_4","Idle1_4 (2)","Idle1_5 (2)","Idle1_13","Idle1_12","Idle1_20","Idle1_21","Idle1_24","Idle1_8","Idle1_26","Idle1_14","Idle1_22","Idle1_25","Idle1_7","Idle1_1 (2)","Idle1_1 (3)")


    ' *** END MASH USER SCRIPT ***

    Set EndReq = Bonzi.Speak("\mrk=999999999\")

    Do
        If Idle_Timer>=5 And Idle_Timer<=Idling_Level2_Finish_Time Then
            If (Idle_Timer Mod 13)=0 Then
                Randomize
                Bonzi.Play Idle_1_Animations(Int(Rnd*(Ubound(Idle_1_Animations)+1)))
            End If
        ElseIf Idle_Timer>Idling_Level2_Finish_Time And Idle_Timer<Sleeping_Timer Then
            If (Idle_Timer Mod 13)=0 Then
                Randomize
                Bonzi.Play Idle_1_Animations(Int(Rnd*(Ubound(Idle_2_Animations)+1)))
            End If
        ElseIf Idle_Timer=Sleeping_Timer Then
            Bonzi.Play "Idle3_1"
            Bonzi.Play "Idle3_2"
        End If
        If Not Idle_Timer=Sleeping_Timer Then
            Idle_Timer=Idle_Timer+1
        End If
        If Free_Speaking=1 Then
            If (Idle_Timer Mod Free_Speaking_Interval)=0 Then
                Randomize
                Random_Speak=Int(2*Rnd+1)
                If Random_Speak=1 Then
                    Call tellajoke()
                ElseIf Random_Speak=2 Then
                    Call tellanamazingfact()
                End If
            End If
        End If
        WScript.Sleep 1000
    Loop Until ScriptComplete
End Sub
x.Environment("VOLATILE").Remove(envVar)