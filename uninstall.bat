@echo off
set regfile="%~dp0\src\remove-folder-keys.reg"

echo Deleting the following registry keys and all associated subkeys:
echo (These are from %regfile%)
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
REGEDIT.exe /s %regfile%

:finished
echo.
echo Finished
echo.
pause