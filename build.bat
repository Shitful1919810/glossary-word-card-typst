@echo off
setlocal enabledelayedexpansion

rem Configuration
set "TYPST_COMMAND=typst"
set "PYTHON=python"
set "OUTPUT_DIR=build"

set "A4_SRC=src_a4.typ"
set "A4_PDF=%OUTPUT_DIR%\glossary_a4.pdf"
set "A5_PDF=%OUTPUT_DIR%\glossary_a5.pdf"
set "A4_SHORT_A5_PDF=%OUTPUT_DIR%\glossary_a4_short_side_a5.pdf"
set "A4_LONG_A5_PDF=%OUTPUT_DIR%\glossary_a4_long_side_a5.pdf"

if "%~1"=="" goto all_target
if /i "%~1"=="a4" goto build_a4
if /i "%~1"=="a5" goto build_a5
if /i "%~1"=="a4_short_side_a5" goto build_a4_short_side_a5
if /i "%~1"=="a4_long_side_a5" goto build_a4_long_side_a5
if /i "%~1"=="all" goto all_target
if /i "%~1"=="clean" goto clean
echo Unknown command: %~1
echo Usage: %~nx0 [a4^|a5^|a4_short_side_a5^|a4_long_side_a5^|all^|clean]
exit /b 1

:ensure_outdir
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)
exit /b 0

:build_a4
call :ensure_outdir
echo Building A4 -> %A4_PDF% ...
"%TYPST_COMMAND%" compile "%A4_SRC%" "%A4_PDF%"
if errorlevel 1 exit /b %errorlevel%
echo OK: %A4_PDF%
exit /b 0

:get_a4_page_count
if not exist "%A4_PDF%" (
    echo A4 PDF not found, building it first...
    call :build_a4
)
set "a4_page_cnt="
for /f "usebackq delims=" %%i in (`%PYTHON% get_pdf_page_cnt.py --input "%A4_PDF%"`) do set "a4_page_cnt=%%i"
if "%a4_page_cnt%"=="" (
    echo Failed to get A4 page count.
    exit /b 1
)
exit /b 0

:build_a5
call :get_a4_page_count
echo Building A5 -> %A5_PDF% ...
"%TYPST_COMMAND%" compile export_a5.typ "%A5_PDF%" --input in="%A4_PDF%" --input page_cnt=%a4_page_cnt%
if errorlevel 1 exit /b %errorlevel%
echo OK: %A5_PDF%
exit /b 0

:build_a4_short_side_a5
call :get_a4_page_count
echo Building A4 short-side A5 -> %A4_SHORT_A5_PDF% ...
"%TYPST_COMMAND%" compile export_a4_short_side_a5.typ "%A4_SHORT_A5_PDF%" --input in="%A4_PDF%" --input page_cnt=%a4_page_cnt%
if errorlevel 1 exit /b %errorlevel%
echo OK: %A4_SHORT_A5_PDF%
exit /b 0

:build_a4_long_side_a5
call :get_a4_page_count
echo Building A4 long-side A5 -> %A4_LONG_A5_PDF% ...
"%TYPST_COMMAND%" compile export_a4_long_side_a5.typ "%A4_LONG_A5_PDF%" --input in="%A4_PDF%" --input page_cnt=%a4_page_cnt%
if errorlevel 1 exit /b %errorlevel%
echo OK: %A4_LONG_A5_PDF%
exit /b 0

:all_target
call :build_a4
call :build_a5
call :build_a4_short_side_a5
call :build_a4_long_side_a5
exit /b 0

:clean
if exist "%OUTPUT_DIR%" (
    echo Removing %OUTPUT_DIR% ...
    rmdir /s /q "%OUTPUT_DIR%"
)
exit /b 0