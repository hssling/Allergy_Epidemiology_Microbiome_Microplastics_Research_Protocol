@echo off
echo Converting Markdown files to DOCX and PDF formats...
echo.

REM Create output directories
if not exist "Protocol\Output_DOCX" mkdir "Protocol\Output_DOCX"
if not exist "Protocol\Output_PDF" mkdir "Protocol\Output_PDF"

echo Checking for pandoc installation...
where pandoc >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Pandoc is not installed.
    echo.
    echo To install pandoc:
    echo 1. Download from: https://pandoc.org/installing.html
    echo 2. Or run: choco install pandoc
    echo 3. Or run: winget install --id JohnMacFarlane.Pandoc
    echo.
    echo After installation, run this batch file again.
    pause
    exit /b 1
)

echo Pandoc found. Starting conversion...
echo.

REM Convert all markdown files to DOCX
echo Converting to DOCX format...
for %%f in ("Protocol\*.md") do (
    echo Converting %%~nf.md to DOCX...
    pandoc "%%f" -o "Protocol\Output_DOCX\%%~nf.docx" --reference-doc="Protocol\reference.docx" 2>nul
    if %errorlevel% equ 0 (
        echo ✓ %%~nf.docx created successfully
    ) else (
        echo ✗ Failed to convert %%~nf.md
    )
)

REM Convert all markdown files in subdirectories to DOCX
for /r "Protocol" %%f in (*.md) do (
    if not "%%~dpf"=="Protocol\" (
        echo Converting %%~nf.md to DOCX...
        pandoc "%%f" -o "Protocol\Output_DOCX\%%~nf.docx" --reference-doc="Protocol\reference.docx" 2>nul
        if %errorlevel% equ 0 (
            echo ✓ %%~nf.docx created successfully
        ) else (
            echo ✗ Failed to convert %%~nf.md
        )
    )
)

echo.
echo Converting to PDF format...
for %%f in ("Protocol\*.md") do (
    echo Converting %%~nf.md to PDF...
    pandoc "%%f" -o "Protocol\Output_PDF\%%~nf.pdf" --pdf-engine=pdflatex 2>nul
    if %errorlevel% equ 0 (
        echo ✓ %%~nf.pdf created successfully
    ) else (
        echo ✗ Failed to convert %%~nf.md
    )
)

REM Convert all markdown files in subdirectories to PDF
for /r "Protocol" %%f in (*.md) do (
    if not "%%~dpf"=="Protocol\" (
        echo Converting %%~nf.md to PDF...
        pandoc "%%f" -o "Protocol\Output_PDF\%%~nf.pdf" --pdf-engine=pdflatex 2>nul
        if %errorlevel% equ 0 (
            echo ✓ %%~nf.pdf created successfully
        ) else (
            echo ✗ Failed to convert %%~nf.md
        )
    )
)

echo.
echo Conversion completed!
echo.
echo Output files are located in:
echo - DOCX files: Protocol\Output_DOCX\
echo - PDF files: Protocol\Output_PDF\
echo.
echo If PDF conversion failed, you may need to install LaTeX:
echo 1. Install MiKTeX: https://miktex.org/download
echo 2. Or use: pandoc "file.md" -o "file.pdf" --pdf-engine=wkhtmltopdf
echo.
pause
