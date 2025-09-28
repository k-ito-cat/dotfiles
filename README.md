# Dotfiles (chezmoi)

## 初回セットアップ（新しいマシン）

### SSH
`chezmoi init --apply git@github.com:<your>/<repo>.git`


## フロー

### 1. 既存ファイルを管理に追加
`chezmoi add <パス>`  
例: `chezmoi add ~/.zshrc`

### 2. 設定の編集
`chezmoi edit <パス>`  
テンプレ化するなら `.tmpl` を使う  
すぐ反映したいとき: `chezmoi edit --apply <パス>`

→ [chezmoi設定ファイル](https://github.com/k-ito-cat/dotfiles/blob/main/dot_config/chezmoi/chezmoi.toml.tmpl)で編集時はVSCodeを立ち上げるように設定済みなので、VSCode上で編集を行う。

### 3. 反映
- 変更確認: `chezmoi diff`  
- 反映: `chezmoi apply`

→ chezmoi管理ファイルだけでなく、実際のファイルも変更される

### 4. リモートへ反映
1. `chezmoi cd` (= `~/.local/share/chezmoi` に移動)  
2. `git status`  
3. `git add -A`  
4. `git commit -m "update dotfiles"`  
5. `git push origin main`

### 5. 別OS/別マシンで最新を取り込み
- `chezmoi update` （pull + apply を一括実行）  
- 手動の場合:  
  - `chezmoi cd`  (= `~/.local/share/chezmoi` に移動) 
  - `git pull origin main`  
  - `chezmoi diff`  
  - `chezmoi apply`


## よく使う確認コマンド
- 管理対象の変更確認: `chezmoi status`  
- 管理対象一覧: `chezmoi managed`  
- 適用結果の確認（テンプレ展開後）: `chezmoi cat <パス>`


## 管理ディレクトリ
- 管理リポジトリ（Git 管理）: `~/.local/share/chezmoi`  
- 設定ファイル（chezmoi 本体設定）: `~/.config/chezmoi/chezmoi.toml`（これもchezmoi管理対象に含めている）

## 運用
- 機密情報は含めない（ユーザー名/メール、SSH鍵、`.env` は 1Password CLI 等で管理）  
- OS差分はテンプレートで分岐  

テンプレート例:  

```go-template
{{ if eq .chezmoi.os "linux" }} 
# Linux用の設定
{{ else if eq .chezmoi.os "darwin" }} 
# macOS用の設定
{{ end }}


