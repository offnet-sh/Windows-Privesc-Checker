# Windows Privilege Escalation Checker

A PowerShell script that performs basic checks for common Windows privilege escalation vectors.  
Designed for use on Windows targets to quickly identify potential security weaknesses.

## Features
- Detects unquoted service paths  
- Identifies services with weak permissions (FullControl to Everyone or Users)  
- Checks if AutoLogon is enabled  

## Requirements
- Windows system with PowerShell  
- Run with appropriate permissions (preferably Administrator)  

## Usage

```powershell
.\WinPrivescCheck.ps1
