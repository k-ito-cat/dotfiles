# PROFILEファイルのパスはOnedriveの方を指しているが、そのファイルではこのファイルへの参照を貼っているため、PowerShell起動時はここに記述あるコードが実行される

# pecoでghqリポジトリを一覧表示してCtrl+]が押されたときにそのリポジトリをCursorで開く
function Open-GhqRepositoryInCode {
    $repo = ghq list | peco
    if ($repo) {
        cursor (Join-Path (ghq root) $repo)
    }
}
Set-PSReadLineKeyHandler -Key Ctrl+] -ScriptBlock {
    Open-GhqRepositoryInCode
}

# ターミナルのスタイリング
oh-my-posh init pwsh --config "$HOME\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json" | Invoke-Expression