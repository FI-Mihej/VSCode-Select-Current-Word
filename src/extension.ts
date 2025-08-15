import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
  const disposable = vscode.commands.registerTextEditorCommand(
    'extension.selectWholeWordVS',
    (editor) => {
      const doc = editor.document;
      const selections: vscode.Selection[] = [];

      for (const sel of editor.selections) {
        const pos = sel.active;

        // Attempt 1: system word definition
        let range = doc.getWordRangeAtPosition(pos);

        // Attempt 2: custom pattern (letters/digits/underscore, with Unicode)
        if (!range) {
          range = doc.getWordRangeAtPosition(pos, /[\p{L}\p{N}_]+/u);
        }

        // If the cursor is exactly on a boundary and nothing is found — move 1 character to the left
        if (!range && pos.character > 0) {
          const left = pos.translate(0, -1);
          range =
            doc.getWordRangeAtPosition(left) ||
            doc.getWordRangeAtPosition(left, /[\p{L}\p{N}_]+/u);
        }

        selections.push(range ? new vscode.Selection(range.start, range.end) : sel);
      }

      editor.selections = selections;
      editor.revealRange(editor.selections[0]);
    }
  );

  context.subscriptions.push(disposable);
}

export function deactivate() {}
