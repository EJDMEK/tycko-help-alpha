# Instrukce pro nasazení pomocí ZIP souboru

## Jak to funguje

1. **Zabalte projekt do ZIP souboru**
2. **Nahrajte ZIP na GitLab**
3. **Pipeline automaticky rozbalí a zpracuje soubory**

## Krok za krokem

### 1. Příprava ZIP souboru

```bash
# V kořenovém adresáři projektu
zip -r tycko-help.zip . -x "node_modules/*" "dist/*" ".git/*"
```

Nebo použijte Windows:
- Klikněte pravým na složku `tycko-golf-helper-main`
- "Odeslat do" > "Komprimovaná složka (zip)"
- Přejmenujte na `project.zip`

### 2. Nahrání na GitLab

1. **Vytvořte nový projekt na GitLab**
2. **Nahrajte ZIP soubor:**
   - Jděte do "Files" v GitLab
   - Klikněte "Upload file"
   - Vyberte `project.zip`
   - Commit s názvem "Initial upload"

### 3. Pipeline se spustí automaticky

Pipeline má tyto stages:
1. **extract** - Rozbalí ZIP soubor
2. **build-frontend** - Buildí React aplikaci
3. **build-backend** - Připraví backend
4. **deploy** - Nasazení (manuální)

### 4. Nastavení deploy

V `.gitlab-ci.yml` upravte deploy script:

```yaml
script:
  - echo "Deploying to server..."
  - rsync -avz --delete frontend/dist/ user@your-server.com:/path/to/public_html/
  - rsync -avz --delete backend/ user@your-server.com:/path/to/api/
```

### 5. GitLab Variables

V Settings > CI/CD > Variables nastavte:
- `SSH_PRIVATE_KEY` - Váš SSH klíč pro server

## Výhody tohoto přístupu

✅ **Jednoduché** - stačí nahrát ZIP
✅ **Rychlé** - žádné Git problémy
✅ **Flexibilní** - můžete nahrávat kdykoliv
✅ **Automatické** - pipeline se postará o vše

## Aktualizace

Pro aktualizaci:
1. Upravte kód lokálně
2. Zabalte nový ZIP
3. Nahrajte na GitLab
4. Pipeline se spustí automaticky

## Troubleshooting

### Pipeline selže při extract
- Zkontrolujte, že ZIP se jmenuje `project.zip`
- Zkontrolujte, že ZIP obsahuje správnou strukturu

### Build selže
- Zkontrolujte, že `package.json` soubory jsou správné
- Zkontrolujte, že všechny závislosti jsou v `package.json`

### Deploy selže
- Zkontrolujte SSH klíč v GitLab variables
- Zkontrolujte cestu k serveru v deploy scriptu
