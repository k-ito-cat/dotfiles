---
name: design-workflow
description: Use when the user wants to create or revise UI design, screen design, wireframes, component design, or UI patterns for this repository. Enforce the design-doc workflow by checking docs/specs and docs/design first, using their README files as the document map, identifying undefined items, asking the user clarifying questions instead of guessing, defining screens from specs before components, and blocking visual design until screen list, responsibilities, transitions, and wireframes are grounded in the docs.
---

# Design Workflow

この skill は、このリポジトリでデザイン作業を進めるときの手順を強制する。

## Quick start

- まず `docs/specs/` と `docs/specs/README.md` を確認する
- 次に `docs/design/` と `docs/design/README.md` を確認する
- 個別ファイル名や責務は、現プロジェクトの `docs/` と `_template/` 側の README を正本にする
- 文書群に未定義項目がある場合は、推測で埋めずにユーザーへヒアリングする

## Workflow

1. 仕様と前提を確認する
   - `docs/specs/`
   - `docs/specs/README.md`
   - 必要なら `project-documents/_template/specs/README.md`
2. デザイン文書群の未定義項目を確認する
   - `docs/design/`
   - `docs/design/README.md`
   - 必要なら `project-documents/_template/design/README.md`
   - 未定義や責務の曖昧さがあるか見る
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
8. 文書を根拠に `Component Gallery` を作る
   - `docs/design/README.md` の文書地図でコンポーネント定義の正本を確認し、状態差、サイズ差、パターン差が認識ずれなく伝わる 1 シートを作る
   - これは見本集ではなく、実装と画面構築のための正本として扱う
9. 視覚方針や実装値の未定義が visual design に影響しないか確認する
10. `docs/specs/` の文書地図に従って、レスポンシブ対応方針と多言語対応方針の正本を確認する
11. 画面デザインへ進む
12. 各段階で差分を `docs/design/` 配下へ還元する
   - すぐ更新しない場合も、更新要否と未更新理由を明示する

## Hard rules

- 文書未確認のまま Pencil や画面デザインへ進まない
- 未定義項目を勝手に補完しない
- ヒアリングで合意していない内容を推測で反映しない
- 仕様を暗黙補完したまま画面一覧を確定しない
- 画面一覧、画面責務、画面遷移図、ワイヤーフレームがない状態でコンポーネント設計や画面デザインへ進まない
- `Component Gallery` を経ずに visual design へ進まない
- ワイヤーフレーム段階で visual design をしない
- `Component Gallery` では画面固有レイアウトの都合を混ぜない
- レスポンシブ対応と多言語対応の有無は `docs/specs/` 側の該当文書を正本とし、design 側で勝手に決めない
- wireframe の更新後は `docs/design/` 配下への還元要否を必ず判断する
- `docs/design/` を未更新のまま次段階へ進む場合は、未更新理由を明示する
- Workflow の段階を飛ばして進む場合は、例外理由を明示する
- 文書群と不整合なデザインを作らない

## Read in this order

1. `docs/design/README.md`
2. `docs/design/`
3. `docs/specs/README.md`
4. `docs/specs/`

必要な個別ファイルは各 README の文書地図に従って読む。README がない、古い、または現プロジェクトと食い違う場合は、`project-documents/_template/design/README.md` と `project-documents/_template/specs/README.md` を確認して正本判断する。

## When to stop and ask

- 仕様から画面が自然に導けない
- 画面は定義できるが、責務の切り方が複数ありうる
- どの UI パターンを採るかで要件解釈が変わる
- 視覚方針や実装値に未定義項目があり、視覚化判断に影響する
- レスポンシブ対応や多言語対応の扱いが `docs/specs/` 側で未定義のまま、screen design に影響する

## Output expectations

- まず不足している前提を指摘する
- 必要ならヒアリングで決める
- 画面一覧を先に固定する
- その後に画面責務、遷移、WF、Component Gallery へ進む
- 今どの Workflow 段階にいるかを短く明示する
- 参照した文書と更新対象文書を必要最小限で明示する
- デザイン案を出すときは、どの文書根拠に従っているかを意識する
