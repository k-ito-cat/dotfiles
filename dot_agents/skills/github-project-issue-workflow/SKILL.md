---
name: github-project-issue-workflow
description: Use when creating, updating, deleting, or organizing GitHub Project issues, draft issues, or project items. Always create new project tasks as draft issues, choose or confirm the appropriate project first, set new items to Todo, and verify Markdown bodies use real newlines instead of escaped newline strings.
---

# GitHub Project Issue Workflow

GitHub Project 上の issue / draft issue / project item を管理する最小手順。

## Scope

- GitHub Project への draft issue 追加
- 既存 project item / draft issue の更新
- 既存 project item / draft issue の削除または整理
- 適切な Project の確認
- 適切な Project がない場合の作成提案

## Required Rules

- 新規タスクは必ず draft issue として追加する。
- Project URL が指定されている場合は、その Project を優先する。
- Project が未指定の場合は、既存 Project から適切なものを探す。
- 適切な Project が見つからない場合は、Project 作成を提案する。
- Project 作成、削除、破壊的変更はユーザーの明示 OK なしに実行しない。
- 新規追加後の Status は `Todo` にする。
- 内容が不明瞭なまま draft issue を作成しない。
- Issue body は、ユーザーが明示した内容または確認済みの事実に基づいて作成し、憶測で背景、要件、作業内容、完了条件を膨らませてはならない。
- 詳細が不足していて body の品質や実行内容に影響する場合は、必ずユーザーへヒアリングし、作成前に認識確認する。
- 優先度は憶測で決めず、必要な場合はユーザーに確認する。
- 目的、完了条件、対象範囲、Project 判断材料のいずれかが不足して作成品質に影響する場合は、作成前にヒアリングする。
- 具体化は、Issue 化しないと誤作業、実行不能、Project 誤選定につながる曖昧さがある場合に限る。
- 詳細手順が未確定なだけなら、無理にヒアリングしない。
- 軽いタスク化が目的の場合は、目的と最低限の完了条件だけで draft issue 化する。
- Issue 本文で小タスクを増やしすぎて、着手ハードルを上げない。
- ヒアリングは原則 1〜3 個の短い質問に絞る。
- ユーザーが「メモとして残す」意図を明示している場合は、曖昧さを許容して短い draft issue として作成してよい。
- Issue 本文はタスク内容に応じて都度構成する。固定テンプレートを無条件に適用しない。
- Markdown 本文は GitHub 上で正しく表示される形式にする。
- `\n` という文字列を本文に混入させない。
- CLI に複数行 body を渡す場合は、実改行として渡す。
- 作成・更新後は内容を確認し、本文にリテラルの `\n` が含まれていないことを確認する。

## Workflow

1. 依頼内容を確認し、Issue 化に必要な具体性があるか判断する。
2. 不明瞭な点が作成品質に影響する場合は、作成前にヒアリングして具体化する。
3. 依頼内容を GitHub Issue として自然なタイトルと本文に整理する。
4. 対象 Project を特定する。
5. Project が未特定または不適切な場合は、候補提示または作成提案を行う。
6. 新規タスクの場合は draft issue として作成する。
7. 新規 item の Status を `Todo` に設定する。
8. 作成・更新・削除後に対象 Project、item、Status、本文表示上の問題有無を確認する。
9. 実行結果と残件を簡潔に報告する。

## Body Construction

- Issue は基本的に端的に書く。
- 情報量を増やして安心感を出さない。
- 本文構成は Issue ごとに判断する。
- 見出しは必要なものだけ使う。
- 小さいタスクは短くする。
- 目的と、それに対する実行内容を明確にする。
- 実行内容はチェックリスト形式を基本とし、必要に応じてチェックリストへの補足情報を添える。
- チェックリストは抽象的な方針ではなく、実行できる具体タスクとして書く。
- 単発ですぐ終わりそうな内容は、冗長化せず相応の短さにする。
- チェックリストは進捗管理に意味がある範囲に絞る。
- 背景、目的、注意点、完了条件は必要な場合だけ置く。
- 調査、実装、バグ修正、環境改善、運用、意思決定、メモで構成を変える。
- 完了条件が必要なタスクでは、完了判断が曖昧にならないように書く。
- 前提、対象外、リスク、参考リンクは必要な場合だけ入れる。
- 実行手順や小タスクは、作成時点で必要な場合だけ書く。
- 詳細な分解は、Issue 作成後の実作業や調査で必要になったときに行う。

## CLI Notes

- `gh project item-create` で draft issue を作成する。
- `gh project field-list` で Status field と `Todo` option を確認する。
- `gh project item-edit` で Status を `Todo` に設定する。
- 複数行 body を `--body "...\n..."` のように渡さない。
- zsh では `$'...\n...'` など、実改行を保持できる渡し方を使う。
- 作成・更新後は `gh project item-list` などで body を確認する。
- GitHub Project 操作に scope が足りない場合は、`gh auth refresh -h github.com -s project` を使う。

## Safety

- push / pull / force push など repository 操作は、この Skill の範囲外とする。
- 削除操作は対象 item を明示し、ユーザーの確認後に実行する。
- Project 作成は、名前、目的、管理対象を提示し、ユーザーの確認後に実行する。
