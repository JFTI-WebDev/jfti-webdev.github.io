# PowerShell script to revert Contact Us and Employee Login back to separate lines in navigation

$files = @(
    "air-force-sim-and-test.html",
    "avionics-and-aircraft-mods.html", 
    "build-to-print-assemblies.html",
    "capabilities.html",
    "careers.html",
    "contact-us.html",
    "custom-components.html",
    "employee-benefits.html",
    "engineering-and-fabrication.html",
    "facilities_v2.html",
    "facilities-overview.html",
    "ground-based-systems.html",
    "jfti-news.html",
    "news.html",
    "oasis-sb.html",
    "simulation-and-training-systems.html",
    "terms-and-conditions.html",
    "unmanned-and-maritime-systems.html",
    "what-we-do.html",
    "why-jfti.html",
    "products/product-overview.html",
    "products/fixed-wing.html",
    "products/rotorcraft.html",
    "products/other.html",
    "products/b-52.html",
    "products/c-130.html",
    "products/f-15.html",
    "products/f-16.html",
    "products/f-a-18.html",
    "products/f-35.html",
    "products/generic.html",
    "products/t-6.html",
    "products/b-52-adjustable-seat.html",
    "news/bugeye-acquisition.html",
    "news/ccat-acquisition.html",
    "news/fuselage-award.html",
    "news/thriving-business.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Reverting $file..."
        
        # Read the file content
        $content = Get-Content $file -Raw
        
        # Revert the navigation pattern back to separate lines
        $pattern = '(\s*<li class="nav-item"><a class="nav-link" href="/news\.html">News</a></li>\s*<li class="nav-item d-flex">\s*<a class="nav-link" href="/contact-us\.html">Contact Us</a>\s*<a class="nav-link border ms-2" href="https://intranet\.jfti\.com">Employee Login</a>\s*</li>)'
        $replacement = '        <li class="nav-item"><a class="nav-link" href="/news.html">News</a></li>
        <li class="nav-item"><a class="nav-link" href="/contact-us.html">Contact Us</a></li>
        <li class="nav-item text-right"><a class="border nav-link" href="https://intranet.jfti.com">Employee Login</a></li>'
        
        $newContent = $content -replace $pattern, $replacement
        
        # Also handle relative paths for products directory
        $pattern2 = '(\s*<li class="nav-item"><a class="nav-link" href="\.\./news\.html">News</a></li>\s*<li class="nav-item d-flex">\s*<a class="nav-link" href="\.\./contact-us\.html">Contact Us</a>\s*<a class="nav-link border ms-2" href="https://intranet\.jfti\.com">Employee Login</a>\s*</li>)'
        $replacement2 = '        <li class="nav-item"><a class="nav-link" href="../news.html">News</a></li>
        <li class="nav-item"><a class="nav-link" href="../contact-us.html">Contact Us</a></li>
        <li class="nav-item text-right"><a class="border nav-link" href="https://intranet.jfti.com">Employee Login</a></li>'
        
        $newContent = $newContent -replace $pattern2, $replacement2
        
        # Write the updated content back to the file
        Set-Content $file -Value $newContent -NoNewline
        
        Write-Host "Reverted $file"
    } else {
        Write-Host "File not found: $file"
    }
}

Write-Host "Navigation revert complete!"
