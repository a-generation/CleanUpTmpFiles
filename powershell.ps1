$APPDATA_PATH = [System.Environment]::GetFolderPath('ApplicationData')
$SIX_MONTHS_AGO = (Get-Date).AddMonths(-6)

if (Test-Path $APPDATA_PATH) {
    Get-ChildItem -Path $APPDATA_PATH -Recurse -File -Include *.tmp | ForEach-Object {
        if ($_.LastWriteTime -lt $SIX_MONTHS_AGO) {
            Remove-Item $_.FullName -Force
            Write-Output "Deleted: $($_.FullName)"
        }
    }
} else {
    Write-Output "AppData directory not found."
}
