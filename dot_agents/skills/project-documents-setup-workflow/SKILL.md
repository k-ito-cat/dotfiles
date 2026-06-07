---
name: project-documents-setup-workflow
description: Use when the user says `pdocs`, `project-docs`, or wants to set up or evolve project documentation under project-documents. Set up documentation from project-documents/_template when needed, connect the app repository's `docs` path with a symlink, read docs/README.md as the operating contract, then hand off structured specs/design document interviews to project-documents-interview after setup and inspection are complete.
---

# Project Documents Setup Workflow

project-documents 運用の入口として、ドキュメント実体の用意、アプリリポジトリとの symlink 接続、標準構成の確認まで進める。setup と inspect が完了したら、仕様書や design docs の具体化は `project-documents-interview` に渡す。

## Documentation Operating Model

- ドキュメント / 仕様書は、詳細仕様の正本ではなく、開発判断の道しるべとして扱う。
- 目的は、メンテナンスコストを下げつつ、プロダクト品質を維持し、ドキュメント / 仕様書が実装と乖離して腐ることを防ぐこと。
- ドキュメント / 仕様書には、品質保証、プロダクト意図、設計思想、判断軸、責務境界、詳細の正本、未決事項、更新条件を残す。
- 詳細仕様は code、OpenAPI、schema、migration、test、prototype などの実行可能または検証可能な成果物を正本とする。
- UI / UX に影響する仕様変更では、design docs を更新する前に、仕様書側で目的、対象ユーザー、利用文脈、MVP 範囲、対象画面、制約、未決事項などの design 入力条件を整理する。
- 空欄を埋めること、網羅性を上げること、実装済み詳細を転記することを目的にしない。
- 仕様書に置いた項目は空欄のまま残さない。不要な項目は置かず、未決事項は保留理由、影響範囲、再確認タイミング、判断に必要な情報を残す。
- 実装前に必要なのは全部の詳細仕様ではなく、品質、意図、判断の再現に必要な仕様である。

## Trigger

- ユーザーが `pdocs` または `project-docs` と言った
- project-documents を使ってプロジェクトドキュメントの作成、接続、整理を始めたい
- 実装前に仕様書を起点として仕様や設計前提を対話で固めたい

## Role

- project-documents のドキュメント実体を正本として扱う
- setup が未完了なら、ドキュメント実体と symlink を用意する
- setup 済みなら、仕様書の状態確認から始める
- template の全項目を埋めるのではなく、今必要な判断だけを対話で決める
- 不要な項目や回答不要な空欄は増やさない
- 未決事項を勝手に補完せず、未決として残す
- 後続の project-documents-interview / prototype / documents sync workflow に渡す前提を整える

## Sources

- 運用方針: `project-documents/README.md`
- ドキュメントひな形: `project-documents/_template/`
- docs 全体の運用原則: `project-documents/_template/README.md`
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
4. `project-documents/README.md`、`_template/`、`_template/README.md`、`_template/specs/README.md`、`_template/design/README.md`、`_template/prototype/README.md` を確認する。
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
- `docs/README.md`
- `docs/specs/`
- `docs/design/`
- `docs/diagrams/`
- `docs/pencil/`
- `docs/prototype/`
- `project-documents/README.md`
- `project-documents/_template/README.md`
- `project-documents/_template/specs/README.md`
- `project-documents/_template/design/README.md`
- `project-documents/_template/prototype/README.md`

確認した項目は次に分類する。

- `ready`: すでに十分
- `needed-now`: 実装や設計の前に今決める必要がある
- `later`: 今は未定義でよい
- `blocked`: ユーザー判断がないと進めない
- `out-of-scope`: この workflow では扱わない

## Phase 3: Handoff To Interview

setup と inspect が完了したら、仕様書や design docs の中身をこの workflow で埋め始めない。次の条件を満たす場合は `project-documents-interview` に切り替える。

- ユーザーが docs、仕様書、spec、design docs、要件、未定義項目を埋めたいと言っている
- prototype 作成前に specs / design の前提を固めたい
- setup 済みの project-documents に対してヒアリングで文書を具体化したい

handoff 時は、次を短く伝える。

- setup / inspect 済みであること
- 確認した docs path と project-documents 実体
- `docs/README.md`、`docs/specs/README.md`、`docs/design/README.md`、`docs/prototype/README.md` を読む必要があること
- 以後は `project-documents-interview` のフェーズ順に、ヒアリング形式で進めること

## Documentation Quality Gate

- 目的は template を埋めることではなく、品質、意図、判断の再現に必要な仕様へ育てること。
- 仕様書は空欄を多く残したまま完成扱いしない。不要な項目は削り、必要な未決事項だけを理由付きで残す。
- API endpoint 詳細、validation の regex / length、DB schema 詳細、migration 詳細、UI の pixel detail、実装済みコード説明、test で担保できる具体挙動は、原則として仕様書へ転記しない。
- それらの詳細を扱う場合は、詳細の正本がどの成果物かを仕様書に短く示す。
- 穴、矛盾、抜け漏れ、目的を達成できなさそうな仕様、実装時に困る抽象度を検出したら、そのまま反映せずユーザーと詰める。
- 決められない論点は無理に確定しない。保留として扱い、保留理由、影響範囲、再確認タイミング、判断に必要な情報を残す。
- ユーザー回答はそのまま転記しない。仕様として成立する表現に整え、既存文書との整合性、用語、粒度、実装可能性を確認してから反映する。
- AI はユーザーの代わりに仕様を確定しないが、品質上の懸念、矛盾、抜け漏れは明確に指摘する。

## Update Conditions

ドキュメント / 仕様書更新が必要な場合:

- 方針、スコープ、責務境界、設計思想、品質上の最低ラインが変わった
- 詳細の正本の置き場所が変わった
- 未決事項を決めた、または新しい未決事項が増えた
- legal / release / security / non-functional などの発火条件に入った
- prototype で本実装に持ち込む判断、捨てる判断、追加検証が決まった
- AI が次回迷いそうな判断が増えた

ドキュメント / 仕様書更新が不要な代表例:

- endpoint を追加しただけ
- schema field や validation の具体値を変えただけ
- migration を追加しただけ
- test を追加しただけ
- UI の細部を調整しただけ
- 実装済みコードの説明を書きたいだけ

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

この workflow では、デザインの仕様前提を直接ヒアリングして埋めない。setup / inspect 中に不足が見つかった場合は、`project-documents-interview` へ渡す論点として整理する。

- 対象ユーザー
- 主要ユースケース
- MVP の画面候補
- レスポンシブ対応有無
- 多言語対応有無
- 入力 / 表示 / 状態管理で未定義の論点
- project-documents-interview に渡すべき前提

画面一覧、画面責務、画面遷移、UI / UX 判断、design docs の具体化は `project-documents-interview` に渡す。操作感、状態変化、導線をブラウザ上で検証する必要が出たら `prototype-workflow` に渡す。

## UI / UX Impact Gate

仕様変更が UI / UX に影響する場合は、design docs を仕様の転記先として扱わない。先に specs 側で design の入力条件を確認する。

specs 側で確認する入力条件:

- その機能や変更が必要な理由
- 対象ユーザー
- 利用頻度
- 利用文脈
- MVP / Post-MVP の範囲
- 対象画面や対象プラットフォーム
- 何を達成、調整、回避したいのか
- 主導線に近い機能か、補助機能か
- 設定保存や将来拡張との関係
- design 側で判断してよい範囲
- 未決事項、保留理由、影響範囲、再確認タイミング

この段階で扱わないもの:

- UI パターンの確定
- 画面内配置
- コンポーネント責務
- token や実装値
- 見た目の細部

入力条件が不足している場合は、design docs を更新せず、`project-documents-interview` で仕様論点としてユーザーと整理する。入力条件が揃い、UI / UX 判断や design docs の具体化が必要な場合も `project-documents-interview` に渡す。

## Boundary

この workflow は、仕様書として決めるべき前提を整理するためのもの。成果物そのものを作る段階に入ったら、目的に応じた workflow に切り替える。

- specs / design docs をヒアリング形式で具体化する段階になったら `project-documents-interview` に切り替える。
- 仕様や設計の穴をブラウザ上の操作感で検証する必要が出たら `prototype-workflow` に切り替える。
- 実装後の変更内容を既存文書へ反映するだけなら `documents-sync-workflow` に切り替える。
- schema、migration、ERD、テーブル責務、制約設計の妥当性をレビューする段階なら `db-design-review` に切り替える。
- docs 全体の運用原則は `_template/README.md`、個別ファイル名は `_template/specs/README.md` と `_template/design/README.md` を正本とし、この skill 内の例示を固定の真実源として扱わない。

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
