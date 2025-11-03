@echo off
echo Manual Markdown to Office Conversion Script
echo ===========================================
echo.
echo This script provides commands to convert individual files.
echo Copy and paste the commands below into Command Prompt or PowerShell.
echo.
echo PREREQUISITES:
echo 1. Install pandoc: winget install --id JohnMacFarlane.Pandoc
echo 2. For PDF: Install MiKTeX from https://miktex.org/download
echo.
echo CONVERSION COMMANDS:
echo.
echo DOCX Conversion:
echo ----------------
echo pandoc "Protocol\Main_Protocol.md" -o "Protocol\Main_Protocol.docx"
echo pandoc "Protocol\Questionnaires\Main_Questionnaire.md" -o "Protocol\Main_Questionnaire.docx"
echo pandoc "Protocol\Data_Collection_Forms\Clinical_Examination_Form.md" -o "Protocol\Clinical_Examination_Form.docx"
echo pandoc "Protocol\Ethical_Documents\Ethics_Committee_Submission.md" -o "Protocol\Ethics_Committee_Submission.docx"
echo pandoc "Protocol\Analysis_Plan\Data_Analysis_Plan.md" -o "Protocol\Data_Analysis_Plan.docx"
echo pandoc "Protocol\Timeline_Budget\Study_Timeline_and_Budget.md" -o "Protocol\Study_Timeline_and_Budget.docx"
echo pandoc "Protocol\SOPs\Standard_Operating_Procedures.md" -o "Protocol\Standard_Operating_Procedures.docx"
echo pandoc "Protocol\Consent_Forms\Participant_Consent_Form.md" -o "Protocol\Participant_Consent_Form.docx"
echo pandoc "Protocol\Data_Management\Data_Management_Plan.md" -o "Protocol\Data_Management_Plan.docx"
echo pandoc "Protocol\Dissemination\Dissemination_Plan.md" -o "Protocol\Dissemination_Plan.docx"
echo pandoc "Protocol\Translation_Plan.md" -o "Protocol\Translation_Plan.docx"
echo.
echo PDF Conversion:
echo ---------------
echo pandoc "Protocol\Main_Protocol.md" -o "Protocol\Main_Protocol.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Questionnaires\Main_Questionnaire.md" -o "Protocol\Main_Questionnaire.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Data_Collection_Forms\Clinical_Examination_Form.md" -o "Protocol\Clinical_Examination_Form.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Ethical_Documents\Ethics_Committee_Submission.md" -o "Protocol\Ethics_Committee_Submission.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Analysis_Plan\Data_Analysis_Plan.md" -o "Protocol\Data_Analysis_Plan.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Timeline_Budget\Study_Timeline_and_Budget.md" -o "Protocol\Study_Timeline_and_Budget.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\SOPs\Standard_Operating_Procedures.md" -o "Protocol\Standard_Operating_Procedures.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Consent_Forms\Participant_Consent_Form.md" -o "Protocol\Participant_Consent_Form.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Data_Management\Data_Management_Plan.md" -o "Protocol\Data_Management_Plan.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Dissemination\Dissemination_Plan.md" -o "Protocol\Dissemination_Plan.pdf" --pdf-engine=pdflatex
echo pandoc "Protocol\Translation_Plan.md" -o "Protocol\Translation_Plan.pdf" --pdf-engine=pdflatex
echo.
echo ALTERNATIVE METHODS:
echo ====================
echo.
echo 1. Online Converter: https://pandoc.org/try/
echo    - Upload .md file
echo    - Select output format
echo    - Download converted file
echo.
echo 2. VS Code Extension:
echo    - Install "Markdown PDF" extension
echo    - Open .md file
echo    - Ctrl+Shift+P → "Markdown PDF: Export"
echo.
echo 3. Microsoft Word:
echo    - Open .md file in VS Code
echo    - Copy content
echo    - Paste into Word
echo    - Save as .docx
echo.
echo 4. Google Docs:
echo    - Upload .md file to Google Drive
echo    - Open with Google Docs
echo    - Download as .docx
echo.
echo OUTPUT LOCATION:
echo ================
echo Converted files will be saved in the Protocol\ folder
echo.
echo TROUBLESHOOTING:
echo ================
echo - If pandoc not found: Add to PATH or use full path
echo - PDF fails: Install LaTeX (MiKTeX)
echo - Permission errors: Run as Administrator
echo.
pause
