@echo off
Setlocal EnableDelayedExpansion

set VIM_CONFIG_ROOT=%~dp0
set VIM_CONFIG_ROOT=%VIM_CONFIG_ROOT:~0,-1%

echo Install VIM configuration ...

:: Update to latest VIM configuration
echo Update to latest VIM configuration ...
::cd "%VIM_CONFIG_ROOT%" && git pull && git submodule update --init

:: Updating system VIM configuration
echo Updating system VIM configuration ...
call :CreateSymbolLinkWithBackup %VIM_CONFIG_ROOT%\vimrc %USERPROFILE%\_vimrc
if not errorlevel 0 (
    echo Install failed.
    exit /b 1
)

call :CreateSymbolLinkWithBackup %VIM_CONFIG_ROOT% %USERPROFILE%\vimfiles
if not errorlevel 0 (
    echo Install failed.
    exit /b 1
)

:: Install VIM plugins
echo Install VIM plugins ...
vim -c ":PluginInstall" -c ":qall"

echo Install complete.
exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Function: CreateSymbolLinkWithBackup
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CreateSymbolLinkWithBackup
set source_file=%1
set dest_file=%2

call :CreateBackupFileIfNeeded
if not errorlevel 0 (
    exit /b 1
)

echo Creating symbol link: "%dest_file%" -^> "%source_file%"
if exist %source_file%\ (
    mklink /D "%dest_file%" "%source_file%"
) else (
    mklink "%dest_file%" "%source_file%"
)
if not errorlevel 0 (
    echo Create backup failed.
    exit /b 1
)

exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Function: CreateBackupFileIfNeeded
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CreateBackupFileIfNeeded
if not exist "%dest_file%" (
    exit /b 0
)

set backup_id=0
set backup_file=%dest_file%.bak

:CheckBackupFileExist
if exist "%backup_file%" (
    set /a backup_id+=1
    set backup_file=%dest_file%.%backup_id%.bak
    goto :CheckBackupFileExist
)

echo Backing up "%dest_file%" to "%backup_file%" ...
move %dest_file% %backup_file% >nul 2>&1
if not errorlevel 0 (
    echo Create backup failed.
    exit /b 1
)

exit /b 0
