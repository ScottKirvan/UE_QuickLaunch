@ECHO OFF
SET targetDir=%~1
SET mode=%~2
set "sourceDir=%~dp0"
ECHO %~n0 was called with the following arguments: %targetDir% %mode% %sourceDir%
IF NOT DEFINED targetDir GOTO END

For %%A in ("%targetDir%") do (
    REM Set Folder=%%~dpA
    Set projectName=%%~nxA
)
REM replace spaces with underscores in projectName
Set projectName=%projectName: =_%
REM replace decimal points with underscores in projectName
REM Set projectName=%projectName:.=_% 
REM replace hyphens with underscores in projectName
Set projectName=%projectName:-=_%
REM replace plus signs with underscores in projectName
Set projectName=%projectName:+=_%
REM replace parentheses with underscores in projectName
Set projectName=%projectName:(=_%
REM replace parentheses with underscores in projectName
Set projectName=%projectName:)=_%
REM replace ampersands with underscores in projectName
REM Set projectName=%projectName:&=_%
REM replace apostrophes with underscores in projectName
Set projectName=%projectName:'=_%
REM replace commas with underscores in projectName
 Set projectName=%projectName:,=_%
REM replace exclamation points with underscores in projectName
 Set projectName=%projectName:!=_%
REM replace at signs with underscores in projectName
Set projectName=%projectName:@=_%
REM replace number signs with underscores in projectName
Set projectName=%projectName:#=_%
REM replace dollar signs with underscores in projectName
REM Set projectName=%projectName:$=_%
REM replace percent signs with underscores in projectName
REM Set projectName=%projectName:%%=_%
REM replace caret signs with underscores in projectName
REM Set projectName=%projectName:^=_%
REM if first character in projectName is a any number, prepend projectName with the letter A
if "%projectName:~0,1%"=="0" Set projectName=A%projectName%
if "%projectName:~0,1%"=="1" Set projectName=A%projectName%
if "%projectName:~0,1%"=="2" Set projectName=A%projectName%
if "%projectName:~0,1%"=="3" Set projectName=A%projectName%
if "%projectName:~0,1%"=="4" Set projectName=A%projectName%
if "%projectName:~0,1%"=="5" Set projectName=A%projectName%
if "%projectName:~0,1%"=="6" Set projectName=A%projectName%
if "%projectName:~0,1%"=="7" Set projectName=A%projectName%
if "%projectName:~0,1%"=="8" Set projectName=A%projectName%
if "%projectName:~0,1%"=="9" Set projectName=A%projectName%
REM if first character in projectName is an underscore, prepend projectName with the letter A
if "%projectName:~0,1%"=="_" Set projectName=A%projectName%


set iconpath=%iconpath:\=\\%bin\\skvfximageres.dll,0
echo.targetDir is: %targetDir%
REM echo.Folder is: %Folder%
echo.projectName is: %projectName%
echo.mode is: %mode%

REM this works for the clicking inside the folder bit
if %mode%==IN_FOLDER (
    
    REM Check if the "template" folder exists in sourceDir
    if exist "%sourceDir%\template\" (
        echo The "template" folder exists in "%sourceDir%"
        
        REM Copy the contents of "template" folder to targetDir recursively
        REM /E - copy all subfolders and files including empty ones
        REM /Y - suppress prompting to confirm you want to overwrite an existing destination file
        REM /C - continue copying even if errors occur (e.g. file already exists in destination, but since we can't confirm overwite, we will skip it)
        xcopy "%sourceDir%\template\" "%targetDir%\" /E /Y /C

        REM Rename the uproject file
        ren "template.uproject" "%projectName%.uproject"

    ) else (
        echo The "template" folder does not exist in "%batchDir%"

        if not EXIST "%projectName%.uproject" (
            echo { "FileVersion": 3 } > "%projectName%.uproject"
        )
    )

    echo.Launching: "%projectName%.uproject"

    start "" "%projectName%.uproject"
)

REM this is for the click on the folder name version
REM if there's already a name-matched uproject file in this folder, 
REM just open it, else, create, then open it.
if %mode%==ON_FOLDER (
    if not EXIST "%targetDir%\%projectName%.uproject" (
        echo { "FileVersion": 3 } > "%targetDir%\%projectName%.uproject"
    )
    echo.Launching "%targetDir%\%projectName%.uproject"
    start "" "%targetDir%\%projectName%.uproject"
)

REM and, to round out the feature set, and because I know
REM my muscle memory will make me do this, also launch 
REM when you've selected this by right clicking directly on a 
REM uproject file
REM NOTE:  this callback isn't registered during install, so it will never get called
if %mode%==ON_UPROJECT (
    echo.Launching: "%projectName%"
    start "" "%projectName%"
)

:END
PAUSE