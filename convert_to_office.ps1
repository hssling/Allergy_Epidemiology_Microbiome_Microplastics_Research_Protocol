# PowerShell script to convert Markdown files to DOCX and PDF
# Requires pandoc to be installed

Write-Host "Converting Markdown files to DOCX and PDF formats..." -ForegroundColor Green
Write-Host ""

# Create output directories
$outputDocx = "Protocol\Output_DOCX"
$outputPdf = "Protocol\Output_PDF"

if (!(Test-Path $outputDocx)) {
    New-Item -ItemType Directory -Path $outputDocx | Out-Null
}

if (!(Test-Path $outputPdf)) {
    New-Item -ItemType Directory -Path $outputPdf | Out-Null
}

# Check for pandoc
try {
    $pandocVersion = pandoc --version 2>$null
    Write-Host "Pandoc found. Starting conversion..." -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "ERROR: Pandoc is not installed or not in PATH." -ForegroundColor Red
    Write-Host ""
    Write-Host "To install pandoc:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://pandoc.org/installing.html" -ForegroundColor Yellow
    Write-Host "2. Or run: choco install pandoc" -ForegroundColor Yellow
    Write-Host "3. Or run: winget install --id JohnMacFarlane.Pandoc" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "After installation, run this script again." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Function to convert files
function Convert-MarkdownFile {
    param (
        [string]$inputFile,
        [string]$outputDir,
        [string]$format
    )

    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
    $outputFile = Join-Path $outputDir "$fileName.$format"

    try {
        if ($format -eq "docx") {
            & pandoc $inputFile -o $outputFile --reference-doc="Protocol\reference.docx" 2>$null
        } elseif ($format -eq "pdf") {
            & pandoc $inputFile -o $outputFile --pdf-engine=pdflatex 2>$null
        }

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ $fileName.$format created successfully" -ForegroundColor Green
        } else {
            Write-Host "✗ Failed to convert $fileName.md to $format" -ForegroundColor Red
        }
    } catch {
        Write-Host "✗ Error converting $fileName.md to $format" -ForegroundColor Red
    }
}

# Convert main protocol files
Write-Host "Converting main protocol files to DOCX..." -ForegroundColor Cyan
Get-ChildItem "Protocol\*.md" | ForEach-Object {
    Convert-MarkdownFile -inputFile $_.FullName -outputDir $outputDocx -format "docx"
}

# Convert files in subdirectories
Write-Host ""
Write-Host "Converting subdirectory files to DOCX..." -ForegroundColor Cyan
Get-ChildItem "Protocol\*\*.md" -Recurse | ForEach-Object {
    Convert-MarkdownFile -inputFile $_.FullName -outputDir $outputDocx -format "docx"
}

# Convert to PDF
Write-Host ""
Write-Host "Converting files to PDF..." -ForegroundColor Cyan
Get-ChildItem "Protocol\*.md" | ForEach-Object {
    Convert-MarkdownFile -inputFile $_.FullName -outputDir $outputPdf -format "pdf"
}

Get-ChildItem "Protocol\*\*.md" -Recurse | ForEach-Object {
    Convert-MarkdownFile -inputFile $_.FullName -outputDir $outputPdf -format "pdf"
}

Write-Host ""
Write-Host "Conversion completed!" -ForegroundColor Green
Write-Host ""
Write-Host "Output files are located in:" -ForegroundColor Yellow
Write-Host "- DOCX files: $outputDocx\" -ForegroundColor Yellow
Write-Host "- PDF files: $outputPdf\" -ForegroundColor Yellow
Write-Host ""
Write-Host "If PDF conversion failed, you may need to install LaTeX:" -ForegroundColor Cyan
Write-Host "1. Install MiKTeX: https://miktex.org/download" -ForegroundColor Cyan
Write-Host "2. Or use alternative PDF engines with pandoc" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to exit"
