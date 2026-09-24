---
name: project-documents-interview
description: Use when the user wants to fill, organize, or evolve project documents, spec, design documents, requirements, or unanswered docs sections through structured interviews after project-documents setup is complete. Use for requests like docsを埋めたい, 仕様を埋めたい, デザイン文書を埋めたい, 要件を整理したい, or prototype前に前提を固めたい.
---

# Project Documents Interview

setup 済みの project-documents に対して、`spec/` と `design/` をヒアリング形式で具体化する。

この skill の目的は、template の空欄を埋めることではない。専門家観点で論点を網羅的に発見し、各論点をステータス表のいずれか、または振り分け先（`別文書へ送る`、`prototypeで検証`）に分類し、品質、意図、判断の再現に必要な内容だけを文書化する。

ステータスの定義は `project-documents/documentation-policy.md` の「ステータス」表を正本とし、この skill では列挙しない。文書にはIDだけを記し、会話では表のラベルで呼ぶ。個別の扱いを定める規則はIDで参照する。

## Trigger

- ユーザーが docs、仕様書、spec、design docs、要件、未定義項目を埋めたいと言った
- `project-documents-setup-workflow` の setup / inspect が完了し、仕様やデザイン文書の具体化へ進む
- prototype 作成前に、仕様、画面、状態、UI / UX 判断の前提を固めたい
- 既存 docs の未決事項をヒアリングで整理したい

setup が未完了、`docs` path の正本が不明、または project-documents 実体が確認できない場合は、この skill では文書を埋めず、`project-documents-setup-workflow` に戻す。

## Operating Model

- 情報の置き場所はdocs READMEから共通運用へ辿る。要求、設計判断、実装上の定義、デザイン、運用手順、未決事項を分ける。設計判断はまずADRへの移譲を検討し、現在の判断だからという理由でspecへ再掲しない。依存一覧・構成ツリー・実装済み詳細を再作成しない。
- 未実装の設計と未決事項は引き継ぎ先が確認できるまで保持する。Storybook は任意の後続作業とし、components の情報は対象実装・stories・説明への対応と表示・操作を確認できた範囲だけ移す。

- `docs/README.md`をプロダクト固有の文書地図とし、共通運用への参照に従う。
- 文書の型と採用条件は `project-documents/documentation-policy.md` に従う。既存の分割文書はプロダクトREADMEから辿り、任意文書を一律に要求しない。
- `design/` はデザインファイル作成のためではなく、prototype と実装が迷わないための UI / UX 判断の正本として扱う。
- `prototype/`は検証道具。採用する要求はspec、デザインはdesign、設計判断はADRへ接続する。
- code、OpenAPI、schema、migration、test、生成物が正本になる詳細を docs に転記しない。
- ユーザー回答をそのまま転記しない。仕様表現に整え、矛盾、品質リスク、粒度、正本分担を確認してから反映する。
- ユーザー合意前にファイル編集しない。

## Required Start Checks

最初にdocs/README.mdを読み、共通運用と今回の論点に必要な要求・デザイン・成果物へ進む。新規文書を採用する時は方針ファイルの「採用する文書」を参照する。全雛形・全仕様書・全ADRを一括読込しない。

その後、既存文書の状態を確認し、対象項目を次に分類する。

- `ready`: すでに十分
- `needed-now`: 今決めないと設計、prototype、実装、品質判断に影響する
- `later`: 判断タイミングが来ていない
- `blocked`: ユーザー判断や外部情報がないと進めない
- `out-of-scope`: この workflow では扱わない

## Interview Modes

既に合意した運用方針に沿う情報の移動・重複整理だけなら `documents-sync-workflow` を使う。新しい仕様判断が必要な論点だけ、このヒアリングへ戻す。

start checks の後、必ず作業モードを決める。ユーザーが明示していない場合は、既存文書の状態を見て推奨モードを提示し、確認してから進める。

### New Mode

docs が空、またはほぼ未定義の場合に使う。

- Phase 1 から順にヒアリングする。
- 既存文書があっても、判断材料として読む。
- 最初から全項目を埋めようとせず、今必要な論点だけ扱う。
- 判断できない項目は `DS04`、不要な項目は `DS05` に分類する。

### Fill Undefined Mode

既存文書は概ね使えるが、`DS01`、`DS04`、blocked、保留論点を埋めたい場合に使う。

- 既存の `DS03` / `DS02` は原則として維持する。
- `DS01`、`DS04`、矛盾、品質リスクがある項目だけ扱う。
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

## Reference Routing

全 reference を一括で読まない。現在のフェーズで必要なものだけ読む。

- プロダクト定義、スコープ、機能・品質要求、用語、未決事項: `references/product-and-requirements.md`
- アーキテクチャ、API契約、validation、error、実装規則: `references/architecture-and-contracts.md`
- ブランチ戦略、変更の流れ、リリース、環境変数の管理手法: `references/development-workflow.md`
- デザイン基礎、画面・状態、部品、pattern、token、デザインレビュー: `references/design-review.md`

### Phase 1: Core Spec Foundation

目的: design と requirements に進むための土台を作る。

参照先: プロダクトREADMEから目的・価値・スコープの文書を辿り、`references/product-and-requirements.md` の必要な観点だけ使う。必要な用語・技術前提は既存の文書・設定・ADRを参照する。

主なヒアリング観点:

- 何をなぜ作るか
- 対象ユーザー、対象外ユーザー
- 利用文脈、利用頻度、代替手段
- 提供価値、価値が崩れる条件
- MVP、対象外、後回し、制約
- 対応環境、レスポンシブの最低範囲
- サービス名、主要用語、操作語彙、表記揺れ禁止
- 既に決まっている技術前提と、今は決めない技術領域

技術前提はUI / UX、prototype、実装判断に影響する範囲だけ確認する。設計判断はADRへ分担し、tech.mdを作る前提にしない。

### Phase 2: Functional Scope

目的: 作るものと、失敗すると価値や品質が落ちる範囲を決める。

参照先: 要求の入口と、今回必要な機能・品質条件の本文。分割方式はプロダクトREADMEに従い、`references/product-and-requirements.md` の必要な観点だけ使う。

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

目的: `design/` に進むための spec 側入力条件を揃える。

確認元: プロダクト定義・スコープ・関連する機能要求と品質条件。ファイル配置はプロダクトREADMEから辿る。

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

不足している場合は `design/` へ進まず、spec 側で追加ヒアリングする。

### Phase 4: Design Documents

目的: prototype と実装が迷わない UI / UX 判断を残す。

参照先: designの入口から今回必要な原則・画面・状態・部品・トークンの説明へ進み、`references/design-review.md` の必要な観点だけ使う。UIプロダクトでは原則の文書化が必要だが、全デザイン雛形の採用は要求しない。

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

tokenの意味と使い分けを文書化し、移行済みの実装値は転記しない。共通チェックはSkillへ分担し、既存の固有チェックは引き継ぎ確認まで保持する。

### Phase 5: Technical / Area Decisions

目的: 必要な技術・品質・運用論点を確認し、保存先を決める。文書の存在や新設を目的にしない。

参照先: `references/architecture-and-contracts.md` のうち、今回の技術境界に関係する観点だけ使う。

- API: 契約の編集元と生成方向、validation境界、エラー、互換性、検証。
- DB・アーキテクチャ: 業務要求、責務・依存境界、整合性、通信、障害分離。
- 入力・UI: 状態、保存・復元、失敗時体験。
- 外部サービス・依存: 採用判断、制約、更新と安全性。
- 実装規則: 検査設定で表現できる部分と固有の文章規則。
- 開発ワークフロー: ブランチ戦略、変更の流れ、リリース、環境変数の管理手法を確認し、`spec/development-workflow.md` へ振り分ける。

契約・データ構造・権限・状態遷移・実値などツールや成果物で定義できるものは、`project-documents/documentation-policy.md` の「文章以外で定義するもの」に従って正本を選ぶ。要求・ADR・成果物へ振り分け、それでも独立した説明が必要な場合だけ方針ファイルの「採用する文書」から雛形を採用する。置き場所は`project-documents/documentation-policy.md` の「内容を書く場所の決め方」に従う。既存のapi.mdやstructure.mdを存続させるために役割を作らない。

### Phase 6: Release / Operational Concerns

目的: 該当する公開・運用論点を確認する。共通監査はrelease-readiness-auditの必要なreferenceを使う。

- 個人情報・Cookie・OAuth・メール・外部送信・分析・課金: 固有要求、公開文書、例外と未決事項。
- 本番公開・バージョニング・告知・rollback: CI等の定義、固有の実行条件と手動手順。
- ドメイン・DNS・証明書、hosting・環境分離・network・secret: 構成定義、判断、残る手動運用。
- 多言語・locale・文言・RTL: 対象範囲、デザイン、文言リソース、設計判断。
- 監視・ログ・復旧: 品質要求、設定、初動と復旧手順。

監査が必要であることと、領域別文書が必要であることを区別する。バージョニング・環境分離・secretの運用方針は `spec/development-workflow.md` に置き、この Phase では公開・運用上の監査だけを扱う。

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
- ユーザー回答が不十分な場合は、勝手に未決扱いせず、追質問、`DS02`、`DS04`、`DS05` のどれにするか確認する。

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
4. ステータス表のいずれか、または振り分け先（`別文書へ送る`、`prototypeで検証`）で提案する。
5. 反映先文書と変更しない範囲を提示する。反映先は`project-documents/documentation-policy.md` の「内容を書く場所の決め方」に従って既存の雛形の節・項目から選ぶ。
6. 次の質問へ進むか、更新提案へ進むかを確認する。

## Quality Intervention Gate

次を検出した場合、即座に文書へ反映しない。懸念、影響、選択肢、推奨案を提示してユーザー確認を取る。

- 既存 spec / design / prototype / 実装方針と矛盾する
- 一般的な設計原則、UX 原則、ソフトウェア品質観点から大きく外れる
- ISO/IEC 25010 系の品質観点で品質劣化につながる
- ISO 9241-210 系の human-centered design 観点で利用者理解や利用文脈が不足している
- セキュリティ、保守性、テスタビリティ、アクセシビリティ、運用性を損なう
- MVP 範囲を不自然に膨らませる
- 詳細仕様を docs に転記し、二重管理になりそう
- prototype で検証すべき不確実性を、根拠なく `DS03` にしている
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
- ステータスごとの論点（`DS03`、`DS02`、`DS04`、`DS05`。見出しはステータス表のラベルで示す）
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
