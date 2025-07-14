# Converts all TIF files in the current directory to JPEG format.
Add-Type -AssemblyName System.Drawing

Get-ChildItem *.tif | ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    
    $encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | 
               Where-Object { $_.MimeType -eq 'image/jpeg' }
    $params = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $params.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
        [System.Drawing.Imaging.Encoder]::Quality, 
        100L
    )
    $img.Save("$($_.DirectoryName)\$($_.BaseName).jpg", $encoder, $params)
    $img.Dispose()
    
    Write-Host "Converted $($_.Name) to $($_.BaseName).jpg"
}
