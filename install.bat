@echo off


set regfile=%~dp0\temp\install.reg
set batchscript=%~dp0
set batchscript=%batchscript:\=\\%bin\\ue-quicklaunch.bat

echo Creating REG file in %regfile%

if not EXIST "%~dp0\temp" (
    md "%~dp0\temp"
)

echo.
echo.Windows Registry Editor Version 5.00 > "%regfile%"
echo.
echo.  >> "%regfile%"
echo.; Adds a context menu item when you right click in the empty space in a  >> "%regfile%"
echo.; directories/folder in Windows Explorer >> "%regfile%"
echo.  >> "%regfile%"
echo.[HKEY_CLASSES_ROOT\Directory\Background\shell\UE_QuickLaunch] >> "%regfile%"
echo.@="&QuickLaunch Unreal Engine here" >> "%regfile%"
echo."Icon"="%%SystemRoot%%\\System32\\shell32.dll,71" >> "%regfile%"
echo.  >> "%regfile%"
echo.[HKEY_CLASSES_ROOT\Directory\Background\shell\UE_QuickLaunch\command] >> "%regfile%"
echo.@="%batchscript% \"%%V\" IN_FOLDER" >> "%regfile%"
echo.  >> "%regfile%"
echo.; Adds a context menu item when you right click on a directories/folder >> "%regfile%"
echo.; name in Windows Explorer >> "%regfile%"
echo. >> "%regfile%"
echo.[HKEY_CLASSES_ROOT\Directory\shell\UE_QuickLaunch] >> "%regfile%"
echo.@="&QuickLaunch Unreal Engine here" >> "%regfile%"
echo."Icon"="%%SystemRoot%%\\System32\\shell32.dll,71" >> "%regfile%"
echo. >> "%regfile%"
echo.[HKEY_CLASSES_ROOT\Directory\shell\UE_QuickLaunch\command] >> "%regfile%"
echo.@="%batchscript% \"%%V\" ON_FOLDER" >> "%regfile%"

echo The following is a copy of the installer's registry script
echo ===========================================================================
type %regfile%
echo.
echo ===========================================================================

:again
set /p answer=Continue and apply these settings using regedit.exe? (Y/N)?
if /i "%answer:~,1%" EQU "Y" goto runit
if /i "%answer:~,1%" EQU "N" goto finished
echo Please type Y for Yes, or N for No
goto again

:runit
echo.
echo Calling %regfile%
REGEDIT.exe /s "%regfile%"

:finished
echo.
echo Finished
echo.
pause