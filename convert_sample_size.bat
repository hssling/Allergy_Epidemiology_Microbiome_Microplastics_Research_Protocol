@echo off
echo Converting Sample Size Calculation to DOCX...
echo.

"C:\Program Files\pandoc\pandoc.exe" "Protocol\Sample_Size_Calculation\sample_size_calculation.md" -o "Protocol\Sample_Size_Calculation\sample_size_calculation.docx"

if %errorlevel% equ 0 (
    echo ✓ Sample Size Calculation converted to DOCX successfully!
    echo File saved as: Protocol\Sample_Size_Calculation\sample_size_calculation.docx
) else (
    echo ✗ Conversion failed. Please check pandoc installation.
)

echo.
pause
