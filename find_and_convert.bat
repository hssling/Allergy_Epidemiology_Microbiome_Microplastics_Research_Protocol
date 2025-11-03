@echo off
echo Finding Pandoc and Converting Files...
echo =====================================
echo.

REM Try to find pandoc in common locations
set PANDOC_PATH=

REM Check if pandoc is in PATH
pandoc --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Pandoc found in PATH
    set PANDOC_PATH=pandoc
    goto :convert
)

REM Check winget installation location
if exist "C:\Users\%USERNAME%\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.8.2.1\pandoc.exe" (
    echo ✓ Pandoc found in WinGet location
    set PANDOC_PATH="C:\Users\%USERNAME%\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.8.2.1\pandoc.exe"
    goto :convert
)

REM Check Program Files
if exist "C:\Program Files\pandoc\pandoc.exe" (
    echo ✓ Pandoc found in Program Files
    set PANDOC_PATH="C:\Program Files\pandoc\pandoc.exe"
    goto :convert
)

REM Check Chocolatey location
if exist "C:\ProgramData\chocolatey\bin\pandoc.exe" (
    echo ✓ Pandoc found in Chocolatey location
    set PANDOC_PATH="C:\ProgramData\chocolatey\bin\pandoc.exe"
    goto :convert
)

echo ✗ Pandoc not found in common locations
echo.
echo Please install pandoc first:
echo 1. winget install --id JohnMacFarlane.Pandoc
echo 2. Or download from: https://pandoc.org/installing.html
echo.
echo Then run this script again.
pause
exit /b 1

:convert
echo.
echo Using pandoc at: %PANDOC_PATH%
echo.
echo Creating output directories...
if not exist "Protocol\Output_DOCX" mkdir "Protocol\Output_DOCX"
if not exist "Protocol\Output_PDF" mkdir "Protocol\Output_PDF"

echo.
echo Converting files to DOCX format...
echo =================================

%PANDOC_PATH% "Protocol\Main_Protocol.md" -o "Protocol\Output_DOCX\Main_Protocol.docx"
if %errorlevel% equ 0 (echo ✓ Main_Protocol.docx created) else (echo ✗ Failed to create Main_Protocol.docx)

%PANDOC_PATH% "Protocol\Questionnaires\Main_Questionnaire.md" -o "Protocol\Output_DOCX\Main_Questionnaire.docx"
if %errorlevel% equ 0 (echo ✓ Main_Questionnaire.docx created) else (echo ✗ Failed to create Main_Questionnaire.docx)

%PANDOC_PATH% "Protocol\Data_Collection_Forms\Clinical_Examination_Form.md" -o "Protocol\Output_DOCX\Clinical_Examination_Form.docx"
if %errorlevel% equ 0 (echo ✓ Clinical_Examination_Form.docx created) else (echo ✗ Failed to create Clinical_Examination_Form.docx)

%PANDOC_PATH% "Protocol\Ethical_Documents\Ethics_Committee_Submission.md" -o "Protocol\Output_DOCX\Ethics_Committee_Submission.docx"
if %errorlevel% equ 0 (echo ✓ Ethics_Committee_Submission.docx created) else (echo ✗ Failed to create Ethics_Committee_Submission.docx)

%PANDOC_PATH% "Protocol\Analysis_Plan\Data_Analysis_Plan.md" -o "Protocol\Output_DOCX\Data_Analysis_Plan.docx"
if %errorlevel% equ 0 (echo ✓ Data_Analysis_Plan.docx created) else (echo ✗ Failed to create Data_Analysis_Plan.docx)

%PANDOC_PATH% "Protocol\Timeline_Budget\Study_Timeline_and_Budget.md" -o "Protocol\Output_DOCX\Study_Timeline_and_Budget.docx"
if %errorlevel% equ 0 (echo ✓ Study_Timeline_and_Budget.docx created) else (echo ✗ Failed to create Study_Timeline_and_Budget.docx)

%PANDOC_PATH% "Protocol\SOPs\Standard_Operating_Procedures.md" -o "Protocol\Output_DOCX\Standard_Operating_Procedures.docx"
if %errorlevel% equ 0 (echo ✓ Standard_Operating_Procedures.docx created) else (echo ✗ Failed to create Standard_Operating_Procedures.docx)

%PANDOC_PATH% "Protocol\Consent_Forms\Participant_Consent_Form.md" -o "Protocol\Output_DOCX\Participant_Consent_Form.docx"
if %errorlevel% equ 0 (echo ✓ Participant_Consent_Form.docx created) else (echo ✗ Failed to create Participant_Consent_Form.docx)

%PANDOC_PATH% "Protocol\Data_Management\Data_Management_Plan.md" -o "Protocol\Output_DOCX\Data_Management_Plan.docx"
if %errorlevel% equ 0 (echo ✓ Data_Management_Plan.docx created) else (echo ✗ Failed to create Data_Management_Plan.docx)

%PANDOC_PATH% "Protocol\Dissemination\Dissemination_Plan.md" -o "Protocol\Output_DOCX\Dissemination_Plan.docx"
if %errorlevel% equ 0 (echo ✓ Dissemination_Plan.docx created) else (echo ✗ Failed to create Dissemination_Plan.docx)

%PANDOC_PATH% "Protocol\Translation_Plan.md" -o "Protocol\Output_DOCX\Translation_Plan.docx"
if %errorlevel% equ 0 (echo ✓ Translation_Plan.docx created) else (echo ✗ Failed to create Translation_Plan.docx)

echo.
echo DOCX conversion completed!
echo.
echo Files saved to: Protocol\Output_DOCX\
echo.
echo Note: PDF conversion requires LaTeX installation.
echo To convert to PDF, install MiKTeX from https://miktex.org/download
echo Then use: pandoc "file.md" -o "file.pdf" --pdf-engine=pdflatex
echo.
pause
