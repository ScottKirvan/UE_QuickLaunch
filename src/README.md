
# UE QuickLaunch


---
from:  https://superuser.com/questions/444726/windows-how-to-add-batch-script-action-to-right-click-menu

Actually, [the current answer](https://superuser.com/a/444787/167187) isn't out of date. I tried the exact same thing on Windows 10 and was able to add `Run Batch script` to the context menu of all folders in Windows.

This is the content of my batch script (won't work with [UNC paths](https://stackoverflow.com/a/9020832/1768141)):

```
@ECHO OFF
ECHO %~n0 was called with the following arguments:
SET args=%*
IF NOT DEFINED args GOTO END
ECHO %*
:END
PAUSE
```

The registry changes I made can be replicated with this REG file:

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\Run Batch script]
@="&Run Batch script"

[HKEY_CLASSES_ROOT\Directory\shell\Run Batch script\command]
@="\"H:\\BATCH_FILE_PATH\\context-batch.bat\" \"%1\""
```

This only adds a context menu item for all directories/folders in Windows. If you want it showing for each and every file instead, you can use this:

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\Run script]
@="Run &script"

[HKEY_CLASSES_ROOT\*\shell\Run script\command]
@="\"H:\\BATCH_FILE_PATH\\context-batch.bat\" \"%1\""
```


Alternatively, you can add your batch script to the `Send To` item list by creating a shortcut to your batch script and placing it under `%APPDATA%\Microsoft\Windows\SendTo` (or enter `shell:sendto` into the address bar)

If you want your script to show in the context menu that appears when you right click on the empty space within a directory (directory background?) you can use the following REG file:

```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\Run Batch script]
@="&Run Batch script"
"Icon"="%SystemRoot%\\System32\\shell32.dll,71"

[HKEY_CLASSES_ROOT\Directory\Background\shell\Run Batch script\command]
@="H:\\BATCH_FILE_PATH\\context-batch.bat \"%V\""
```

You don't need the `"Icon"="%SystemRoot%\\System32\\shell32.dll,71"` line. It simply adds an icon to your context-menu that looks like this:

[![context menu icon windows](https://i.stack.imgur.com/z57XF.png)](https://i.stack.imgur.com/z57XF.png)

- [Vinayak](https://superuser.com/users/167187/vinayak)

