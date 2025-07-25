# dotfiles

## 使い方

- **設定ファイル追加**: `chezmoi add <ファイル>`

すでにローカルマシンに設定ファイルが存在していることが前提

- **設定変更**: `chezmoi edit <ファイル>`

元の設定ファイルの内容を編集

- **設定適用**: `chezmoi apply`

編集の適用。chezmoi 管理のファイルと元ファイルの内容が更新される。

- **設定確認**: `chezmoi diff`

- **設定ファイルの管理対象の確認**: `chezmoi managed`

### chezmoi 管理対象のファイル格納場所（git 管理）

`$HOME/.local/share/chezmoi`

### chazmoi.toml 格納場所（chazmoi の設定ファイル）

`$HOME/.config/chezmoi`

## 設定ファイル構成（個人メモ）

### Windows / Mac 共通

#### Git 設定

- **.gitconfig**

  - chezmoi 管理ファイル: `dot_gitconfig.tmpl`
  - .gitconfig.local を include

- **.gitconfig.local**: 個人設定（非公開）
  - ユーザー名、メールアドレスなど

### Windows

#### PowerShell プロファイル

PowerShell 起動時に実行するプログラム

- peco によって指定のキーコマンド押下で ghq 管理のリポジトリ一覧を出力し、選択されたリポジトリを Cursor で開く
- oh-my-posh による PowerShell カラーのカスタマイズ

```
OS → OneDrive内PROFILE → ユーザー直下PROFILE
```

- **OneDrive 内 PROFILE**: システムデフォルト設定場所
  - パス: `C:\Users\<ユーザー名>\OneDrive\ドキュメント\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
  - 内容: ユーザー直下の PROFILE を読み込む単純な参照
- **ユーザー直下 PROFILE**: chezmoi で管理する実際の設定（システムが参照する PROFILE が更に参照するファイル）

  - パス: `C:\Users\<ユーザー名>\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
  - chezmoi 管理ファイル: `WindowsPowerShell\Microsoft.PowerShell_profile.ps1.tmpl`
