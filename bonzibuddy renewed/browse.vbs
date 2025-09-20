Set x=CreateObject("Wscript.shell")
url=InputBox("Enter your url or search here!", "bonzibuddy renewed")
x.run url, 0, False
x.run "Searching.exe"