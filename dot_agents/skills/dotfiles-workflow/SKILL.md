---
name: dotfiles-workflow
description: Use for dotfiles, shell/editor/CLI config, aliases, functions, keybinds, navi, git config, and ~/.config files. Investigate first, edit the chezmoi source only after explicit user approval, propose chezmoi add for unmanaged files, and run chezmoi apply only when approved.
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
- `~/.agents/skills`

## パッケージ宣言運用

- Mac / WSL / Linuxbrew 共通の CLI ツールは `Brewfile.tmpl` の共通領域を正本にする。
- macOS の GUI アプリは、Homebrew Cask がある場合は `Brewfile.tmpl` の `darwin` ブロックを正本にする。
- Windows ホスト側の GUI アプリは `windows/configuration.winget` を正本にする。
- Windows ホスト側の IME や OS 固有設定は `windows/apply.ps1` を正本にする。
- 片方の OS にしかないツールは、もう片方に無理に代替を置かない。
- deprecated、ID 不一致、手動設定が必要なツールは、すぐ宣言へ入れず README の pending に残す。
- `windows/` は dotfiles リポジトリ内の管理ファイルであり、chezmoi apply 対象からは `.chezmoiignore` で外す。

## 手順

1. 依頼が相談、調査、可否確認、選択肢提示、レビューのいずれかを判定する。
   - 該当する場合は読み取り調査だけを行い、編集しない。
   - ユーザーが実装や変更を求めている場合でも、編集前ゲートを通す。
2. ユーザーが変更したい生成先ファイルを特定する。
3. まず chezmoi source directory を探す。
   - 生成先との対応を優先して確認する。
   - `.tmpl`、`dot_`、`private_`、`symlink_`、分割設定ファイルも確認する。
   - `~/.agents/skills/<skill>` を変更する場合は、生成先を直接編集せず、`dot_agents/skills/<skill>` の有無を先に確認する。
   - Skill 名を変更する場合は、生成先の rename だけで済ませず、`dot_agents/skills/<old>` の rename、frontmatter `name`、関連 Skill からの参照、`agents/openai.yaml` も同時に確認する。
   - 見つからない場合は、大小文字違い、typo、名前の勘違いを疑って探索する。
4. 現状分析、選択肢、推奨案、反映範囲、変更しない範囲を整理し、ユーザーに確認する。
5. ユーザーの明示的な OK がある場合だけ、管理対象なら chezmoi source file を編集する。
6. 未管理なら生成先を先に編集しない。`chezmoi add <target>` を提案し、ユーザーに確認する。
7. 管理元を編集したら、承認された範囲で次を実行する。
   - `chezmoi diff`
   - `chezmoi apply`
8. 反映が必要な変更では、生成先も確認する。
9. 変更した管理元ファイルと apply 結果を報告する。

## 必須ルール

- chezmoi 管理元がある場合、生成先 dotfile を正本として扱わない。
- dot config が chezmoi 管理対象の場合、更新は基本的に chezmoi 側の `.tmpl` / `dot_` / `private_` / `symlink_` 管理元を優先する。
- `~/.agents/skills` 配下は実ファイルが存在しても、chezmoi 管理対象の可能性が高い。`chezmoi source-path` が新名で失敗した場合も、旧名・表記ゆれ・`dot_agents/skills` を探索してから未管理と判断する。
- 参照先としても、生成先の実ファイルより chezmoi 管理元を優先する。
- 実ファイルを確認する場合でも、真実源は chezmoi 管理元として扱う。
- ユーザーの明示的な OK が出るまで、`apply_patch` などによるファイル編集を行わない。
- `chezmoi apply` は、編集方針または反映操作として承認された場合だけ実行する。
- ユーザーのレビュー、指摘、懸念は即修正指示として扱わず、まず分析、同意点、懸念点、修正方針を提示して確認する。
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

### navi 強制ルール

- navi に CLI コマンド、サブコマンド、オプション、設定値を追加・変更する場合は、編集前に対象 CLI のローカル `--help` / `--version`、または公式ドキュメントで存在と挙動を確認する。
- ユーザーが提示したコマンドであっても、未確認のまま navi に登録しない。
- 推測したコマンド名、サブコマンド名、オプション名、設定値を navi に登録しない。
- 編集前ゲートには、確認に使ったコマンドまたは公式ドキュメントと、確認できた事実を明記する。
- 確認できない場合は、navi への追加・変更を行わず、未確認であることと代替の確認方法をユーザーに提示する。

### navi 追加フロー

- navi にキー操作、ショートカット、CLI サブコマンド、設定値、用語を追加する前に、追加対象の意味と実際の挙動を確認する。
- ユーザーの表現をそのまま仕様名として扱わない。特に「モード」「切替」「スクロール」「履歴」「送信」などの曖昧語は、実際の action 名、help、keymap、公式 docs、README、ローカル設定を確認してから表記を決める。
- 公式 docs だけで TUI/CLI のショートカットが確認できない場合は、ローカルの `--help`、設定ファイル、インストール済みパッケージ、upstream source の keymap を順に確認する。
- navi のコメントは、内部実装名よりも利用時に何が起きるかを優先して書く。ただし実装名が識別に有用な場合は併記する。
- 既存セクション内で対象ツールが明らかな場合、コメントにツール名を重複させない。既存の文体との統一が必要な場合だけ残す。
- 確認した事実と、navi 上の推奨表記を分けてユーザーに提示し、明示的な OK の後に編集する。

## よく使う確認コマンド

```sh
chezmoi source-path
chezmoi managed
chezmoi status
chezmoi diff
chezmoi apply
chezmoi add <target>
```
