try {
    Clear-RecycleBin
    Write-Host "Cleaned successfully" -ForegroundColor Green
}
catch {
    Write-Host "Failed to clean the Recycle Bin" -ForegroundColor Red
}