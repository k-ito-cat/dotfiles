# Public Environment Variable Audit

## 目的

client bundle や browser runtime に公開される env に secret が混ざっていないかを監査する。

Vite 公式 docs では `VITE_` prefix の env は client source に露出する。Next.js の `NEXT_PUBLIC_`、SvelteKit の `PUBLIC_` も同様に client 公開の境界として扱う。framework ごとの prefix 変更や build-time inline も確認する。

## 公式確認先

- Vite: https://vite.dev/guide/env-and-mode/
- Next.js: https://nextjs.org/docs/app/guides/environment-variables
- SvelteKit public env: https://svelte.dev/docs/kit/$env-static-public
- SvelteKit dynamic public env: https://svelte.dev/docs/kit/$env-dynamic-public

最新仕様が判断に影響する場合は、公式 docs を確認してから断定する。

## 読むもの

- `.env.example`, `.env.*.example`, `.env.1password`, README の env 説明
- `vite.config.*`, `next.config.*`, `svelte.config.*`, `astro.config.*`
- `src/**/*.ts`, `src/**/*.tsx`, `src/**/*.svelte`, `src/**/*.astro`
- CI/CD workflow, hosting provider env 設定の説明
- generated client, frontend config, analytics config

実 secret 値は読まない。名前、prefix、参照場所、公開境界を確認する。

## 監査手順

1. 使用 framework と env 取り込み方式を特定する。
2. client 公開 prefix を列挙する。
   - Vite: default `VITE_`, config の `envPrefix`
   - Next.js: `NEXT_PUBLIC_`
   - SvelteKit: `PUBLIC_` default public prefix
   - Astro/Vite 系: `PUBLIC_` や `VITE_` の扱いを公式 docs と config で確認
3. env 名を分類する。
   - public config: public URL, public analytics ID, feature flag public key
   - server secret: API secret, OAuth client secret, database URL, token, signing key
   - ambiguous: `KEY`, `TOKEN`, `SECRET`, `PRIVATE`, `ADMIN`, `WEBHOOK`, `PASSWORD`, `DSN`
4. client code で参照している env を確認する。
5. build output や generated files に secret 名や値が入りうる経路を確認する。
6. docs に PJ 固有の env 管理方針があるか確認する。

## 危険パターン

- `VITE_API_KEY`, `NEXT_PUBLIC_API_SECRET`, `PUBLIC_TOKEN` のような名前で secret らしき値を公開している。
- OAuth client secret、database URL、session secret、JWT signing secret が client prefix を持つ。
- `envPrefix` を広げて `APP_` や空文字にしている。
- frontend error reporting / analytics に secret や PII を env 経由で渡している。
- local dev 用 `.env` の説明が production と混ざっている。
- preview 環境の public env が production API や production analytics に向いている。

## 判定基準

Critical:

- secret が client 公開 prefix を持つ、または client bundle から参照される。
- production credential が docs/example/generated output に残っている。

High:

- env 境界が未定義で、public/private の分類ができない。
- `envPrefix` を広げているが理由と制約がない。

Medium:

- public env と server env の命名が紛らわしい。
- staging/preview/prod の env 分離が不明確。

Low:

- `.env.example` が不足して onboarding や監査が難しい。

## docs に残すべきもの

- env の正本の場所
- public/private の命名方針
- hosting/CI/1Password など設定場所の管理方針
- prefix 変更を採用する場合の理由と影響範囲
- 例外と未決事項

## 報告例

```md
- [Critical] `VITE_` prefix の env に secret らしき名前がある
  - 確認した事実: `.env.example` に `VITE_XXX_SECRET` がある
  - リスク: Vite では `VITE_` prefix の値は client source へ露出する
  - 推奨: server-only env に移し、client は backend API 経由で利用する
  - docs 更新要否: `security.md` または `infra.md` に env 境界を残す
```
