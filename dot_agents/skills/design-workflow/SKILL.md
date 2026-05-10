---
name: design-workflow
description: Use when the user wants to create or revise UI design, screen design, wireframes, component design, or UI patterns for this repository. Check docs/README.md first, then docs/specs and docs/design, use their README files as the document map, identify undefined decisions that affect quality or intent, ask clarifying questions instead of guessing, and keep design docs focused on design intent rather than pixel-level detail.
---

# Design Workflow

この skill は、このリポジトリでデザイン作業を進めるときの判断手順を定める。

## Documentation Operating Model

- design docs は pixel detail の正本ではなく、UI の設計意図、主導線、状態設計、品質上外したくない観点を残す場所として扱う。
- design docs は specs の転記先ではなく、specs で定義された目的、対象ユーザー、利用文脈、制約、未決事項を入力にして UI / UX 判断を設計する場所として扱う。
- specs に design の入力条件が不足している場合は、UI パターン、配置、コンポーネント責務、token を推測で確定しない。
- prototype や本実装で確認できる細部は design docs へ転記しない。
- design docs に残すのは、UI 原則、主導線、状態設計、a11y、破壊的操作、empty / loading / error、レスポンシブ、prototype や本実装へ持ち込む判断に絞る。
- 個人開発では、重い design file より prototype を優先してよい。ただし、prototype で採用した判断は必要最小限だけドキュメント / 仕様書に残す。
- 空欄を埋めること、網羅性を上げること、prototype や実装の細部を転記することを目的にしない。

## Quick start

- まず docs 全体の正本分担と更新条件を `docs/README.md` で確認する
- 次に `docs/specs/` と `docs/specs/README.md` を確認する
- 次に `docs/design/` と `docs/design/README.md` を確認する
- 個別ファイル名や責務は、現プロジェクトの `docs/` と `_template/` 側の README を正本にする
- 文書群に未定義項目がある場合は、今決める必要があり品質や意図に影響するものだけユーザーへヒアリングする

## Workflow

1. 仕様と前提を確認する
   - `docs/README.md`
   - `docs/specs/`
   - `docs/specs/README.md`
   - 必要なら `project-documents/_template/specs/README.md`
   - UI / UX 判断に必要な design 入力条件が specs 側に定義されているか確認する
   - 入力条件が不足している場合は、UI 案を確定せず project-documents-workflow / specs へ戻す
2. デザイン文書群の未定義項目を確認する
   - `docs/design/`
   - `docs/design/README.md`
   - 必要なら `project-documents/_template/design/README.md`
   - 未定義や責務の曖昧さがあるか見る
   - 未定義項目は、今決める必要があり品質や意図に影響する場合だけユーザーへヒアリングして決める
3. 仕様を根拠に、今回の設計判断に必要な画面を箇条書きで列挙する
   - 画面を列挙していて仕様から自然に導けないものが出たら、画面設計を止めて仕様へ戻る
4. 各画面の責務を定義する
5. 画面遷移図を作る
6. ワイヤーフレームを作る
   - この段階では visual design をしない
   - 画面構成、情報の主従、操作位置だけを決める
7. ワイヤーフレームを根拠に必要コンポーネントと UI パターンを洗い出す
   - 必要なら 6 と 7 は往復してよい
8. 文書を根拠に `Component Gallery` を作る
   - `docs/design/README.md` の文書地図でコンポーネント定義の参照元を確認し、状態差、サイズ差、パターン差が認識ずれなく伝わる 1 シートを作る
   - これは見本集ではなく、画面構築時の認識ずれを減らすための判断材料として扱う
9. 視覚方針や実装値の未定義が visual design に影響しないか確認する
10. `docs/specs/` の文書地図に従って、レスポンシブ対応方針と多言語対応方針の正本を確認する
11. 画面デザインへ進む
12. 各段階で差分を `docs/design/` 配下へ還元する必要があるか判断する
   - docs 全体の更新条件は `docs/README.md` に従う
   - 更新が必要なのは、UI 原則、主導線、状態設計、品質上外したくない観点、本実装へ持ち込む判断が変わった場合に限る
   - prototype や実装の細部だけの差分は、design docs へ転記しない

## Hard rules

- 文書未確認のまま Pencil や画面デザインへ進まない
- 未定義項目を勝手に補完しない
- specs 側の design 入力条件が不足しているまま、UI パターン、配置、コンポーネント責務、token を確定しない
- design docs を仕様要望の仮置き場にしない
- ヒアリングで合意していない内容を推測で反映しない
- 仕様を暗黙補完したまま画面一覧を確定しない
- 画面一覧、画面責務、画面遷移図、ワイヤーフレームが不足していて品質や意図の判断ができない状態で、コンポーネント設計や画面デザインへ進まない
- `Component Gallery` が必要な規模や複雑さの場合は、それを経ずに visual design へ進まない
- ワイヤーフレーム段階で visual design をしない
- `Component Gallery` では画面固有レイアウトの都合を混ぜない
- レスポンシブ対応と多言語対応の有無は `docs/specs/` 側の該当文書を正本とし、design 側で勝手に決めない
- wireframe の更新後は `docs/design/` 配下への還元要否を必ず判断する
- `docs/design/` を未更新のまま次段階へ進む場合は、更新条件に該当しないことを明示する
- Workflow の段階を飛ばして進む場合は、例外理由を明示する
- 文書群と不整合なデザインを作らない
- prototype と design docs が乖離した場合、prototype を自動的に正としない。採用する場合は、採用判断だけを design docs または specs に戻す。

## Read in this order

1. `docs/README.md`
2. `docs/design/README.md`
3. `docs/design/`
4. `docs/specs/README.md`
5. `docs/specs/`

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
- 今回の判断に必要な画面範囲を先に固定する
- その後に、必要な範囲で画面責務、遷移、WF、Component Gallery へ進む
- 今どの Workflow 段階にいるかを短く明示する
- 参照した文書と更新対象文書を必要最小限で明示する
- デザイン案を出すときは、どの文書根拠に従っているかを意識する
