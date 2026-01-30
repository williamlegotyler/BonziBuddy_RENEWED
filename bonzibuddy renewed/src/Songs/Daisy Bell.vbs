Set s=CreateObject("WScript.Shell"):Set f=CreateObject("Scripting.FileSystemObject")
h="C:\Windows\SysWOW64\wscript.exe"
If InStr(WScript.FullName,"SysWOW64")=0 And f.FileExists(h) Then
  c=Chr(34)&h&Chr(34)&Chr(34)&WScript.ScriptFullName&Chr(34):s.Run c,1,False:WScript.Quit
End If

On Error Resume Next

Set AgentControl = WScript.CreateObject("Agent.Control.2", "AgentControl_")
AgentControl.Connected = True

Dim Bonzi
Dim BonziID
BonziID = "Bonzi"
Dim SongEndReq
Dim ScriptComplete

ScriptComplete = False

AgentControl.Characters.Load BonziID, "bonzi.acs"

Set Bonzi = AgentControl.Characters(BonziID)

If Bonzi Is Nothing Then
    WScript.Quit
End If

Sub AgentControl_Click(ByVal CharacterID, ByVal Button, ByVal Shift, ByVal X, ByVal Y)
    On Error Resume Next

    If Button = 1 Then
        Bonzi.StopAll
    End If
End Sub

Bonzi.Show 
Bonzi.StopAll
Bonzi.TTSModeID = "{CA141FD0-AC7F-11D1-97A3-006008273001}"
Bonzi.Speak "\Chr=""Monotone""\\Pit=123\\Spd=55\Dai \Pit=100\zee, \Pit=80\Dai \Pit=60\zee"
Bonzi.Speak "\Chr=""Monotone""\\Pit=69\\Spd=90\Give \Pit=78\me \Pit=82\your \Pit=69\an, \Pit=80\ser \Pit=60\true."
Bonzi.Speak "\Chr=""Monotone""\\Pit=92\\Spd=55\I'm \Pit=123\half \Pit=100\cray \Pit=80\zee."
Bonzi.Speak "\Chr=""Monotone""\\Pit=69\\Spd=105\all \Pit=75\for \Pit=80\the  \Pit=80\love \Pit=104\of \Pit=90\you."
Bonzi.Speak "\Chr=""Monotone""\\Pit=98\\Spd=85\it \Pit=110\won't be \Pit=100\a \Pit=123\sty- \Pit=98\lish \Pit=92\mare \Pit=80\rege."
Bonzi.Speak "\Chr=""Monotone""\\Pit=90\\Spd=85\I \Pit=100\can't \Pit=69\a ford, a care- \Pit=60\ridge."
Bonzi.Speak "\Chr=""Monotone""\\Pit=60\\Spd=95\But \Pit=80\you'll \Pit=104\look \Pit=90\sweet."
Bonzi.Speak "\Chr=""Monotone""\\Pit=60\\Spd=95\Up \Pit=80\on \Pit=104\the \Pit=90\seat"

Set SongEndReq = Bonzi.Speak ("\Chr=""Monotone""\\Pit=100\\Spd=95\Of \Pit=110\a \Pit=123\by \Pit=100\sic \Pit=80\cull, \Pit=90\built, \Pit=60\for \Pit=80\two")

Do
    WScript.Sleep 100 
Loop Until ScriptComplete

Bonzi.Hide
AgentControl.Characters.Unload BonziID 

Sub AgentControl_RequestComplete(ByVal RequestObject)
    On Error Resume Next
    
    If RequestObject Is SongEndReq Then
        ScriptComplete = True
    End If
End Sub