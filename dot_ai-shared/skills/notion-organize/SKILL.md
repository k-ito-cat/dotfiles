---
name: notion-organize
description: Use when organizing Notion content for 情報整理 or 仕様整理. Preserve information volume and meaning, keep headings clean, update in stages, and verify each update with fetch.
---

# Notion Organize

Notion の情報整理・仕様整理を進めるときの手順。

## Quick start

- まず `情報整理` か `仕様整理` かを明示する
- 実行前にこのフローで進めるか確認する
- `source` と `target` を fetch して最新内容を確認する

## Hard rules

- Notion MCP の更新系操作（追加・更新・削除・移動）は、実行前に毎回ユーザーへ確認し、明示的な `yes` / `OK` がある場合のみ実行する
- Notion MCP の読み取り系操作（fetch / search / get-comments など）は、事前確認なしで実行してよい
- Notion のページ本文を更新する前に、`notion://docs/enhanced-markdown-spec` を確認し、対象ブロック（特に `columns`）の書式要件を先に確定する
- `notion-update-page` は `data` を文字列ではなくオブジェクトで渡す
- `columns` 内の本文更新では、列内要素のインデント（タブ）を維持した形式で更新する
- 原文がメンション形式（例: `<mention-date .../>`）の場合、更新後もメンション形式を維持する。文字列日付へは変換しない
- 情報量を減らさない
- 意味を勝手に変えない
- 支離滅裂でない限り原文を保持する
- 見出しに番号を付けない
- 見出しに作業メタ情報を書かない
- 原文にないカテゴリを無理に立てない
- 大きな更新は一括で反映しない。まず最小差分で反映テストし、fetch で崩れがないことを確認してから全量反映する
- 更新後は必ず fetch で確認する

## Workflow

1. source と target を fetch する
2. 原文の論点と構造を把握する
3. 整理方針を設計する
4. セクション単位で段階更新する
5. 各更新後に fetch で崩れと欠落を確認する
6. 最後に欠落チェックを行う
