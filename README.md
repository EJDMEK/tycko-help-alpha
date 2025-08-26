# Týčko Help - Golf FAQ Systém

FAQ systém pro golf s admin rozhraním pro správu obsahu.

## Struktura projektu

```
tycko-help/
├── frontend/                 # React frontend aplikace
│   ├── src/
│   ├── dist/                # Build pro nasazení
│   └── package.json
├── backend/                 # Node.js backend s JSON databází
│   ├── data/
│   │   ├── categories.json
│   │   └── questions.json
│   ├── server.js
│   └── package.json
├── .gitlab-ci.yml          # GitLab CI/CD pipeline
└── README.md
```

## GitLab CI/CD Pipeline

Projekt obsahuje automatickou CI/CD pipeline:

### Stages:
1. **build-frontend** - Build React aplikace
2. **build-backend** - Příprava backend souborů
3. **deploy** - Nasazení na server (manuální)

### Jak to funguje:
- Při push do `main` nebo `develop` branch se spustí automatické buildy
- Frontend se buildí do `dist/` složky
- Backend se připraví bez `node_modules`
- Deploy stage je manuální (spustí se ručně)

### Nastavení na GitLab:
1. Nahrát kód na GitLab
2. V Settings > CI/CD nastavit variables:
   - `SSH_PRIVATE_KEY` - SSH klíč pro server
3. Upravit deploy script v `.gitlab-ci.yml`

## Lokální vývoj

### Backend

```bash
cd backend
npm install
npm start
```

Backend běží na `http://localhost:3000`

### Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend běží na `http://localhost:8080`

## API Endpointy

### Kategorie
- `GET /api/categories` - Seznam kategorií
- `POST /api/admin/categories` - Vytvořit/upravit kategorii
- `DELETE /api/admin/categories/:id` - Smazat kategorii

### Otázky
- `GET /api/questions` - Seznam otázek (s filtrováním)
- `GET /api/questions/:id` - Konkrétní otázka
- `POST /api/admin/questions` - Vytvořit/upravit otázku
- `DELETE /api/admin/questions/:id` - Smazat otázku

### Featured otázky
- `POST /api/admin/featured` - Nastavit featured otázky

## Nasazení na server

### Automatické (GitLab CI/CD)
1. Push do `main` branch
2. Spustit deploy stage v GitLab
3. Pipeline automaticky nahrá soubory na server

### Manuální
```bash
# Backend
cd backend
npm install --production
# Nahrát na server do složky api/

# Frontend
cd frontend
npm run build
# Nahrát dist/ na server do public_html/
```

### Konfigurace na serveru
1. **Backend:**
   ```bash
   cd api
   npm install --production
   pm2 start ecosystem.config.js
   pm2 startup
   pm2 save
   ```

2. **Frontend:**
   Vytvořit `.env` soubor:
   ```env
   VITE_API_URL=https://your-domain.com/api
   ```

## Funkce

### Admin rozhraní (`/admin`)
- ✅ Správa kategorií (CRUD)
- ✅ Správa otázek (CRUD)
- ✅ Nastavení nejčastějších otázek
- ✅ Vyhledávání a filtrování
- ✅ Rich text editor pro obsah

### Frontend
- ✅ Zobrazení kategorií a otázek
- ✅ Vyhledávání
- ✅ Nejčastější otázky
- ✅ Responsivní design

## Databáze

Používá JSON soubory:
- `categories.json` - kategorie
- `questions.json` - otázky

Výhody:
- ✅ Žádná instalace databáze
- ✅ Snadné zálohování
- ✅ FTP friendly
- ✅ Čitelnost

## Technologie

- **Frontend**: React + TypeScript + Vite + Tailwind CSS
- **Backend**: Node.js + Express
- **Databáze**: JSON soubory
- **UI**: Shadcn/ui komponenty
- **CI/CD**: GitLab CI/CD
