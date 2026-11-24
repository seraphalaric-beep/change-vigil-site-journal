$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$root = Split-Path $PSScriptRoot -Parent
$source = [Drawing.Bitmap]::new((Join-Path $root 'docs/memory-well.png'))
function Export-Artwork($name, $crop, $width, $height) {
    $bitmap = [Drawing.Bitmap]::new($width, $height)
    $graphics = [Drawing.Graphics]::FromImage($bitmap)
    try {
        $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::NearestNeighbor
        $graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::Half
        $destination = [Drawing.Rectangle]::new(0, 0, $width, $height)
        $graphics.DrawImage($source, $destination, $crop, [Drawing.GraphicsUnit]::Pixel)
        $bitmap.Save((Join-Path $root $name), [Drawing.Imaging.ImageFormat]::Png)
    } finally {
        $graphics.Dispose()
        $bitmap.Dispose()
    }
}
try {
    $banner = [Drawing.Rectangle]::new(0, 68, 1536, 497)
    $icon = [Drawing.Rectangle]::new(86, 694, 262, 262)
    Export-Artwork 'assets/banner-1544x500.png' $banner 1544 500
    Export-Artwork 'assets/banner-772x250.png' $banner 772 250
    Export-Artwork 'assets/icon-256x256.png' $icon 256 256
    Export-Artwork 'assets/icon-128x128.png' $icon 128 128
    Export-Artwork 'ui/public/well-mark.png' $icon 64 64
    $scene = [Drawing.Rectangle]::new(800, 130, 736, 436)
    Export-Artwork 'ui/public/well-scene.png' $scene 220 130
} finally {
    $source.Dispose()
}
