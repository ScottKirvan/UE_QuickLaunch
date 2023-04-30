@ECHO OFF
ECHO %~n0 was called with the following arguments:
SET Filepath=%~1
SET mode=%~2
IF NOT DEFINED Filepath GOTO END
echo.%Filepath% 
echo.

For %%A in ("%Filepath%") do (
    Set Folder=%%~dpA
    Set Name=%%~nxA
)
echo.Filepath is: %Filepath%
echo.Folder is: %Folder%
echo.Name is: %Name%
echo.

:: this works for the clicking inside the folder bit
if %mode%==IN_FOLDER (
    if not EXIST "%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Name%.uproject"
    )
    echo.Launching: "%Name%.uproject"
    start "" "%Name%.uproject"
)

:: this is for the click on the folder name version
:: if there's already a name-matched uproject file in this folder, 
:: just open it, else, create, then open it.
if %mode%==ON_FOLDER (
    if not EXIST "%Filepath%\%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Filepath%\%Name%.uproject"
    )
    echo.Launching "%Filepath%\%Name%.uproject"
    start "" "%Filepath%\%Name%.uproject"
)

:: and, to round out the feature set, and because I know
:: my muscle memory will make me do this, also launch 
:: when you've selected this by right clicking directly on a 
:: uproject file
if %mode%==ON_UPROJECT (
    echo.Launching: "%Name%"
    start "" "%Name%"
)

:END
::PAUSE