---
name: blog-memo-ingest
description: Use when adding a user-provided memo verbatim into an Astro Markdown blog draft, choosing an existing post or proposing a new post with slug, title, categories, and frontmatter before editing.
---

# Blog Memo Ingest

ユーザーから渡されたメモを、Astro Markdown Blog の記事メモ欄へ一語一句変えずに転記するための workflow。

対象リポジトリは `astro-markdown-blog` を想定する。別リポジトリで使う場合は、同等の Markdown 記事構成、frontmatter、メモ欄見出しがあるか確認してから使う。

## Hard Rules

- メモ本文は要約、整形、校正、表記ゆれ修正、Markdown 化をしない。
- ユーザーが渡したメモ本文は、一語一句同じ状態で `## メモ` 欄へ入れる。
- 対象記事が未確定の場合は、候補を出してユーザーに確認する。
- 既存記事への追記、新規記事作成、frontmatter 提案のいずれも、編集前にユーザーの明示的な OK を得る。
- 新規記事を作る場合は、タイトル、slug、カテゴリ、frontmatter を提案し、承認後に作成する。
- `## メモ` の固定見出しを使う。
- メモ欄は1記事につき1つだけにする。
- Git 操作、Notion 更新、既存記事本文のリライトは、明示指示がない限り行わない。

## 前提運用

記事は `src/content/posts/blog/*.md` に置く。

公開状態は frontmatter の `status` で管理する。

- `private`: 非公開。書いたが公開をやめたい記事、公開対象にしない記事
- `draft`: 執筆中で、公開する意思がある記事
- `published`: 公開記事

執筆状態は `writingStatus` で管理する。

- `writing`: 進行中
- `planned-high`: 進行予定高
- `planned-mid`: 進行予定中
- `todo`: 未着手
- `done`: 執筆完了

メモ欄は次の形式にする。

```md
## メモ

ここにメモを書く
```

## Workflow

1. ユーザーが追加したいメモ本文を確定する。
2. `src/content/posts/blog/**/*.md` から関連しそうな既存記事を探す。
   - タイトル、slug、カテゴリ、本文中の語を広めに検索する。
   - 指示されたファイルや用語が見当たらない場合は、大小文字、typo、表記ゆれを疑って探索する。
3. 既存記事候補と新規作成案を提示する。
4. ユーザーに対象を確認する。
   - 既存記事に追記
   - 新規記事を作成
   - ユーザーが別ファイルを指定
5. 編集方針を確認する。
6. ユーザーの OK 後にだけ Markdown を編集する。
7. `npm run posts:board` を実行して、`status` / `writingStatus` / メモ欄状態を確認する。

## 既存記事へ追記する場合

対象ファイルに `## メモ` 欄がある場合は、その中の末尾へ追記する。

```md
## メモ

既存メモ

---

追加メモを一語一句そのまま
```

`---` は複数メモを区切るために追加してよい。ユーザーのメモ本文そのものは変更しない。

対象ファイルに `## メモ` 欄がない場合は、Markdown 末尾に `## メモ` 欄を作成し、メモ本文をそのまま入れる。

`## メモ` 見出しが複数ある場合は `BROKEN_MEMO` として扱い、修正方針を提示してユーザー確認を取る。

## 新規記事を作成する場合

新規記事が必要な場合は、編集前に次を提案する。

- `title`
- `slug`
- `categories`
- `status`
- `writingStatus`
- 作成先ファイルパス

デフォルト値:

```yaml
thumbnail: "/images/thumbnail/noimage.webp"
githubUrl: ""
status: "draft"
writingStatus: "todo"
```

`publishedAt` と `updatedAt` は作業日の JST 日付にする。

frontmatter 例:

```yaml
---
title: "提案タイトル"
publishedAt: "YYYY-MM-DD"
updatedAt: "YYYY-MM-DD"
thumbnail: "/images/thumbnail/noimage.webp"
githubUrl: ""
categories:
  - 提案カテゴリ
status: "draft"
writingStatus: "todo"
---
```

本文の初期形:

```md
ここに本文を書く

## メモ

ユーザーのメモ本文を一語一句そのまま
```

## 提案時の注意

- slug は既存ファイル名と衝突しないように確認する。
- カテゴリは `src/constants/categories.ts` と `public/admin/config.yml` の既存候補から選ぶ。
- 既存カテゴリに合うものがない場合は、勝手に新規カテゴリを追加せず、カテゴリ追加案として提示してユーザー確認を取る。
- 新規カテゴリを提案する場合は、カテゴリ名、理由、影響ファイルを示す。
- メモ本文に秘密情報、トークン、個人情報らしき内容がある場合は、転記前にユーザーへ確認する。
- Notion から取得した本文でも、意味を変えず、情報量を減らさず、原文を保持する。
