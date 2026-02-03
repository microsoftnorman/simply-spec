# Simply Spec

AI-powered specification and implementation planning skills for GitHub Copilot.

## Quick Start (30 seconds)

### Option 1: One-liner (PowerShell)
```powershell
irm https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.ps1 | iex
```

### Option 2: One-liner (Bash/Zsh)
```bash
curl -fsSL https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.sh | bash
```

<details>
<summary>View install.sh script</summary>

```bash
#!/bin/bash
# Simply Spec Installer for Bash/Zsh
# Usage: curl -fsSL https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.sh | bash

set -e

REPO="microsoftnorman/simply-spec"
BRANCH="main"
SKILLS_PATH=".github/skills"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/.github/skills"

echo -e "\033[36mInstalling Simply Spec skills...\033[0m"

# Create skills directory
mkdir -p "$SKILLS_PATH"

# Function to download file silently
download_file() {
    local url="$1"
    local dest="$2"
    curl -fsSL "$url" -o "$dest" 2>/dev/null || true
}

# Install spec-driven-development
echo -e "  \033[33mInstalling spec-driven-development...\033[0m"
mkdir -p "$SKILLS_PATH/spec-driven-development/templates"
mkdir -p "$SKILLS_PATH/spec-driven-development/examples"
download_file "$BASE_URL/spec-driven-development/SKILL.md" "$SKILLS_PATH/spec-driven-development/SKILL.md"
download_file "$BASE_URL/spec-driven-development/QUICK-REFERENCE.md" "$SKILLS_PATH/spec-driven-development/QUICK-REFERENCE.md"
download_file "$BASE_URL/spec-driven-development/templates/spec-template.md" "$SKILLS_PATH/spec-driven-development/templates/spec-template.md"
download_file "$BASE_URL/spec-driven-development/examples/example-spec-taskflow.md" "$SKILLS_PATH/spec-driven-development/examples/example-spec-taskflow.md"
download_file "$BASE_URL/spec-driven-development/examples/example-prompt-plan-taskflow.md" "$SKILLS_PATH/spec-driven-development/examples/example-prompt-plan-taskflow.md"

# Install spec-to-implementation-plan
echo -e "  \033[33mInstalling spec-to-implementation-plan...\033[0m"
mkdir -p "$SKILLS_PATH/spec-to-implementation-plan/templates"
mkdir -p "$SKILLS_PATH/spec-to-implementation-plan/examples"
download_file "$BASE_URL/spec-to-implementation-plan/SKILL.md" "$SKILLS_PATH/spec-to-implementation-plan/SKILL.md"
download_file "$BASE_URL/spec-to-implementation-plan/QUICK-REFERENCE.md" "$SKILLS_PATH/spec-to-implementation-plan/QUICK-REFERENCE.md"
download_file "$BASE_URL/spec-to-implementation-plan/templates/implementation-plan-template.md" "$SKILLS_PATH/spec-to-implementation-plan/templates/implementation-plan-template.md"
download_file "$BASE_URL/spec-to-implementation-plan/templates/discovery-template.md" "$SKILLS_PATH/spec-to-implementation-plan/templates/discovery-template.md"
download_file "$BASE_URL/spec-to-implementation-plan/examples/example-implementation-plan-taskflow.md" "$SKILLS_PATH/spec-to-implementation-plan/examples/example-implementation-plan-taskflow.md"

# Install agent-skill-creator
echo -e "  \033[33mInstalling agent-skill-creator...\033[0m"
mkdir -p "$SKILLS_PATH/agent-skill-creator/examples"
download_file "$BASE_URL/agent-skill-creator/SKILL.md" "$SKILLS_PATH/agent-skill-creator/SKILL.md"
download_file "$BASE_URL/agent-skill-creator/QUICK-REFERENCE.md" "$SKILLS_PATH/agent-skill-creator/QUICK-REFERENCE.md"
download_file "$BASE_URL/agent-skill-creator/examples/SKILL-TEMPLATE.md" "$SKILLS_PATH/agent-skill-creator/examples/SKILL-TEMPLATE.md"
download_file "$BASE_URL/agent-skill-creator/examples/example-api-endpoint-creator-SKILL.md" "$SKILLS_PATH/agent-skill-creator/examples/example-api-endpoint-creator-SKILL.md"

echo ""
echo -e "\033[32mDone! Simply Spec skills installed to $SKILLS_PATH\033[0m"
echo ""
echo -e "\033[36mTry it out:\033[0m"
echo '  Ask Copilot: "Create a spec for [your feature]"'
echo ""
```

</details>

### Option 3: Manual
```bash
# Clone and copy skills to your project
git clone https://github.com/microsoftnorman/simply-spec.git /tmp/simply-spec
mkdir -p .github/skills
cp -r /tmp/simply-spec/.github/skills/* .github/skills/
rm -rf /tmp/simply-spec
```

## What You Get

Three AI agent skills that transform how you plan and build software:

| Skill | Purpose |
|-------|---------|
| **spec-driven-development** | Create comprehensive specs from ideas or prompts |
| **spec-to-implementation-plan** | Transform specs into step-by-step executable plans |
| **agent-skill-creator** | Create new custom skills for your team |

## Usage

After installation, just ask Copilot:

```
"Create a spec for [your feature]"
"Turn this spec into an implementation plan"
"Create a skill for [your workflow]"
```

The skills are automatically detected by GitHub Copilot when placed in `.github/skills/`.

## Workflow

```
IDEA → SPEC → PLAN → CODE
  ↓      ↓      ↓      ↓
Prompt  spec.md  plan.md  Implementation
```

1. **Describe** what you want to build
2. **Generate** a detailed specification
3. **Create** an implementation plan with atomic tasks
4. **Execute** each task with AI assistance

## Project Structure

```
.github/skills/
├── spec-driven-development/     # Spec creation skill
│   ├── SKILL.md                 # Main instructions
│   ├── QUICK-REFERENCE.md       # Cheat sheet
│   └── templates/               # Spec templates
├── spec-to-implementation-plan/ # Planning skill
│   ├── SKILL.md
│   ├── QUICK-REFERENCE.md
│   └── templates/               # Plan templates
└── agent-skill-creator/         # Skill creation skill
    ├── SKILL.md
    ├── QUICK-REFERENCE.md
    └── examples/                # Example skills
```

## Optional: Documentation Structure

Want to organize your specs and plans? Create this structure:

```bash
mkdir -p docs/{specs,plans,context}
```

See [docs/README.md](docs/README.md) for the full documentation workflow.

## Requirements

- GitHub Copilot with agent mode (VS Code, JetBrains, or CLI)
- Skills must be in `.github/skills/` directory

## License

MIT
