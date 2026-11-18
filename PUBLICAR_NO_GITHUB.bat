@echo off
setlocal
cd /d "%~dp0"
set REPO=brunopeixe1981-svg/CUDY-app
echo ============================================
echo   Publicar CUDY no GitHub: %REPO%
echo ============================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo [ERRO] O Git nao esta instalado.
  echo Instala em https://git-scm.com/download/win e volta a correr este ficheiro.
  start https://git-scm.com/download/win
  pause
  exit /b 1
)

git config user.name >nul 2>nul || git config --global user.name "brunopeixe1981-svg"
git config user.email >nul 2>nul || git config --global user.email "brunopeixe1981-svg@users.noreply.github.com"

if not exist ".git" (
  git init -b main
)
git add -A
git update-index --chmod=+x gradlew
git commit -m "CUDY: versao inicial (rebrand do Kitsu X)" || echo (nada novo para commit)

where gh >nul 2>nul
if not errorlevel 1 (
  echo A criar o repositorio com o GitHub CLI...
  gh auth status >nul 2>nul || gh auth login --web
  gh repo create %REPO% --public --source=. --remote=origin --push
  if not errorlevel 1 goto fim
)

echo.
echo O GitHub CLI nao esta disponivel. Vai abrir-se a pagina para criares o repositorio.
echo  - Nome: CUDY-app
echo  - Visibilidade: Public
echo  - NAO marques "Add a README", ".gitignore" nem "license"
echo Depois de clicares em "Create repository", volta aqui e carrega numa tecla.
start "" "https://github.com/new?name=CUDY-app&visibility=public"
pause

git remote remove origin >nul 2>nul
git remote add origin https://github.com/%REPO%.git
git push -u origin main
if errorlevel 1 (
  echo [ERRO] O envio falhou. Confirma que o repositorio foi criado e que tens sessao iniciada.
  pause
  exit /b 1
)

:fim
echo.
echo Concluido: https://github.com/%REPO%
start "" "https://github.com/%REPO%"
pause
