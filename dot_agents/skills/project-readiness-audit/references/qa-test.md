# QA and Test Audit

## 目的

AI にテストコードや確認手順を作らせる前、または変更レビュー時に、正常系だけへ偏らず、境界条件・状態遷移・例外系・権限・実運用事故パターンを監査する。

PJ 固有の主要導線、受け入れ基準、既知課題、QA 環境差分、テスト戦略の採用方針は `docs/specs/qa.md`, `test.md`, `acceptance.md` に残す。

## 読むもの

- `docs/specs/requirements/functional.md`, `acceptance.md`, `qa.md`, `test.md`, `validation.md`, `error-policy.md`, `security.md`
- related tests, test utils, fixtures, mocks
- API/client/schema implementation
- UI routes and state management

## 監査観点

### テスト依頼前

- 何を守りたい変更かを一文で説明できるか。
- 正常系、異常系、境界条件、権限、通信失敗、再試行、二重送信、戻る操作を含めたか。
- 期待する観点整理を先に依頼し、すぐコード生成へ進んでいないか。
- 実装詳細に引きずられた brittle test になっていないか。

### 入力・境界値

- null、undefined、空文字、未入力、空配列、重複、最大/最小、桁数、文字種、timezone を確認しているか。
- trim/normalize の有無が validation 方針と一致しているか。
- 同値分割と境界値分析で代表ケースを選べているか。

### 状態遷移

- 作成、更新、削除、復元、取り消し、再送、タイムアウト、部分失敗の遷移を確認しているか。
- 許可されない遷移を test/guard/API で防げるか。
- optimistic update と実データの不一致を検出できるか。

### 認証・認可

- 未認証、期限切れ、権限なし、他ユーザー resource、削除済み resource を確認しているか。
- UI 非表示だけでなく API 側の拒否を確認しているか。
- import/export/search/bulk operation で権限漏れがないか。

### API / schema / client 契約

- request/response schema、OpenAPI、generated client、UI 利用箇所が同期しているか。
- validation error と error response の分岐キーが UI で利用できるか。
- pagination/cursor/filter/sort 条件変更時の挙動を確認しているか。

### Test level

- pure logic は unit、境界をまたぐ挙動は integration、主要導線は E2E に寄せられているか。
- E2E が多すぎて遅く壊れやすくなっていないか。
- mock/stub が実環境と乖離しすぎていないか。
- flaky test の隔離、再試行、修正方針があるか。

### a11y / VRT / browser

- keyboard、focus、accessible name、form error、modal/menu/popover、reduced motion を主要導線で確認しているか。
- visual regression を採用する場合、安定した比較対象と許容差があるか。
- browser/device 差分を必要な範囲で確認しているか。

## 危険パターン

- AI に「テスト書いて」とだけ依頼し、観点整理がない。
- happy path の snapshot だけ増える。
- API mock が成功しか返さない。
- auth/permission の test が UI 表示だけ。
- flaky を retry だけで隠す。

## docs に残すべきもの

- PJ 固有の主要導線と回帰対象
- Ready/Done、公開可否、受け入れ基準
- テストレベルごとの責務、品質ゲート、採用ツール
- 既知課題、保留、QA 環境差分

## docs から外す候補

同値分割、境界値、二重送信、戻る操作、通信失敗などの汎用 checklist は docs から外し、この reference を参照する。
