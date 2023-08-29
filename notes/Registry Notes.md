
# Background
To get right-click context menus to work with Windows, applications add registry settings that tell Windows Explorer what to populate those right-click menus with, and what to do when the user selects those menu items.  

Messing with the registry can be a bit daunting, and if you mess it up you can fuxor your system pretty quickly.  Many applications add these context menus during install, so this isn't an unusual or hacky thing to do, but it gets down into the guts of how windows works, so you want to be careful.  I've had a bad install mess up my system.  It's not fun, and it's not easy to fix, so please beware and always be sure you trust the source you're getting any registry modifying code from.

I've included the extra example files in this repo and the explanation below because I recommend always perusing REG files (In this case, I've included the Installer [source code](../src/UE_QuickLaunch_installer/ExampleComponents.wxs)) before clicking on them.  Even a basic understanding of what's happening can help protect you from malicious (or accidental) registry hacks. 

Further reading:  https://www.howtogeek.com/724600/how-to-read-a-reg-file-and-check-if-its-safe/

---
The following examples are based on a reworked and fixed answer from:  https://superuser.com/questions/444726/windows-how-to-add-batch-script-action-to-right-click-menu - from user [Vinayak](https://superuser.com/users/167187/vinayak)

> **Note** The process outlined below does NOT work with **UNC paths**

# Overview
Without going into too much detail, the Registry is organized like a directly structure.  Each "directory" is a Key, and in the same way that directories can have subdirectories, keys can have subkeys.  Each key can also *store* zero or more values  -- this is conceptually similar to directory structures:  A directory could have zero or more files stored under it.  So, keys can optionally hold subkeys and values, and each of those subkeys can alternatively have more subkeys and values, ad infinitum.

In our situation, in order to populate the right click menus, Windows Explorer looks at what's listed as subkeys in specific registry keys.  There's a set of them for right-clicking on files, and a set for right-clicking on folders, and a set for right clicking in an empty area that could eventually hold a file or a folder.  There are two specific keys, one with values that describe the look of the menu, and one with values that contain the `command` that Windows Explorer will call (in our case, it will run a batch file). 

The structure, in registry file format, looks kind of like this:
```
Windows Registry Editor Version 5.00

[HKEY\UNIQUEPATH\THAT\EXPLORER\WATCHES\_a_key_we_create_]
"some code that fills out the menu"

[HKEY\UNIQUEPATH\THAT\EXPLORER\WATCHES\_a_key_we_create_\command]
"a line that is executed by windows explorer"
```

It's really pretty straight forward.  Using [`regedit`](https://support.microsoft.com/en-us/windows/how-to-open-registry-editor-in-windows-10-deab38e6-91d6-e0aa-4b7c-8878d9e07b11) you can browse the registry editor and even look specifically at the keys that this repo works with.

# Example Code
## A Batch File for Debugging
Here's the batch script we'll use for testing.  It takes a single argument, a file or folder path, prints it to the screens, and then waits for a key-press before it exits.
```
@ECHO OFF
ECHO %~n0 was called with the following arguments:
SET args=%*
IF NOT DEFINED args GOTO END
ECHO %*
:END
PAUSE
```

## REG Files
All these examples need to be modified to match your system paths and the name of your batch file.

Each of these is formatted as a  \*.REG file and will run the batch file specified in the `command` key when selected -- keep in mind that `Windows Registry Editor Version 5.00` is required on the first line of a REG file.

To add a right-click context menu when you click on the name of a folder:
```
Windows Registry Editor Version 5.00

; Adds a context menu item when you right click on a directories/folder 
; name in Windows Explorer

[HKEY_CLASSES_ROOT\Directory\shell\ContextTestKey]
@="&Run Batch script"

[HKEY_CLASSES_ROOT\Directory\shell\ContextTestKey\command]
@=H:\\BATCH_FILE_PATH\\context-batch.bat \"%V\""
```

To add a right-click context menu when you click on a file:
```
Windows Registry Editor Version 5.00

; Adds a context menu item when you right-click on a file name 
; in Windows Explorer

[HKEY_CLASSES_ROOT\*\shell\ContextTestKey]
@="Run &script"

[HKEY_CLASSES_ROOT\*\shell\ContextTestKey\command]
@=H:\\BATCH_FILE_PATH\\context-batch.bat \"%V\""
```

To add a right-click context menu for when you right-click on the empty space within a directory:
```
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\ContextTestKey]
@="&Run Batch script"
"Icon"="%SystemRoot%\\System32\\shell32.dll,71"

[HKEY_CLASSES_ROOT\Directory\Background\shell\ContextTestKey\command]
@="H:\\BATCH_FILE_PATH\\context-batch.bat \"%V\""
```

The line `"Icon"="%SystemRoot%\\System32\\shell32.dll,71"` is just an example how how to add an icon to your item in the context menu.  It's completely optional.

[![context menu icon windows](https://i.stack.imgur.com/z57XF.png)](https://i.stack.imgur.com/z57XF.png)

Alternatively, you can add your batch script to the `Send To` item list by creating a shortcut to your batch script and placing it under `%APPDATA%\Microsoft\Windows\SendTo` (or enter `shell:sendto` into the address bar)

## To Remove The Registery Changes
> **Note**:  This is to **Remove**, not uninstall or roll-back any changes -- this just deletes the keys you've added in case you feel you want to remove any keys you've added.

For example, to remove the keys that were installed when you installed the "click-on-a-file" context menu, all you do is list the same Registry Keys used above with a "-" in front of them.  Here's the REG file that will remove the "click-on-a-file" keys from above:
```
Windows Registry Editor Version 5.00

[-HKEY_CLASSES_ROOT\*\shell\ContextTestKey\command]
[-HKEY_CLASSES_ROOT\*\shell\ContextTestKey]
```



## Registry Keys Created and Used by UE_QuickLaunch
```
[HKEY_CLASSES_ROOT\Directory\Background\shell\UE_QuickLaunch]
[HKEY_CLASSES_ROOT\Directory\Background\shell\UE_QuickLaunch\command]
[HKEY_CLASSES_ROOT\Directory\shell\UE_QuickLaunch]
[HKEY_CLASSES_ROOT\Directory\shell\UE_QuickLaunch\command]
```


