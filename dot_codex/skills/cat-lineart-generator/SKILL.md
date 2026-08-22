---
name: cat-lineart-generator
description: Generate a transparent PNG of one consistent sophisticated feline line-art character in a user-requested pose. Use only when explicitly invoked for this reusable cat asset; do not use for unrelated cat images.
---

# 猫線画ジェネレーター

同一のスタイライズドな猫キャラクターを、画風・体型・尻尾の解剖学的長さを変えずに別ポーズで生成する。`imagegen` を使用し、画像を生成する前にその Skill も読む。生成前に猫の状態とシーンを整理し、承認された生成設計だけを画像化する。

## 入力の扱い

可変なのは `POSE`、`VIEW`、`DIRECTION`、シーン上の前提、必要時だけ頭の角度・尻尾の姿勢・接地基準線との関係・四肢位置である。線パターンは既定の `continuous-outline` を維持し、ユーザーが明示した場合だけ `separated-silhouette` に切り替える。固定仕様は聞き直さない。

- 画像生成の前に必ず、猫の状態・動作、視点・向き、シーン上の前提、構図を確認する。ユーザーがすでに指定している場合は、聞き直す代わりにその内容を生成設計へ記載する。
- 結果を左右する項目が未指定なら、一問ずつ確認する。例: 「横向き・正面・斜めのどれにしますか？」
- 尻尾の姿勢がポーズから決まらない場合は、立てる・体に添える・脚に巻く・横へ伸ばす・下げるのどれかを確認する。続けて、描かない接地基準線に対して接する・上に保つ・下へ出してよいのどれかを確認する。
- 現在の要求だけからポーズを決める。過去の生成や参照画像のポーズを再利用・推測しない。
- 固定仕様の変更、尻尾比率の変更、複数個体化は、明示的な変更依頼として扱う。

## 生成前の合意

情報が揃ったら、画像を生成せずに次の「生成設計」を提示し、ユーザーの明示的な承認を得る。これは毎回必須であり、ユーザーが詳細な依頼をしていても省略しない。

- 猫の状態・動作
- 視点・向き
- シーン上の前提と、描くもの／描かないもの
- 構図（全身を切らないこと）
- 使用する参照画像と各画像の役割
- 固定仕様（体型、尻尾、顔パーツ、線画表現）
- 線パターン（明示指定時のみ）
- 生成プロンプト案

承認前に `imagegen` を呼び出さない。承認後は、承認された設計に沿ってプロンプトを調整し、固定仕様または明示された可変条件以外を追加しない。

## 参照画像

参照画像が利用可能なら、生成設計を提示する前に確認し、承認後に `imagegen` へ渡す。役割を混同しない。

1. `style_identity` — 線・スタイライズ表現・キャラクターらしさを保つ。伸びなどのポーズ由来の体型変形は継承しない。
2. `neutral_proportion` — 自然に立つ横向きの中立姿勢がある場合だけ、体幹・脚・尻尾の比率の主参照にする。

既定の `style_identity` 参照は次の2枚である。どちらもポーズや体型の主参照にはしない。

1. `assets/style-identity-01.png`
2. `assets/style-identity-02.png`

ローカルの参照画像は `view_image` で確認してから、役割を明記して生成リクエストへ含める。追加の参照画像がある場合は、生成設計で役割を確認してから使う。

中立姿勢がない場合、`style_identity` を形状マスターと呼ばない。詳細な固定仕様は [identity-spec.md](references/identity-spec.md) を読む。

## 生成

承認済みの生成設計に基づき、組み立てたプロンプトでは固定ブロックを常に含め、可変条件だけを今回の要求で置換する。透明背景を生成時に指定し、白背景を後処理で透過化しない。

```text
Use case: illustration-story
Asset type: reusable UI/content cat asset
Input images: <available references and their roles>
Primary request: The same sophisticated feline line-art character in a new pose. Do not reuse or infer a previous pose; derive the action, orientation, and viewing angle only from this request.
Identity and proportions: A consistent, balanced feline form with a slightly elongated torso, modest head, moderately slim limbs, and natural triangular ears. Stylization is allowed when it serves visual balance, gesture, and elegance; it must not become baby-animal, chibi, mascot-like, or softly cartoonish. Keep paws and head proportionate, avoiding exaggerated roundness. Draw no eyes and no nose. A single short, quiet mouth line is allowed; do not add other facial marks. Keep the same body proportions, torso thickness, head size, limb thickness, ear shape, tail thickness, and tail anatomy across all outputs. Tail centerline length, from tail base to tip along its curve, is 1.00 times torso centerline length, from neck base to tail base, with only ±5% tolerance. Tail direction and curvature may change, but anatomical length may not.
Style/medium: A sophisticated, restrained contemporary feline line illustration with a calm, slightly aloof character. It should feel like an art-book or editorial illustration: elegant, graphic, and visually intentional rather than warm, cute, or playful. Favor elongated proportion, controlled asymmetry, a sculptural silhouette, and generous negative space over literal anatomical detail or cartoon expression. Use smooth, clean continuous contours; marker-like monoline with a consistent black stroke about 0.7% of the canvas short edge; rounded caps and joins; no brush-pressure variation, tapering, dry-brush texture, or calligraphic stroke. Use restrained internal detail only; no fill; no shading; no gradients; no hatching; no texture; no fur rendering.
Line pattern: Use `continuous-outline` by default. When the user explicitly requests `separated-silhouette`, draw each anatomical form as an independent open silhouette contour. Keep the body, tail, and any separately articulated limbs visually related but never connect, overlap, or cross their contour strokes. Leave deliberate clean gaps at anatomical junctions, using the same monoline weight and rounded caps. Retain every other Style/medium requirement.
Pose: <current request only>
View and direction: <current request only>
Composition/framing: One isolated cat. Choose the canvas aspect ratio to fit the cat's pose rather than forcing a square canvas. Keep ears, paws, body, and tail fully visible.
Scene/backdrop: Fully transparent background.
Constraints: A visually refined, restrained, and elegant feline silhouette; preserve the defined body build and tail ratios; no prior pose carry-over.
Avoid: friendly character design, approachable mascot tone, cute, playful charm, mascot character, logo-like simplification, rounded simplified silhouette, soft cartoon appeal, chibi, baby-animal proportions, oversized head, oversized rounded paws, overly symmetrical front-facing icon composition, cartoon expression, children's-book cuteness, decorative facial features, background, white backdrop, ground line, floor, shadow, props, text, decorative elements, hair strands, eyes, nose, realistic facial rendering, sketchy or repeated strokes.
```

生成後は、保存前に透過状態だけを確認する。成果物の見た目や構図の受け入れ検査・再生成は行わない。

出力 PNG のローカルパスを特定したら、まず次を実行して透過状態を確認する。

```sh
python3 scripts/validate_and_save_png.py <generated-png-path> --check
```

`needs_transparency_edit` が `true` の場合は、その画像を `view_image` で確認してから `imagegen` の編集対象にする。編集では、猫の線・形・構図を一切変えず、背景だけを完全な透明背景にするよう依頼する。透明化編集は 1 回だけ行い、再出力を同じコマンドで確認する。再出力も透過を確認できなければ、保存せずに失敗理由を報告してユーザーの指示を待つ。

## 検証と保存

選んだ生成 PNG のローカルパスを特定して、次を実行する。

```sh
python3 scripts/validate_and_save_png.py <generated-png-path> --name <descriptive-kebab-case-name>
```

`--check` は出力の透過状態だけを JSON で報告し、保存はしない。通常実行では、8-bit RGBA PNG・四辺の完全透明を検査してから、OS の Downloads に非上書きコピーする。RGBA または透明辺の検証に失敗した場合は、上記の透明化編集を 1 回だけ行う。透明化後も失敗した場合、または保存に失敗した場合は、別形式への変換・背景の除去・別保存先へのフォールバックはしない。失敗理由を報告し、ユーザーの指示を待つ。保存は外部ディレクトリへの書き込みなので、実行環境の承認が必要なら直前に取得する。

最終報告には、使用した参照画像の役割、最終プロンプト、検証結果、保存先を含める。
