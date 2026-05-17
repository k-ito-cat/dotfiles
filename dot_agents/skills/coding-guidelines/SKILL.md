---
name: coding-guidelines
description: Use when writing or modifying code in any language. Universal implementation principles — change scope discipline, consistency with existing code, readability, correctness, testing and verification, dependency and compatibility judgment, security basics, and dummy data conventions. Project-specific conventions live in project-documents specs, not here.
---

# Coding Guidelines

コードを書く・変更するときに、どのプロジェクトでも成り立つ上位原則を固定する。

プロジェクト単位の具体規約（スタイル、命名ケース、フレームワーク作法など）は project-documents の spec を正本とし、この skill には置かない。この skill は上位原則のみを扱う。

## 変更スコープの規律

- 1つの作業で目的を混ぜない。機能追加・仕様変更・挙動変更・バグ修正は分ける。
- 最小差分を保つ。依頼範囲外の「ついで改修」「ついで最適化」をしない。
- デッドコードやコメントアウトした残骸を残さない。
- コメントは追加しない。既存のコメントは削除せず維持する。

## 既存コードへの一貫性

- 周辺コードの命名・構造・イディオム・エラー処理パターンに合わせる。
- 既存の抽象・ユーティリティ・ヘルパーを再利用し、車輪の再発明をしない。
- README や package.json の既存スクリプト・作法を確認し、導入済みの流儀に従う。

## 可読性・設計判断

- 巧妙さより明快さを優先する。
- 命名は意図を表すものにする。
- 早すぎる抽象化・過度な一般化を避ける。重複排除と過抽象のバランスを取る。
- マジックナンバーやハードコードは、意味と変更可能性に応じて定数・設定へ切り出す。

## 正しさ・堅牢性

- エラーを握り潰さない。失敗は早く明確に扱う（fail-fast）。
- 入力の検証、境界値、null・空・未定義の扱いを意識する。
- 副作用と冪等性を意識する。

## テスト・検証

- テストは目的に沿って書く。カバレッジ稼ぎや形だけのテストを足さない。
- 変更に対する検証手段を通す。JS/TS では、変更が対象スクリプトに関係する場合 `npm run format` / `npm run lint` / `npm run test` を実行する。
- 実装が複雑、影響範囲が広い、依存やビルド周りに触れた場合は `npm run build` も実行する。
- 検証結果は正直に報告する。失敗・スキップを隠さない。

## 依存・互換性

- 依存やライブラリの追加は、標準機能や既存の仕組みで足りないかを先に検討してから判断する。
- 後方互換性と破壊的変更の影響範囲を意識する。
- バージョン依存・変更されやすい挙動は、確認してから扱う。

## セキュリティ基本

- 機密情報（トークン、鍵、パスワード等）をコードに直書きしない。
- 信頼境界、インジェクション、エスケープの基本を守る。

## サンプル・ダミーデータ

- seed、モック、ダミーデータ、表示名は汎用的な内容を使う。個人名、ハンドル、プロジェクト固有情報、実在サービスを強く想起させる具体名は避ける。
- seed、モック、ダミーデータは、ダミー用途だと分かる名前・値を優先する。
