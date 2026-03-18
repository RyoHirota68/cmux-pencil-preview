---
name: pen-preview
description: Start, stop, or manage PDF preview sessions for .pen files in cmux browser.
allowed-tools: Bash, mcp__pencil__export_nodes
argument-hint: [file.pen | --stop | --list | --clean]
---

# pen-preview

Manage PDF preview sessions for Pencil (.pen) files in cmux browser.

The CLI is located at `${CLAUDE_PLUGIN_ROOT}/bin/pen-preview`.

## Commands

Start preview:
```bash
${CLAUDE_PLUGIN_ROOT}/bin/pen-preview $ARGUMENTS
```

If no arguments are provided, show help:
```bash
${CLAUDE_PLUGIN_ROOT}/bin/pen-preview --help
```

## After starting a preview

When starting a new preview (not --stop, --list, --clean, --reload), immediately export the current design so the browser shows the latest state instead of a blank page:

1. Read the output of pen-preview to get the Pen file path, Surface ID, and PDF path.
2. Run export_nodes with the pen file path, outputDir as the session directory (the directory containing preview.pdf), format='pdf', and nodeIds=all top-level screen frames.
3. Run Bash: `cd '<outputDir>' && mv -f $(ls -t *.pdf | head -1) preview.pdf && cmux browser <surface> reload`

## Notes

- Multiple .pen files can be previewed simultaneously — each gets its own cmux browser pane.
- After starting, the PostToolUse hook will automatically export and reload the preview whenever `batch_design` is used.
- If the user provides a relative path, resolve it to an absolute path before passing it to the command.
