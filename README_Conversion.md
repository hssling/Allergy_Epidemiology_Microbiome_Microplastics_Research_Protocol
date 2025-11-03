# Allergy Research Protocol - File Conversion Guide

## 📄 Protocol Files Created

All research protocol documents have been created in Markdown format (.md) in the following structure:

```
Protocol/
├── Main_Protocol.md                           # Main research protocol
├── Questionnaires/
│   └── Main_Questionnaire.md                  # Study questionnaire
├── Data_Collection_Forms/
│   └── Clinical_Examination_Form.md           # Clinical assessment form
├── Ethical_Documents/
│   └── Ethics_Committee_Submission.md         # Ethics submission template
├── Analysis_Plan/
│   └── Data_Analysis_Plan.md                  # Statistical analysis plan
├── Timeline_Budget/
│   └── Study_Timeline_and_Budget.md           # Timeline and budget
├── SOPs/
│   └── Standard_Operating_Procedures.md       # Study procedures
├── Consent_Forms/
│   └── Participant_Consent_Form.md            # Consent forms
├── Data_Management/
│   └── Data_Management_Plan.md                # Data management plan
├── Dissemination/
│   └── Dissemination_Plan.md                  # Publication and dissemination plan
└── Translation_Plan.md                        # Kannada translation plan
```

## 🔄 Converting to DOCX and PDF

### Option 1: Automated Conversion (Recommended)

**Prerequisites:**
- Install Pandoc: `winget install --id JohnMacFarlane.Pandoc`
- For PDF conversion: Install MiKTeX (https://miktex.org/download)

**Run the conversion script:**
```bash
# Using PowerShell (recommended)
.\convert_to_office.ps1

# Or using Command Prompt
convert_to_office.bat
```

**Output:**
- DOCX files: `Protocol/Output_DOCX/`
- PDF files: `Protocol/Output_PDF/`

### Option 2: Manual Conversion

If automated conversion fails, convert files individually:

#### Using Pandoc (Command Line):
```bash
# Convert to DOCX
pandoc Protocol/Main_Protocol.md -o Protocol/Main_Protocol.docx

# Convert to PDF (requires LaTeX)
pandoc Protocol/Main_Protocol.md -o Protocol/Main_Protocol.pdf --pdf-engine=pdflatex
```

#### Using Online Tools:
1. Go to https://pandoc.org/try/
2. Upload your .md file
3. Select output format (DOCX/PDF)
4. Download converted file

#### Using VS Code Extensions:
1. Install "Markdown PDF" extension
2. Open .md file in VS Code
3. Press `Ctrl+Shift+P` → "Markdown PDF: Export (pdf)"

### Option 3: Using Microsoft Word

1. Open the .md file in VS Code or any text editor
2. Copy the content
3. Paste into Microsoft Word
4. Save as .docx format
5. Export to PDF if needed

## 📋 File Checklist

After conversion, verify you have these files:

### DOCX Files:
- [ ] Main_Protocol.docx
- [ ] Main_Questionnaire.docx
- [ ] Clinical_Examination_Form.docx
- [ ] Ethics_Committee_Submission.docx
- [ ] Data_Analysis_Plan.docx
- [ ] Study_Timeline_and_Budget.docx
- [ ] Standard_Operating_Procedures.docx
- [ ] Participant_Consent_Form.docx
- [ ] Data_Management_Plan.docx
- [ ] Dissemination_Plan.docx
- [ ] Translation_Plan.docx

### PDF Files:
- [ ] Main_Protocol.pdf
- [ ] Main_Questionnaire.pdf
- [ ] Clinical_Examination_Form.pdf
- [ ] Ethics_Committee_Submission.pdf
- [ ] Data_Analysis_Plan.pdf
- [ ] Study_Timeline_and_Budget.pdf
- [ ] Standard_Operating_Procedures.pdf
- [ ] Participant_Consent_Form.pdf
- [ ] Data_Management_Plan.pdf
- [ ] Dissemination_Plan.pdf
- [ ] Translation_Plan.pdf

## 🛠 Troubleshooting

### Pandoc Not Found:
```bash
# Check if installed
pandoc --version

# If not found, add to PATH or use full path
# Default installation path: C:\Users\[username]\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.8.2.1\
```

### PDF Conversion Fails:
- Install LaTeX: https://miktex.org/download
- Or use alternative: `--pdf-engine=wkhtmltopdf`

### Permission Issues:
- Run terminal as Administrator
- Or use user-level installation

## 📤 Sharing Files

### For Ethics Committee Submission:
- Submit: Main_Protocol.pdf, Ethics_Committee_Submission.pdf
- Include: Participant_Consent_Form.pdf, Data_Management_Plan.pdf

### For Funding Applications:
- Submit: Main_Protocol.pdf, Study_Timeline_and_Budget.pdf
- Include: Data_Analysis_Plan.pdf, Dissemination_Plan.pdf

### For Study Implementation:
- Use: All DOCX files for editing
- Distribute: PDF versions to team members
- Archive: Original .md files for version control

## 📞 Support

If conversion issues persist:
1. Check pandoc installation: `pandoc --version`
2. Verify file paths are correct
3. Try manual conversion with online tools
4. Contact IT support for software installation

---

**Conversion completed on:** __________

**Converted by:** __________
