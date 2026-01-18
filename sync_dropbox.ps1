# Backup script for syncing Dropbox to external drive using rclone
# Usage: .\sync_dropbox.ps1 [-r remote_name] [-p remote_path] [-t target_dir]
# Options:
#   -r  Remote name (default: dropbox)
#   -p  Remote path to sync (default: root)
#   -t  Target directory (default: script directory)
#   -h  Show this help message
# Examples:
#   .\sync_dropbox.ps1                           # sync dropbox root to script dir
#   .\sync_dropbox.ps1 -p /Documents             # sync /Documents to script dir
#   .\sync_dropbox.ps1 -t D:\backup              # sync dropbox root to custom dir
#   .\sync_dropbox.ps1 -r mydropbox -p /Photos -t D:\backup
#
# EXECUTION POLICY:
# If you get an error about execution policy, run this command in PowerShell as Administrator:
#     Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Or run this script with:
#     powershell -ExecutionPolicy Bypass -File .\sync_dropbox.ps1

# Configuration defaults
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RemoteName = "dropbox"
$RemotePath = ""
$TargetDir = $ScriptDir

# Parse flags
function Show-Help {
    Get-Content $MyInvocation.ScriptName | Select-Object -Skip 1 -First 14 | ForEach-Object { $_ -replace '^# ?', '' }
    exit 0
}

$i = 0
while ($i -lt $args.Count) {
    switch ($args[$i]) {
        "-r" { $RemoteName = $args[$i + 1]; $i += 2 }
        "-p" { $RemotePath = $args[$i + 1]; $i += 2 }
        "-t" { $TargetDir = $args[$i + 1]; $i += 2 }
        "-h" { Show-Help }
        default { Show-Help }
    }
}

# Check if rclone is installed
$rcloneCommand = Get-Command rclone -ErrorAction SilentlyContinue
if (-not $rcloneCommand) {
    Write-Host "Error: rclone is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install rclone first:"
    Write-Host "  Option 1: choco install rclone"
    Write-Host "  Option 2: scoop install rclone"
    Write-Host "  Option 3: Download from https://rclone.org/downloads/"
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if remote exists
$remotes = & rclone listremotes 2>$null
$remoteExists = $remotes | Where-Object { $_ -eq "${RemoteName}:" }

if (-not $remoteExists) {
    Write-Host "Error: Remote '${RemoteName}' not found" -ForegroundColor Red
    Write-Host ""
    Write-Host "Available remotes:"
    $remotes | ForEach-Object { Write-Host "  $_" }
    Write-Host ""
    Write-Host "To configure a remote, run: rclone config"
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Build the source path
if ([string]::IsNullOrEmpty($RemotePath)) {
    $Source = "${RemoteName}:"
    Write-Host "Syncing entire ${RemoteName} to ${TargetDir}" -ForegroundColor Green
} else {
    # Normalize path separators
    $RemotePath = $RemotePath.Replace("\", "/")
    $Source = "${RemoteName}:${RemotePath}"
    Write-Host "Syncing ${RemoteName}:${RemotePath} to ${TargetDir}" -ForegroundColor Green
}

# Confirmation prompt
Write-Host ""
Write-Host "This will sync from:"
Write-Host "  Source: ${Source}"
Write-Host "  Destination: ${TargetDir}"
Write-Host ""
$confirmation = Read-Host "Continue? (y/n)"

if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Host "Sync cancelled"
    exit 0
}

# Run the sync
Write-Host "`nStarting sync...`n" -ForegroundColor Yellow

& rclone sync $Source $TargetDir `
    --progress `
    --verbose `
    --transfers 4 `
    --checkers 8 `
    --contimeout 60s `
    --timeout 300s `
    --retries 3 `
    --low-level-retries 10 `
    --stats 1s `
    --exclude "._*"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Sync complete!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Sync failed with exit code: $LASTEXITCODE" -ForegroundColor Red
}
