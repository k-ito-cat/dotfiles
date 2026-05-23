---
name: package-addition-check
description: Use before adding or recommending a new package, dependency, global npm package, CLI tool, plugin, MCP server, GitHub Action, or small OSS library. Check supply-chain risk, official package identity, maintainers, install scripts, dependency weight, publish and issue activity, security advisories, and whether the dependency is actually necessary.
---

# Package Addition Check

パッケージや依存を追加する前に、便利さよりも「固定・監視・隔離して利用できるか」を先に確認する。

## 手順

1. 追加目的を確認する。
   - 解決したい問題を一文で明確にする。
   - 標準機能、既存依存、短い自作実装で足りないかを先に検討する。
   - 依存を増やす理由が弱い場合は、追加しない案を第一候補にする。

2. パッケージの実体を特定する。
   - 公式サイト、公式 README、registry、GitHub repository を確認する。
   - npm scoped package、旧名、fork、後継、類似名、typo を確認する。
   - 似た名前の偽物、typosquatting、organization 偽装の可能性を確認する。

3. maintainer と organization を確認する。
   - registry の owner / maintainer と GitHub organization が自然に対応しているか見る。
   - 最近 maintainer が急に変わっていないか、放置後に突然 publish されていないかを見る。
   - 個人管理の小規模 package は、代替手段や自作で済ませる余地を強めに検討する。

4. セキュリティ情報を確認する。
   - GitHub Security Advisories、npm advisory、OSV、公式 issue / discussion、直近のセキュリティニュースを確認する。
   - 既知脆弱性、乗っ取り、悪性リリース、撤回、deprecated 情報がないか確認する。
   - 公式情報で確認できない場合は、その旨を明示し、補助情報は推測として扱う。

5. install scripts と配布物を確認する。
   - `preinstall` / `install` / `postinstall` / `prepare` などの scripts を確認する。
   - install 時に network、shell、binary download、credential 参照を行うものは強く警戒する。
   - 可能なら `ignore-scripts` 前提で動くか確認する。

6. 依存の重さを確認する。
   - 直接依存だけでなく、transitive dependencies の数と性質を見る。
   - 小さい用途に対して依存数が多い package は避ける。
   - 既存 bundle size、runtime surface、権限、native binary の有無も確認する。

7. publish とメンテナンス状況を確認する。
   - publish 頻度、最終 publish、リリース直後すぎないかを見る。
   - issue / PR の滞留、破壊的変更、deprecated、migration 方針を確認する。
   - 更新が極端に多い、または長期停止後に突然更新された package は慎重に扱う。

8. 導入する場合の固定方法を決める。
   - `latest` は使わない。
   - 原則 exact version に固定する。
   - `package-lock.json` / `pnpm-lock.yaml` / mise lock file などの lockfile を管理する。
   - CI では `npm ci` / `pnpm install --frozen-lockfile` のように lockfile 前提で入れる。
   - 更新は Renovate / Dependabot などの PR 経由に寄せる。

## 判定

- **追加しない**: 標準機能、既存依存、自作で足りる。身元や保守状態に不安がある。install scripts や依存数が重い。
- **保留**: 目的は妥当だが、公式情報、maintainer、脆弱性、固定方法の確認が不足している。
- **追加可**: 目的が明確で、公式 identity、maintainer、security、install scripts、依存量、固定方法を確認済み。

## 回答形式

回答では、事実と判断を分ける。

- 確認済み事実: 公式情報、package identity、maintainer、install scripts、依存数、publish / issue 状況。
- リスク: typosquatting、保守停滞、install scripts、依存過多、直近 publish、既知脆弱性。
- 推奨判断: 追加可、保留、追加しない。
- 導入条件: exact version、lockfile、ignore scripts、監視方法、代替案。
