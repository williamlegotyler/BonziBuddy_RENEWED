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

Bonzi.Show 
Bonzi.StopAll
Bonzi.TTSModeID = "{CA141FD0-AC7F-11D1-97A3-006008273001}"
Bonzi.Speak "\Chr=""Monotone""\\Map=""\Pit=262\\Spd=200\beu \Pit=247\tì \Pit=262\full \Pit=196\\Spd=130\drea \Pit=165\mer \Pit=147\\Spd=120\wake \Pit=139\\Spd=150\un \Pit=147\to \Pit=220\\Spd=120\mee""=""Beautiful dreamer wake unto me.""\"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=190\star \Pit=247\\Spd=120\light \Pit=220\\Spd=90\and \Spd=130\dew \Pit=196\drops \Pit=175\\Spd=120\are \Spd=150\wai \Pit=165\ting \Pit=147\\Spd=120\for \Pit=165\\Spd=130\thee"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=150\Sounds \Pit=247\of \Pit=262\the \Pit=196\rude \Pit=165\world \Pit=147\heard \Pit=139\in \Pit=147\the \Pit=220\day"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=160\lulled \Pit=247\by \Pit=220\the moon \Pit=196\light \Pit=165\have \Pit=175\all \Pit=165\passed \Pit=139\a \Pit=131\way"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=160\beu \Pit=175\tì \Pit=147\full \Pit=123\\Spd=140\drea \Pit=220\\Spd=160\mer queen \Pit=196\of \Pit=165\my \Pit=131\song"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=70\list \Spd=130\while i \Pit=220\woo \Pit=294\thee \Pit=247\with soft mel \Pit=220\lo \Pit=196\dì"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=70\Gone \Pit=247\\Spd=130\are \Pit=262\the \Pit=196\cares \Pit=165\of \Pit=147\life's \Pit=139\bì \Pit=147\zì \Pit=220\throngs"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=70\Beu \Pit=247\\Spd=130\tì \Pit=220\full drea \Pit=196\mer \Pit=175\awake \Pit=165\un \Pit=147\to \Pit=165\mee."
Bonzi.Speak "\Chr=""Monotone""\\Pit=220\\Spd=130\Beu \Pit=247\tì \Pit=262\full drea \Pit=220\mer \Pit=165\aw \Pit=175\\Spd=70\wake \Pit=165\\Spd=130\un \Pit=147\to \Pit=131\mee"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=190\beu \Pit=247\tì \Pit=262\full \Pit=196\\Spd=130\drea \Pit=165\mer \Pit=147\\Spd=120\out \Pit=139\\Spd=150\on \Pit=147\the \Pit=220\\Spd=120\sea"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=190\mer \Pit=247\\Spd=120\maids \Pit=220\\Spd=90\are \Spd=130\chan \Pit=196\ting \Pit=175\\Spd=120\the \Spd=150\wild \Pit=165\lo\Pit=147\\Spd=70\reh \Pit=165\\Spd=70\lei."
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=150\o \Pit=247\ver \Pit=262\the \Pit=196\stream \Pit=165\let \Pit=147\vay \Pit=139\pors \Pit=147\are \Pit=220\borne."
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=160\Wai \Pit=247\ting \Pit=220\to fade \Pit=196\at \Pit=165\the \Pit=175\bright \Pit=165\kum\Pit=139\ming \Pit=131\morn."
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=160\beu \Pit=175\tì \Pit=147\full \Pit=123\\Spd=140\drea \Pit=220\\Spd=160\mer queen \Pit=196\of \Pit=165\my \Pit=131\song"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=70\e'en \Spd=130\as the \Pit=220\morn \Pit=294\on \Pit=247\the streamlet\Pit=220\and \Pit=196\sea"
Bonzi.Speak "\Chr=""Monotone""\\Pit=262\\Spd=70\then \Pit=247\\Spd=130\will \Pit=262\all \Pit=196\clouds \Pit=165\of \Pit=147\sar \Pit=139\row \Pit=147\de \Pit=220\part"
Bonzi.Speak "\Chr=""Monotone""\\Pit=196\\Spd=70\Beu \Pit=247\\Spd=130\tì \Pit=220\full drea \Pit=196\mer \Pit=175\awake \Pit=165\un \Pit=147\to \Pit=165\mee."
    
Set SongEndReq = Bonzi.Speak("\Chr=""Monotone""\\Pit=220\\Spd=130\Beu \Pit=247\tì \Pit=262\full drea \Pit=220\mer \Pit=165\aw \Pit=175\\Spd=70\wake \Pit=165\\Spd=130\un \Pit=147\to \Pit=131\mee.")

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