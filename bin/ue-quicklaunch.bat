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
:: replace spaces with underscores in Name
Set Name=%Name: =_%
:: replace decimal points with underscores in Name
Set Name=%Name:.=_% 
:: replace hyphens with underscores in Name
Set Name=%Name:-=_%
:: replace plus signs with underscores in Name
Set Name=%Name:+=_%
:: replace parentheses with underscores in Name
Set Name=%Name:(=_%
:: replace parentheses with underscores in Name
Set Name=%Name:)=_%
:: replace ampersands with underscores in Name
:: Set Name=%Name:&=_%
:: replace apostrophes with underscores in Name
Set Name=%Name:'=_%
:: replace commas with underscores in Name
 Set Name=%Name:,=_%
:: replace exclamation points with underscores in Name
 Set Name=%Name:!=_%
:: replace at signs with underscores in Name
Set Name=%Name:@=_%
:: replace number signs with underscores in Name
Set Name=%Name:#=_%
:: replace dollar signs with underscores in Name
Set Name=%Name:$=_%
:: replace percent signs with underscores in Name
:: Set Name=%Name:%%=_%
:: replace caret signs with underscores in Name
:: Set Name=%Name:^=_%
:: if first character in Name is a any number, prepend Name with the letter A
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
:: if first character in Name is an underscore, prepend Name with the letter A
if "%Name:~0,1%"=="_" Set Name=A%Name%


set iconpath=%iconpath:\=\\%bin\\skvfximageres.dll,0
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
PAUSE