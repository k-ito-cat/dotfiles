---
name: web-baseline-check
description: Use when writing or modifying UI in .jsx/.tsx/.html/.css/.scss files or Tailwind class strings. Before implementing common UI patterns (modals, popovers, tooltips, accordions, dropdowns, layout, container queries, parent selectors, etc.), check whether a Baseline-available native HTML/CSS/Web API can replace custom JS or library-based implementations.
---

# Web Baseline Check

UI実装で「自前ハック」「JSでの状態管理」「ライブラリ依存」を書く前に、Baseline到達済みの標準APIで同等の機能が実現できないか必ず確認する。

## 起動条件

- `.jsx` / `.tsx` / `.html` / `.css` / `.scss` / Tailwindクラス文字列を編集する作業に入ったとき
- 「モーダル」「ポップオーバー」「ツールチップ」「アコーディオン」「ドロップダウン」「親要素スタイル変更」「コンテナクエリ」など一般的なUIパターンを実装するとき

## 確認手順

1. 実装しようとしているパターンに該当する標準APIが存在するか、**webstatus.dev または MDN** で確認する
   - https://webstatus.dev （Baseline状態を機械可読に検索）
   - MDNページ最上部の Baseline バッジ
2. Baseline状態を判定する:
   - **Widely available**（全主要ブラウザで30ヶ月以上） → そのまま採用
   - **Newly available**（全主要ブラウザの最新安定版でサポート） → ユーザーに採否を提案して合意を取る
   - **未到達** → 従来パターン

## 報告フォーマット（Newly availableの場合）

ユーザーに以下を提示してから実装に進む:

- 該当する標準API名
- Baseline区分（Widely / Newly）と到達時期
- 採用した場合の利点（コード量、a11y、保守性）
- 採用しない場合の従来パターン
- 推奨案

## 公式優先

- Baseline / API仕様の判断は webstatus.dev / MDN / W3C / WHATWG の一次情報で行う
- 記憶や学習データの古い知識で断定しない（特にBaseline到達時期は変わりやすい）
- WebFetch等で最新情報を取得してから判断する
