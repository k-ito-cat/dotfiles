---
name: notion-organize
description: Use when the user asks to organize Notion content as 情報整理 or 仕様整理. Preserve information volume, avoid changing meaning without confirmation, keep headings clean, and perform staged updates with fetch-based verification.
---

# Notion Organize

Notion の情報整理・仕様整理を進めるときの手順。

## Quick start

- まず `情報整理` か `仕様整理` かを明示する
- 実行前にこのフローで進めるか確認する
- `source` と `target` を fetch して最新内容を確認する

## Hard rules

- 情報量を減らさない
- 意味を勝手に変えない
- 支離滅裂でない限り原文を保持する
- 見出しに番号を付けない
- 見出しに作業メタ情報を書かない
- 原文にないカテゴリを無理に立てない
- 大きな更新は一括で反映しない
- 更新後は必ず fetch で確認する

## Workflow

1. source と target を fetch する
2. 原文の論点と構造を把握する
3. 整理方針を設計する
4. セクション単位で段階更新する
5. 各更新後に fetch で崩れと欠落を確認する
6. 最後に欠落チェックを行う
