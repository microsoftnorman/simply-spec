# Simply Spec Installer for PowerShell
# Usage: irm https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.ps1 | iex
# Or with options:
#   .\install.ps1 -Force          Auto-approve all overwrites
#   .\install.ps1 -SkipExisting   Skip existing files (never overwrite)

param(
    [switch]$Force,
    [switch]$SkipExisting
)

$ErrorActionPreference = "Stop"

$repo = "microsoftnorman/simply-spec"
$branch = "main"
$skillsPath = ".github/skills"
$script:AutoApprove = $Force

Write-Host "Installing Simply Spec skills..." -ForegroundColor Cyan

# Function to prompt for overwrite
function Confirm-Overwrite {
    param([string]$FilePath)
    
    if ($script:AutoApprove) { return $true }
    if ($SkipExisting) { return $false }
    
    # Check if running interactively
    if ([Environment]::UserInteractive -and $Host.UI.RawUI) {
        $response = Read-Host "    File exists: $FilePath. Overwrite? [y/N/a(ll)]"
        switch ($response.ToLower()) {
            'y' { return $true }
            'a' { $script:AutoApprove = $true; return $true }
            default { return $false }
        }
    } else {
        Write-Host "    Skipping existing: $FilePath (use -Force to overwrite)" -ForegroundColor Yellow
        return $false
    }
}

# Function to download file with overwrite protection
function Get-RemoteFile {
    param(
        [string]$Url,
        [string]$Destination
    )
    
    if (Test-Path $Destination) {
        if (-not (Confirm-Overwrite -FilePath $Destination)) {
            return
        }
    }
    
    try {
        Invoke-WebRequest -Uri $Url -OutFile $Destination -UseBasicParsing
    } catch {
        Write-Host "    Skipping $(Split-Path $Destination -Leaf) (not found)" -ForegroundColor DarkGray
    }
}

# Create skills directory
if (-not (Test-Path $skillsPath)) {
    New-Item -ItemType Directory -Path $skillsPath -Force | Out-Null
}

# Skills to download
$skills = @(
    "spec-driven-development",
    "spec-to-implementation-plan", 
    "agent-skill-creator"
)

$baseUrl = "https://raw.githubusercontent.com/$repo/$branch/.github/skills"

foreach ($skill in $skills) {
    Write-Host "  Installing $skill..." -ForegroundColor Yellow
    
    $skillPath = Join-Path $skillsPath $skill
    if (-not (Test-Path $skillPath)) {
        New-Item -ItemType Directory -Path $skillPath -Force | Out-Null
    }
    
    # Download main files
    $files = @("SKILL.md", "QUICK-REFERENCE.md")
    foreach ($file in $files) {
        $url = "$baseUrl/$skill/$file"
        $dest = Join-Path $skillPath $file
        Get-RemoteFile -Url $url -Destination $dest
    }
    
    # Download templates if they exist
    $templatesPath = Join-Path $skillPath "templates"
    $templateFiles = switch ($skill) {
        "spec-driven-development" { @("spec-template.md") }
        "spec-to-implementation-plan" { @("implementation-plan-template.md", "discovery-template.md") }
        "agent-skill-creator" { @() }
        default { @() }
    }
    
    if ($templateFiles.Count -gt 0) {
        if (-not (Test-Path $templatesPath)) {
            New-Item -ItemType Directory -Path $templatesPath -Force | Out-Null
        }
        foreach ($file in $templateFiles) {
            $url = "$baseUrl/$skill/templates/$file"
            $dest = Join-Path $templatesPath $file
            Get-RemoteFile -Url $url -Destination $dest
        }
    }
    
    # Download examples if they exist
    $examplesPath = Join-Path $skillPath "examples"
    $exampleFiles = switch ($skill) {
        "spec-driven-development" { @("example-spec-taskflow.md", "example-prompt-plan-taskflow.md") }
        "spec-to-implementation-plan" { @("example-implementation-plan-taskflow.md") }
        "agent-skill-creator" { @("SKILL-TEMPLATE.md", "example-api-endpoint-creator-SKILL.md") }
        default { @() }
    }
    
    if ($exampleFiles.Count -gt 0) {
        if (-not (Test-Path $examplesPath)) {
            New-Item -ItemType Directory -Path $examplesPath -Force | Out-Null
        }
        foreach ($file in $exampleFiles) {
            $url = "$baseUrl/$skill/examples/$file"
            $dest = Join-Path $examplesPath $file
            Get-RemoteFile -Url $url -Destination $dest
        }
    }
}

# Create docs structure
Write-Host "  Creating docs structure..." -ForegroundColor Yellow
$docsFolders = @("docs/specs", "docs/plans", "docs/context")
foreach ($folder in $docsFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }
}

# Download docs README
$docsUrl = "https://raw.githubusercontent.com/$repo/$branch/docs/README.md"
Get-RemoteFile -Url $docsUrl -Destination "docs/README.md"

Write-Host ""
Write-Host "Done! Simply Spec installed:" -ForegroundColor Green
Write-Host "  - Skills: $skillsPath" -ForegroundColor Green
Write-Host "  - Docs:   docs/" -ForegroundColor Green
Write-Host ""
Write-Host "Try it out:" -ForegroundColor Cyan
Write-Host '  Ask Copilot: "Create a spec for [your feature]"'
Write-Host ""
