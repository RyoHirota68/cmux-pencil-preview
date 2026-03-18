# cmux-pencil-preview

[Pencil](https://www.pencil.dev/) デザインを [cmux](https://github.com/manaflow-ai/cmux) ブラウザでホットリロードするツール。

デザインの変更を即座に確認できます。Claude Code で `batch_design` を実行するたびに、PDFプレビューが自動でエクスポート・リロードされます。手動でのエクスポートやリフレッシュは不要です。

[English](README.md)

## 必要なもの

- macOS
- [cmux](https://github.com/manaflow-ai/cmux)
- Claude Code に [Pencil MCP server](https://www.pencil.dev/) を設定済み

## インストール

```
/plugin marketplace add RyoHirota68/cmux-pencil-preview
/plugin install cmux-pencil-preview
```

インストール後、Claude Code を再起動して hook を有効化してください。プレビューを開始:

```
/pen-preview my-app.pen
```

## 仕組み

```
batch_design → PostToolUse hook 発火
  → hook が additionalContext (JSON) を出力
  → Claude が additionalContext 経由で指示を受け取る
  → Claude が export_nodes (PDF) を呼び出し、Bash 経由でリロードを実行
```

## 使い方

デザインのプレビューを開始:
```
/pen-preview my-app.pen
```

別のデザインも同時にプレビュー:
```
/pen-preview landing-page.pen
```

プレビュー中のファイルを確認:
```
/pen-preview --list
```

手動でブラウザをリロード（通常はhookが自動で行うので不要）:
```
/pen-preview --reload              # 全てリロード
/pen-preview --reload my-app.pen   # 1つだけリロード
```

プレビューを停止:
```
/pen-preview --stop                # 全て停止
/pen-preview --stop my-app.pen     # 1つだけ停止
```

stateファイルを全削除:
```
/pen-preview --clean
```

## 注意事項

- **macOS 専用** — パスのハッシュに `md5 -q` を使用しており、Linux では動作しません。
- **Claude Code plugin API は開発中** — hook や plugin のフォーマットは今後変更される可能性があります。
- **PostToolUse hook は Claude にシェルコマンドを実行させます** — `rm`, `mv`, `cmux browser reload` を `additionalContext` 経由で指示します。対象はプレビュー用の一時ディレクトリ (`/tmp/pen-preview-$USER/`) に限定されています。

## ライセンス

MIT
