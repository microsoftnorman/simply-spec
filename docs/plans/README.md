# Implementation Plans

Store implementation plans and progress tracking here.

## Structure

```
plans/
└── [project-name]/
    ├── implementation-plan.md   # Detailed step-by-step plan
    ├── todo.md                  # Progress checklist
    └── notes.md                 # Optional: implementation notes
```

## Creating a New Plan

1. Create project folder: `mkdir plans/my-project`
2. Use the `spec-to-implementation-plan` skill to generate from a spec
3. Or copy template from `.github/skills/spec-to-implementation-plan/templates/implementation-plan-template.md`

## Keeping Plans Updated

### After Each Step
```markdown
## Step 2.1: Database Schema
- [x] Schema created        ← Mark completed
- [x] Migrations run        ← Mark completed
- [ ] Tests written         ← Still pending
```

### In todo.md
```markdown
- [x] Step 1.1: Project setup
- [x] Step 1.2: Express app
- [ ] Step 2.1: Database schema  ← Currently working
- [ ] Step 2.2: Validation schemas
```

## Linking to Spec

Always reference the source spec:
```markdown
**Based on:** [../../specs/project-name/spec.md](../../specs/project-name/spec.md)
```
