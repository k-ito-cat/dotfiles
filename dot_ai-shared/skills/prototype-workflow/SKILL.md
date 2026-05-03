---
name: prototype-workflow
description: Use when creating or revising high-quality disposable browser prototypes under project-documents/<project>/prototype. Prioritize quality and coverage over lightness to validate UI/UX gaps, screen states, UI stack, and interactions not covered by specs or design.
---

# Prototype Workflow

プロジェクト文書配下に、使い捨て前提の高品質なブラウザプロトタイプを作る。

## 目的

- 仕様・デザインだけでは見つけづらい UI/UX 体験の穴を見つける。
- 考慮できていない画面状態、空状態、エラー状態、密度、レスポンシブ、操作導線を洗い出す。
- 必要な UI スタックやコンポーネント構成に抜けがないか確認する。
- インタラクション、状態遷移、操作感をブラウザ上で具体的に確認する。
- 軽量に作るが、確認品質を落とさない。

## 正本

- 方針・ひな形: `project-documents/<project>/prototype/`
- 正本テンプレート: `project-documents/_template/prototype/`

## 手順

1. 対象プロジェクトと確認したい体験、画面状態、操作導線を特定する。
2. 関連する `specs/` と `design/` を確認し、プロトタイプで扱う範囲の正本を特定する。
3. `project-documents/<project>/prototype` がなければ、`project-documents/_template/prototype` から用意する。
4. `prototype/README.md` に目的、確認観点、未検証のリスクを短く残す。
5. `Vite + Svelte + daisyUI + @lucide/svelte` を標準として実装する。
6. 見た目と操作感に必要な状態・データ・インタラクション・分岐は省略しない。
7. API、認証、本格永続化、例外処理は原則作らない。
8. 必要に応じて `npm run build` で確認する。
9. プロトタイプ作成中・作成後に判明した仕様やデザインの不足を整理し、必要な正本文書を更新する。

## 正本同期

- プロトタイプは自我を出さず、仕様書とデザインを厳守する。
- 仕様書にない挙動、画面状態、情報、文言、導線をプロトタイプだけで確定しない。
- 仕様書に未定義の要素をプロトタイプに反映する場合は、必ず `specs/` も更新する。
- デザインに未定義の UI やレイアウトをプロトタイプに反映する場合は、必ず `design/` の更新要否を判断し、必要なら更新する。
- ユーザーが明示的に気づいていなくても、AI が仕様書やデザインに記載がない事実に気づいた場合は、未定義事項として扱う。
- 後から未定義だったことが発覚した場合も、プロトタイプだけを正として残さず、仕様書を必ずメンテナンスする。
- 仕様書更新が必要な変更を、仕様書未更新のまま完了扱いにしない。

## 品質方針

- 行数・ファイル数は制約にしない。
- ライブラリ選定で不要な記述量を減らすが、品質・網羅性を犠牲にしない。
- daisyUI theme を定義し、既製品感を抑える。
- アイコンは `@lucide/svelte` を使う。
- モックデータは汎用的で、ダミー用途だと分かる内容にする。
- 空状態、選択状態、確認状態、メニュー、モーダル、トーストなど、体験判断に必要な UI 状態を用意する。
- 本実装への流用は前提にしない。

## 必須ルール

- プロトタイプは `project-documents/<project>/prototype/` 配下に 1 つ置く。
- プロジェクト直下や `project-documents` 直下に横断プロトタイプを置かない。
- 品質を落として軽量化しない。
- 仕様書と矛盾する UI/UX をプロトタイプに入れない。
- 仕様書未定義の挙動をプロトタイプだけで既成事実化しない。
