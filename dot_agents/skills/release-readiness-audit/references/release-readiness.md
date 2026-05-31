# Release Readiness Audit

## 目的

公開前・リリース前に、全 PJ 共通で落としやすいリスクを監査する。リリースフローそのものを定義せず、公開してよい状態かを確認する。

PJ 固有の公開対象、判断者、リリースフロー、確認環境、rollback 手順、告知方針は `release.md` に残す。

## 読むもの

- `release.md`, `domain.md`, `infra.md`, `observability.md`, `legal.md`, `security.md`, `qa.md`, `test.md`
- deploy/hosting config, CI/CD workflow
- DNS/domain/mail DNS docs
- app routes, 404/500, auth flow, major user journeys
- monitoring/logging config

## 公開前監査

### 環境 / deploy

- production, staging, preview の区別があるか。
- production env が設定済みで、public/private env 境界が確認済みか。
- deploy target、build command、runtime version、migration 実行順序が確認されているか。
- rollback または緊急停止の手段があるか。

### Domain / DNS / HTTPS

- 本番ドメイン、apex/www、redirect、canonical が確認されているか。
- HTTPS と証明書自動更新が有効か。
- HSTS / preload の採用有無が判断されているか。
- DNS provider、TTL、変更権限が分かるか。

### Cookie / session / headers

- production cookie が `Secure` 前提で動くか。
- SameSite、CSRF、CORS、CSP、security headers が確認済みか。
- preview/staging の緩い設定が production に入らないか。

### 主要導線

- signup/login/logout/account recovery/account deletion など認証導線を確認しているか。
- CRUD、検索、import/export、upload、決済などプロダクトの主要導線を確認しているか。
- 404/500/offline/permission denied/validation error が壊れていないか。
- 成功表示と実データが一致するか。

### Mail / external service

- メール送信がある場合、SPF/DKIM/DMARC と送信元ドメインを確認しているか。
- OAuth provider、payment provider、analytics、monitoring、storage の production 設定が確認済みか。
- 外部サービス障害時の縮退やユーザー表示があるか。

### SEO / crawling / metadata

- robots、sitemap、canonical、noindex、OGP、favicon、apple-touch-icon、manifest の要否を確認しているか。
- `<html lang>` が正しく指定されているか (多言語 PJ では locale ごとに変えているか)。
- title タグと meta description が全ページに設定されているか (テンプレ + 動的生成のフォールバック含む)。
- OGP (og:title / og:description / og:image / og:url) と twitter:card が設定されているか。動的画像生成の方針があるか。
- private/preview/staging が index されないか (環境別の noindex / robots.txt / Basic 認証)。
- エラーページ (404 / 500) が適切な HTTP status code を返し、または noindex 付与で検索結果に混入しないか。
- 検索結果ページ、フィルタ後の一覧ページ、無限スクロール等が重複コンテンツや薄いコンテンツとして index されないか (noindex / canonical)。
- public page が必要な場合、最低限の meta があるか。
- 公開時に Google Search Console / Bing Webmaster Tools への登録と所有権検証が完了しているか。
- ユーザー依存データ (ログイン後画面、user-specific response) を CDN / KV / shared cache に永続化していないか。キャッシュキーに user 識別子が含まれているか、または `Cache-Control: private` が効いているか。

### Accessibility / performance

- 主要導線で keyboard、focus、accessible name、form error、modal/menu の最低ラインを確認しているか。
- LCP/INP/CLS、bundle size、画像、font、API latency など公開後に問題化しやすい点を確認しているか。

### Monitoring / logs / incident

- 初日監視対象、アラート、問い合わせ導線、障害時の初動があるか。
- logs に secret/PII が出ないことを確認しているか。
- deploy 直後に確認する dashboard や smoke test があるか。

### Legal / privacy

- 個人情報、Cookie、外部送信、分析、課金、メール、OAuth がある場合、`privacy-legal.md` の監査を通しているか。
- プライバシーポリシー、利用規約、同意 UI の要否が未定義のまま公開されないか。

### Known issues / release notes

- 既知課題が公開可否に影響するか分類されているか。
- ユーザー向け告知や変更履歴が必要か確認しているか。
- feature flag / kill switch の初期値が本番想定になっているか。

## Critical blocker 例

- production secret が client に露出する。
- 認可 bypass がある。
- account deletion や payment など破壊的操作が戻せず、確認もない。
- production DB migration/backup/rollback が未確認で、失敗時に復旧不能。
- 個人情報を扱うのに privacy/legal の判断が未定義。

## docs に残すべきもの

- リリース判断者、公開対象、公開しない範囲
- 確認環境、承認、deploy、rollback の PJ 固有方針
- 公開不可条件、公開後でもよい条件
- 既知課題、保留、リスク受容

## docs から外す候補

汎用的な公開前 checklist の詳細は docs から外し、この reference を参照する。docs には PJ 固有の公開条件だけ残す。
