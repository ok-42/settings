:: https://www.tenforums.com/tutorials/5645-rebuild-icon-cache-windows-10-a.html#option2
ie4uinit.exe -show
taskkill /im explorer.exe /f
del /a /q "%localappdata%\IconCache.db"
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*"
shutdown /r /f /t 00
