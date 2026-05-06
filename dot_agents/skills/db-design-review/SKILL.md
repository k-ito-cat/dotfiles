---
name: db-design-review
description: Use when the user asks to review a database schema, ERD, migration, or table design. Review the design against requirements, responsibility separation, uniqueness, referential integrity, null/default/delete rules, naming, types, history/state transitions, expected query performance, and future extensibility.
---

# DB Design Review

DB 設計レビュー時の観点を固定する。

## Quick start

- まず要件文書と仕様文書を確認する
- 次に ER 図、schema、migration、DDL、Atlas HCL など実体を確認する
- 仕様と設計を対応付けながらレビューする

## Review points

- 仕様や要件を正しく表現しているか
- データの責務分離は妥当か
- 一意性・参照整合性は守れるか
- NULL、デフォルト値、削除方針は妥当か
- 命名は明確か
- 型、桁、日時、金額の扱いは妥当か
- 履歴・監査・状態遷移を考慮しているか
- 想定クエリに対して性能上無理がないか
- 将来の拡張で破綻しにくいか

## Output rules

- findings を優先して返す
- 仕様根拠があるものは根拠を添える
- 事実と判断を分ける
- 問題がなければ、その旨と残るリスクを述べる
