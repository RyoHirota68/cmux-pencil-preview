# cmux-pencil-preview

Hot reload for [Pencil](https://www.pencil.dev/) designs in [cmux](https://github.com/manaflow-ai/cmux) browser.

Every time Claude Code runs `batch_design` on a `.pen` file, the design is automatically exported as PDF and reloaded in the cmux browser pane.

[日本語ドキュメント](README.ja.md)

## Requirements

- macOS
- [cmux](https://github.com/manaflow-ai/cmux)
- [Pencil MCP server](https://www.pencil.dev/) configured in Claude Code

## Install

```
/plugin marketplace add RyoHirota68/cmux-pencil-preview
/plugin install cmux-pencil-preview
```

This registers the PostToolUse hook automatically. Then start a preview:

```
/pen-preview my-app.pen
```

## How it works

```
batch_design → PostToolUse hook fires
  → hook emits additionalContext (JSON)
  → Claude runs export_nodes (PDF)
  → Claude runs mv + cmux browser reload
```

## Usage

Start previewing a design:
```
/pen-preview my-app.pen
```

Open another design at the same time:
```
/pen-preview landing-page.pen
```

See what's being previewed:
```
/pen-preview --list
```

Manually reload the browser (usually not needed — the hook does this automatically):
```
/pen-preview --reload              # reload all
/pen-preview --reload my-app.pen   # reload one
```

Stop previewing:
```
/pen-preview --stop                # stop all
/pen-preview --stop my-app.pen     # stop one
```

Remove all state files:
```
/pen-preview --clean
```

## Notes

- **macOS only** — uses `md5 -q` for path hashing, which is not available on Linux.
- **Claude Code plugin API is evolving** — hook and plugin formats may change in future Claude Code releases.
- **The PostToolUse hook instructs Claude to run shell commands** (`rm`, `mv`, `cmux browser reload`) via `additionalContext`. These commands are scoped to the preview temp directory (`/tmp/pen-preview-$USER/`).

## License

MIT
