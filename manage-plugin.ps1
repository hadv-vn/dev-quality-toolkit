$ErrorActionPreference = "Stop"
$repoPath = $PSScriptRoot

$allPlugins = @(
    @{ Name = "agent-architect"; Description = "Thiet ke va tao moi cac AI sub-agent chuyen nghiep" }
    @{ Name = "developer"; Description = "Review commit (Android, Qt C++/C), code Python, bao mat, hieu nang" }
    @{ Name = "teacher"; Description = "Agent giao vien GDCD / Giao duc kinh te va phap luat" }
    @{ Name = "my-style"; Description = "Nguyen tac va phong cach ca nhan ap dung xuyen suot moi du an" }
)

Write-Host ""
Write-Host "=== Ban muon lam gi? ==="
Write-Host "  [1] Install (cai dat plugin)"
Write-Host "  [2] Uninstall (go cai dat plugin)"
Write-Host ""
$action = Read-Host "Chon 1 hoac 2"

switch ($action) {
    "2" { $mode = "uninstall" }
    default { $mode = "install" }
}

Write-Host ""
if ($mode -eq "install") {
    Write-Host "=== Danh sach plugin co the cai dat ==="
}
else {
    Write-Host "=== Danh sach plugin co the go cai dat ==="
}
for ($i = 0; $i -lt $allPlugins.Count; $i++) {
    $p = $allPlugins[$i]
    Write-Host ("  [{0}] {1} - {2}" -f ($i + 1), $p.Name, $p.Description)
}
Write-Host "  [0] Tat ca"
Write-Host ""

$verbVi = if ($mode -eq "install") { "cai" } else { "go" }
$answer = Read-Host "Go so thu tu (vd: 1 3) hoac ten plugin (vd: developer teacher), hoac 0 de $verbVi tat ca"

$tokens = $answer -split '[\s,]+' | Where-Object { $_ -ne "" }

if ($tokens.Count -eq 0 -or $tokens -contains "0") {
    $selected = $allPlugins | ForEach-Object { $_.Name }
}
else {
    $selected = @()
    foreach ($t in $tokens) {
        if ($t -match '^\d+$') {
            $idx = [int]$t - 1
            if ($idx -ge 0 -and $idx -lt $allPlugins.Count) {
                $selected += $allPlugins[$idx].Name
            }
            else {
                Write-Warning "So thu tu khong hop le: $t (bo qua)"
            }
        }
        else {
            $match = $allPlugins | Where-Object { $_.Name -eq $t }
            if ($match) {
                $selected += $t
            }
            else {
                Write-Warning "Khong tim thay plugin: $t (bo qua)"
            }
        }
    }
}

$selected = $selected | Select-Object -Unique

if (-not $selected -or $selected.Count -eq 0) {
    Write-Host "Khong co plugin nao duoc chon. Da huy."
    exit 0
}

if ($mode -eq "uninstall") {
    $confirm = Read-Host "Xac nhan go cai dat: $($selected -join ', ') ? (y/N)"
    if ($confirm -notmatch '^(y|Y)$') {
        Write-Host "Da huy."
        exit 0
    }

    foreach ($plugin in $selected) {
        Write-Host "Uninstalling plugin: $plugin"
        claude plugin uninstall "$plugin@dev-quality-toolkit"
    }
}
else {
    Write-Host ""
    Write-Host "Adding marketplace: dev-quality-toolkit ($repoPath)"
    claude plugin marketplace add $repoPath

    foreach ($plugin in $selected) {
        Write-Host "Installing plugin: $plugin"
        claude plugin install "$plugin@dev-quality-toolkit"
    }
}

Write-Host ""
Write-Host "Done. Run 'claude plugin list' to verify."
