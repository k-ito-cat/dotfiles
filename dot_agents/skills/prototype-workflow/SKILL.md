---
name: prototype-workflow
description: Use when creating or revising high-quality disposable browser prototypes under project-documents/<project>/prototype. Treat the prototype README and template prototype directory as the source for setup details, expose specification gaps, validate UI/UX states and interactions, and classify drift between prototype, specifications, and design without automatically making the prototype authoritative.
---

# Prototype Workflow

プロジェクト文書配下に、使い捨て前提の高品質なブラウザプロトタイプを作る。

## 目的

- 仕様・デザインだけでは見つけづらい UI/UX 体験の穴を見つける。
- 考慮できていない画面状態、空状態、エラー状態、密度、レスポンシブ、操作導線を洗い出す。
- 必要な UI スタックやコンポーネント構成に抜けがないか確認する。
- インタラクション、状態遷移、操作感をブラウザ上で具体的に確認する。
- 軽量に作るが、確認品質を落とさない。

## Documentation Operating Model

- prototype は仕様書の代替ではなく、体験確認と仕様判断のための検証材料として扱う。
- 仕様書は現時点で合意された判断、prototype は体験検証の証拠、本実装は最終挙動の正本として扱う。
- prototype の細部をそのまま仕様書や design 文書へ転記しない。
- ドキュメント / 仕様書には、prototype で何を検証するか、何を採用したか、何を捨てたか、本実装へ持ち込む判断、未決事項だけを残す。
- 仕様、スコープ、責務境界、品質上の最低ライン、詳細の正本、未決事項が変わった場合だけ、関連するドキュメント / 仕様書を更新する。

## 正本

- プロジェクト側 prototype: `project-documents/<project>/prototype/`
- 正本テンプレート: `project-documents/_template/prototype/`
- docs 全体の運用原則: `project-documents/_template/README.md`
- プロトタイプ方針: `project-documents/_template/prototype/README.md`
- 仕様文書地図: `project-documents/_template/specs/README.md`
- デザイン文書地図: `project-documents/_template/design/README.md`

## 手順

1. 対象プロジェクトと確認したい体験、画面状態、操作導線を特定する。
2. `docs/README.md` を確認し、docs 全体の正本分担、更新条件、prototype から戻す基準を確認する。
3. 関連する `specs/` と `design/` を確認し、各 README の文書地図に従ってプロトタイプで扱う範囲の正本を特定する。
4. `project-documents/<project>/prototype/` がなければ、`project-documents/_template/prototype/` から用意する。
5. `prototype/README.md` に目的、確認観点、未検証のリスクを短く残す。
6. `Vite + Svelte + daisyUI + @lucide/svelte` を標準として実装する。
7. 見た目と操作感に必要な状態・データ・インタラクション・分岐は省略しない。
8. API、認証、本格永続化、例外処理は原則作らない。
9. 必要に応じて `npm run build` で確認する。
10. プロトタイプ作成中・作成後に、仕様書 / design 文書 / prototype の乖離を分類する。
11. 乖離がある場合は判断イベントとして扱い、仕様書が正か、prototype の判断を採用するか、未決事項として保留するかを決める。

## Prototype Sync Gate

- Prototype は、仕様書や design 文書では見えなかった未定義事項が最も露出しやすい工程として扱う。
- Prototype に存在する状態、操作、文言、画面、分岐、データ、UI パターンが、仕様書や design 文書に存在しない場合は、すぐに文書更新せず、乖離として分類する。
- 乖離を見つけた場合は、仕様書が正か、prototype の判断を採用するか、prototype 限定の検証要素として残すか、保留にするかを決める。
- prototype の判断を採用する場合は、採用した判断、本実装へ持ち込むこと、未決事項をドキュメント / 仕様書へ最小限だけ残す。
- 仕様書未更新のまま prototype だけが採用判断の正になっている状態を完了扱いしない。

## Prototype Drift Classification

Prototype 作成中・作成後は、仕様書 / design 文書 / prototype の差分を次に分類する。

- 仕様書にあり、prototype にもある: 問題なし。
- 仕様書にあるが、prototype にない: prototype 未実装、意図的対象外、または prototype 範囲外かを判断する。
- prototype にあるが、仕様書にない: 仕様不足、prototype 都合、検証仮説、余計な機能追加のどれかを判断する。
- prototype と仕様書が矛盾している: どちらを正とするか判断し、必要なら `documents-sync-workflow` に従ってメンテナンスする。

乖離時の判断:

- 仕様書が正しい場合は、prototype を修正、対象外化、または破棄する。
- prototype がより良い判断を示している場合は、仕様書または design 文書を更新してから、その判断を正とする。
- まだ判断できない場合は、未決事項として保留理由、影響範囲、判断タイミングを残す。

## 品質方針

- Prototype の品質は、本実装品質ではなく仕様確認品質として扱う。
- 重視するものは、仕様 / design との同期、AI readable な構造、主要状態と操作導線の可視化、ブラウザでの操作確認、必要に応じた build 成功である。
- a11y 完備、performance 最適化、production-ready な抽象化、網羅的テスト、厳密な例外処理は原則対象外とする。
- lint / framework warning は、操作確認、表示確認、仕様同期、AI readability を妨げる場合だけ対応する。
- プロトタイプ品質を理由に、仕様確認に不要な作り込みを増やさない。
- 行数・ファイル数は制約にしない。
- ライブラリ選定で不要な記述量を減らすが、品質・網羅性を犠牲にしない。
- daisyUI theme を定義し、既製品感を抑える。
- アイコンは `@lucide/svelte` を使う。
- モックデータは汎用的で、ダミー用途だと分かる内容にする。
- 空状態、選択状態、確認状態、メニュー、モーダル、トーストなど、体験判断に必要な UI 状態を用意する。
- 本実装への流用は前提にしない。
- 古い prototype は正本扱いせず、`検証中`、`採用方針あり`、`本実装反映済み`、`破棄` のいずれかの状態で扱う。

## 必須ルール

- プロトタイプは `project-documents/<project>/prototype/` 配下に 1 つ置く。
- プロジェクト直下や `project-documents` 直下に横断プロトタイプを置かない。
- prototype の具体ファイル構成は `project-documents/_template/prototype/` と `README.md` を正本とし、この skill 内で固定しない。
- 品質を落として軽量化しない。
- 仕様書と矛盾する UI/UX をプロトタイプに入れない。
- 仕様書未定義の挙動をプロトタイプだけで既成事実化しない。
- prototype と仕様書が乖離した場合に、prototype を自動的に正としない。
