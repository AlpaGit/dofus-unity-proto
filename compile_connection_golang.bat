@echo off
setlocal enabledelayedexpansion

:: Set the directory paths
set "includesDir=connection"
set "outputDir=./src_golang/connection"

:: Check if the includes directory exists
if not exist "%includesDir%" (
    echo The "%includesDir%" directory does not exist.
    exit /b 1
)


:: Loop through all files in the includes directory
protoc -I. -I./game/google/protobuf --go_out=./src_golang ./connection/login_message.proto

echo All files in the %includesDir% directory have been processed.

endlocal