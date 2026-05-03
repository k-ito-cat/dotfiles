---
name: prototype-workflow
description: Use when creating or revising high-quality disposable browser prototypes under project-documents/<project>/prototype. Treat prototypes as a place where specification gaps become visible, validate UI/UX states and interactions, and keep prototype behavior synchronized with specifications and design through documents-sync-workflow.
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
9. プロトタイプ作成中・作成後に、仕様書 / design 文書 / prototype の乖離を分類する。
10. 乖離がある場合は `documents-sync-workflow` の正本判断に従って、仕様書を更新するか、prototype を仕様へ戻すか、prototype 限定の検証要素として残すか、保留にするかを決める。

## Prototype Sync Gate

- Prototype は、仕様書や design 文書では見えなかった未定義事項が最も露出しやすい工程として扱う。
- Prototype に存在する状態、操作、文言、画面、分岐、データ、UI パターンが、仕様書や design 文書に存在しない場合は、成果物と文書の乖離として扱う。
- 乖離を見つけた場合は、`documents-sync-workflow` の正本判断に従って、仕様書を更新するか、prototype を仕様へ戻すか、prototype 限定の検証要素として残すか、保留にするかを決める。
- 仕様書未更新のまま prototype だけが正になっている状態を完了扱いしない。

## Prototype Drift Classification

Prototype 作成中・作成後は、仕様書 / design 文書 / prototype の差分を次に分類する。

- 仕様書にあり、prototype にもある: 問題なし。
- 仕様書にあるが、prototype にない: prototype 未実装、意図的対象外、または prototype 範囲外かを判断する。
- prototype にあるが、仕様書にない: 仕様不足、prototype 都合、検証仮説、余計な機能追加のどれかを判断する。
- prototype と仕様書が矛盾している: どちらを正とするか判断し、必要なら `documents-sync-workflow` に従ってメンテナンスする。

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
