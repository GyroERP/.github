$labels = @(
    @{name="type:bug"; color="d73a4a"; desc="Defect or incorrect behavior"},
    @{name="type:feature"; color="a2eeef"; desc="New capability or enhancement"},
    @{name="type:task"; color="fef2c0"; desc="Maintenance, refactor, CI, or docs"},
    @{name="type:epic"; color="5319e7"; desc="Large initiative spanning multiple issues"},
    @{name="priority:critical"; color="b60205"; desc="Production impact or urgent"},
    @{name="priority:high"; color="d93f0b"; desc="High priority work"},
    @{name="priority:medium"; color="fbca04"; desc="Normal priority work"},
    @{name="priority:low"; color="0e8a16"; desc="Low priority or nice to have"},
    @{name="module:platform"; color="1d76db"; desc="Infrastructure, CI, tooling"},
    @{name="module:inventory"; color="5319e7"; desc="Inventory and stock"},
    @{name="module:sales"; color="006b75"; desc="Sales and CRM"},
    @{name="module:purchasing"; color="e99695"; desc="Purchasing and suppliers"},
    @{name="module:finance"; color="0052cc"; desc="Finance and accounting"},
    @{name="module:operations"; color="cfd3d7"; desc="Operations and workflows"},
    @{name="module:admin"; color="7057ff"; desc="Administration and RBAC"},
    @{name="status:blocked"; color="000000"; desc="Blocked by dependency or decision"}
)

foreach ($repo in @("backend", "frontend", "database")) {
    Write-Output "=== GyroERP/$repo ==="
    foreach ($label in $labels) {
        gh label create $label.name --repo "GyroERP/$repo" --color $label.color --description $label.desc --force 2>&1 | Out-Null
    }
    Write-Output "Created $($labels.Count) labels"
}
