@ECHO OFF
ECHO %~n0 was called with the following arguments:
SET Filepath=%~1
SET mode=%~2
IF NOT DEFINED Filepath GOTO END
ECHO %Filepath% 

For %%A in ("%Filepath%") do (
    Set Folder=%%~dpA
    Set Name=%%~nxA
)
echo.Filepath is: %Filepath%
echo.Folder is: %Folder%
echo.Name is: %Name%
:: this works for the clicking inside the folder bit
if %mode%==IN_FOLDER (
    if not EXIST "%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Name%.uproject"
    )
    start "" "%Name%.uproject"
)

:: this is for the click on the folder name version
:: if there's already a name-matched uproject file in this folder, 
:: just open it, else, create, then open it.
if %mode%==ON_FOLDER (
    if not EXIST "%Filepath%\%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Filepath%\%Name%.uproject"
    )
    start "" "%Filepath%\%Name%.uproject"
)

echo %Filepath%
set var=%Filepath:\=\\%
echo @="%var%\\context-batch.bat \"%V\" IN_FOLDER"


:END
PAUSE