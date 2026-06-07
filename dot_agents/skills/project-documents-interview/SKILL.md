---
name: project-documents-interview
description: Use when the user wants to fill, organize, or evolve project documents, specs, design documents, requirements, or unanswered docs sections through structured interviews after project-documents setup is complete. Use for requests like docsを埋めたい, 仕様を埋めたい, デザイン文書を埋めたい, 要件を整理したい, or prototype前に前提を固めたい.
---

# Project Documents Interview

setup 済みの project-documents に対して、`specs/` と `design/` をヒアリング形式で具体化する。

この skill の目的は、template の空欄を埋めることではない。専門家観点で論点を網羅的に発見し、各論点を `決定`、`仮決定`、`後で判断`、`不要`、`別文書へ送る`、`prototypeで検証` に分類し、品質、意図、判断の再現に必要な内容だけを文書化する。

## Trigger

- ユーザーが docs、仕様書、spec、design docs、要件、未定義項目を埋めたいと言った
- `project-documents-setup-workflow` の setup / inspect が完了し、仕様やデザイン文書の具体化へ進む
- prototype 作成前に、仕様、画面、状態、UI / UX 判断の前提を固めたい
- 既存 docs の未決事項をヒアリングで整理したい

setup が未完了、`docs` path の正本が不明、または project-documents 実体が確認できない場合は、この skill では文書を埋めず、`project-documents-setup-workflow` に戻す。

## Operating Model

- `docs/README.md` を docs 全体の正本分担と更新条件の正本として扱う。
- `docs/specs/README.md` と `docs/design/README.md` を、対象文書、責務、フォーマット、スタブ運用の正本として扱う。
- `design/` はデザインファイル作成のためではなく、prototype と実装が迷わないための UI / UX 判断の正本として扱う。
- `prototype/` は検証道具であり正本ではない。採用する判断だけを `specs/` または `design/` に戻す。
- code、OpenAPI、schema、migration、test、生成物が正本になる詳細を docs に転記しない。
- ユーザー回答をそのまま転記しない。仕様表現に整え、矛盾、品質リスク、粒度、正本分担を確認してから反映する。
- ユーザー合意前にファイル編集しない。

## Required Start Checks

最初に次を読む。

1. `docs/README.md`
2. `docs/specs/README.md`
3. `docs/design/README.md`
4. `docs/prototype/README.md`

その後、既存文書の状態を確認し、対象項目を次に分類する。

- `ready`: すでに十分
- `needed-now`: 今決めないと設計、prototype、実装、品質判断に影響する
- `later`: 判断タイミングが来ていない
- `blocked`: ユーザー判断や外部情報がないと進めない
- `out-of-scope`: この workflow では扱わない

## Interview Modes

start checks の後、必ず作業モードを決める。ユーザーが明示していない場合は、既存文書の状態を見て推奨モードを提示し、確認してから進める。

### New Mode

docs が空、またはほぼ未定義の場合に使う。

- Phase 1 から順にヒアリングする。
- 既存文書があっても、判断材料として読む。
- 最初から全項目を埋めようとせず、今必要な論点だけ扱う。
- 判断できない項目は `後で判断`、不要な項目は `不要` に分類する。

### Fill Undefined Mode

既存文書は概ね使えるが、未定義、後で判断、blocked、保留論点を埋めたい場合に使う。

- 既存の `決定` / `仮決定` は原則として維持する。
- 未定義、後で判断、矛盾、品質リスクがある項目だけ扱う。
- 既存文書の全体再設計に広げない。
- 既存決定に明らかな矛盾や品質リスクがある場合だけ、Quality Intervention Gate で扱う。

### Reorganize Mode

既存文書をベースに、設計判断を 1 から再点検する場合に使う。

- 既存文書を捨てず、各項目の現在値として扱う。
- Phase 順は維持する。
- 各文書、各論点を 1 つずつ確認する。
- 既存内容を要約し、現在も妥当か評価する。
- 各論点を `維持`、`軽微修正`、`修正`、`刷新`、`不要`、`後で判断`、`prototypeで検証` に分類する。
- `修正` / `刷新` の場合だけ追加ヒアリングする。
- 既存内容を無視して作り直さない。
- ユーザーが「1からやる」と言った場合も、既存文書があるなら既存内容を前提に再審査する。

Reorganize Mode の確認フォーマット:

```text
現在フェーズ:
対象文書:
対象論点:
既存内容:
現在の評価:
選択肢:
推奨:
質問:
```

選択肢は必要に応じて次から出す。

- 維持
- 軽微修正
- 修正
- 刷新
- 不要
- 後で判断
- prototypeで検証

## Interview Phases

必ずこの順序で進める。後続フェーズで前提不足が見つかったら、前のフェーズへ戻る。

### Phase 1: Core Spec Foundation

目的: design と requirements に進むための土台を作る。

読む順序:

1. `specs/core/product.md`
2. `specs/core/scope.md`
3. `specs/core/glossary.md`
4. `specs/core/tech.md`

主なヒアリング観点:

- 何をなぜ作るか
- 対象ユーザー、対象外ユーザー
- 利用文脈、利用頻度、代替手段
- 提供価値、価値が崩れる条件
- MVP、対象外、後回し、制約
- 対応環境、レスポンシブの最低範囲
- サービス名、主要用語、操作語彙、表記揺れ禁止
- 既に決まっている技術前提と、今は決めない技術領域

`core/tech.md` は深掘りしすぎない。UI / UX、prototype、実装判断に影響する技術前提だけ扱う。

### Phase 2: Functional Scope

目的: 作るものと、失敗すると価値や品質が落ちる範囲を決める。

読む順序:

1. `specs/requirements/functional.md`
2. `specs/requirements/non-functional.md`

主なヒアリング観点:

- 機能一覧、必須機能、任意機能、後回し、対象外
- 機能ごとのユーザー価値
- 作ること、作らないこと
- 状態と永続化
- 失敗すると困ること
- 実装前チェック
- 品質上の最低ライン

非機能要件では ISO/IEC 25010 系の品質観点を論点発見に使う。ただし品質特性を機械的に全部埋めず、後から気づくと戻しにくい最低ラインだけ扱う。

### Phase 3: Design Input Spec

目的: `design/` に進むための specs 側入力条件を揃える。

確認元:

- `specs/core/product.md`
- `specs/core/scope.md`
- `specs/requirements/functional.md`
- `specs/requirements/non-functional.md`

必ず確認する入力条件:

- 対象ユーザー
- 利用頻度、利用文脈
- 主導線
- MVP / Post-MVP
- 対象画面候補、対象プラットフォーム
- 対応デバイス、レスポンシブ、多言語
- 状態保存の有無
- design 側で判断してよい範囲
- prototype で検証すべき仮説

不足している場合は `design/` へ進まず、specs 側で追加ヒアリングする。

### Phase 4: Design Documents

目的: prototype と実装が迷わない UI / UX 判断を残す。

読む順序:

1. `design/DESIGN.md`
2. `design/foundations.md`
3. `design/hig.md`
4. `design/screens.md`
5. `design/layouts.md`
6. `design/ui-patterns.md`
7. `design/components.md`
8. `design/tokens.md`
9. `design/checklist.md`

主なヒアリング観点:

- design docs の責務と prototype との関係
- デザイン前提、ブランド、トーン、テーマ
- 色、タイポグラフィ、余白、密度、装飾方針
- human-centered design、利用者理解、利用文脈、認知負荷
- a11y、フォーカス、キーボード、motion、reduced-motion
- 開閉、ナビゲーション、破壊的操作、validation、empty、loading、error
- 画面一覧、画面責務、主要状態、遷移、権限、URL
- レイアウト方針、グローバル領域、ビューポート、モバイル特有
- UI pattern、通知階層、overlay、confirm、form / wizard
- コンポーネント分類、必要な範囲、prototype に必要な範囲
- token 運用方針、値の正本、実装との同期方法

`tokens.md` で実装値を決めるのは、prototype または実装で必要な最低限に留める。`design/checklist.md` は最後の確認観点であり、判断の正本にしない。

### Phase 5: Technical / Area Specs

目的: design と requirements で見えた技術、品質、運用論点を必要な範囲だけ specs へ戻す。

読む候補:

- `specs/area/architecture.md`
- `specs/area/structure.md`
- `specs/area/api.md`
- `specs/area/validation.md`
- `specs/area/error-policy.md`
- `specs/area/security.md`
- `specs/area/test.md`
- `specs/area/qa.md`
- `specs/area/observability.md`
- `specs/area/dependencies.md`
- `specs/area/coding-guidelines.md`

発火条件:

- API がある: `api.md`, `validation.md`, `error-policy.md`, `test.md`
- DB、責務境界、依存方向がある: `architecture.md`, `structure.md`, `security.md`
- 入力フォームがある: `validation.md`, `error-policy.md`, `design/ui-patterns.md`
- 外部サービス、外部パッケージ、SaaS がある: `dependencies.md`, `security.md`, 必要なら `gate/legal.md`
- 本番公開予定がある: `observability.md`, `qa.md`, `gate/release.md`
- 実装規約がぶれそう: `coding-guidelines.md`

### Phase 6: Gate Specs

目的: 発火条件に入った公開、法務、インフラ、多言語論点だけ扱う。

読む候補:

- `specs/gate/legal.md`
- `specs/gate/release.md`
- `specs/gate/domain.md`
- `specs/gate/infra.md`
- `specs/gate/i18n.md`

発火条件:

- 個人情報、Cookie、OAuth、メール、外部送信、分析、課金、規約、プライバシーポリシー: `legal.md`
- 本番公開、バージョニング、告知、rollback: `release.md`
- 独自ドメイン、DNS、メール DNS、証明書: `domain.md`
- hosting、環境分離、network、secret 管理: `infra.md`
- 多言語、locale、文言リソース、RTL: `i18n.md`

### Phase 7: Quality Cross-check

目的: 文書反映前に、矛盾、抜け漏れ、品質劣化、正本分担の破綻を確認する。

確認観点:

- Product: 目的、対象ユーザー、価値、MVP、対象外の整合
- UX / Human-centered design: 利用文脈、認知負荷、主導線、状態、エラー時体験
- Accessibility: keyboard、focus、contrast、motion、live region、入力支援
- Software quality: ISO/IEC 25010 系の品質観点、特に機能適合性、性能効率、互換性、使用性、信頼性、セキュリティ、保守性、移植性
- Architecture: 責務境界、依存方向、正本の置き場所、二重管理回避
- Security / Release: 個人情報、認可、secret、公開条件、rollback、監視

## Interview Protocol

ヒアリング形式を絶対遵守する。

- 質問前に、現在の Interview Mode を明示する。
- 原則として 1 回に 1 論点だけ質問する。
- 密接に結びついた論点や、比較しないと判断しづらい論点だけ 2-3 個までまとめてよい。
- 質問前に、現在フェーズ、対象文書、今回の論点、なぜ今聞くか、回答後の扱いを示す。
- 選択肢がある場合だけ、選択肢、メリット、デメリット、推奨案を出す。
- ユーザーが途中で別論点を出したら、回答部分と新論点を切り分ける。
- ユーザー回答が不十分な場合は、勝手に未決扱いせず、追質問、仮決定、後で判断、不要のどれにするか確認する。

質問フォーマット:

```text
現在フェーズ:
対象文書:
今回の論点:
なぜ今聞くか:

質問:

判断観点:

回答後の扱い:
```

回答後の処理:

1. 回答を仕様表現に整える。
2. 既存文書、正本分担、用語、粒度、実装可能性との整合を確認する。
3. 矛盾、品質リスク、デファクトからの逸脱、二重管理、過剰スコープを確認する。
4. ステータスを `決定`、`仮決定`、`後で判断`、`不要`、`別文書へ送る`、`prototypeで検証` のいずれかで提案する。
5. 反映先文書と変更しない範囲を提示する。
6. 次の質問へ進むか、更新提案へ進むかを確認する。

## Quality Intervention Gate

次を検出した場合、即座に文書へ反映しない。懸念、影響、選択肢、推奨案を提示してユーザー確認を取る。

- 既存 specs / design / prototype / 実装方針と矛盾する
- 一般的な設計原則、UX 原則、ソフトウェア品質観点から大きく外れる
- ISO/IEC 25010 系の品質観点で品質劣化につながる
- ISO 9241-210 系の human-centered design 観点で利用者理解や利用文脈が不足している
- セキュリティ、保守性、テスタビリティ、アクセシビリティ、運用性を損なう
- MVP 範囲を不自然に膨らませる
- 詳細仕様を docs に転記し、二重管理になりそう
- prototype で検証すべき不確実性を、根拠なく `決定` 扱いにしている
- ユーザー表現が曖昧で、実装やデザイン時に複数解釈できる

介入フォーマット:

```text
懸念:
影響する品質観点:
放置した場合のリスク:
選択肢:
推奨案:
文書上の扱い:
確認:
```

## Update Proposal

文書更新前に必ず提示する。

- Interview Mode
- 現状分析
- 維持する内容
- 決定事項
- 仮決定
- 後で判断
- 不要
- prototype で検証
- 別文書へ送る論点
- 更新対象ファイル
- 変更しない範囲
- ユーザー確認

ユーザーの明示的な OK が出るまで、`apply_patch` などによるファイル編集を行わない。

## Output

通常のヒアリング中は短く、次を示す。

- 現在フェーズ
- 対象文書
- 今回の論点
- 質問
- 回答後の扱い

更新提案や品質介入時だけ、選択肢、推奨案、反映範囲を詳しく出す。
