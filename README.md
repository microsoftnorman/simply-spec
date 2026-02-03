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

> **Note:** Existing files are skipped by default to prevent accidental overwrites.  
> Use `-y` (bash) or `-Force` (PowerShell) to auto-approve overwrites, or run interactively to choose per-file.

<details>
<summary>View install.sh script</summary>

```bash
#!/bin/bash
# Simply Spec Installer for Bash/Zsh
# Usage: curl -fsSL https://raw.githubusercontent.com/microsoftnorman/simply-spec/main/install.sh | bash
# Options: 
#   -y, --yes     Auto-approve all overwrites
#   -n, --no      Skip existing files (never overwrite)

set -e

REPO="microsoftnorman/simply-spec"
BRANCH="main"
SKILLS_PATH=".github/skills"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/.github/skills"

# Parse arguments
AUTO_APPROVE=""
SKIP_EXISTING=""
for arg in "$@"; do
    case $arg in
        -y|--yes) AUTO_APPROVE="yes" ;;
        -n|--no) SKIP_EXISTING="yes" ;;
    esac
done

echo -e "\033[36mInstalling Simply Spec skills...\033[0m"

# Create skills directory
mkdir -p "$SKILLS_PATH"

# Function to prompt for overwrite
prompt_overwrite() {
    local file="$1"
    if [[ "$AUTO_APPROVE" == "yes" ]]; then return 0; fi
    if [[ "$SKIP_EXISTING" == "yes" ]]; then return 1; fi
    if [[ -t 0 ]]; then
        echo -en "    \033[33mFile exists: $file. Overwrite? [y/N/a(ll)]: \033[0m"
        read -r response
        case $response in
            [yY]) return 0 ;; [aA]) AUTO_APPROVE="yes"; return 0 ;; *) return 1 ;;
        esac
    else
        echo -e "    \033[33mSkipping existing: $file (use -y to overwrite)\033[0m"
        return 1
    fi
}

# Function to download file with overwrite protection
download_file() {
    local url="$1"
    local dest="$2"
    if [[ -f "$dest" ]]; then
        if ! prompt_overwrite "$dest"; then return 0; fi
    fi
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

# Create docs structure
echo -e "  \033[33mCreating docs structure...\033[0m"
mkdir -p docs/{specs,plans,context}
download_file "https://raw.githubusercontent.com/$REPO/$BRANCH/docs/README.md" "docs/README.md"

echo ""
echo -e "\033[32mDone! Simply Spec installed:\033[0m"
echo -e "\033[32m  - Skills: $SKILLS_PATH\033[0m"
echo -e "\033[32m  - Docs:   docs/\033[0m"
echo ""
echo -e "\033[36mTry it out:\033[0m"
echo '  Ask Copilot: "Create a spec for [your feature]"'
echo ""
```

</details>

### Option 3: Manual
```bash
# Clone and copy to your project
git clone https://github.com/microsoftnorman/simply-spec.git /tmp/simply-spec
mkdir -p .github/skills docs/{specs,plans,context}
cp -r /tmp/simply-spec/.github/skills/* .github/skills/
cp /tmp/simply-spec/docs/README.md docs/
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

After installation, your project will have:

```
your-project/
├── .github/skills/                  # AI agent skills
│   ├── spec-driven-development/     # Spec creation skill
│   │   ├── SKILL.md
│   │   ├── QUICK-REFERENCE.md
│   │   └── templates/
│   ├── spec-to-implementation-plan/ # Planning skill
│   │   ├── SKILL.md
│   │   ├── QUICK-REFERENCE.md
│   │   └── templates/
│   └── agent-skill-creator/         # Skill creation skill
│       ├── SKILL.md
│       ├── QUICK-REFERENCE.md
│       └── examples/
└── docs/                            # Your documentation
    ├── README.md                    # Documentation guide
    ├── specs/                       # Project specifications
    ├── plans/                       # Implementation plans
    └── context/                     # Discovery & context docs
```

See [docs/README.md](docs/README.md) for the full documentation workflow.

## Requirements

- GitHub Copilot with agent mode (VS Code, JetBrains, or CLI)
- Skills must be in `.github/skills/` directory

## License

MIT
