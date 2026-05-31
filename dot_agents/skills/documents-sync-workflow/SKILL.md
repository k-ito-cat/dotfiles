---
name: documents-sync-workflow
description: Use when documentation content may be out of sync with implementation, design, prototypes, DB schema, tests, README, project-documents, templates, related specifications, or generated outputs. Detect discrepancies, decide which side is authoritative, identify required maintenance, and update documents only after user agreement.
---

# Documents Sync Workflow

この skill は、ドキュメントに書かれた内容と、実装・設計・prototype・DB schema・test・README・関連仕様書・template などの実態との乖離を検知し、どちらを正としてメンテナンスすべきか判断するための workflow である。

目的は、ドキュメントのフォーマット品質を上げることではなく、ドキュメント / 仕様書が開発判断の道しるべとして信頼できる状態を維持すること。

## Documentation Operating Model

- ドキュメント / 仕様書は、詳細仕様の正本ではなく、品質保証、プロダクト意図、設計思想、判断軸、責務境界、詳細の正本、未決事項、更新条件を残す場所として扱う。
- 詳細仕様は code、OpenAPI、schema、migration、test、prototype などの実行可能または検証可能な成果物を正本とする。
- 実装差分、prototype 差分、test 差分を見つけても、即ドキュメント / 仕様書更新とは判断しない。
- 更新が必要なのは、方針、スコープ、責務境界、設計思想、品質上の最低ライン、詳細の正本、未決事項が変わった場合に限る。
- 空欄を埋めること、実装済み詳細を転記すること、網羅性を上げることを同期の目的にしない。

## Trigger

- ドキュメントと実装・設計・prototype・DB schema・test・README・関連文書の内容がずれていないか確認したい
- 実装、設計、prototype、DB、test、release、QA、生成物の変更後に、文書の最新性や整合性を確認したい
- README、`docs/`、project-documents、template、仕様書、設計文書の間で、どちらを正とするか判断したい
- template と現プロジェクト文書、または Skill に明記された構成が食い違っている
- ドキュメント更新そのもの、同期判断、正本判断、横断整合性確認が主題になっている

## Scope

- この workflow は、既にある内容・成果物・実態の同期と整合性維持を扱う。
- 新規プロジェクト文書を対話で育てる主導は `project-documents-setup-workflow` が扱う。
- 画面設計や UI 設計そのものは `design-workflow` が扱う。
- prototype の実装は `prototype-workflow` が扱う。
- アプリケーションコード修正そのものは、この workflow の主目的ではない。

## Sources

- `README.md`
- `package.json` や workspace / build / script 設定
- アプリ側 `docs` path
- `project-documents/README.md`
- `project-documents/_template/`
- `project-documents/_template/README.md`
- `project-documents/_template/specs/README.md`
- `project-documents/_template/design/README.md`
- `project-documents/_template/prototype/README.md`
- `project-documents/<project>/`
- 実装、設計成果物、prototype、DB schema / migration、test、生成物

`docs` が symlink の場合は、リンク先の実体を含めて確認する。

## Workflow

1. 対象リポジトリ、文書実体、関連成果物を確認する。
   - docs 配下を扱う場合は、先に `docs/README.md` または `project-documents/_template/README.md` の docs 全体の正本分担と更新条件を確認する。
2. ドキュメントに書かれた内容と実態を照合する。
3. 乖離を分類する。
   - ドキュメントが古い
   - 成果物が仕様から逸脱している
   - 成果物が詳細仕様の正本であり、ドキュメント更新は不要
   - ドキュメントが詳細仕様を転記しすぎており、正本の所在だけに戻すべき
   - 文書間で矛盾している
   - README や構成説明が実ディレクトリと違う
   - template が古い、または共通項目が欠けている
   - Skill に明記された構成やファイル名が古い
   - 対象プロジェクト固有の拡張であり template へ反映しない
   - 判断材料が足りず正本を決められない
4. どちらを正とするか判断する。
   - ドキュメントを更新する
   - 成果物を仕様へ戻す
   - 成果物を詳細の正本とし、ドキュメントには設計意図と正本の所在だけ残す
   - template をメンテナンスする
   - Skill 記述をメンテナンスする
   - プロジェクト固有差分として扱う
   - 仮決めまたは保留にする
5. 更新対象、更新理由、反映内容、波及先、保留事項を整理してユーザーの合意を得る。
6. 合意した内容だけを反映する。
7. 更新後に関連文書と成果物を横断確認し、残った乖離を報告する。

## Template Consistency

- この skill や他 skill に明記されたファイル名、ディレクトリ名、ファイル数は固定の真実源として扱わない。
- 実際の `project-documents/_template/`、`project-documents/<project>/`、`project-documents/README.md` を確認し、差分があればどちらを正とするか判断する。
- template 配下の親ディレクトリと各 README を優先して確認し、個別ファイル名は README の文書地図に従う。
- docs 全体の運用原則、各ディレクトリの役割、正本の分担、更新条件は `project-documents/_template/README.md` を基準に確認する。
- specs の文書地図は `project-documents/_template/specs/README.md`、design の文書地図は `project-documents/_template/design/README.md`、prototype の方針は `project-documents/_template/prototype/README.md` を基準に確認する。
- template が正なら、Skill 側の記述を修正する。
- Skill の方針や品質基準が正しく、template に共通項目が欠けている場合は、template のメンテナンス候補として扱う。
- template は安易に編集しない。決定事項となる見出し、ファイル、項目を追加する前に、なぜ共通 template に必要か、どのプロジェクトにも適用できるか、既存プロジェクトへどう影響するかを整理する。
- ただし、template に項目が存在しないことでプロダクト品質、仕様の整合性、実装判断、メンテナビリティが落ちる恐れがある場合は、ユーザーの合意を得て template のメンテナンスを行う。
- template をメンテナンスする場合は、現プロジェクトのドキュメント構成と `project-documents/_template/` の構成が矛盾しないように揃える。
- template に反映しないプロジェクト固有の項目は、対象プロジェクト固有の判断として扱い、template へ一般化しない。

## Hard Rules

- フォーマット改善を主目的にしない。
  - 理由: この workflow は、文書の形ではなく、文書に書かれた内容と実態の整合性を守るためのもの。
  - template やフォーマットを変更するのは、乖離解消や品質維持に必要な場合に限る。
- 片方だけを自動的に正としない。
  - 理由: 実装が正しい場合も、仕様書が正しい場合も、どちらも古い場合もある。
  - 判断には、ユーザーの意図、既存文書、実装実態、設計成果物、変更履歴、プロダクト品質への影響を使う。
- 詳細仕様の転記を同期とみなさない。
  - 理由: endpoint 詳細、schema field、validation の具体値、migration、UI 細部、test で担保できる具体挙動をドキュメントへ転記すると、二重管理になり腐りやすい。
  - それらは成果物を正本とし、ドキュメント / 仕様書には設計意図、判断軸、正本の所在、未決事項だけを残す。
- 関連文書を横断確認する。
  - 理由: 1 箇所だけ更新すると、仕様、構造、API、validation、エラー方針、design、README の間に新しい矛盾が生まれる。
- 更新前に合意を取る。
  - 理由: 正本判断はプロダクト判断であり、AI が勝手に確定すると認識ずれや仕様の嘘が混ざる。
- 保留は理由付きで残す。
  - 理由: 正本を決められない乖離を単に放置すると、後続作業で同じ迷いが再発する。
  - 保留理由、影響範囲、再確認タイミング、判断に必要な情報を残す。

## Prototype Drift

- prototype と仕様書 / design 文書が乖離した場合、prototype を自動的に正としない。
- 乖離は判断イベントとして扱う。
- 仕様書が正しい場合は、prototype を修正、対象外化、または破棄する。
- prototype の判断を採用する場合は、仕様書または design 文書に採用判断を反映してから正とする。
- 判断できない場合は、prototype を検証中扱いにし、未決事項として保留理由、影響範囲、判断タイミングを残す。

## Output

- 確認した文書と成果物
- 検出した乖離
- 正本判断
- 更新対象
- 更新理由
- 反映内容
- 保留事項
- 横断確認結果
