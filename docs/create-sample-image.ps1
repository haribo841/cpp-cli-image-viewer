param([string]$OutputPath = (Join-Path $PSScriptRoot 'images/sample-color-bars.png'))

# Deterministic test fixture, not a photograph or generated application mockup.
Add-Type -AssemblyName System.Drawing
$outputDirectory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
$bitmap = [System.Drawing.Bitmap]::new(640, 480)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$palette = @('White', 'Yellow', 'Cyan', 'Lime', 'Magenta', 'Red', 'Blue', 'Black')
try {
    for ($bar = 0; $bar -lt $palette.Count; $bar++) {
        $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromName($palette[$bar]))
        try { $graphics.FillRectangle($brush, $bar * 80, 0, 80, 480) }
        finally { $brush.Dispose() }
    }
    $bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output $OutputPath
}
finally {
    $graphics.Dispose()
    $bitmap.Dispose()
}
