# Microsoft Azure Data Studio Troubleshooter

Created by **Dewald Pretorius**.

The repository includes the original `Troubleshooter.ps1` diagnostics and a new guarded `Repair.ps1` helper.

Supported repair actions:

- `Diagnose`
- `ResetCache`
- `FlushDns`

```powershell
.\Repair.ps1 -Action Diagnose
.\Repair.ps1 -Action ResetCache -WhatIf
.\Repair.ps1 -Action ResetCache -Confirm
```

Azure Data Studio must be closed before cache repair. Existing cache folders are preserved as timestamped backups. Each run saves pre-change evidence and a log. Source-reviewed for Windows PowerShell 5.1; not runtime-tested against every extension or data provider.
