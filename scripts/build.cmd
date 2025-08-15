@echo off
setlocal enableextensions enabledelayedexpansion

REM === Configuration ===
set "EXT_NAME=select-current-word-vs"

REM === Step 0: Tool checks (optional, but helpful) ===
where node >nul 2>nul || (echo [ERROR] Node.js not found in PATH.& exit /b 1)
where npm  >nul 2>nul || (echo [ERROR] npm not found in PATH.& exit /b 1)
where npx  >nul 2>nul || (echo [ERROR] npx not found in PATH.& exit /b 1)

echo.
echo === Cleaning previous build artifacts ===
if exist out rmdir /s /q out
del /q "*.vsix" 2>nul

echo.
echo === Compiling TypeScript ===
call npm run compile
if errorlevel 1 goto :error

echo.
echo === Reading version from package.json ===
for /f "usebackq delims=" %%v in (`node -p "require('./package.json').version"`) do set "VERSION=%%v"
if not defined VERSION (
  echo [ERROR] Failed to read version from package.json
  goto :error
)

set "OUT_FILE=%EXT_NAME%-%VERSION%.vsix"

echo.
echo === Packaging extension (%OUT_FILE%) ===
npx @vscode/vsce package --allow-missing-repository -o "%OUT_FILE%"
if errorlevel 1 goto :error

echo.
echo [OK] Build complete: %OUT_FILE%
exit /b 0

:error
echo.
echo [FAIL] Build failed. See messages above.
exit /b 1
