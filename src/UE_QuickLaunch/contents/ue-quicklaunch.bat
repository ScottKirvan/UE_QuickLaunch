@ECHO OFF
setLocal

SET targetDir=%~1
SET mode=%~2
set "sourceDir=%~dp0"
ECHO %~n0 was called with the following arguments: %targetDir% %mode% %sourceDir%

IF NOT DEFINED mode GOTO ERROR
IF NOT "%mode%"=="ON_FOLDER" IF NOT "%mode%"=="IN_FOLDER" if NOT "%mode%"=="OPEN_DOCS" echo The second argument must be either "ON_FOLDER", "IN_FOLDER", or "OPEN_DOCS" aborting. && goto ERROR

if %mode%==OPEN_DOCS (
    start "" "https://github.com/ScottKirvan/UE_QuickLaunch"
    goto END
)

IF NOT DEFINED targetDir GOTO ERROR
IF NOT DEFINED sourceDir GOTO ERROR

REM check if targetDir exists
if not exist "%targetDir%" echo The target directory does not exist, aborting. && goto ERROR
REM check if mode is either "ON_FOLDER" or "IN_FOLDER"

For %%A in ("%targetDir%") do (
    Set projectName=%%~nxA
)
echo ProjectName before cleanup: %projectName%

REM replace spaces with underscores in projectName
Set projectName=%projectName: =_%
REM replace decimal points with underscores in projectName
Set projectName=%projectName:.=_%
REM replace hyphens with underscores in projectName
Set projectName=%projectName:-=_%
REM replace plus signs with underscores in projectName
Set projectName=%projectName:+=_%
REM replace parentheses with underscores in projectName
Set projectName=%projectName:(=_%
REM replace parentheses with underscores in projectName
Set projectName=%projectName:)=_%
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
Set projectName=%projectName:$=_%
REM if first character in projectName is a any number, prepend projectName with the UE_
if "%projectName:~0,1%"=="0" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="1" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="2" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="3" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="4" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="5" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="6" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="7" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="8" Set projectName=UE_%projectName%
if "%projectName:~0,1%"=="9" Set projectName=UE_%projectName%
REM if first character in projectName is an underscore, prepend projectName with UE
if "%projectName:~0,1%"=="_" Set projectName=UE%projectName%

echo After cleanup:
echo.targetDir is: %targetDir%
echo.projectName is: %projectName%
echo.mode is: %mode%

REM this works for the clicking inside the folder bit
if %mode%==IN_FOLDER goto createProject
if %mode%==ON_FOLDER goto createProject
REM ELSE
goto ERROR

:createProject
REM Check if the "ue_quicklaunch_template" folder exists in sourceDir
REM if it exists, copy it to the targetDir
if exist "%sourceDir%\ue_quicklaunch_template\" (
    if not EXIST "%targetDir%\%projectName%.uproject" (
        echo The "ue_quicklaunch_template" folder exists in "%sourceDir%" - copying files
        
        REM Copy the contents of "ue_quicklaunch_template" folder to targetDir recursively
        REM /E - copy subdirectories, including empty ones.
        REM /W:0 - specifies a wait time of 0 seconds before retries (to avoid unnecessary delays).
        REM /R:0 - specifies 0 retry attempts (to avoid retries on failures).
        REM /XC excludes existing files with the same timestamp, but different file sizes. Robocopy normally overwrites those.
        REM /XN excludes existing files newer than the copy in the destination directory. Robocopy normally overwrites those.
        REM /XO excludes existing files older than the copy in the destination directory. Robocopy normally overwrites those.
        echo robocopy "%sourceDir%\ue_quicklaunch_template\\" "%targetDir%\\" /E /XN /XC /XO /W:0 /R:0 /NDL /NFL
        robocopy "%sourceDir%\ue_quicklaunch_template\\" "%targetDir%\\" /E /XN /XC /XO /W:0 /R:0 /NDL /NFL

        REM Rename the uproject file
        echo ren "%targetDir%\ue_quicklaunch_template.uproject" "%projectName%.uproject"
        ren "%targetDir%\ue_quicklaunch_template.uproject" "%projectName%.uproject"
    )
) else (
    REM Template folder does not exist, so create the uproject file
    echo The "ue_quicklaunch_template" folder does not exist in "%sourceDir%"

    if not EXIST "%targetDir%\%projectName%.uproject" (
        echo Creating new uproject file.
        echo { "FileVersion": 3 } > "%targetDir%\%projectName%.uproject"
    )
)

REM echo.Launching: "%projectName%.uproject"

REM echo start "" "%targetDir%\%projectName%.uproject"
REM start "" "%targetDir%\%projectName%.uproject"

echo start "" "%targetDir%\%projectName%.uproject"
start "" "%targetDir%\%projectName%.uproject"

goto END

:ERROR
echo An error occurred.
REM Pause here so the user can see the errors.
PAUSE

:END

endLocal

REM PAUSE

