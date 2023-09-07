@ECHO OFF
SET Filepath=%~1
SET mode=%~2
ECHO %~n0 was called with the following arguments: %Filepath% %mode%
IF NOT DEFINED Filepath GOTO END

For %%A in ("%Filepath%") do (
    Set Folder=%%~dpA
    Set Name=%%~nxA
)
REM replace spaces with underscores in Name
Set Name=%Name: =_%
REM :: replace decimal points with underscores in Name
REM Set Name=%Name:.=_% 
REM replace hyphens with underscores in Name
Set Name=%Name:-=_%
REM replace plus signs with underscores in Name
Set Name=%Name:+=_%
REM replace parentheses with underscores in Name
Set Name=%Name:(=_%
REM replace parentheses with underscores in Name
Set Name=%Name:)=_%
REM replace ampersands with underscores in Name
REM Set Name=%Name:&=_%
REM replace apostrophes with underscores in Name
Set Name=%Name:'=_%
REM replace commas with underscores in Name
 Set Name=%Name:,=_%
REM replace exclamation points with underscores in Name
 Set Name=%Name:!=_%
REM replace at signs with underscores in Name
Set Name=%Name:@=_%
REM replace number signs with underscores in Name
Set Name=%Name:#=_%
REM replace dollar signs with underscores in Name
REM Set Name=%Name:$=_%
REM replace percent signs with underscores in Name
REM Set Name=%Name:%%=_%
REM replace caret signs with underscores in Name
REM Set Name=%Name:^=_%
REM if first character in Name is a any number, prepend Name with the letter A
if "%Name:~0,1%"=="0" Set Name=A%Name%
if "%Name:~0,1%"=="1" Set Name=A%Name%
if "%Name:~0,1%"=="2" Set Name=A%Name%
if "%Name:~0,1%"=="3" Set Name=A%Name%
if "%Name:~0,1%"=="4" Set Name=A%Name%
if "%Name:~0,1%"=="5" Set Name=A%Name%
if "%Name:~0,1%"=="6" Set Name=A%Name%
if "%Name:~0,1%"=="7" Set Name=A%Name%
if "%Name:~0,1%"=="8" Set Name=A%Name%
if "%Name:~0,1%"=="9" Set Name=A%Name%
REM if first character in Name is an underscore, prepend Name with the letter A
if "%Name:~0,1%"=="_" Set Name=A%Name%


set iconpath=%iconpath:\=\\%bin\\skvfximageres.dll,0
echo.Filepath is: %Filepath%
echo.Folder is: %Folder%
echo.Name is: %Name%
echo.mode is: %mode%

REM this works for the clicking inside the folder bit
if %mode%==IN_FOLDER (
    if not EXIST "%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Name%.uproject"
    )
    echo.Launching: "%Name%.uproject"
    pause
    REM start "" "%Name%.uproject"
)

REM this is for the click on the folder name version
REM if there's already a name-matched uproject file in this folder, 
REM just open it, else, create, then open it.
if %mode%==ON_FOLDER (
    if not EXIST "%Filepath%\%Name%.uproject" (
        echo { "FileVersion": 3 } > "%Filepath%\%Name%.uproject"
    )
    echo.Launching "%Filepath%\%Name%.uproject"
    REM start "" "%Filepath%\%Name%.uproject"
)

REM and, to round out the feature set, and because I know
REM my muscle memory will make me do this, also launch 
REM when you've selected this by right clicking directly on a 
REM uproject file
REM NOTE:  this callback isn't registered during install, so it will never get called
if %mode%==ON_UPROJECT (
    echo.Launching: "%Name%"
    REM start "" "%Name%"
)

:END
PAUSE