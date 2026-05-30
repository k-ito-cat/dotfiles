# Dependency Audit

## 目的

外部 package、SaaS、SDK、provider、GitHub Action、CLI などの依存が、公開・運用・供給網リスクを増やしていないかを監査する。

新規 package 追加の詳細評価は `package-addition-check` skill を併用する。この reference は project readiness の文脈で、依存全体と運用を確認する。

## 読むもの

- `package.json`, lockfile, workspace config
- CI/CD workflow and GitHub Actions
- `docs/specs/dependencies.md`, `tech.md`, `security.md`, `legal.md`, `operations.md`
- external SDK/API/provider 設定
- Renovate/Dependabot config

## 監査観点

### 依存の棚卸し

- runtime dependency と dev dependency が分かれているか。
- 外部 SaaS/SDK/provider が `dependencies.md` にカタログ化されているか。
- auth、payment、mail、monitoring、analytics、storage など運用影響が大きい依存を把握しているか。
- 個別 npm package 一覧を docs に転記していないか。正本は package manager 管理ファイルにする。

### package supply chain

- package identity、registry、repository、maintainer、publish 状況を確認しているか。
- typosquatting、似た名前、旧 package、fork、unmaintained package を疑っているか。
- install scripts、native binary、postinstall download、credential access があるか。
- transitive dependencies が用途に対して重すぎないか。
- known vulnerability、deprecated、security advisory を確認しているか。

### lockfile / install

- lockfile を管理しているか。
- CI は frozen/clean install を使うか。
- package manager と version が固定されているか。
- `latest` や range が意図せず浮いていないか。

### 更新運用

- Renovate/Dependabot の採用有無が判断されているか。
- major/minor/patch、dev/runtime、security update の扱いが分かれているか。
- automerge 条件に CI、branch protection、影響範囲が含まれているか。
- 更新しない条件、保留条件、rollback 方針があるか。

### 外部 service risk

- provider 障害時の影響と代替/縮退があるか。
- cost、rate limit、data residency、DPA、privacy、SLA を確認しているか。
- secret/API key の管理境界があるか。
- webhook や callback endpoint の security を確認しているか。

## 危険パターン

- 小さい用途に重い依存を追加している。
- maintainer や repository が不自然に変わっている。
- install script が network/binary download/shell を実行するが警戒していない。
- GitHub Action を SHA 固定せず、広い permission で使う。
- external SDK が client bundle で PII を送るが legal/security docs に載っていない。

## docs に残すべきもの

- 依存方針、採用しない基準、単一障害点への考え方
- 外部 SaaS/SDK/provider カタログ
- Renovate/Dependabot 方針、automerge 条件、更新頻度
- 例外、保留、リスク受容
