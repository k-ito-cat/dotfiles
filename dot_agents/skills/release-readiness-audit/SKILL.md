---
name: release-readiness-audit
description: Audit release and launch readiness across security, public environment variables, privacy/legal triggers, dependencies, QA/test, observability, web-client risks, and operational blockers before exposing a service to users. Use when reviewing project-documents specs/templates, preparing a service release, checking whether common checklist items are satisfied, or deciding whether a concern belongs in a reusable audit skill instead of PJ-specific docs.
---

# Release Readiness Audit

サービスをユーザーに公開・リリースする前に、全 PJ 共通で見るべき品質、セキュリティ、公開準備、観測性、復旧リスクを監査する。

この skill は仕様を定義しない。`docs/specs` に書くべき PJ 固有判断と、全 PJ 共通の監査観点を分離し、実装・設定・CI・env・package・docs を横断して「満たしているか」を確認する。

## 前提

- 個人開発を主対象にする。チーム向けの承認フローや厳格な役割分担は、必要な場合だけ PJ 側 docs に残す。
- 全 PJ で共通するチェックリストや診断観点は docs に定義しない。この skill に置く。
- PJ 固有の採用方針、例外、責任者、実際の窓口、公開範囲、未決事項、リスク受容だけを `docs/specs` に残す。
- 監査結果によって PJ 固有判断が必要になった場合だけ、関連 specs の更新候補として報告する。

## 使い方

1. 依頼の目的を分類する。
   - `change audit`: 実装差分、PR、設計変更の監査
   - `release audit`: 公開前、リリース前の監査
   - `security audit`: セキュリティ重点監査
   - `docs audit`: specs/template に共通チェックが残っていないかの監査
   - `full audit`: 複数領域を横断する監査
2. 対象リポジトリ、`docs` symlink、`project-documents/<project>`、実装、設定、package、CI、env サンプルを確認する。
3. 必要な reference だけ読む。
4. 事実、リスク、推奨、docs 更新要否を分けて報告する。
5. 仕様変更や docs 更新が必要な場合は、反映前にユーザー合意を得る。

## Reference Routing

- セキュリティ全般、認証、認可、Cookie、CSP、CORS、秘密情報、PII、監査ログ: `security.md`
- client に公開される env、`VITE_`、`NEXT_PUBLIC_`、`PUBLIC_`、bundle 混入: `public-env.md`
- 公開前チェック、DNS、HTTPS、メール DNS、SEO、rollback、feature flag: `release-readiness.md`
- 個人情報、Cookie、外部送信、分析、課金、規約、プライバシーポリシー: `privacy-legal.md`
- npm/package、外部 SaaS、SDK、lockfile、更新運用、供給網リスク: `dependencies.md`
- QA 観点、テスト戦略、境界値、状態遷移、回帰、AI へのテスト依頼前確認: `qa-test.md`
- ログ、監視、アラート、障害検知、初動、復旧: `observability-ops.md`
- Web client 特有の storage、CSRF、URL、upload、analytics、a11y、performance: `web-client.md`

## 監査で見る情報源

対象に応じて、次を広く確認する。

- `README.md`, `specs/README.md`, 関連 specs
- `package.json`, lockfile, workspace 設定
- framework config: Vite, Next.js, SvelteKit, Astro, Vercel, Netlify など
- `.env.example`, `.env.*.example`, `.env.1password`, CI secret 設定の参照記述
- auth/session/middleware/router/API/client code
- DB schema, migration, validation schema, OpenAPI, generated client
- CI/CD workflow, deploy config, hosting config
- README, release docs, monitoring docs

秘密情報そのものを要求しない。実値が必要に見えても、名前、配置、参照方法、公開境界、検証方法だけを見る。

## Severity

- `Critical`: secret 漏洩、認可 bypass、公開前 blocker、個人情報漏洩、データ破壊につながる
- `High`: 公開サービスで攻撃面や法務/運用事故に直結しやすい
- `Medium`: 条件次第で事故になる、または検出・復旧が困難になる
- `Low`: 改善推奨、将来の保守性や監査性に影響する
- `Info`: 確認済み事実、docs 更新候補、保留メモ

## Output

監査結果は簡潔に、次の順で出す。

```md
## Findings

- [Severity] タイトル
  - 確認した事実:
  - リスク:
  - 推奨:
  - 参照:
  - docs 更新要否:

## 確認済み

## 追加確認が必要

## docs に残すべき PJ 固有判断

## docs から Skill 参照へ寄せる候補
```

問題がない場合も、確認範囲と未確認範囲を明示する。

## Boundary

- この skill は一般的な監査観点を提供する。法的助言、脆弱性診断サービス、侵入テストの代替ではない。
- PJ 固有の仕様を勝手に確定しない。
- 共通チェックを docs に戻さない。docs には PJ 固有判断、例外、未決事項、監査結果から生じた判断だけを残す。
- 依存追加の詳細評価が主題の場合は `package-addition-check` も使う。
- docs と実装の同期判断が主題の場合は `documents-sync-workflow` も使う。
