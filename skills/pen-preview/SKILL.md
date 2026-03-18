---
name: pen-preview
description: Start, stop, or manage PDF preview sessions for .pen files in cmux browser.
allowed-tools: Bash
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

## Notes

- Multiple .pen files can be previewed simultaneously — each gets its own cmux browser pane.
- After starting, the PostToolUse hook will automatically export and reload the preview whenever `batch_design` is used.
- If the user provides a relative path, resolve it to an absolute path before passing it to the command.
