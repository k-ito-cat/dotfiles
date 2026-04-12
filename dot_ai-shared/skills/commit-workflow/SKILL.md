---
name: commit-workflow
description: Use when the user asks for `gcm` or `gc!`, or whenever commit splitting and commit message generation are needed. Split changes before writing messages, prefer line-level grouping when practical, and follow the Japanese conventional-commit rules used by the user.
---

# Commit Workflow

`gcm` と `gc!` のためのコミット分割とコミットメッセージ作成手順。

## Quick start

- まず差分全体を把握する
- 変更の性質が混ざっていないか確認する
- 必要ならファイル単位ではなく行単位でも分割を検討する

## Workflow

1. 差分全体を確認する
2. 変更のまとまりを切り分ける
3. 機能追加、仕様変更、挙動変更、バグ修正、docs、style を混ぜない
4. 大きい変更は途中でも動く粒度に刻む
5. 各まとまりごとにコミットメッセージを作る

## Commit message rules

- 形式: `<type>[(scope)][!]: <subject>`
- type: feat / fix / docs / style / refactor / perf / test / build / ci / chore / revert
- subject は日本語で簡潔に書く
- 句点は付けない
- 作業内容ではなく変更内容または変更意図を書く

## gc! rules

- コミット前に、対象ファイルと対応するコミット文案を一覧で提示する
- 差分にシークレット、トークン、パスワード、秘密鍵、個人情報などセキュリティリスクのある情報が含まれる場合、該当箇所を指摘しコミットしないことを提案する
- 許可を得てからコミットする
