#!/usr/bin/env bash
set -e

EXT_NAME="select-current-word-vs"

echo "Cleaning previous build artifacts..."
rm -rf out
rm -f ./*.vsix

echo "Compiling TypeScript..."
npm run compile

VERSION=$(node -p "require('./package.json').version")
OUT_FILE="${EXT_NAME}-${VERSION}.vsix"

echo "Packaging extension (${OUT_FILE})..."
npx @vscode/vsce package --allow-missing-repository -o "$OUT_FILE"

echo "Build complete: $OUT_FILE"
