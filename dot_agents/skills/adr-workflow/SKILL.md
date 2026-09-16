---
name: adr-workflow
description: Use when the user says `adr`, wants to record an architecture/design decision, or explicitly migrate past decisions into ADRs. Reconstruct evidence into MADR, choose the project or master location, confirm before writing, and use adrs for lifecycle operations.
---

# ADR Workflow

決定した直後に、その判断を決定時点のまま ADR として残す。

このスキルは手順を担当する。ADR の書く条件、置き場所の判定、命名、status、spec との接続は `project-documents/_template/decisions/README.md` を正本とし、ここに重複させない。

## Trigger

- ユーザーが `adr` と言った
- 会話の中で設計判断、技術選定、方針が確定し、それを残したい
- 過去に捨てた案を記録しておきたい

## Role

- 直前の会話をMADRのContext / Decision Drivers / Considered Options / Decision Outcome / Consequencesへ整理し直す
- 書くべきでない判断は、書かないと言う
- 会話に無い内容を補完しない
- ユーザーの確認前にファイルを書かない

## 手順

1. project-documents の場所を確認する。
   - アプリリポジトリ内にいる場合、`docs` が `project-documents/<project>` への symlink になっている。`docs/decisions/` から辿る。
   - プロジェクト外にいる場合、または `docs` が無い場合は `project-documents` リポジトリの場所を確認する。
   - project name は原則リポジトリ名を使う。ユーザー指定があればそれを優先する。

2. 正本を読む。
   - `project-documents/_template/decisions/README.md` の「書く条件」「置き場所の判定」「ファイル」を読む。
   - 記憶で代用しない。条件は更新される。
   - 対象階層で`adrs config`を実行し、ADR directory、NextGen mode、MADR templateを確認する。

3. 書くべきか判定する。
   - 「書く条件」に照らす。
   - 当てはまらない場合は、その理由を示して書かないことを提案する。ユーザーが求めた場合でも、まず該当しないと伝える。
   - 当てはまる条件を明示してから次に進む。

4. 置き場所を決める。
   - 「そのプロジェクトを消したら、この判断も一緒に消えるか」で判定する。
   - 消える → `project-documents/<project>/decisions/`
   - 残る → `project-documents/_decisions/`
   - 判定結果と理由を短く示す。迷う場合はプロジェクト配下に倒し、その旨を伝える。

5. 連番を決める。
   - 対象階層で`adrs list`を確認し、次の番号を予測する。確認前にはファイルを作らない。
   - 連番はディレクトリごとに独立している。他方の番号を参照しない。

6. 会話から素材を取り出す。
   - Context: 何を解こうとしたか。判断が必要になった理由。**その時点で分かっていた制約だけ**を書く。
   - Decision Drivers: 会話で優先された品質、制約、避けたい損失を書く。
   - Considered Options: **実際に会話に出た案だけ**を書く。
   - Decision Outcome: 採用した案と、会話で示された理由。
   - Consequences: 得たもの、失ったもの、覆すべき条件。
   - Confirmation: 判断への準拠を確認できるtest、review、doctorなどが会話にある場合だけ書く。
   - 素材がない任意節は、形式のために推測で埋めず削除する。判断に不可欠な情報が足りない場合はユーザーへ質問する。

7. 下書きを提示して確認を取る。
   - 置き場所、ファイル名、本文全体を提示する。
   - 会話から取れず補った箇所があれば、どこを補ったか明示する。
   - 明示的な OK が出るまで書き込まない。

8. 書き込む。
   - 対象階層で`adrs new --no-edit --status <status> "<title>"`を使ってファイルを作り、確認済み本文を反映する。
   - `project-documents/_template/decisions/template.md` と生成されたMADRの構成に従う。
   - 新しい判断の`date`は実行日とする。履歴移行では確認できた判断日を使う。
   - `_decisions/` に書いた場合は `_decisions/README.md` の Index に 1 行追加する。

9. 接続を確認する。
   - docs READMEの分担に照らし、要求の変更はspec、UI / UXの変更はdesign、実装上の定義は成果物へ接続する。設計判断は未実装でもADRを参照先にでき、現在の判断だからという理由でspecへ再掲しない。
   - 既存の判断を覆した場合は、`adrs status <旧番号> superseded --by <新番号>`でstatusとlinkを更新する。本文は書き換えない。
   - `spec/` 側から理由を辿る必要がある項目には `→ ADR-NNNN` の参照を提案する。

10. 検証する。
   - 対象階層で`adrs doctor`を実行する。
   - `adrs list`で番号、title、statusが認識されることを確認する。
   - README索引、関連ADR、spec / design / 実装へのlinkを確認する。

## 必須ルール

- **会話に出ていない選択肢を Considered Options に書かない。** 一般的にありそうな代替案を補って埋めない。偽の検討履歴は ADR の価値を破壊する。
- **決定時点で知らなかったことを Context に書かない。** 後から分かった事実を混ぜると、なぜその判断が妥当だったかが読めなくなる。
- 会話に判断の経緯が無い場合（別セッションで決めた、口頭で決めた）は、推測で再構成せずユーザーに聞く。答えが得られない項目は未記入のままにせず、何が不明かを本文に残す。
- 過去の ADR の判断内容を編集しない。訂正も追記ではなく新しい ADR で行う。status / linkの変更と、ユーザーが明示的に承認したformat migrationによるmetadata・見出しの機械変換だけは例外とし、意味を変えない。
- 実装済み詳細の説明だけでADRを作らない。既存の設計判断の移譲はユーザーが求めた場合に行い、既存文書、Git履歴、保存された会話記録から確認できた情報だけで再構成する。仮決定を確定に変えず、理由・比較案・決定日を推測しない。元情報は引き継ぎ確認まで保持し、非ADRの保全記録も選べる。
- 過去分を無断でADR化しない。明示的な依頼がある場合は既存文書を優先し、記憶に基づく場合はそのことと不明点を明記する。本文全体の確認を省略しない。
- 通常は1回の実行で1つのADRだけを扱う。ユーザーが履歴の一括移行を明示した場合は、判断ごとの対応表、status、日付根拠、削除する移行元をまとめて提示して承認を得たうえで、複数ADRを一括処理できる。1ファイル1判断の原則は維持する。
- 対象に`adrs.toml`がある場合は`adrs`を作成・status・link・診断の入口とする。CLIが利用できない場合、手書きへ無断で切り替えずユーザーへ報告する。
- ユーザーの明示的な OK が出るまでファイルを書き込まない。

## 判断が無い場合

会話が調査、確認、実装だけで終わっていて残すべき判断が無い場合は、ADR を作らずにその旨を伝える。件数を増やすことを目的にしない。
