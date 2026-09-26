---
name: db-design-review
description: Use when the user asks to review a database schema, ERD, migration, or table design.
metadata:
  category: レビュー・監査
  summary: DB の schema・migration・テーブル設計を、根拠付きの観点でレビューする
---

# DB Design Review

DB 設計レビュー時の観点を固定する。各観点には、正しさの拠り所とする外部の情報源を添える。基準の確定、事前ヒアリング、出力の型は `review-protocol` に従う。

## Quick start

- `review-protocol` に従い、要求文書・仕様文書・ADR から基準を確定する
- 次に ER 図、schema、migration、DDL、Atlas HCL など実体を確認する
- 使っている DB を確かめ、DB 固有の観点はその DB の公式ドキュメントで確かめる。下の PostgreSQL の資料は、他の DB では同等の資料に読み替える
- レビューの対象に応じて通す節を選び、仕様と設計を対応付けながらレビューする
- squawk や Atlas の lint で検査できる項目はツールの結果を使い、レビューは意味の判断に集中する

## DB 固有の事前ヒアリング

`review-protocol` の共通項目に加え、文書で分からない場合に次を確かめる。

| 聞くこと | 精度が上がる理由 |
| --- | --- |
| 業務上の不変条件（どんなときも崩れてはいけない決まり） | 制約や排他で守るべきものが決まる |
| 主なクエリとその頻度、読み書きの比率 | インデックスと非正規化の妥当性を判断できる |
| データ量の見込み（件数と増え方） | キーの型、パーティション、保持の要否が決まる |
| 同時に更新される場面と、そのときに期待する結果 | 排他の方式を要求に照らして判断できる |
| 保持期間と、削除・匿名化の要求 | 不要なデータの扱いを判断できる |
| DB の製品と版、実行環境 | 使える機能と、根拠にする資料が決まる |

## 通す節の選び方

- 新しい設計・設計の見直し: 1〜10、13、14
- migration: 1、4、11、14 を中心に、変更が触れる節
- 運用の見直し: 9、10、12

通した節と通さなかった節を、出力の「前提と範囲」に書く。

## Review points

### 1. 要求との対応

- 要求（FRQ・NFR）ごとに、それを支える表・列・制約があるか（ISO/IEC 25010 の機能完全性）
- それらが要求を正しく表しているか（ISO/IEC 25010 の機能正確性、ISO/IEC 25012 の正確性）
- 表・列から要求へ辿れるか。要求に対応しない表・列・インデックスがないか
- 業務上の不変条件を1つずつ挙げ、DB の制約・アプリ・守らない、のどこで守るかが決まっているか

### 2. 論理モデル

- 1つの表が1つの実体か関係を表しているか。同じ事実を複数の場所に持つ場合は、どちらを正とし、どう同期するかが決まっているか（ISO/IEC 25012 の一貫性）
- 多重度（1対1、1対多、多対多）と任意性が要求と合っているか
- 非正規化する場合は、その理由（計測した性能など）と同期の方法が書かれているか

### 3. キーと識別子

- 代理キーとは別に、自然キーの一意性を UNIQUE で守っているか（PostgreSQL の制約）
- 主キーの型が、データ量の見込みに対して枯渇しないか。連番は identity で持つか（squawk の prefer-bigint-over-int・prefer-identity）
- 外部に出す ID が推測されて困らないか

### 4. 制約で守る整合性

- NOT NULL を標準とし、NULL を許す列に理由があるか。デフォルト値が妥当か（ISO/IEC 25012 の完全性、PostgreSQL の Not-Null 制約）
- CHECK、UNIQUE、外部キー、EXCLUDE（期間の重なりの禁止など）で守れる決まりを、制約で守っているか（PostgreSQL の制約）
- 削除・更新時の参照の扱い（CASCADE、RESTRICT、SET NULL など）が業務の決まりと合っているか
- 論理削除する場合に、一意制約と両立しているか

### 5. 型と値の表し方

- 日時はタイムゾーンを持つ型で持つか（PostgreSQL の Date/Time Types）。期間は終わりを含まない形で扱い、日時に BETWEEN を使っていないか（Don't Do This）
- 金額は丸め誤差の出ない numeric で持つか（PostgreSQL の Monetary Types）
- 単位・通貨・タイムゾーンが、列や型から分かるか

### 6. 時間の軸

- 現在の値だけでよいか、履歴が要るかが要求で決まっているか。値がいつ時点のものか判断できるか（ISO/IEC 25012 の最新性）
- 誰がいつ変えたかを残す要求があれば、それを満たすか
- 許される状態の移り方を、制約などで表せるか

### 7. 同時実行とトランザクション

- トランザクションの範囲が、業務上ひとまとまりで成功・失敗すべき操作と一致しているか。分離レベルで防げない現象を、要求が許しているか（PostgreSQL の Transaction Isolation）
- 不変条件ごとに、同時に更新されたときに守る仕組みがあるか（一意制約、行ロック、分離レベルと再試行、楽観ロック）。その解決（後から保存した方が勝つ、衝突を検出するなど）が要求として決まっているか（PoEAA の Optimistic / Pessimistic Offline Lock）
- 再送や二重実行が起きても、結果が重複しないか（冪等性。RFC 9110 の冪等なメソッドの定義）
- 複数の行・表をロックする順序が揃っていて、デッドロックを招かないか

### 8. アクセスと性能

- 主なクエリごとに、インデックスの根拠があるか。実行計画で確かめているか（PostgreSQL の Indexes、Using EXPLAIN）
- 外部キーの参照する側に、必要なインデックスがあるか。PostgreSQL は外部キーを宣言しても参照する側にインデックスを作らない（PostgreSQL の制約）
- インデックスが多すぎて書き込みを重くしていないか
- データ量の見込みに対して、パーティションが要るか。目安はテーブルがサーバーの物理メモリを超えること（PostgreSQL の Table Partitioning）

### 9. データの一生

- 保持期間と、消す・匿名化する手段があるか（GDPR 第5条のデータ最小化・保存の制限）
- 論理削除した行、一時データ、古い履歴が、消されずに溜まらないか
- 親を失った行が生まれないか

### 10. アクセス制御と機密

- アプリが使うロールの権限が、必要な操作に限られているか
- 複数の利用者・テナントのデータを分ける必要がある場合に、行レベルセキュリティや制約で分離しているか。テーブルの所有者は FORCE ROW LEVEL SECURITY を付けない限り制限を受けないことを踏まえているか（PostgreSQL の Row Security Policies）
- アプリ側のセキュリティ全般は release-readiness-audit の security で確認し、ここでは重ねて見ない

### 11. 変更の安全性

- migration がデータを失わないか（Atlas の Destructive Changes、squawk の ban-drop-column・ban-drop-table）
- 既存のデータ次第で失敗しないか。一意制約・NOT NULL の追加や型の変更の前に、既存のデータを確かめているか（Atlas の Data-dependent Changes）
- 旧版のアプリが動いている間も壊れないか。後方互換を壊す変更を、広げる・移す・縮めるの段階に分けているか（Atlas の Backward Incompatible Changes、Fowler の Parallel Change）
- 大きなテーブルを長くロックしないか。制約は NOT VALID で足してから検証し、インデックスは CONCURRENTLY で作り、lock_timeout を設定しているか（squawk の constraint-missing-not-valid・require-concurrent-index-creation・require-lock-timeout、Atlas の Concurrent Index Policy）
- 値の埋め戻しと、元に戻す方法が決まっているか

### 12. 運用と復旧

- 許されるデータの消失（RPO）と復旧までの時間（RTO）の要求に、バックアップの方式が見合っているか（PostgreSQL の Continuous Archiving and PITR）
- 復元を試して、戻せることを確かめているか
- 監視と障害時の初動は release-readiness-audit の observability-ops で確認し、ここでは重ねて見ない

### 13. 保守性

- 命名がプロジェクトの規約に沿い、意味が明確か（機械検査するなら Atlas の Naming Conventions）
- 制約・命名・コメント（COMMENT ON）から意図が読み取れ、変更の影響を見積もれるか（ISO/IEC 25010 の解析性・修正性）
- 見込まれている機能の追加を、既存の表を大きく作り直さずに受け入れられるか（ISO/IEC 25010 のモジュール性）。見込みは要求の未決事項など文書に書かれたものを基準にし、想像で先回りした汎用化は求めない
- データ量や利用者の見込みが増えても耐えられるか（ISO/IEC 25010 のスケーラビリティ）

### 14. 代表的なアンチパターン

次のそれぞれに当たらないかを確かめる。当たる場合は、それを選んだ理由が要求や ADR に書かれているかを見る。

SQL Antipatterns の論理設計:

- Jaywalking: 複数の値をカンマ区切りなどで1つの列に入れる。個々の値に制約や外部キーを掛けられず、検索と更新が壊れやすい
- Naive Trees: 親の ID だけで階層を持つ。任意の深さの子孫や祖先を扱いにくい
- ID Required: すべての表に、意味のない id を機械的に付ける。自然キーの重複を許し、交差表で同じ組が重複する
- Keyless Entry: 外部キーの制約を張らない。参照先のない行が生まれる
- Entity-Attribute-Value: 属性を「名前と値」の行として持つ。型・NOT NULL・外部キーを掛けられない
- Polymorphic Associations: 1つの列が、種類によって別々の表を指す。外部キーを張れない
- Multicolumn Attributes: 同じ意味の列を tag1、tag2 のように並べる。数の上限が固定され、検索が列の数だけ増える
- Metadata Tribbles: 年ごとなどに表や列を増やして分ける。まとめて問い合わせにくく、構造が増え続ける

SQL Antipatterns の物理設計:

- Rounding Errors: 金額など正確さの要る値に float を使う。丸め誤差が出る
- 31 Flavors: 増える選択肢を、CHECK や ENUM の列定義に固定する。選択肢を変えるたびに schema の変更が要る
- Phantom Files: ファイルを DB の外に置き、パスだけを持つ。削除・トランザクション・バックアップの整合を DB で保てない
- Index Shotgun: 根拠なくインデックスを張る、または張らない。性能と書き込みの負荷の釣り合いが崩れる

SQL Antipatterns のアプリ開発のうち、設計に関わるもの:

- Readable Passwords: パスワードを元に戻せる形で持つ。漏れたときに、そのまま使われる
- Pseudokey Neat-Freak: 代理キーの欠番を詰める前提で設計する。参照の付け替えや競合を招く

PostgreSQL の Don't Do This のうち、schema に関わるもの:

- timestamp without time zone で時刻を持つ。ある瞬間ではなく、暦と時計の表示を記録してしまう
- UTC の値を timestamp without time zone に入れる。DB がタイムゾーンを判断できない
- char(n) を使う。空白の詰め物で比較が揺れ、長さの検査にもならない
- 理由なく varchar(n) を使う。text より速くならず、恣意的な上限が後で本番の失敗になる
- money を使う。端数の扱いと通貨の区別ができない
- serial を使う。identity の方が定義と依存関係の管理が明確
- 表や列に大文字の名前を付ける。引用符が常に要り、ツールごとに扱いがずれる
- テーブルの継承（inheritance）やルール（rules）を使う。継承はパーティションで、ルールはトリガーで置き換えられる
- SQL_ASCII のエンコーディングを使う。混ざった文字コードを後から正しく戻せない

クエリの誤り（SQL Antipatterns のクエリの章）はこの Skill では扱わない。SQL インジェクションは release-readiness-audit の security で確認する。

## 根拠

- ISO/IEC 25010:2023（製品品質モデル）: https://iso25000.com/index.php/en/iso-25000-standards/iso-25010
- ISO/IEC 25012（データ品質モデル）: https://iso25000.com/index.php/en/iso-25000-standards/iso-25012
- PostgreSQL Constraints: https://www.postgresql.org/docs/current/ddl-constraints.html
- PostgreSQL Date/Time Types: https://www.postgresql.org/docs/current/datatype-datetime.html
- PostgreSQL Monetary Types: https://www.postgresql.org/docs/current/datatype-money.html
- PostgreSQL Transaction Isolation: https://www.postgresql.org/docs/current/transaction-iso.html
- PostgreSQL Indexes: https://www.postgresql.org/docs/current/indexes.html
- PostgreSQL Using EXPLAIN: https://www.postgresql.org/docs/current/using-explain.html
- PostgreSQL Table Partitioning: https://www.postgresql.org/docs/current/ddl-partitioning.html
- PostgreSQL Row Security Policies: https://www.postgresql.org/docs/current/ddl-rowsecurity.html
- PostgreSQL Continuous Archiving and PITR: https://www.postgresql.org/docs/current/continuous-archiving.html
- PostgreSQL Wiki, Don't Do This: https://wiki.postgresql.org/wiki/Don't_Do_This
- Bill Karwin, SQL Antipatterns, Volume 1（2022）: https://pragprog.com/titles/bksap1/sql-antipatterns-volume-1/
- Martin Fowler, Patterns of Enterprise Application Architecture（Optimistic Offline Lock）: https://martinfowler.com/eaaCatalog/optimisticOfflineLock.html
- Martin Fowler, Parallel Change: https://martinfowler.com/bliki/ParallelChange.html
- RFC 9110 9.2.2 Idempotent Methods: https://www.rfc-editor.org/rfc/rfc9110#section-9.2.2
- GDPR 第5条（データ最小化・保存の制限）: https://gdpr-info.eu/art-5-gdpr/
- Atlas Migration Analyzers: https://atlasgo.io/lint/analyzers
- squawk Rules: https://squawkhq.com/docs/rules

## Output rules

- `review-protocol` の出力の型で返す。重さは `review-protocol` の3段階に従う
- 各指摘の根拠には、要求の ID か、上の情報源を示す
