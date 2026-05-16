# Windows Environment

Windows ホスト側の GUI アプリと Windows 固有設定を管理する。

## Files

- `configuration.winget`: WinGet Configuration の正本
- `apply.ps1`: WinGet Configuration で扱いにくい Windows 設定

## Apply

PowerShell で実行する。

```powershell
winget configure -f .\windows\configuration.winget
powershell -ExecutionPolicy Bypass -File .\windows\apply.ps1
```

## Manual Or Pending

| Item | Status |
| --- | --- |
| Google Japanese IME Muhenkan key setting | Manual setting |

## Notes

- Google Japanese IME may not appear in `winget search`, but an installed environment can report it as `Google.JapaneseIME` from the `winget` source.
- Pencil is managed as `Pencil.Desktop` on Windows. The macOS Homebrew Cask `pencil` is a different deprecated app, so Pencil.dev is not managed by Brewfile.
