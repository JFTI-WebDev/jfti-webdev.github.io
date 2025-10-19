# PowerShell script to fix Overview positioning in product pages

Write-Host "Fixing Overview positioning in product pages..."

# Files that need Capabilities menu fix (Overview in middle)
$filesToFix = @(
    "products\t-6.html",
    "products\product-overview.html", 
    "products\other.html",
    "products\generic.html",
    "products\f-a-18.html",
    "products\b-52.html"
)

$updatedFiles = 0

foreach ($file in $filesToFix) {
    if (Test-Path $file) {
        Write-Host "Fixing $file..."
        $content = Get-Content $file -Raw
        
        # Fix Capabilities menu - move Overview to top
        $oldCapabilities = @"
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#additive-manufacturing">Additive Manufacturing</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#electrical-fabrication">Electrical Fabrication</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#engineering-tools">Engineering Tools</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#facilities">Facilities</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#mechanical-fabrication">Mechanical Fabrication</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html">Overview</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#software-development">Software Development</a>
"@

        $newCapabilities = @"
                                <a class="dropdown-item text-capitalize" href="/capabilities.html">Overview</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#additive-manufacturing">Additive Manufacturing</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#electrical-fabrication">Electrical Fabrication</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#engineering-tools">Engineering Tools</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#facilities">Facilities</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#mechanical-fabrication">Mechanical Fabrication</a>
                                <a class="dropdown-item text-capitalize" href="/capabilities.html#software-development">Software Development</a>
"@

        if ($content -match [regex]::Escape($oldCapabilities)) {
            $content = $content -replace [regex]::Escape($oldCapabilities), $newCapabilities
            Set-Content $file -Value $content -NoNewline
            Write-Host "  ✓ Fixed $file"
            $updatedFiles++
        } else {
            Write-Host "  - No changes needed for $file"
        }
    } else {
        Write-Host "  ✗ File $file not found"
    }
}

Write-Host ""
Write-Host "=== SUMMARY ==="
Write-Host "Files processed: $($filesToFix.Count)"
Write-Host "Files updated: $updatedFiles"
Write-Host ""
Write-Host "All product pages have been fixed!"