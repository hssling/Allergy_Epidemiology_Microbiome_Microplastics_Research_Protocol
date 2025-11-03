@echo off
echo Converting Standard Operating Procedures to DOCX...
echo.

"C:\Program Files\pandoc\pandoc.exe" "Protocol\SOPs\Standard_Operating_Procedures.md" -o "Protocol\SOPs\Standard_Operating_Procedures.docx"

if %errorlevel% equ 0 (
    echo ✓ Standard Operating Procedures converted to DOCX successfully!
    echo File saved as: Protocol\SOPs\Standard_Operating_Procedures.docx
) else (
    echo ✗ Conversion failed. Please check pandoc installation.
)

echo.
pause
