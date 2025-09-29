Set x=CreateObject("Wscript.shell")
url=InputBox("Enter your url or search here!", "bonzibuddy renewed")
if url="" Then Wscript.quit
x.run url, 0, False
x.run "Searching.exe"