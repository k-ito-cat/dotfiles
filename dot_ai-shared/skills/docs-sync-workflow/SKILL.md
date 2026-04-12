---
name: docs-sync-workflow
description: Use when the user asks to update or review `docs/` or `README.md`, or when feature, structure, library, API, or design changes may require documentation sync. Determine whether updates are needed, identify exact target documents, explain the planned updates before editing, and check related documents horizontally.
---

# Docs Sync Workflow

この skill は、実装と `docs/` / `README.md` の同期判断と更新手順を扱う。

## Quick start

- `README.md`、`package.json`、`docs/` の実ファイル一覧を確認する
- `docs/` が symlink の場合はリンク先の実体も含めて構成を把握する
- まず `更新要否` `更新対象` `更新理由` を整理し、更新前にユーザーへ明示する
- デザイン作成や画面設計が主題なら `design-workflow` Skill を併用する

## When to use

- 機能追加、仕様変更、挙動変更、API 方針変更を行った
- ディレクトリ構造や docs 構成が変わった
- ライブラリ、ツール、開発手順を追加または変更した
- `README.md` や `docs/` の記述ずれを調査または修正したい
- `docs/design/` の同期要否を判断したい

## Hard rules

- パス参照だけでなく内容整合性を確認する
- 実在する文書だけを対象にし、名前や配置を決め打ちしない
- 指摘箇所を修正する場合は、同種のずれが他にないか横断確認する
- 更新前に対象文書、更新理由、更新方針を明示する
- ドキュメント更新はユーザーの許可を得てから行う
- デザイン作成の詳細手順は `design-workflow` Skill を正本とする
- プロジェクト文書の新規作成、追記、未記入項目の補完は、例外なくユーザーとの対話とヒアリングで進める
- どの文書のどの論点を埋めるかを先に明示し、合意なしに内容を確定しない
- 一般論や推測だけで埋めず、`docs/specs/structure.md` や関連文書を参照して、このプロジェクトでの最適解として質問を具体化する

## Target mapping

- 機能追加、仕様変更、挙動変更:
  - 関連する `docs/specs/*` を確認し、必要なら更新する
  - 用語、画面責務、UI パターンへ波及する場合は `glossary` や `docs/design/*` も確認する
- ディレクトリ構造、責務、構成変更:
  - `docs/specs/structure.md` を優先して確認する
  - `README.md` の構成説明、導線、セットアップ手順も確認する
- ライブラリ、ツール、開発手順変更:
  - `README.md` と関連する仕様書、手順書を確認する
- API、validation、error policy 変更:
  - 対応する API 文書、validation 方針、error policy 文書を確認する
- デザイン関連の構成や方針変更:
  - `docs/design/` 配下を横断確認する
  - 画面設計や UI 設計へ進む場合は `design-workflow` Skill を使う

## Workflow

1. 実ファイル一覧と関連ドキュメント導線を確認する
2. 変更内容から更新契機を分類する
3. 更新要否を判断する
4. 対象文書と未更新でよい文書を整理する
5. 文書作成や未記入項目補完では、どの項目を埋めるかと判断に必要な前提を整理する
6. `docs/specs/structure.md` と関連文書を参照し、ヒアリング項目を具体化する
7. ユーザーへ対象、理由、更新方針、確認したい論点を明示して許可を得る
8. 合意した内容だけを反映する
9. 更新後は `README.md` と関連文書の残差分を横断確認する
