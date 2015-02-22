set USER_VIMFILE_ROOT=%~dp0
del "%USER_VIMFILE_ROOT%\..\_vimrc"
mklink /H "%USER_VIMFILE_ROOT%\..\_vimrc" "%USER_VIMFILE_ROOT%\vimrc"