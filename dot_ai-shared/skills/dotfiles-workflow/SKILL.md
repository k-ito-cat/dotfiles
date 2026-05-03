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
- 明示指示がない限り、`chezmoi update`、`git pull`、`git push` は実行しない。
- 生成先ファイルの削除・置換は、事前にユーザーへ確認する。
- zsh 変更は適切な分割ファイルに置く。
  - core: `dot_config/zsh/00-core.zsh.tmpl`
  - aliases: `dot_config/zsh/10-aliases.zsh.tmpl`
  - history: `dot_config/zsh/15-history.zsh.tmpl`
  - functions/widgets: `dot_config/zsh/20-functions.zsh.tmpl`
  - keybinds: `dot_config/zsh/30-keybinds.zsh.tmpl`
  - ssh-agent: `dot_config/zsh/90-ssh-agent.zsh.tmpl`
- navi には、別ファイルで管理している alias / function / keybind を重複定義しない。必要なら参照導線だけ追加する。

## よく使う確認コマンド

```sh
chezmoi source-path
chezmoi managed
chezmoi status
chezmoi diff
chezmoi apply
chezmoi add <target>
```
