# Fix Fixed Wing Menu on All HTML Files
# Updates the Fixed Wing submenu structure across all pages

Write-Host "=== FIXING FIXED WING MENU ON ALL HTML FILES ===" -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path "." -Include "*.html" -Recurse | Select-Object -ExpandProperty FullName
$totalFiles = $htmlFiles.Count
$currentFile = 0
$fixedFiles = 0

Write-Host "Found $totalFiles HTML files to update..." -ForegroundColor Cyan
Write-Host ""

foreach ($file in $htmlFiles) {
    $currentFile++
    $fileName = Split-Path $file -Leaf
    $relativePath = $file.Replace((Get-Location).Path + "\", "")
    
    Write-Host "[$currentFile/$totalFiles] Processing: $fileName" -NoNewline
    
    $content = Get-Content $file -Raw
    $fileChanged = $false
    
    # Check if this file has the Fixed Wing menu structure
    if ($content -match 'Fixed Wing.*?dropdown-toggle.*?href="/products/fixed-wing.html"') {
        # This is the old structure that needs to be fixed
        $oldPattern = @'
            <div class="dropdown-submenu">
              <a class="dropdown-item text-capitalize dropdown-toggle" href="/products/fixed-wing.html" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>
              <div class="dropdown-menu">
                <a class="dropdown-item text-capitalize" href="/products/b-52.html">B-52</a>
                <a class="dropdown-item text-capitalize" href="/products/c-130.html">C-130</a>
                <a class="dropdown-item text-capitalize" href="/products/f-15.html">F-15</a>
                <a class="dropdown-item text-capitalize" href="/products/f-16.html">F-16</a>
                <a class="dropdown-item text-capitalize" href="/products/f-a-18.html">F/A-18</a>
                <a class="dropdown-item text-capitalize" href="/products/f-35.html">F-35</a>
                <a class="dropdown-item text-capitalize" href="/products/generic.html">Generic</a>
                <a class="dropdown-item text-capitalize" href="/products/t-6.html">T-6</a>
              </div>
            </div>
'@

        $newPattern = @'
            <div class="dropdown-submenu">
              <a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>
              <div class="dropdown-menu">
                <a class="dropdown-item text-capitalize" href="/products/fixed-wing.html">Fixed Wing Overview</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item text-capitalize" href="/products/b-52.html">B-52</a>
                <a class="dropdown-item text-capitalize" href="/products/c-130.html">C-130</a>
                <a class="dropdown-item text-capitalize" href="/products/f-15.html">F-15</a>
                <a class="dropdown-item text-capitalize" href="/products/f-16.html">F-16</a>
                <a class="dropdown-item text-capitalize" href="/products/f-a-18.html">F/A-18</a>
                <a class="dropdown-item text-capitalize" href="/products/f-35.html">F-35</a>
                <a class="dropdown-item text-capitalize" href="/products/generic.html">Generic</a>
                <a class="dropdown-item text-capitalize" href="/products/t-6.html">T-6</a>
              </div>
            </div>
'@

        $content = $content -replace [regex]::Escape($oldPattern), $newPattern
        $fileChanged = $true
    }
    
    # Also check for the simple link version that might need updating
    if ($content -match 'Fixed Wing.*?href="/products/fixed-wing.html".*?data-bs-toggle="dropdown"') {
        # This is the problematic version where the link has both href and dropdown toggle
        $oldPattern2 = '<a class="dropdown-item text-capitalize dropdown-toggle" href="/products/fixed-wing.html" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>'
        $newPattern2 = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>'
        
        $content = $content -replace [regex]::Escape($oldPattern2), $newPattern2
        
        # Now add the Fixed Wing Overview link after the Fixed Wing toggle
        $fixedWingToggle = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>'
        $fixedWingWithOverview = '<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>
              <div class="dropdown-menu">
                <a class="dropdown-item text-capitalize" href="/products/fixed-wing.html">Fixed Wing Overview</a>
                <div class="dropdown-divider"></div>'
        
        $content = $content -replace [regex]::Escape($fixedWingToggle), $fixedWingWithOverview
        $fileChanged = $true
    }
    
    if ($fileChanged) {
        Set-Content $file $content
        Write-Host " - FIXED" -ForegroundColor Green
        $fixedFiles++
    } else {
        Write-Host " - No changes needed" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "=== FIX SUMMARY ===" -ForegroundColor Green
Write-Host "Total files processed: $totalFiles" -ForegroundColor Cyan
Write-Host "Files fixed: $fixedFiles" -ForegroundColor Green
Write-Host "Files unchanged: $($totalFiles - $fixedFiles)" -ForegroundColor Gray

Write-Host ""
Write-Host "🎉 Fixed Wing menu updated on all HTML files!" -ForegroundColor Green
Write-Host "Fix completed at $(Get-Date)" -ForegroundColor Gray
