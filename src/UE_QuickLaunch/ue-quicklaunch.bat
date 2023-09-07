@ECHO OFF
SET targetDir=%~1
SET mode=%~2
set "sourceDir=%~dp0"
ECHO %~n0 was called with the following arguments: %targetDir% %mode% %sourceDir%

IF NOT DEFINED targetDir GOTO ERROR
IF NOT DEFINED mode GOTO ERROR
IF NOT DEFINED sourceDir GOTO ERROR
REM check if targetDir exists
if not exist "%targetDir%" echo The target directory does not exist, aborting. && goto ERROR
REM check if mode is either "ON_FOLDER" or "IN_FOLDER"
IF NOT "%mode%"=="ON_FOLDER" IF NOT "%mode%"=="IN_FOLDER" echo The mode argument must be either "ON_FOLDER" or "IN_FOLDER", aborting. && goto ERROR

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
    REM Check if the "ue_project_template" folder exists in sourceDir
    if exist "%sourceDir%\ue_project_template\" (
        echo The "ue_project_template" folder exists in "%sourceDir%"
        
        REM Copy the contents of "ue_project_template" folder to targetDir recursively
        REM /E - copy all subfolders and files including empty ones
        REM /Y - suppress prompting to confirm you want to overwrite an existing destination file
        REM /C - continue copying even if errors occur (e.g. file already exists in destination, but since we can't confirm overwite, we will skip it)
        xcopy "%sourceDir%\ue_project_template\" "%targetDir%\" /E /Y /C

        REM Rename the uproject file
        ren "ue_project_template.uproject" "%projectName%.uproject"

    ) else (
        echo The "ue_project_template" folder does not exist in "%batchDir%"

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
    REM Check if the "ue_project_template" folder exists in sourceDir
    if exist "%sourceDir%\ue_project_template\" (
        echo The "ue_project_template" folder exists in "%sourceDir%"
        
        REM Copy the contents of "ue_project_template" folder to targetDir recursively
        REM /E - copy all subfolders and files including empty ones
        REM /Y - suppress prompting to confirm you want to overwrite an existing destination file
        REM /C - continue copying even if errors occur (e.g. file already exists in destination, but since we can't confirm overwite, we will skip it)
        xcopy "%sourceDir%\ue_project_template\" "%targetDir%\" /E /Y /C

        REM Rename the uproject file
        echo ren "%targetDir%\ue_project_template.uproject" "%projectName%.uproject"
        ren "%targetDir%\ue_project_template.uproject" "%projectName%.uproject"

    ) else (
        if not EXIST "%targetDir%\%projectName%.uproject" (
            echo { "FileVersion": 3 } > "%targetDir%\%projectName%.uproject"
        )
    )
    echo.Launching "%targetDir%\%projectName%.uproject"
    start "" "%targetDir%\%projectName%.uproject"
)

REM and, to round out the feature set, and because I know
REM my muscle memory will make me do this, also launch 
REM when you've selected this by right clicking directly on a 
REM uproject file
REM NOTE:  this callback isn't registered during install, so it will never get called
<<<<<<< HEAD
REM NOTE:  I had installed this, but it conflicted with Unreal's own registry entries.
REM if %mode%==ON_UPROJECT (
REM    echo.Launching: "%projectName%"
REM    start "" "%projectName%"
REM )

goto END

:ERROR
echo An error occurred.
REM Pause here so the user can see the errors.
PAUSE
=======
REM if %mode%==ON_UPROJECT (
REM     echo.Launching: "%projectName%"
REM     start "" "%projectName%"
REM )
>>>>>>> 2b7fffe72bf17ba4b0fedbbeac7b89eb240c3247

:END
REM PAUSE

