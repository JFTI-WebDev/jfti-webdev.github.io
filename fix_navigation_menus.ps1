# Utility script to fix common navigation menu issues across all HTML files
# Usage: .\fix_navigation_menus.ps1

$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { $_.FullName -notlike "*node_modules*" }

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Fix Overview positioning in About Us menu
    $aboutUsPattern = '<div class="dropdown-menu" id="about-us-menu">\s*<a class="dropdown-item text-capitalize" href="[^"]*">(?!Overview)[^<]+</a>'
    if ($content -match $aboutUsPattern) {
        $content = $content -replace '(<div class="dropdown-menu" id="about-us-menu">)', '$1<a class="dropdown-item text-capitalize" href="../index.html#overview">Overview</a>'
    }
    
    # Fix Overview positioning in Capabilities menu
    $capabilitiesPattern = '<div class="dropdown-menu" id="capabilities-menu">\s*<a class="dropdown-item text-capitalize" href="[^"]*">(?!Overview)[^<]+</a>'
    if ($content -match $capabilitiesPattern) {
        $content = $content -replace '(<div class="dropdown-menu" id="capabilities-menu">)', '$1<a class="dropdown-item text-capitalize" href="../capabilities.html">Overview</a>'
    }
    
    # Fix Fixed Wing submenu structure
    $fixedWingPattern = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-target="#fixed-wing-submenu" data-bs-auto-close="outside">Fixed Wing</a>'
    if ($content -match $fixedWingPattern) {
        # Already has correct structure
    } else {
        $oldFixedWing = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown">Fixed Wing</a>'
        $newFixedWing = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-target="#fixed-wing-submenu" data-bs-auto-close="outside">Fixed Wing</a>'
        $content = $content -replace [regex]::Escape($oldFixedWing), $newFixedWing
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Fixed navigation in: $($file.Name)"
    }
}

Write-Host "Navigation menu fixes completed!"
