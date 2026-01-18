<#
.SYNOPSIS
    Backup script for syncing Dropbox to external drive using rclone

.DESCRIPTION
    This script syncs content from a Dropbox remote (configured in rclone) to the 
    directory where this script is located (typically an external drive).

.PARAMETER RemoteName
    The name of the rclone remote (default: "dropbox")

.PARAMETER RemotePath
    Optional path within the remote to sync (default: "" which syncs entire remote)

.EXAMPLE
    .\sync_dropbox.ps1
    Syncs entire Dropbox using default "dropbox" remote name

.EXAMPLE
    .\sync_dropbox.ps1 -RemoteName my_dropbox
    Syncs entire Dropbox using custom remote name

.EXAMPLE
    .\sync_dropbox.ps1 -RemoteName dropbox -RemotePath "Work/Projects"
    Syncs specific folder from Dropbox

.NOTES
    EXECUTION POLICY:
    If you get an error about execution policy, run this command in PowerShell as Administrator:
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    
    Or run this script with:
        powershell -ExecutionPolicy Bypass -File .\sync_dropbox.ps1
#>

param(
    [string]$RemoteName = "dropbox",
    [string]$RemotePath = ""
)

# Get script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Function to write colored output
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# Check if rclone is installed
$rcloneCommand = Get-Command rclone -ErrorAction SilentlyContinue
if (-not $rcloneCommand) {
    Write-ColorOutput Red "Error: rclone is not installed"
    Write-Output ""
    Write-Output "Please install rclone first:"
    Write-Output "  Option 1: choco install rclone"
    Write-Output "  Option 2: scoop install rclone"
    Write-Output "  Option 3: Download from https://rclone.org/downloads/"
    Write-Output ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if remote exists
$remotes = & rclone listremotes 2>$null
$remoteExists = $remotes | Where-Object { $_ -eq "${RemoteName}:" }

if (-not $remoteExists) {
    Write-ColorOutput Red "Error: Remote '${RemoteName}' not found"
    Write-Output ""
    Write-Output "Available remotes:"
    $remotes | ForEach-Object { Write-Output "  $_" }
    Write-Output ""
    Write-Output "To configure a remote, run: rclone config"
    Write-Output ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Build the source path
if ([string]::IsNullOrEmpty($RemotePath)) {
    $Source = "${RemoteName}:"
    Write-ColorOutput Green "Syncing entire ${RemoteName} to ${ScriptDir}"
} else {
    # Normalize path separators
    $RemotePath = $RemotePath.Replace("\", "/")
    $Source = "${RemoteName}:${RemotePath}"
    Write-ColorOutput Green "Syncing ${RemoteName}:${RemotePath} to ${ScriptDir}"
}

# Confirmation prompt
Write-Output ""
Write-Output "This will sync from:"
Write-Output "  Source: ${Source}"
Write-Output "  Destination: ${ScriptDir}"
Write-Output ""
$confirmation = Read-Host "Continue? (y/n)"

if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Output "Sync cancelled"
    exit 0
}

# Run the sync
Write-ColorOutput Yellow "`nStarting sync...`n"

& rclone sync $Source $ScriptDir `
    --progress `
    --verbose `
    --transfers 4 `
    --checkers 8 `
    --contimeout 60s `
    --timeout 300s `
    --retries 3 `
    --low-level-retries 10 `
    --stats 1s

if ($LASTEXITCODE -eq 0) {
    Write-Output ""
    Write-ColorOutput Green "✓ Sync complete!"
} else {
    Write-Output ""
    Write-ColorOutput Red "✗ Sync failed with exit code: $LASTEXITCODE"
}
