---
name: adr-workflow
description: Use when a durable design, architecture, technology, tooling, documentation, or operating-policy decision is accepted, changed, rejected, or superseded—even if the user does not say ADR (e.g. 「これでいく」「方針が固まった」「採用する」「見送る」). Also use for explicit ADR requests and historical decision migration. Exclude mere research, work logs, and reversible implementation details. Reconstruct evidence into MADR, confirm before writing, and use adrs for lifecycle operations.
---

# ADR Workflow

同じ文脈の話に結論が付き、その文脈の作業が完了する時点で、判断を決定時点のまま ADR として残す。

このスキルは手順を担当する。ADR の書く条件、置き場所の判定、命名、status、spec との接続は `project-documents/_template/decisions/README.md` を正本とし、ここに重複させない。

## Trigger

- ユーザーが `adr` と言った
- 会話の中で、継続的な設計、技術選定、ツール選定、文書運用、開発運用の方針が確定、変更、却下された。ユーザーがADRへの記録を明示していなくても対象とする
- 過去に捨てた案を記録しておきたい
- 過去の判断を既存文書、Git履歴、保存された会話記録からADRへ移行したい

発火はADR候補として内部的に保持する条件であり、会話へ即座に割り込む条件ではない。同じ文脈の結論と作業が完了する時点で「書く条件」に該当するかを判定し、該当する場合だけ一度の確認を行う。ユーザーの確認前には書き込まない。

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
   - 履歴移行では、判断内容を確認したcommit hash、既存文書、保存された会話の日付を`More Information`へ残す。ローカル環境固有の絶対pathは恒久的な出典にしない。
   - 素材がない任意節は、形式のために推測で埋めず削除する。判断に不可欠な情報が足りない場合はユーザーへ質問する。

7. 作成内容を簡略に提示し、一度だけ確認を取る。
   - ADR候補の仮題、置き場所とその理由、残す内容の簡略な要約を提示する。
   - 置き場所はこの確認までに確定する。確認後に配置先を選ばせる二度目の確認を設けない。
   - 本文全体は提示せず、MADRへ整理した全量を内部で保持する。
   - 判断に不可欠な情報が足りない場合は、この確認より前に質問して解消する。承認後に内容確認へ戻らない。
   - 明示的な OK が出るまで書き込まない。

8. 書き込む。
   - OK後は本文全体の再提示や二度目の確認を行わず、対象階層で`adrs new --no-edit --status <status> "<title>"`を使ってファイルを作り、確認済みの要約に対応する全量を反映する。
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
   - 完了報告では作成したADRのpath、status、検証結果に加え、ユーザーがterminalから開ける `v <ファイル名>` を提示する。ファイル名だけでは一意にならない場合は、fzfで一意に絞れる相対pathを渡す。

## 必須ルール

- **会話に出ていない選択肢を Considered Options に書かない。** 一般的にありそうな代替案を補って埋めない。偽の検討履歴は ADR の価値を破壊する。
- **決定時点で知らなかったことを Context に書かない。** 後から分かった事実を混ぜると、なぜその判断が妥当だったかが読めなくなる。
- 会話に判断の経緯が無い場合（別セッションで決めた、口頭で決めた）は、推測で再構成せずユーザーに聞く。答えが得られない項目は未記入のままにせず、何が不明かを本文に残す。
- 過去の ADR の判断内容を編集しない。訂正も追記ではなく新しい ADR で行う。status / linkの変更と、ユーザーが明示的に承認したformat migrationによるmetadata・見出しの機械変換だけは例外とし、意味を変えない。ただし、未完了・未commitの履歴移行で、下書きが証拠やユーザー判断と矛盾すると判明した場合は、誤った再構成を履歴として残さず、確認済みの証拠に合わせて下書きを訂正する。
- 実装済み詳細の説明だけでADRを作らない。既存の設計判断の移譲はユーザーが求めた場合に行い、既存文書、Git履歴、保存された会話記録から確認できた情報だけで再構成する。仮決定を確定に変えず、理由・比較案・決定日を推測しない。元情報は引き継ぎ確認まで保持する。
- 移行中の対応表や検証メモは一時的な作業資料とし、`decisions/`へ非ADR文書として恒久保存しない。判断は判断ごとにADRへ、要求・デザイン・実装上の定義・運用手順はそれぞれの正本へ移し、対応確認後に作業資料を廃止する。
- 過去分を無断でADR化しない。明示的な依頼がある場合は既存文書を優先し、記憶に基づく場合はそのことと不明点を明記する。履歴移行に必要な確認は、判断ごとの対応表、配置先、status、日付根拠、移行元を含む一度の確認にまとめ、承認後に本文全体の再確認を設けない。
- 通常は1回の実行で1つのADRだけを扱う。ユーザーが履歴の一括移行を明示した場合は、判断ごとの対応表、status、日付根拠、削除する移行元をまとめて提示して承認を得たうえで、複数ADRを一括処理できる。1ファイル1判断の原則は維持する。
- 対象に`adrs.toml`がある場合は`adrs`を作成・status・link・診断の入口とする。CLIが利用できない場合、手書きへ無断で切り替えずユーザーへ報告する。
- ユーザーの明示的な OK が出るまでファイルを書き込まない。
- 一度の確認でOKを得た後に、配置先、本文、作成可否について二度目の確認を求めない。

## 判断が無い場合

会話が調査、確認、実装だけで終わっていて残すべき判断が無い場合は、ADR を作らずにその旨を伝える。件数を増やすことを目的にしない。
