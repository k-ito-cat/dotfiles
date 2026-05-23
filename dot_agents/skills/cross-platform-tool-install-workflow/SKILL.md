---
name: cross-platform-tool-install-workflow
description: Use when installing, declaring, or recommending global npm packages, CLI tools, developer utilities, or app-linked tools across macOS, Windows, and WSL. Check official compatibility and installation docs first, compare package managers such as npm, Homebrew, winget, and manual installers, and add OS-specific branches when configuration differs.
---

# Cross-platform Tool Install Workflow

npm グローバルパッケージ、CLI ツール、開発補助ツール、GUI アプリ連携を導入・提案するときは、macOS / Windows ホスト / WSL の差分を先に確認する。

## 手順

1. 実際のツール名・パッケージ名を特定する。
   - npm の scoped package、旧名、後継パッケージ、類似名、typo を確認する。
   - GUI アプリ本体、CLI、拡張機能、MCP サーバーなどが別パッケージの場合は分けて扱う。

2. 公式情報を一次情報として確認する。
   - 公式 docs / 公式 README / npm package / GitHub Releases / Homebrew formula・cask / winget package を優先する。
   - インストールコマンド、対応 OS、設定パス、非推奨情報は記憶で断定しない。

3. 対応環境を比較する。
   - macOS
   - Windows ホスト
   - WSL / Linux
   - GUI アプリ連携がある場合は、GUI がどちら側に存在するかを確認する。

4. 導入方法を比較する。
   - npm global install
   - Homebrew formula / cask
   - winget
   - 公式 installer
   - mise / asdf など、既存のバージョン管理ツール
   - 手動配置が必要な場合は、その理由と保守コストを明示する。

5. 連携差分を確認する。
   - PATH と shell 初期化
   - 設定ファイルの場所
   - 認証情報・secret 参照
   - SSH agent / 1Password 連携
   - Windows 側 GUI と WSL 側 CLI の橋渡し
   - localhost、socket、ブラウザ起動、MCP、ファイルパス変換の必要性

6. 管理場所を決める。
   - macOS / WSL 共通 CLI は、可能なら共通の宣言に寄せる。
   - macOS 専用 GUI アプリは `Brewfile.tmpl` の `darwin` ブロックを優先する。
   - Windows ホスト側 GUI アプリは `windows/` 配下の winget / PowerShell 管理を優先する。
   - WSL 専用の設定は Linux 分岐に閉じ込める。
   - dotfiles / `~/.config` / shell 設定は生成先ではなく chezmoi 管理元を編集する。

7. 差分がある場合は OS 分岐を書く。
   - 既存の `.tmpl`、`.chezmoiignore`、OS 条件分岐、shell 分割方針に合わせる。
   - 片方の OS で不安定な workaround が必要な場合、無理に共通化しない。
   - Windows ホスト GUI と WSL CLI のブリッジが必要なものは、Mac と同等扱いにしない。

8. 回答では事実と判断を分ける。
   - 事実: 公式情報で確認した対応 OS、導入方法、設定差分。
   - 判断: 推奨する導入経路、分岐方法、管理場所、その理由。

## 判断基準

- Mac を主戦場にする前提でも、Windows / WSL の既存運用を壊さない。
- ただし、Windows / WSL 側で GUI 連携やブリッジが複雑になる場合は、Mac 優先を明示してよい。
- パッケージ名が同じでも、OS ごとに配布物・設定パス・連携対象が違う場合は別物として扱う。
- 公式に安定した導入方法がないものは、すぐ管理対象へ入れず pending 扱いを提案する。
