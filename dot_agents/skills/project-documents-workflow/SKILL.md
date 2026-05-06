---
name: project-documents-workflow
description: Use when the user says `pdocs`, `project-docs`, or wants to set up or evolve project documentation under project-documents. Set up documentation from project-documents/_template when needed, connect the app repository's `docs` path with a symlink, then use the template README files as the document map and guide user interviews to fill only necessary specifications in a development-safe order.
---

# Project Documents Workflow

project-documents 運用の入口として、ドキュメント実体の用意、アプリリポジトリとの symlink 接続、必要な仕様書の対話的な具体化を進める。

## Trigger

- ユーザーが `pdocs` または `project-docs` と言った
- project-documents を使ってプロジェクトドキュメントの作成、接続、整理を始めたい
- 実装前に仕様書を起点として仕様や設計前提を対話で固めたい

## Role

- project-documents のドキュメント実体を正本として扱う
- setup が未完了なら、ドキュメント実体と symlink を用意する
- setup 済みなら、仕様書の状態確認から始める
- template の全項目を埋めるのではなく、今必要な判断だけを対話で決める
- 未決事項を勝手に補完せず、未決として残す
- 後続の design / prototype / documents sync workflow に渡す前提を整える

## Sources

- 運用方針: `project-documents/README.md`
- ドキュメントひな形: `project-documents/_template/`
- 仕様文書地図: `project-documents/_template/specs/README.md`
- デザイン文書地図: `project-documents/_template/design/README.md`
- プロトタイプ方針: `project-documents/_template/prototype/README.md`
- プロジェクトドキュメント実体: `project-documents/<project>/`
- アプリ側ドキュメント path: `<project>/docs`

## Start Checks

1. 現在地がアプリケーションリポジトリか確認する。
2. project name を確認する。
   - 原則はリポジトリ名を使う。
   - ユーザー指定があればそれを優先する。
3. `project-documents` リポジトリの場所を確認する。
4. `project-documents/README.md`、`_template/`、`_template/specs/README.md`、`_template/design/README.md`、`_template/prototype/README.md` を確認する。
5. `project-documents/<project>` の有無を確認する。
6. アプリ側 `docs` path の状態を確認する。
   - 存在しない
   - project-documents への symlink
   - 実ディレクトリ
   - 壊れた symlink

## Phase 1: Setup

setup が未完了の場合だけ行う。

1. `project-documents/_template` を `project-documents/<project>` にコピーする。
2. アプリ側の `docs` path を `project-documents/<project>` への symlink にする。
3. symlink 先と標準構成を確認する。
4. setup が終わったら仕様書の中身をすぐ埋めず、Phase 2 に進む。

## Phase 2: Inspect

setup 済み、または既存ドキュメントがある場合はここから始める。

- `docs/`
- `docs/specs/`
- `docs/design/`
- `docs/diagrams/`
- `docs/pencil/`
- `docs/prototype/`
- `project-documents/README.md`
- `project-documents/_template/specs/README.md`
- `project-documents/_template/design/README.md`
- `project-documents/_template/prototype/README.md`

確認した項目は次に分類する。

- `ready`: すでに十分
- `needed-now`: 実装や設計の前に今決める必要がある
- `later`: 今は未定義でよい
- `blocked`: ユーザー判断がないと進めない
- `out-of-scope`: この workflow では扱わない

## Phase 3: Interview

開発順序に沿って、必要な仕様書だけ対話で具体化する。

1. `specs/`
   - `_template/specs/README.md` の文書地図を確認し、今必要なプロダクト判断、要件、技術判断、品質判断だけ扱う
2. `design/`
   - `_template/design/README.md` の文書地図を確認し、仕様として必要な体験、画面候補、デザイン前提だけ扱う
3. `prototype/`
   - `_template/prototype/README.md` の方針を確認し、操作感の検証が必要になった段階だけ扱う

## Documentation Quality Gate

- 目的は template を埋めることではなく、実装・設計・検証に耐える仕様書へ育てること。
- 穴、矛盾、抜け漏れ、目的を達成できなさそうな仕様、実装時に困る抽象度を検出したら、そのまま反映せずユーザーと詰める。
- 決められない論点は無理に確定しない。保留として扱い、保留理由、影響範囲、再確認タイミング、判断に必要な情報を残す。
- ユーザー回答はそのまま転記しない。仕様として成立する表現に整え、既存文書との整合性、用語、粒度、実装可能性を確認してから反映する。
- AI はユーザーの代わりに仕様を確定しないが、品質上の懸念、矛盾、抜け漏れは明確に指摘する。

## Dialogue Quality

- 原則として、1 つの論点を質問し、ユーザーの回答を確認してから次の論点へ進む。
- ただし、密接に結びついた論点や比較しないと判断しづらい論点は、認知負荷が高くなりすぎない範囲でまとめて質問してよい。
- 質問を複数まとめる場合は、どの回答がどの論点に対応するか分かる形にする。
- ユーザーが未回答のまま追加質問や補足をした場合は、先に新しい入力を整理し、未回答の論点を残すか、質問を組み替える。
- ユーザー回答が一部だけの場合は、回答済み部分だけを検証し、未回答部分は追質問、保留、不要のいずれにするか確認する。
- ユーザー回答と新しい質問が混ざっている場合は、回答として扱う部分と新しい論点を切り分け、必要なら先に整合性を確認する。
- 各論点は `今決める`、`仮決めする`、`後で決める`、`決めない`、`不要` のどれとして扱うかを明確にする。
- 複数の妥当な仕様判断がありうる場合だけ、選択肢と影響を示す。
  - 例: MVP 範囲、認証方式、データ所有境界、同期方式、命名、validation 境界、API 境界、エラー方針
- ユーザー回答をそのまま転記しない。反映前に、表記、用語、タイポ、意味の正確さ、既存仕様との整合性、実装時に困る抽象度、見落としや穴を確認する。
- 回答が実装判断に足りない、矛盾している、または複数解釈できる場合は、AI だけで未決扱いにしない。懸念を示し、具体化するか、仮決めするか、後で決めるか、未決事項にするかをユーザーと確認する。
- 一般論は論点発見や品質確認にだけ使う。最終的な仕様書には、そのプロジェクトの目的、制約、優先順位に基づく判断を書く。
- 対話で合意した後、更新対象の仕様書、反映する内容、仮決め、未決事項、他文書への波及を確認してから更新する。

## Design Boundary

この workflow では、デザインの仕様前提までは扱う。

- 対象ユーザー
- 主要ユースケース
- MVP の画面候補
- レスポンシブ対応有無
- 多言語対応有無
- 入力 / 表示 / 状態管理で未定義の論点
- design-workflow に渡すべき前提

画面一覧の確定、画面責務、画面遷移、ワイヤーフレーム、コンポーネント設計、visual design、Component Gallery は `design-workflow` に渡す。

## Boundary

この workflow は、仕様書として決めるべき前提を整理するためのもの。成果物そのものを作る段階に入ったら、目的に応じた workflow に切り替える。

- 画面一覧、画面責務、画面遷移、ワイヤーフレーム、コンポーネント設計を作る段階になったら `design-workflow` に切り替える。
- 仕様や設計の穴をブラウザ上の操作感で検証する必要が出たら `prototype-workflow` に切り替える。
- 実装後の変更内容を既存文書へ反映するだけなら `documents-sync-workflow` に切り替える。
- schema、migration、ERD、テーブル責務、制約設計の妥当性をレビューする段階なら `db-design-review` に切り替える。
- 個別ファイル名は `_template/specs/README.md` と `_template/design/README.md` を正本とし、この skill 内の例示を固定の真実源として扱わない。

## Hard Rules

- 仕様書を網羅的に埋めることを目的にしない。
  - 理由: 判断材料がない項目を埋めると、仕様書に根拠のない決定が混ざり、後続の実装・設計・検証の信頼性が落ちる。
  - 対象例: 公開判断、品質判断、詳細なエラー方針、将来拡張の API など、現時点で判断材料や実装予定がない項目。
  - ただし、実装や設計の品質に影響する項目はスキップしない。未決なら、保留理由、影響範囲、決めるタイミングを残す。
- template の空欄を機械的に補完しない。
  - 理由: template は論点発見のための枠であり、空欄を埋めること自体は品質保証にならない。
  - 一般的な設計原則、業界慣習、既存フォーマット、標準的な非機能観点は、論点発見や品質向上の材料として積極的に使ってよい。
  - ただし、それをこのプロジェクトに採用する場合は、目的、制約、優先順位、既存文書、実装方針との整合を確認する。
  - 避けること: 一般論を、このプロジェクトで採用する理由や適用範囲を示さずに確定仕様として書くこと。
  - よい使い方: 一般論をもとに候補を出し、このプロジェクトでは採用する / 一部採用する / 採用しない / 後で判断する、を決める。
- ユーザーが合意していない判断を確定しない。
  - 理由: 仕様書は実装判断の正本になるため、AI の推測を確定事項として混ぜると後で認識ずれが起きる。
  - 判断材料が足りない場合は、質問する、仮決めとして明記する、保留にする、不要と判断する、のどれかをユーザーと決める。
- 未決事項は単に未決とだけ書かない。
  - 理由: 未決のままだと、いつ何を決めればよいか分からず放置される。
  - 保留理由、影響範囲、再確認タイミング、判断に必要な情報を残す。
- setup と仕様策定を混ぜない。
  - 理由: symlink や template コピーの状態が不確かなまま仕様書を更新すると、正本でない場所へ書く危険がある。
  - 先に project-documents の実体とアプリ側 docs path の接続を確認する。
- setup 済みなら setup を繰り返さない。
  - 理由: 既存ドキュメントの上書き、重複作成、symlink の破壊を避けるため。
  - 既存状態がある場合は、作り直しではなく状態確認から始める。
- project-documents の実体を正本として扱う。
  - 理由: アプリ側 `docs` は symlink であり、実体は `project-documents/<project>/` にあるため。
  - 参照・更新時は symlink 先を確認し、実体側の文書構成を基準にする。
- アプリケーションコード生成そのものは扱わない。
  - 理由: この workflow は仕様書とドキュメント運用の workflow であり、アプリケーション生成や実装は責務外。
  - 必要なら、仕様書として実装前提を整理したうえで別 workflow に渡す。

## Output

必要に応じて、次を短く示す。

- 現在フェーズ
- 確認した文書
- 今決める論点
- 質問
- 更新対象
- 未決事項
- 次に進む条件

## Verification

```sh
test -L <project>/docs
readlink <project>/docs
find project-documents/<project> -maxdepth 2 -type d | sort
```
