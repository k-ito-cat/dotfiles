# Windows Environment

Windows ホスト側の GUI アプリと Windows 固有設定を管理する。

## Files

- `bootstrap.ps1`: 適用エントリポイント。`configuration.winget` と `apply.ps1` を順に実行する
- `configuration.winget`: WinGet Configuration の正本
- `apply.ps1`: WinGet Configuration で扱いにくい Windows 設定

## Apply

PowerShell で実行する。

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\bootstrap.ps1
```

`winget configure` は冪等なため、繰り返し実行しても安全に収束する。

## Limitations

- `configuration.winget` から行を削除しても、実機からアンインストールはされない。`WinGetPackage` リソースは既定で `Ensure: Present` のため、追加方向のみ宣言的に収束する。
- アプリを恒久的に削除したい場合は、該当リソースに `Ensure: Absent` を明記する必要がある。

## Manual Or Pending

| Item | Status |
| --- | --- |
| Google Japanese IME Muhenkan key setting | Manual setting |

## Notes

- Google Japanese IME may not appear in `winget search`, but an installed environment can report it as `Google.JapaneseIME` from the `winget` source.
- Pencil is managed as `Pencil.Desktop` on Windows. The macOS Homebrew Cask `pencil` is a different deprecated app, so Pencil.dev is not managed by Brewfile.
