$ErrorActionPreference = "Stop"

$microsoftJapaneseImeInputTip = "0411:{03B5835F-F03C-411B-9CE2-AA23E1171E36}{A76C93D9-5523-4E90-AAFA-4DB112F9AC76}"

$currentInputMethodOverride = Get-WinDefaultInputMethodOverride

if ($null -eq $currentInputMethodOverride -or $currentInputMethodOverride.InputMethodTip -ne $microsoftJapaneseImeInputTip) {
    Set-WinDefaultInputMethodOverride -InputTip $microsoftJapaneseImeInputTip
}
