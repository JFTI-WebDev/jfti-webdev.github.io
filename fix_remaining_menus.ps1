# Fix Remaining Fixed Wing Menus
# Add Fixed Wing Overview to all files that don't have it

Write-Host "=== FIXING REMAINING FIXED WING MENUS ===" -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path "." -Include "*.html" -Recurse | Select-Object -ExpandProperty FullName
$totalFiles = $htmlFiles.Count
$currentFile = 0
$fixedFiles = 0

Write-Host "Found $totalFiles HTML files to check..." -ForegroundColor Cyan
Write-Host ""

foreach ($file in $htmlFiles) {
    $currentFile++
    $fileName = Split-Path $file -Leaf
    $relativePath = $file.Replace((Get-Location).Path + "\", "")
    
    Write-Host "[$currentFile/$totalFiles] Processing: $fileName" -NoNewline
    
    $content = Get-Content $file -Raw
    $fileChanged = $false
    
    # Check if this file has Fixed Wing but no Fixed Wing Overview
    if ($content -match 'Fixed Wing' -and $content -notmatch 'Fixed Wing Overview') {
        # Fix 1: Update double /products/products/ paths to single /products/ paths
        if ($content -match "/products/products/") {
            $content = $content -replace "/products/products/", "/products/"
            $fileChanged = $true
        }
        
        # Fix 2: Add Fixed Wing Overview link
        # Look for the pattern: Fixed Wing dropdown-toggle with href="#" followed by dropdown-menu
        $pattern = '(<a class="dropdown-item text-capitalize dropdown-toggle" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside">Fixed Wing</a>\s*<div class="dropdown-menu">)'
        
        if ($content -match $pattern) {
            $replacement = '$1
                                <a class="dropdown-item text-capitalize" href="/products/fixed-wing.html">Fixed Wing Overview</a>
                                <div class="dropdown-divider"></div>'
            
            $content = $content -replace $pattern, $replacement
            $fileChanged = $true
        }
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
Write-Host "🎉 All remaining Fixed Wing menus updated!" -ForegroundColor Green
Write-Host "Fix completed at $(Get-Date)" -ForegroundColor Gray
