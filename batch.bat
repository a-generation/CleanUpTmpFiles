@echo off
setlocal

set "APPDATA_PATH=%APPDATA%"
set "SIX_MONTHS_AGO=%DATE%"

rem Calculate date 6 months ago
for /f "tokens=2 delims==" %%A in ('wmic os get localdatetime /value') do set "datetime=%%A"
set "DATE=%datetime:~0,8%"

set "SIX_MONTHS_AGO=%DATE%"

for /r "%APPDATA_PATH%" %%f in (*.tmp) do (
    forfiles /p "%%~dpf" /m "%%~nxf" /d -180 /c "cmd /c del @path"
    if exist "%%f" (
        del "%%f"
        echo Deleted: %%f
    )
)

endlocal
