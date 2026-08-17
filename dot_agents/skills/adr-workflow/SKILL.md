---
name: adr-workflow
description: Use when the user says `adr`, or wants to record an architecture/design decision as an ADR. Reconstruct the decision from the conversation into Context, Considered Options, Decision, and Consequences, decide whether it should be written at all, choose between the project and master location, then confirm the draft before writing.
---

# ADR Workflow

決定した直後に、その判断を決定時点のまま ADR として残す。

このスキルは手順を担当する。ADR の書く条件、置き場所の判定、命名、status、specs との接続は `project-documents/_template/decisions/README.md` を正本とし、ここに重複させない。

## Trigger

- ユーザーが `adr` と言った
- 会話の中で設計判断、技術選定、方針が確定し、それを残したい
- 過去に捨てた案を記録しておきたい

## Role

- 直前の会話を Context / Considered Options / Decision / Consequences に整理し直す
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
   - 対象ディレクトリの既存ファイルを確認し、最大値 + 1 を採る。
   - 連番はディレクトリごとに独立している。他方の番号を参照しない。

6. 会話から素材を取り出す。
   - Context: 何を解こうとしたか。判断が必要になった理由。**その時点で分かっていた制約だけ**を書く。
   - Considered Options: **実際に会話に出た案だけ**を書く。
   - Decision: 採用した案と、会話で示された理由。
   - Consequences: 得たもの、失ったもの、覆すべき条件。
   - 素材が足りない項目は、埋めずにユーザーへ質問する。

7. 下書きを提示して確認を取る。
   - 置き場所、ファイル名、本文全体を提示する。
   - 会話から取れず補った箇所があれば、どこを補ったか明示する。
   - 明示的な OK が出るまで書き込まない。

8. 書き込む。
   - `template.md` の構成に従う。
   - frontmatter の `date` は実行日を入れる。
   - `_decisions/` に書いた場合は `_decisions/README.md` の Index に 1 行追加する。

9. 接続を確認する。
   - 採用した結果が `specs/` に反映済みか確認する。未反映なら、何を更新すべきかを提示する。ADR は `specs/` の代わりにならない。
   - 既存の判断を覆した場合は、古い ADR の status を `superseded by ADR-NNNN` に変更する。本文は書き換えない。
   - `specs/` 側から理由を辿る必要がある項目には `→ ADR-NNNN` の参照を提案する。

## 必須ルール

- **会話に出ていない選択肢を Considered Options に書かない。** 一般的にありそうな代替案を補って埋めない。偽の検討履歴は ADR の価値を破壊する。
- **決定時点で知らなかったことを Context に書かない。** 後から分かった事実を混ぜると、なぜその判断が妥当だったかが読めなくなる。
- 会話に判断の経緯が無い場合（別セッションで決めた、口頭で決めた）は、推測で再構成せずユーザーに聞く。答えが得られない項目は未記入のままにせず、何が不明かを本文に残す。
- 過去の ADR の本文を編集しない。訂正も追記ではなく新しい ADR で行う。status の変更だけは例外とする。
- 実装済みの内容を説明するために ADR を書かない。
- 遡って過去の判断を ADR 化しない。ユーザーが明示的に求めた場合は、記憶で再構成した内容であることを本文に明記する。
- 1 回の実行で 1 つの ADR だけ扱う。複数の判断が混ざっている場合は分割を提案する。
- ユーザーの明示的な OK が出るまでファイルを書き込まない。

## 判断が無い場合

会話が調査、確認、実装だけで終わっていて残すべき判断が無い場合は、ADR を作らずにその旨を伝える。件数を増やすことを目的にしない。
