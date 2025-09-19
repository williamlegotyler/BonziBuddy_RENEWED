Set x=CreateObject("Wscript.shell")
url=InputBox("Enter your url or search here!")
x.run url, 0, False
x.run "Searching.exe"
Wscript.sleep "10000"
x.run "Stop.exe"