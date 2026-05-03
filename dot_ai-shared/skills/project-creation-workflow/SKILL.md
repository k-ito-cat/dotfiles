---
name: project-creation-workflow
description: Use when creating a new project from monorepo-template while managing docs in project-documents. Copy project-documents/_template to project-documents/<project>, replace project/docs with a symlink, verify the result, and do not push or pull unless explicitly asked.
---

# Project Creation Workflow

新規プロジェクト作成時に、アプリケーションコードと docs 実体を分離して初期化する。

## 正本

- docs 運用方針: `project-documents/README.md`
- docs ひな形: `project-documents/_template/`
- code ひな形: `monorepo-template/`

## 手順

1. プロジェクト名と作成先を確認する。
2. `monorepo-template` から新規プロジェクトを作成する。
3. `project-documents/_template` を `project-documents/<project>` にコピーする。
4. プロジェクト側に実体の `docs` がある場合は、削除前に内容を確認し、ユーザーへ確認する。
5. プロジェクト側に `docs -> ../project-documents/<project>` の symlink を貼る。
6. symlink 先、docs 構成、README の整合を確認する。

## 必須ルール

- `project-documents/_template` を docs ひな形の正本として扱う。
- `monorepo-template/docs` は使わない。
- 既存 `docs` 実体を削除・置換する前に必ずユーザーへ確認する。
- push / pull は明示指示があるまで行わない。
- プロジェクト名の表記ゆれ、大小文字違い、typo を疑って既存ディレクトリを確認する。

## 確認

```sh
test -L <project>/docs
readlink <project>/docs
find project-documents/<project> -maxdepth 2 -type d | sort
```
