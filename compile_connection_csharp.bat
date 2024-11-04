@echo off
setlocal enabledelayedexpansion

:: Set the directory paths
set "includesDir=connection"
set "outputDir=./src_csharp/connection"

mkdir "src_csharp/connection"

:: Check if the includes directory exists
if not exist "%includesDir%" (
    echo The "%includesDir%" directory does not exist.
    exit /b 1
)

:: Loop through all files in the includes directory
for %%F in ("%includesDir%\*") do (
    :: Get the file name
    set "fileName=%%~nxF"
    
    :: Run the protoc command for each file
    echo Processing !fileName!...
    :: protoc -I. --proto_path=%includesDir%/ --csharp_out=./%outputDir% %includesDir%/!fileName!
    protogen --proto_path=%includesDir% +listset=yes +names=auto +repeatedaslist=yes --csharp_out=%outputDir% +oneof=enum !fileName!
    :: Check if the command was successful
    if !errorlevel! equ 0 (
        echo Protoc command executed successfully for !fileName!
    ) else (
        echo An error occurred while executing the protoc command for !fileName!
    )
    
    echo.
)

echo All files in the %includesDir% directory have been processed.

endlocal