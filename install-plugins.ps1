$ErrorActionPreference = "Stop"
$repoPath = $PSScriptRoot

Write-Host "Adding marketplace: dev-quality-toolkit ($repoPath)"
claude plugin marketplace add $repoPath

Write-Host "Installing plugin: agent-architect"
claude plugin install agent-architect@dev-quality-toolkit

Write-Host "Installing plugin: developer"
claude plugin install developer@dev-quality-toolkit

Write-Host "Installing plugin: teacher"
claude plugin install teacher@dev-quality-toolkit

Write-Host "Done. Run 'claude plugin list' to verify."
