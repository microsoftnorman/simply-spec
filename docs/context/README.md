# Project Context

Store discovered project context and conventions here.

## Structure

```
context/
└── [project-name]/
    ├── discovery.md      # Full discovery analysis
    └── conventions.md    # Optional: extracted key conventions
```

## Purpose

When creating implementation plans for existing projects, the discovery phase captures:

- Instruction files (`.github/copilot-instructions.md`, `CLAUDE.md`, etc.)
- Architecture patterns
- Testing conventions
- Code style rules
- Build and deployment processes

## Creating Discovery Document

1. Create project folder: `mkdir context/my-project`
2. Use the `spec-to-implementation-plan` skill's discovery phase
3. Or copy template from `.github/skills/spec-to-implementation-plan/templates/discovery-template.md`

## When to Update

- When project conventions change
- When new patterns are established
- After major refactoring
- When onboarding new team members

## Usage

Reference in implementation plans:
```markdown
## Project Context
See: [../../context/project-name/discovery.md](../../context/project-name/discovery.md)
```
