---
name: design-workflow
description: Use when the user wants to create or revise UI design, screen design, wireframes, component design, or UI patterns for this repository. Enforce the design-doc workflow by checking docs/specs and docs/design first, identifying undefined items, asking the user clarifying questions instead of guessing, defining screens from specs before components, and blocking visual design until screen list, responsibilities, transitions, and wireframes are grounded in the docs.
---

# Design Workflow

この skill は、このリポジトリでデザイン作業を進めるときの手順を強制する。

## Quick start

- まず `docs/specs/product.md` と `docs/specs/structure.md` を確認する
- 必要に応じて `docs/specs/api.md` を確認する
- 次に `docs/design/` 配下を確認する
  - `DESIGN.md`
  - `foundations.md`
  - `components.md`
  - `ui-patterns.md`
  - `screens.md`
  - `tokens.md`
  - `checklist.md`
- 文書群に未定義項目がある場合は、推測で埋めずにユーザーへヒアリングする

## Workflow

1. 仕様と前提を確認する
   - `docs/specs/product.md`
   - `docs/specs/structure.md`
   - 必要なら `docs/specs/api.md`
2. デザイン文書群の未定義項目を確認する
   - `docs/design/` 配下に未定義や責務の曖昧さがあるか見る
   - 未定義項目はユーザーへヒアリングして決める
3. 仕様を根拠に必要画面を箇条書きで網羅的に列挙する
   - 画面を列挙していて仕様から自然に導けないものが出たら、画面設計を止めて仕様へ戻る
4. 各画面の責務を定義する
5. 画面遷移図を作る
6. ワイヤーフレームを作る
   - この段階では visual design をしない
   - 画面構成、情報の主従、操作位置だけを決める
7. ワイヤーフレームを根拠に必要コンポーネントと UI パターンを洗い出す
   - 必要なら 6 と 7 は往復してよい
8. 文書を根拠に `Layout Gallery` を作る
   - `screens.md` と `layouts.md` を正本にして、画面内のゾーン構成とレスポンシブ時の崩し方を 1 シートで固定する
   - ここではコンポーネント中身ではなく、面の分割、幅配分、主従、補助面の扱いを視覚化する
9. 文書を根拠に `Component Gallery` を作る
   - `components.md` を正本にして、状態差、サイズ差、パターン差が認識ずれなく伝わる 1 シートを作る
   - これは見本集ではなく、実装と画面構築のための正本として扱う
10. foundations / tokens の未定義が visual design に影響しないか確認する
11. 画面デザインへ進む
12. 各段階で差分を `docs/design/` 配下へ還元する
   - すぐ更新しない場合も、更新要否と未更新理由を明示する

## Hard rules

- 文書未確認のまま Pencil や画面デザインへ進まない
- 未定義項目を勝手に補完しない
- ヒアリングで合意していない内容を推測で反映しない
- 仕様を暗黙補完したまま画面一覧を確定しない
- 画面一覧、画面責務、画面遷移図、ワイヤーフレームがない状態でコンポーネント設計や画面デザインへ進まない
- `Layout Gallery` と `Component Gallery` を経ずに visual design へ進まない
- ワイヤーフレーム段階で visual design をしない
- `Layout Gallery` ではコンポーネント詳細に入りすぎない
- `Component Gallery` では画面固有レイアウトの都合を混ぜない
- wireframe の更新後は `docs/design/` 配下への還元要否を必ず判断する
- `docs/design/` を未更新のまま次段階へ進む場合は、未更新理由を明示する
- Workflow の段階を飛ばして進む場合は、例外理由を明示する
- 文書群と不整合なデザインを作らない

## Read in this order

1. `docs/design/checklist.md`
2. `docs/design/DESIGN.md`
3. `docs/design/foundations.md`
4. `docs/design/screens.md`
5. `docs/design/layouts.md`
6. `docs/design/components.md`
7. `docs/design/ui-patterns.md`
8. `docs/design/tokens.md`

## When to stop and ask

- 仕様から画面が自然に導けない
- 画面は定義できるが、責務の切り方が複数ありうる
- Layout と screen responsibility の境界が曖昧
- どの UI パターンを採るかで要件解釈が変わる
- foundations や tokens に未定義項目があり、視覚化判断に影響する

## Output expectations

- まず不足している前提を指摘する
- 必要ならヒアリングで決める
- 画面一覧を先に固定する
- その後に画面責務、遷移、WF、Layout Gallery、Component Gallery へ進む
- 今どの Workflow 段階にいるかを短く明示する
- 参照した文書と更新対象文書を必要最小限で明示する
- デザイン案を出すときは、どの文書根拠に従っているかを意識する
