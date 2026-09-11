---
name: cat-lineart-generator
description: Generate a transparent PNG of one consistent refined feline line-art character for recurring website use. Preserve the canonical character identity, proportions, gentle feline charm, structural plausibility, and small-size graphic readability across poses.
---

# 猫線画ジェネレーター

同一のスタイライズドな猫キャラクターを、個体性・基本体格・画風を保ったまま別ポーズで生成する。

この猫は単体の作品イラストではなく、Webサイト内で継続的に使用する visual motif / brand-adjacent IP / symbolic site character として扱う。

画像生成には `imagegen` を使用し、生成前にその Skill も読む。詳細な固定個体仕様が存在する場合は [identity-spec.md](references/identity-spec.md) も読む。

## 基本原則

優先順位は次の通りとする。

1. 同じ猫として認識できること
2. canonical reference の体格・比率を維持すること
3. 猫らしい柔らかさと控えめな可愛らしさがあること
4. Webデザイン内で記号として読みやすいこと
5. 猫として構造的に無理のないポーズであること
6. 洗練された簡潔な線画であること
7. 今回指定された動作・視点・構図を満たすこと

解剖学的妥当性は、最終画面に骨格を説明するためではなく、破綻を防ぐための内部的な設計制約として扱う。写実性、筋肉表現、骨格表現を強める理由にしてはならない。

## キャラクターの方向性

この猫は、成猫らしい自然な体格を持ちながら、柔らかく親しみのある存在として表現する。求める印象は gentle、charming、softly feline、quiet、refined、understated、slightly playful、approachable without becoming childish。

可愛らしさは許可し、むしろ必要とする。ただし、子猫体型、chibi、極端に大きな頭・肉球・目、幼児向けマスコット表現、過度に丸い玩具的シルエットでは表現しない。柔らかな輪郭、自然な仕草、静かな表情性、猫らしい曲線、控えめな非対称性から作る。

## 体格・品種・個体特徴

基準体格は、軽やかで柔軟な一般的な成猫とする。胴体は自然な長さで、胸郭・肩・筋肉の隆起を強調しない。四肢は自然で繊細、肉球は控えめ、腹部には必要に応じてごく自然な柔らかな曲線を許可する。頭は胴体に対して適度な大きさ、耳は自然な三角形とする。強そう・運動能力が高そうに見せる必要はない。

既定では品種名を指定しない。品種名は顔貌、耳、体格、毛色など不要な特徴まで誘導する可能性があるため、必要な形態特徴は canonical reference と固定個体仕様で定義する。ユーザーが明示的に品種を指定した場合のみ追加する。

ポーズが変わっても、torso length、torso depth、head-to-body ratio、head size、ear length・shape・ear-to-head proportion、neck length、foreleg・hind-leg anatomical length、limb thickness、paw size、tail-base placement・thickness、tail taper、anatomical tail length、顔パーツの省略ルール、線幅・線質、全体のデザイン言語は原則として変更しない。ポーズや遠近による見かけ上の短縮は許可するが、underlying body plan を変更してはならない。

## Proportion lock と尻尾

この猫は毎回新しく解釈される猫ではなく、同じ固定個体である。canonical reference に合わせて胴体の長さと厚み、頭と胴体の比率、耳、前脚・後脚、脚の太さ、肉球、尻尾の付け根・太さ・taper・解剖学的長さを維持する。visible projection は変えてよいが、underlying proportions は変更してはならない。

尻尾は identity-critical feature とする。tail-base placement、anatomical tail length、tail-base thickness、taper を維持する。方向、カーブ、上下、巻き方は変えてよいが、遠近や曲線を理由に解剖学的な長さ自体を変えない。

## 入力の扱い

可変にできるものは `POSE`、`VIEW`、`DIRECTION`、頭の角度、四肢位置、尻尾の方向・カーブ、接地状態、シーン上の前提、線パターン、透過検証の実行有無である。固定仕様は聞き直さない。

- ユーザーが指定済みの項目は聞き直さない。ポーズから自然に決められる細かな項目はモデル側で判断してよい。結果を大きく左右する複数の意味ある候補がある場合だけ確認する。
- 線パターンが未指定なら、必ず次の二択で確認する。`A. 連続輪郭（continuous-outline）` — 連続した滑らかな輪郭線で描く。`B. 分離シルエット（separated-silhouette）` — 部位の輪郭をつなげず、清潔な隙間を残す。ユーザーには「A / B のどちらにしますか？」と聞く。
- 透過検証の実行有無が未指定なら、必ず次の二択で確認する。`A. 透過検証を実行する`、`B. 透過検証をスキップする（推奨）`。ユーザーには「A / B のどちらにしますか？」と聞く。
- 現在の要求だけからポーズを決める。過去の生成や参照画像のポーズを再利用・推測しない。
- 固定仕様の変更、尻尾比率の変更、複数個体化は、明示的な変更依頼として扱う。

## 生成前の合意

生成前に、猫の状態・動作、視点・向き、シーン上の前提、構図、想定用途、使用する参照画像と各役割、canonical identity と維持する比率、今回変更する要素、構造上注意すべき点、線として省略・抽象化できる部分、線パターン、透過検証を整理する。情報が十分なら細かな再確認を繰り返さない。運用上ユーザー承認が必要な場合は、生成設計を提示して明示的な承認を得る。

承認が必要な場合は承認前に `imagegen` を呼び出さない。承認後は、承認された設計に沿ってプロンプトを調整し、固定仕様または明示された可変条件以外を追加しない。

## 参照画像

参照画像が利用可能なら、生成設計を提示する前に確認し、承認後に `imagegen` へ渡す。役割を混同しない。

1. `canonical_identity` — 同一個体性と体格を決定する最優先参照。理想的には自然な横向き立位を使い、頭身、耳、胴体、首、四肢、肉球、尻尾、body plan を継承する。強いポーズ変形は継承しない。
2. `neutral_proportion` — `canonical_identity` がない場合に、中立的な体格比率を判断する補助参照。
3. `style_identity` — 線質、抽象化、スタイライズ、キャラクターらしさの参照。強いポーズ由来の変形を body proportions の基準にしない。

既定の `style_identity` 参照は次の2枚である。どちらもポーズや体型の主参照にはしない。

1. `assets/style-identity-01.png`
2. `assets/style-identity-02.png`

ローカルの参照画像は `view_image` で確認してから、役割を明記して生成リクエストへ含める。追加の参照画像がある場合は、生成設計で役割を確認してから使う。

体格の優先順位は `canonical_identity`、`neutral_proportion`、固定仕様、スタイルの優先順位は `style_identity`、canonical reference とする。中立姿勢がない場合、強い伸び・丸まり・屈曲ポーズを形状マスターにしてはならない。

## 構造的妥当性と線の抽象化

猫として成立する underlying structure を維持する。頭・首・胴体の接続、胸郭と骨盤、前脚・後脚の関節方向と接続位置、weight-bearing、paws の接地、尻尾の付け根、胴体の自然な屈曲を破綻させない。broken joint logic、floating paws、fused limbs、impossible limb attachment、boneless rubber-like torso deformation、骨盤から不自然に離れた尻尾を避ける。

解剖学は invisible scaffold として使用する。構造が成立した後は、可読性、可愛らしさ、流れ、美しさのために線を編集・省略・抽象化してよい。耳と頭、首と肩、胸郭、骨盤、膝や足首、paw への細かな接続を、構造上必要だからという理由だけで描かない。smooth visual rhythm、graceful contour continuity、feline softness、small-size readability を優先し、over-articulated joints、construction-like anatomy、不要な contour bumps を避ける。

## 生成

承認済みの生成設計に基づき、組み立てたプロンプトでは固定ブロックを常に含め、可変条件だけを今回の要求で置換する。透明背景を生成時に指定し、白背景を後処理で透過化しない。

```text
Use case: recurring website illustration asset
Asset type: transparent feline editorial line-art character for web UI and reusable SVG-oriented design
Input images: <available references and their roles>
Primary request: Render the same established feline character in the requested pose and view. Change the pose, not the identity. This is the same canonical cat, not a newly reinterpreted cat.
Identity and proportions: Use the canonical reference as the authority. Preserve torso length and depth, head-to-body ratio, head size, ear length and shape, ear-to-head proportion, neck length, foreleg and hind-leg anatomical length, limb thickness, paw size, tail-base placement, tail thickness, tail taper, and anatomical tail length. Perspective may change visible projection, never the underlying body plan.
Character and structure: A gentle, charming adult domestic cat with a soft feline presence: quietly cute, warm, refined, and slightly playful without becoming infantile or mascot-like. Use natural, softly rounded, light and supple forms. Maintain believable head, neck, torso, pelvis, limb, paw, weight-bearing, and natural tail attachment relationships. Anatomy is an invisible scaffold; simplify visible lines for charm, clear silhouette, and graphic elegance rather than describing skeleton, muscles, joints, chest, or shoulders.
Style/medium: Sophisticated minimal feline line art with gentle charm, editorial and art-book sensibility adapted for modern web design. Favor soft curves, controlled asymmetry, elegant gesture, generous negative space, selective simplification, and small-size readability. Use smooth, clean continuous contours; marker-like monoline with a consistent black stroke about 0.7% of the canvas short edge; rounded caps and joins; no brush-pressure variation, tapering, dry-brush texture, or calligraphic stroke. No fill, shading, gradients, hatching, texture, fur rendering, or sketchy repeated strokes.
Line pattern: Use continuous outline (連続輪郭, `continuous-outline`) by default. When the user explicitly requests separated silhouette (分離シルエット, `separated-silhouette`), draw each anatomical form as an independent open silhouette contour. Keep the body, tail, and any separately articulated limbs visually related but never connect, overlap, or cross their contour strokes. Leave deliberate clean gaps at anatomical junctions, using the same monoline weight and rounded caps. Retain every other Style/medium requirement.
Pose: <current request only>
View and direction: <current request only>
Composition/framing: One isolated cat. Choose the canvas aspect ratio to fit the cat's pose rather than forcing a square canvas. Keep ears, paws, body, and tail fully visible.
Scene/backdrop: Fully transparent background.
Constraints: A visually refined, restrained, and elegant feline silhouette; preserve the defined body build and tail ratios; no prior pose carry-over.
Avoid: kitten or chibi proportions, oversized head, paws, or eyes, childish mascot treatment, overly rounded toy-like anatomy, visible muscular definition, strong skeletal articulation, construction-like anatomy, unnecessary contour bumps, cartoon facial expression, realistic fur or facial rendering, dense internal detail, decorative clutter, props unless requested, text, shadow, floor, background elements, eyes, nose, whiskers, or decorative facial marks.
```

## 生成後の品質確認と修正

生成後、保存前に一度だけ視覚確認する。canonical reference と同じ猫として見え、頭身・耳・脚・肉球・尻尾の比率が維持されていること、四肢・接地・尻尾の接続が自然であること、骨格を説明しすぎず柔らかなシルエットであること、小サイズでも読みやすくUIやタイポグラフィと共存できることを確認する。

個体性、体格、構造、抽象化、用途適合性のいずれかに明確な問題がある場合だけ、問題点を限定して1回だけ編集または再生成してよい。画像全体を再解釈させず、修正後も重大な問題が残る場合は自動で再生成を繰り返さない。

生成後は、ユーザーが選択した場合だけ保存前に透過状態を確認する。スキップを選択した場合は検証コマンドを呼ばず、透過状態を保証しない。どちらの場合も、選んだ PNG は Downloads に保存する。

透過検証を実行する場合、出力 PNG のローカルパスを特定したら、まず次を実行して透過状態を確認する。

```sh
python3 scripts/validate_and_save_png.py <generated-png-path> --check
```

`needs_transparency_edit` が `true` の場合は、その画像を `view_image` で確認してから `imagegen` の編集対象にする。編集では、猫の線・形・構図を一切変えず、背景だけを完全な透明背景にするよう依頼する。透明化編集は 1 回だけ行い、再出力を同じコマンドで確認する。再出力も透過を確認できなければ、保存せずに失敗理由を報告してユーザーの指示を待つ。透過検証をスキップした場合、この編集フローも行わない。

## 透過検証と保存

選んだ生成 PNG は必ず OS の Downloads に、依頼内容から決めた説明的な kebab-case 名で非上書き保存する。

透過検証を実行する場合は、選んだ生成 PNG のローカルパスを特定して、次を実行する。

```sh
python3 scripts/validate_and_save_png.py <generated-png-path> --name <descriptive-kebab-case-name>
```

透過検証をスキップする場合は、次を実行する。

```sh
python3 scripts/validate_and_save_png.py <generated-png-path> --name <descriptive-kebab-case-name> --skip-validation
```

`--check` は出力の透過状態だけを JSON で報告し、保存はしない。通常実行では、8-bit RGBA PNG・四辺の完全透明を検査してから Downloads に非上書きコピーする。`--skip-validation` は PNG 形式だけを確認して非上書きコピーし、透過状態を保証しない。検証に失敗した場合は、上記の透明化編集を 1 回だけ行う。透明化後も失敗した場合、または保存に失敗した場合は、別形式への変換、背景除去、別保存先への自動フォールバックは行わない。保存は外部ディレクトリへの書き込みなので、実行環境の承認が必要なら直前に取得する。

最終報告には必要に応じて、使用した参照画像と各役割、canonical identity の扱い、最終生成プロンプト、個体比率・構造・線の抽象化の確認結果、透過検証結果、保存先を含める。
