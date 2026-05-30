# Observability and Operations Audit

## 目的

公開後に問題を検知・切り分け・復旧できるかを監査する。監視 SaaS や具体 Runbook を定義するのではなく、欠落しやすい運用観点を確認する。

PJ 固有の監視基盤、通知先、SLO、Runbook、オンコール、連絡網、インシデント分類は `docs/specs/observability.md` と `operations.md` に残す。

## 読むもの

- `docs/specs/observability.md`, `operations.md`, `release.md`, `security.md`, `legal.md`, `infra.md`
- logging/monitoring/error reporting config
- hosting/provider dashboard docs
- CI/CD and deploy config
- alert/runbook docs

## 監査観点

### Logs

- error, warning, audit, access, business event のどれを記録するか分かれているか。
- request id / trace id / user id hash など調査に必要な相関情報があるか。
- secret、token、password、email、raw request body、cookie を記録していないか。
- log level が production で過剰に verbose になっていないか。

### Metrics / SLI

- availability、latency、error rate、queue/job failure、external API failure など最低限の指標があるか。
- user-visible な失敗を検知できるか。
- cost や quota/rate limit の異常を検知できるか。

### Alerts

- 公開直後に見るべき alert があるか。
- alert fatigue を避けるため、重大度と通知先が整理されているか。
- user impact があるのに silent failure にならないか。
- 誤検知時の扱いがあるか。

### Error reporting

- frontend/backend の error reporting が production で有効か。
- sourcemap 公開範囲や stack trace に secret/PII がないか。
- expected error と unexpected error を分けて扱っているか。

### Runbook / incident

- 代表的な障害に対して、確認手順と復旧手順があるか。
- DB migration 失敗、deploy 失敗、external provider 障害、auth 障害、mail 送信失敗を考慮しているか。
- 問い合わせ導線、内部記録、事後振り返りの最低限があるか。

### Backup / recovery

- backup 対象、頻度、復旧手順、復旧テストの有無が分かるか。
- account deletion や user data deletion と backup retention が矛盾していないか。
- RPO/RTO を決めない場合でも、公開時の許容停止時間を意識しているか。

## 危険パターン

- エラーが UI 上で握りつぶされ、monitoring にも出ない。
- PII を error reporting に送っている。
- alert はあるが誰が見るか不明。
- backup はあるが restore したことがない。
- 個人開発なので問い合わせ導線がなく、障害や脆弱性報告を受け取れない。

## docs に残すべきもの

- 観測の目的、採用基盤、記録する/しない情報
- alert、SLO/SLI、dashboard、Runbook の PJ 固有内容
- 運用体制、インシデント分類、連絡網、SLA
- 保留、リスク受容、公開後に整える項目
