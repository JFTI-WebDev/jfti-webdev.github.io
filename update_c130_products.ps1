# Utility script to update all C-130 product pages with new products
# Usage: .\update_c130_products.ps1 -ProductName "Product Name" -ImagePath "image.png" -LinkPath "product-page.html"

param(
    [Parameter(Mandatory=$true)]
    [string]$ProductName,
    [Parameter(Mandatory=$true)]
    [string]$ImagePath,
    [Parameter(Mandatory=$true)]
    [string]$LinkPath
)

$c130ProductFiles = @(
    "products/c-130j-simulated-reference-set-panel.html",
    "products/c-130j-simulated-afcsp-panel.html",
    "products/c-130j-simulated-overhead-engine-start-panel.html",
    "products/c-130j-simulated-overhead-apu-panel.html",
    "products/c-130j-simulated-overhead-fadec-panel.html",
    "products/c-130j-simulated-overhead-hud-panel.html",
    "products/c-130j-simulated-cni-mu.html",
    "products/c-130j-simulated-cnbp.html",
    "products/c-130j-throttle.html",
    "products/c-130h-copilot-yoke-column-with-handle.html",
    "products/c-130h-pilot-yoke-column-with-handle.html",
    "products/c-130j-cursor-control-panel-ccp.html",
    "products/eo-ir-hand-control-unit.html",
    "products/c-130j-pilot-yoke-mechanism-and-handle.html"
)

$oldPlaceholder = "<div class=`"col-lg-3 col-md-4 col-sm-6 mb-4`">
                        <div class=`"text-center d-flex flex-column h-100`">
                            <div class=`"bg-light mb-3`" style=`"height: 200px; display: flex; align-items: center; justify-content: center;`">
                                <i class=`"fas fa-image text-muted`" style=`"font-size: 3rem;`"></i>
                            </div>
                            <h4 class=`"text-primary mb-3`">$ProductName</h4>
                            <a href=`"#`" class=`"btn btn-primary w-100 mt-auto`">View Product</a>
                        </div>
                    </div>"

$newProduct = "<div class=`"col-lg-3 col-md-4 col-sm-6 mb-4`">
                        <div class=`"text-center d-flex flex-column h-100`">
                            <img src=`"../assets/img/images/Products/$ImagePath`" alt=`"$ProductName`" class=`"img-fluid mb-3`" style=`"max-height: 200px; object-fit: contain;`">
                            <h4 class=`"text-primary mb-3`">$ProductName</h4>
                            <a href=`"/products/$LinkPath`" class=`"btn btn-primary w-100 mt-auto`">View Product</a>
                        </div>
                    </div>"

foreach ($file in $c130ProductFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw
        if ($content -match [regex]::Escape($oldPlaceholder)) {
            $content = $content -replace [regex]::Escape($oldPlaceholder), $newProduct
            Set-Content -Path $file -Value $content -NoNewline
            Write-Host "Updated $ProductName in: $($file.Split('/')[-1])"
        }
    }
}

Write-Host "Product update completed for: $ProductName"
