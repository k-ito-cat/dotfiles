# Web Client Audit

## 目的

browser/client 側で起きやすい公開前リスクを監査する。UI/UX の詳細設計ではなく、client で扱うデータ、auth 境界、storage、外部送信、a11y、performance のリスクを見る。

UI/UX 判断や画面責務は design docs に残す。client の一般監査観点はこの reference に置く。

## 読むもの

- frontend source, route/layout/component/state management
- API client, generated client, auth/session handling
- browser storage usage
- analytics/error reporting config
- framework config and env usage
- `security.md`, `legal.md`, `qa.md`, `test.md`, `requirements/non-functional.md`

## 監査観点

### Auth boundary

- client 側の login state は表示制御に留め、認可は server/API で行っているか。
- token/session を localStorage に置く必要があるか。cookie auth の場合 CSRF を確認しているか。
- logout 後に cache、storage、service worker、in-memory state に機密情報が残らないか。

### Browser storage

- localStorage/sessionStorage/IndexedDB/cache に PII や secret を保存していないか。
- theme、view setting、feature flag など public state と user data を分けているか。
- shared device や account switch で前ユーザーの情報が残らないか。

### API client

- API 直叩きが散らばらず、共通 client/adapter で auth/error/timeout を扱っているか。
- timeout、retry、abort、race、double submit を確認しているか。
- generated client と schema の同期が壊れていないか。

### URL / navigation

- redirect destination、return URL、external link、open redirect を確認しているか。
- query param に PII や secret を載せていないか。
- browser history、share URL、copy link に載る情報を意識しているか。

### File / image / external resource

- upload の size/type/count、metadata、preview、storage permission を確認しているか。
- external image や OGP fetch で privacy、mixed content、tracking、SSRF 風の backend proxy リスクがないか。
- object URL の revoke、large file、failed upload の状態を扱っているか。

### Analytics / monitoring

- page view、event、error に PII/secret/raw input を載せていないか。
- consent 前に送信してはいけない event が送られていないか。
- user id の扱いが legal/security docs と整合しているか。

### Accessibility

- icon-only button、menu、modal、popover、toast、form error、loading、empty state に accessible name/role/focus があるか。
- keyboard 操作と focus trap/return が主要導線で確認されているか。
- destructive action は確認または undo があり、keyboard でも扱えるか。

### Performance

- 初期 bundle、画像、font、route splitting、heavy computation、list virtualization を確認しているか。
- loading/error/empty state が性能劣化時にも破綻しないか。
- client-side analytics や third-party script が Core Web Vitals を悪化させていないか。

## 危険パターン

- `isAdmin` や `userId` を client state から信用する。
- localStorage に access token や user data を長期保存する。
- redirect URL を allowlist なしで使う。
- analytics に search query、email、raw error payload を送る。
- UI は消えているが API では操作できる。

## docs に残すべきもの

- client/server の責務境界
- storage に保存してよい PJ 固有データ
- API client の正本と生成物
- analytics/monitoring の採用方針
- design 側で扱う a11y/interaction の PJ 固有判断
