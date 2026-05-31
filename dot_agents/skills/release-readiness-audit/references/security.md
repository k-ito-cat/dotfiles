# Security Audit

## 目的

全 PJ 共通のセキュリティ監査観点を扱う。ここでは仕様を決めず、実装・設定・docs が危険な状態になっていないかを確認する。

PJ 固有の認証方式、権限モデル、Cookie 属性、監査ログの保持期間、脆弱性報告窓口、対応目安、開示ポリシーは `security.md` に残す。

## 目次

- 読むもの
- 共通監査観点
  - 脅威モデル
  - 認証
  - 認可 / 権限モデル
  - セッション / Cookie / CSRF
  - 入力 / 出力防御
  - ブラウザセキュリティ
  - 秘密情報
  - PII / 個人情報
  - 監査ログ
  - 脆弱性報告 / 受付
- docs に残すべきもの
- 報告時の観点

## 読むもの

- `security.md`, `legal.md`, `dependencies.md`, `observability.md`, `release.md`
- auth/session/middleware/router/API handler
- DB schema, migration, validation schema
- framework/server config, security headers, CORS/CSP 設定
- `.env*.example`, CI/CD, hosting config
- package manager files and lockfile

## 共通監査観点

### 脅威モデル

- 守る資産が明示されているか。
- 攻撃面が API、browser、auth、storage、file upload、external service、admin/ops に分けて見られているか。
- 個人開発でも、公開サービスなら「攻撃者がいる」前提で扱っているか。
- 想定外の脅威を対象外にする場合、理由と再確認タイミングがあるか。

危険パターン:

- 「個人開発なのでセキュリティは後で」で公開範囲が広がっている。
- DB や storage の ownership 境界が曖昧。
- admin/debug endpoint が公開経路から到達可能。

### 認証

- 登録、ログイン、ログアウト、session refresh、アカウント復旧、認証手段追加/削除の失敗時挙動があるか。
- OAuth / passkey / password を併用する場合、同一ユーザーへの紐付け、重複アカウント、乗っ取り経路を確認しているか。
- メール認証や password reset token に期限、単回利用、漏洩時の影響範囲があるか。
- rate limit、brute force、credential stuffing への最低限の対策を確認しているか。

危険パターン:

- client 表示だけで未認証/認証済みを切り替える。
- OAuth callback の state / nonce / redirect URI の扱いが曖昧。
- アカウント復旧が本人確認を弱める抜け道になる。

### 認可 / 権限モデル

- API / service / repository のどこで最終的に権限判定するかが明確か。
- UI 表示制御を認可の代替にしていないか。
- userId / organizationId / resource owner の照合が保存、取得、更新、削除すべてにあるか。
- IDOR を防ぐため、path/query/body の ID を信用していないか。
- bulk operation、import/export、search、restore、trash で ownership が抜けていないか。

危険パターン:

- `WHERE id = ?` だけで owner 条件がない。
- client から送られた `userId` を信用している。
- 404/403 の扱いで存在確認 oracle を作っている。

### セッション / Cookie / CSRF

- session cookie に `HttpOnly`, `Secure`, `SameSite` をどう設定するか確認しているか。
- cookie auth の state-changing request に CSRF 対策があるか。
- logout、password change、認証手段削除、アカウント削除で session invalidation を確認しているか。
- preview/staging/prod で cookie domain と secure 設定が崩れないか。

危険パターン:

- local dev のために緩めた cookie 設定が production に混ざる。
- CORS 許可と credential 付き request の組み合わせが広すぎる。
- CSRF 対策を CORS だけに依存する。

### 入力 / 出力防御

- HTML、Markdown、URL、file name、image metadata、import data、external API response を信用していないか。
- XSS、SQL injection、open redirect、SSRF、path traversal、file upload abuse の入口を確認しているか。
- validation schema、DB constraint、API boundary、UI validation の責務が分かれているか。
- rich text / HTML 表示がある場合、sanitize と escape の正本があるか。

危険パターン:

- URL 入力を fetch/proxy/screenshot 等に直接渡す。
- redirect destination を allowlist なしで受け取る。
- file upload の MIME/type/size/拡張子/storage permission が未確認。

### ブラウザセキュリティ

- CSP、CORS、security headers、iframe embedding、mixed content、referrer policy を確認しているか。
- analytics、image CDN、OAuth provider、payment provider など外部 origin を把握しているか。
- CSP を導入する場合、report-only から始めるか、blocker を洗い出しているか。
- CORS は必要な origin と method/header に限定しているか。

危険パターン:

- `Access-Control-Allow-Origin: *` と credentials を同時に扱う設計。
- CSP の `script-src 'unsafe-inline'` を恒久運用にする。
- preview domain を広く許可したまま production に残す。

### 秘密情報

- secret は server/runtime/CI に閉じ、client bundle に入らないか。
- `.env`, `.env.local`, `.env.production`, `.env.1password`, CI secrets の責務が分かれているか。
- logging、error reporting、test snapshot、generated output に secret が混ざらないか。
- secret rotation と漏洩時の失効手順があるか。

`VITE_` など client 公開 env の詳細は `public-env.md` を読む。

### PII / 個人情報

- 収集、保存、表示、ログ、監視、分析、外部送信ごとに個人情報の扱いを確認しているか。
- email、name、IP、user agent、auth identifier、OAuth profile、uploaded image metadata が対象に含まれているか。
- error log / audit log / analytics event に PII を載せない基準があるか。
- export/delete/account deletion の仕様と整合しているか。

### 監査ログ

- セキュリティ上意味のある操作を記録できるか。
- 記録しない情報、保持期間、アクセス権限、改ざん対策が PJ 側 docs にあるか。
- auth failure、permission denied、account deletion、credential change、data export、admin operation を検討しているか。

監査ログは「記録すれば安全」ではない。PII や secret を残しすぎると新しいリスクになる。

### 脆弱性報告 / 受付

Skill は受付導線を定義しない。次を監査する。

- 公開サービスとして、脆弱性報告導線が必要か検討されているか。
- 必要な場合、`security.md` に受付窓口、security.txt、対応目安、報奨金有無、開示ポリシー、初動確認者があるか。
- 窓口が個人情報や exploit code を受け取りうる前提で扱われているか。
- 公開前 checklist に受付導線の確認が含まれているか。

## docs に残すべきもの

- 守る資産、想定脅威、対象外リスク
- 採用する認証方式、権限モデル、session/cookie 方針
- CORS/CSP/security header の採用値と例外
- secret 管理場所、rotation 方針
- PII、監査ログ、脆弱性報告窓口の PJ 固有判断

## 報告時の観点

- どの証拠を見て判断したかを明示する。
- 設定値が未確認なら未確認と書く。
- 実装で確認できる詳細を docs に転記しない。docs には方針、例外、未決事項だけを提案する。
