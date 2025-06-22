# This file was generated with AI, proceed with caution.

function Manage-Symlinks {
    param (
        [array]$PathPairs # Array of hashtables with 'Target' and 'Source' keys
    )

    foreach ($pair in $PathPairs) {
        $targetPath = $pair['Target']
        $linkSource = $pair['Source']

        # Check if the target file exists
        if (Test-Path $targetPath) {
            Write-Output "File or symlink exists at $targetPath. Deleting..."
            Remove-Item -Path $targetPath -Force
        } else {
            Write-Output "No file found at $targetPath. Proceeding to create symlink."
        }

        # Create symbolic link
        Write-Output "Creating symbolic link from $targetPath to $linkSource..."
        New-Item -ItemType SymbolicLink -Path $targetPath -Target $linkSource

        Write-Output "Symbolic link created successfully for $targetPath."
    }
}

$paths = @(
    @{ Target = "$HOME\AppData\Local\nvim"; Source = "$HOME\projects\dotfiles\nvim\.config\nvim" }
    @{ Target = "$HOME\.wezterm.lua"; Source = "$HOME\projects\dotfiles\wezterm\.config\wezterm\wezterm.lua" }
    @{ Target = "$HOME\AppData\Roaming\zed"; Source = "$HOME\projects\dotfiles\zed\.config\zed" }
)

Manage-Symlinks -PathPairs $paths
