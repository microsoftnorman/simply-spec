# Simply Spec Installer for PowerShell
# Usage: irm https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

$repo = "microsoftnorman/simply-spec"
$branch = "main"
$skillsPath = ".github/skills"

Write-Host "Installing Simply Spec skills..." -ForegroundColor Cyan

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
        try {
            Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        } catch {
            Write-Host "    Skipping $file (not found)" -ForegroundColor DarkGray
        }
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
            try {
                Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
            } catch {
                Write-Host "    Skipping templates/$file (not found)" -ForegroundColor DarkGray
            }
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
            try {
                Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
            } catch {
                Write-Host "    Skipping examples/$file (not found)" -ForegroundColor DarkGray
            }
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
try {
    Invoke-WebRequest -Uri $docsUrl -OutFile "docs/README.md" -UseBasicParsing
} catch {
    Write-Host "    Skipping docs/README.md (not found)" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "Done! Simply Spec installed:" -ForegroundColor Green
Write-Host "  - Skills: $skillsPath" -ForegroundColor Green
Write-Host "  - Docs:   docs/" -ForegroundColor Green
Write-Host ""
Write-Host "Try it out:" -ForegroundColor Cyan
Write-Host '  Ask Copilot: "Create a spec for [your feature]"'
Write-Host ""
