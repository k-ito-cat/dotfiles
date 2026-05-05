---
name: dotfiles-workflow
description: Use for dotfiles, shell/editor/CLI config, aliases, functions, keybinds, navi, git config, and ~/.config files. Edit the chezmoi source first; propose chezmoi add for unmanaged files, and run chezmoi apply unless stopped.
---

# Dotfiles Workflow

設定系ファイルは、生成先ではなく dotfiles / chezmoi 側を正本として扱う。

## 正本

- `chezmoi source-path` が返す source directory を正本として扱う。
- dotfiles リポジトリ直下を source directory にしている環境では、そのリポジトリ直下で作業してよい。
- 別 checkout の dotfiles リポジトリがあっても、`chezmoi source-path` と一致しない場合は正本として扱わない。

## 対象

- zsh、shell、alias、function、keybind
- navi cheats/config
- Neovim、WezTerm、mise、starship、yazi、sheldon
- git config / global ignore
- `~/.config` 配下
- dotfile または CLI / tool の設定ファイル全般

## 手順

1. ユーザーが変更したい生成先ファイルを特定する。
2. まず chezmoi source directory を探す。
   - 生成先との対応を優先して確認する。
   - `.tmpl`、`dot_`、`private_`、`symlink_`、分割設定ファイルも確認する。
   - 見つからない場合は、大小文字違い、typo、名前の勘違いを疑って探索する。
3. 管理対象なら chezmoi source file を編集する。
4. 未管理なら生成先を先に編集しない。`chezmoi add <target>` を提案し、ユーザーに確認する。
5. 管理元を編集したら、原則として次を実行する。
   - `chezmoi diff`
   - `chezmoi apply`
6. 反映が必要な変更では、生成先も確認する。
7. 変更した管理元ファイルと apply 結果を報告する。

## 必須ルール

- chezmoi 管理元がある場合、生成先 dotfile を正本として扱わない。
- dot config が chezmoi 管理対象の場合、更新は基本的に chezmoi 側の `.tmpl` / `dot_` / `private_` / `symlink_` 管理元を優先する。
- 参照先としても、生成先の実ファイルより chezmoi 管理元を優先する。
- 実ファイルを確認する場合でも、真実源は chezmoi 管理元として扱う。
- 明示指示がない限り、`chezmoi update`、`git pull`、`git push` は実行しない。
- 生成先ファイルの削除・置換は、事前にユーザーへ確認する。
- zsh 変更は適切な分割ファイルに置く。
  - core: `dot_config/zsh/00-core.zsh.tmpl`
  - aliases: `dot_config/zsh/10-aliases.zsh.tmpl`
  - history: `dot_config/zsh/15-history.zsh.tmpl`
  - functions/widgets: `dot_config/zsh/20-functions.zsh.tmpl`
  - keybinds: `dot_config/zsh/30-keybinds.zsh.tmpl`
  - ssh-agent: `dot_config/zsh/90-ssh-agent.zsh.tmpl`

## zsh 運用

- zsh 設定は種別ごとにファイル分割して管理する。
- 新しい定義を追加・修正する場合は、まず適切な種別のファイルに配置する。
- navi 側には必要に応じて参照導線のみ追加し、実体の重複は避ける。

## navi 運用

- cheatsheet は `dot_local/share/navi/cheats/` 配下でカテゴリ別の `.cheat` ファイルに分ける。
- 単一ファイルへ集約しない。
- 新しいコマンドは既存カテゴリに入るか確認してからファイルを増やす。
- コマンドリストを navi 以外の設定ファイル（zsh の alias / function / keybind など）で管理している場合、navi には重複記載しない。
- 実体が別ファイルにある場合は、ファイルパスを `cat` で参照するコマンドとして明記する。

## よく使う確認コマンド

```sh
chezmoi source-path
chezmoi managed
chezmoi status
chezmoi diff
chezmoi apply
chezmoi add <target>
```
