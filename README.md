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
