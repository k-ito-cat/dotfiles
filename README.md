# Dotfiles (chezmoi)

chezmoi で管理する dotfiles。mac と WSL(Linux) で日常運用し、Windows ホスト側の GUI アプリ・OS 設定は `windows/` で別管理する。

## 初回セットアップ

### mac / WSL

1. Homebrew を導入する
   - 未導入のままだと、`chezmoi apply` 時の自動スクリプトが `brew bundle` で失敗する
2. `brew install chezmoi`
3. `chezmoi init --apply git@github.com:<your>/<repo>.git`
   - 残りのツールは初回 apply の自動スクリプトが `brew bundle` / `mise install` で導入する

### Windows ホスト

PowerShell で `windows/bootstrap.ps1` を実行する。詳細は `windows/README.md`。

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\bootstrap.ps1
```

## 日常運用

chezmoi の操作コマンド（`apply` / `diff` / `add` / `edit` / `update` など）は navi の dotfiles チートを参照する（`navi` または `Ctrl+N`）。

### apply 時に自動実行されるもの

`.chezmoiscripts/run_onchange_*` が、対象ファイルが変わったときだけ `chezmoi apply` 時に自動実行する。

- Brewfile を変更したとき → `brew bundle`
- mise 設定を変更したとき → `mise install`

### 手動が必要なもの

- sheldon のプラグインを追加・変更したとき → 新しいシェルを開く（既存プラグインの更新のみ `sheldon lock --update`）
- Neovim のプラグインを追加・変更したとき → 新規プラグインは起動時に自動導入、既存プラグインの更新は `:Lazy sync`

## 機密情報

トークン・鍵・パスワードなどの機密情報は、リポジトリに平文で置かない。テンプレート内で機密情報が必要になった場合は、次のいずれかで参照する。

- 1Password CLI 経由で参照する（chezmoi の `onepasswordRead` などを利用）
- chezmoi 管理外のローカルファイルに置き、そこから参照する

## 構成

- 管理リポジトリ: `~/.local/share/chezmoi`
- chezmoi 本体設定: `~/.config/chezmoi/chezmoi.toml`（これ自体も管理対象に含める）
- 運用前提: mac / WSL(Linux)。Windows ホスト側は `windows/`（chezmoi 管理対象外。winget Configuration + PowerShell で管理）
