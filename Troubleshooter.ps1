#requires -Version 5.1
<# Created by Dewald Pretorius #>
param([string]$OutputPath)
if(-not $OutputPath){$OutputPath="$([Environment]::GetFolderPath('Desktop'))\Azure_Data_Studio_Reports"};New-Item $OutputPath -ItemType Directory -Force|Out-Null
$p=Get-Process azuredatastudio -ErrorAction SilentlyContinue
$ext="$env:USERPROFILE\.azuredatastudio\extensions"
$extensions=Get-ChildItem $ext -Directory -ErrorAction SilentlyContinue|Select-Object Name,LastWriteTime
$events=Get-WinEvent -FilterHashtable @{LogName='Application';StartTime=(Get-Date).AddDays(-7)} -ErrorAction SilentlyContinue|Where-Object Message -match 'Azure Data Studio|azuredatastudio'|Select-Object -First 50 TimeCreated,Id,ProviderName,Message
@('MICROSOFT AZURE DATA STUDIO DIAGNOSTICS','Created by Dewald Pretorius',"Generated: $(Get-Date)","Running: $([bool]$p)",'Extensions:',($extensions|Format-Table -AutoSize|Out-String -Width 220),'Events:',($events|Format-List|Out-String -Width 220),'Guidance: test with extensions disabled, verify authentication, certificates, proxy settings, terminal shell, name resolution, and user-profile health.')|Set-Content (Join-Path $OutputPath 'Report.txt') -Encoding UTF8