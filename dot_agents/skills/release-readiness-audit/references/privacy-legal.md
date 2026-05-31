# Privacy and Legal Trigger Audit

## 目的

公開・実装前に、個人情報、Cookie、外部送信、分析、メール、OAuth、課金などの法務・プライバシー論点が未定義のまま進んでいないかを監査する。

この reference は法的助言ではない。法的判断が必要な場合は、AI だけで確定せず、未決事項として残す。

## 読むもの

- `legal.md`, `security.md`, `observability.md`, `dependencies.md`, `release.md`
- auth/profile/account code
- analytics/error reporting/monitoring config
- cookie/storage usage
- external service integrations
- mail/payment/OAuth provider settings

## 発火条件

次を扱う場合は privacy/legal 監査を必ず行う。

- email, name, user id, profile image, IP address, user agent
- OAuth / passkey / password / account recovery
- Cookie, localStorage, sessionStorage, IndexedDB
- analytics, error monitoring, session replay, advertising
- mail sending, push notification, webhook
- file upload, image metadata, import/export
- external API/SaaS/SDK への送信
- payment, subscription, invoice, refund
- terms, privacy policy, consent UI, age restriction

## 監査観点

### 収集データ

- 何を収集するか、必須/任意か、利用目的があるか。
- 収集しないはずのデータが logs/analytics/error reporting に混ざっていないか。
- OAuth provider から不要な scope を要求していないか。

### 保持・削除

- 保持期間、削除手順、アカウント削除時の対象範囲があるか。
- logical delete と physical delete の意味が docs と実装で一致しているか。
- backup や audit log に残るデータの扱いが未定義でないか。

### 第三者提供 / 外部委託 / 外部送信

- 外部 SaaS、SDK、analytics、monitoring、mail provider、payment provider を把握しているか。
- 送信データ、送信目的、データ所在、契約/DPA の要否が検討されているか。
- 日本向けサービスで外部送信規律の検討が漏れていないか。

### Cookie / tracking / consent

- Cookie 用途を essential / analytics / marketing などに分類しているか。
- 同意前にブロックすべきものがあるか。
- 同意 UI、再設定導線、撤回導線、同意ログの要否があるか。

### 規約 / ポリシー / 問い合わせ

- プライバシーポリシーと利用規約の要否が未定義のまま公開されないか。
- 公開場所、改定通知、問い合わせ先があるか。
- 個人開発であっても、問い合わせ先や運営者情報の扱いを検討しているか。

### 課金

- 課金有無、料金体系、返金、解約、特商法表記、インボイスの要否を確認しているか。
- 課金予定なしの場合も、将来検討タイミングがあるか。

## 危険パターン

- analytics や monitoring に email/user name/full URL/query を送っている。
- OAuth scope が広すぎる。
- アカウント削除後も user data が通常導線から復元できる。
- プライバシーポリシー未定義のまま本番公開する。
- Cookie banner を出すだけで、同意前ブロックや撤回導線がない。

## docs に残すべきもの

- 対象法域、収集データ、利用目的、保持期間、削除方法
- 第三者提供、外部委託、外部送信、同意設計
- 規約/ポリシーの公開場所、問い合わせ先
- 課金有無、特商法/インボイス要否
- 未決事項と法務確認が必要な論点
