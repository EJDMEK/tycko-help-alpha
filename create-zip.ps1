# PowerShell skript pro vytvoření ZIP souboru pro GitLab

Write-Host "Vytvářím ZIP soubor pro GitLab..." -ForegroundColor Green

# Zkontrolujte, že jsme v správném adresáři
if (-not (Test-Path "frontend") -or -not (Test-Path "backend")) {
    Write-Host "Chyba: Nejsem v kořenovém adresáři projektu!" -ForegroundColor Red
    Write-Host "Spusťte tento skript z adresáře tycko-golf-helper-main" -ForegroundColor Yellow
    exit 1
}

# Název ZIP souboru
$zipName = "project.zip"

# Odstraňte starý ZIP pokud existuje
if (Test-Path $zipName) {
    Remove-Item $zipName -Force
    Write-Host "Odstraněn starý ZIP soubor" -ForegroundColor Yellow
}

# Vytvořte ZIP soubor
try {
    Compress-Archive -Path @(
        "frontend",
        "backend", 
        ".gitlab-ci.yml",
        ".gitignore",
        "README.md",
        "deploy-instructions.md"
    ) -DestinationPath $zipName -Force

    Write-Host "ZIP soubor vytvořen úspěšně: $zipName" -ForegroundColor Green
    
    # Zobrazte velikost
    $size = (Get-Item $zipName).Length
    $sizeMB = [math]::Round($size / 1MB, 2)
    Write-Host "Velikost: $sizeMB MB" -ForegroundColor Cyan
    
    Write-Host ""
    Write-Host "Nyní můžete nahrát $zipName na GitLab:" -ForegroundColor Yellow
    Write-Host "1. Jděte na GitLab > Files" -ForegroundColor White
    Write-Host "2. Klikněte 'Upload file'" -ForegroundColor White
    Write-Host "3. Vyberte $zipName" -ForegroundColor White
    Write-Host "4. Commit s názvem 'Initial upload'" -ForegroundColor White
    
} catch {
    Write-Host "Chyba při vytváření ZIP souboru: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
