@echo off
chcp 65001 >nul
pushd "%~dp0"
echo ===== Praxis-Intranet: Dateien aus Downloads uebernehmen =====
echo Nur noetig, wenn der Browser nicht direkt speichern konnte.
set "DL=%USERPROFILE%\Downloads"
if not exist archiv mkdir archiv
for /f %%t in ('powershell -nologo -noprofile -command "Get-Date -Format yyyy-MM-dd_HHmm"') do set "TS=%%t"
call :uebernehmen config
call :uebernehmen neuigkeiten
echo.
echo Fertig. An den PCs die Seite mit F5 neu laden.
popd
pause
exit /b
:uebernehmen
set "NEU="
set "OK="
for /f "delims=" %%f in ('dir /b /o-d "%DL%\%1*.js" 2^>nul') do if not defined NEU set "NEU=%%f"
if not defined NEU echo Keine %1-Datei in Downloads gefunden - uebersprungen.& exit /b
echo Gefunden: %NEU%
set /p OK=%1.js ersetzen? Die alte Version wird in archiv gesichert. J oder N: 
if /i not "%OK%"=="J" echo Uebersprungen.& exit /b
if exist %1.js copy /y %1.js "archiv\%1_%TS%.js" >nul
move /y "%DL%\%NEU%" %1.js >nul
echo %1.js wurde ersetzt.
exit /b
