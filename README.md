<p align="center">
  <img src="assets/icon.png" alt="Select Current Word (VS-like)" width="128">
</p>

# Select Current Word (VS-like)

Highlights the whole word under the cursor, like `Edit.SelectCurrentWord` in Visual Studio.

## Features
- Works regardless of the cursor position inside the word.
- Supports multiple cursors.
- Uses VS Code's built-in word boundary detection with a Unicode-friendly fallback.

## Usage
1. Place the cursor anywhere inside a word.
2. Press the assigned keybinding (default or your own).
3. The entire word will be selected.

## Default Keybinding
`Ctrl+Shift+Alt+Space` – ergonomic two-hand chord:  
Hold `Ctrl+Shift+Alt` with one hand and tap `Space` with the other.

**Why this combination?**
- Avoids conflicts with built-in VS Code shortcuts.
- Does not overlap with dangerous actions (like closing tabs, files, or editors).
- Suitable for touch-typing (10-finger typing style).

> **Note:** On some systems `Alt+Space` may trigger the OS window menu.  
> If this happens, rebind the command in *Keyboard Shortcuts*.

### How to Rebind
1. Open **File → Preferences → Keyboard Shortcuts** (`Ctrl+K Ctrl+S`).
2. Search for:
   `Select Current Word (VS-like)` (command id: `extension.selectCurrentWordVS`).
3. Assign your preferred key.

**Example `keybindings.json` entry:**
```jsonc
{
  "key": "ctrl+alt+y",
  "command": "extension.selectCurrentWordVS",
  "when": "editorTextFocus && !editorReadonly"
}
```

## Installation
- **From VSIX**:
  1. Open VS Code.
  2. Go to *Extensions* → click the ⋯ menu → *Install from VSIX…*
  3. Select the `.vsix` file for this extension.

- **From Marketplace** (once published):
  1. Open the Extensions view in VS Code (`Ctrl+Shift+X`).
  2. Search for **Select Current Word (VS-like)**.
  3. Click **Install**.

## Known Limitations
- Uses the active language's word separators; behavior may differ across languages.
- If the cursor is placed exactly at the word boundary, selection may extend to the previous word depending on editor settings.

## Source Code
[GitHub Repository](https://github.com/FI-Mihej/VSCode-Select-Current-Word)
