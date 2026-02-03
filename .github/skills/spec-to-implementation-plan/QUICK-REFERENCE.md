# Spec to Implementation Plan - Quick Reference

## The 5-Step Process

```
1. DISCOVER  →  2. DECOMPOSE  →  3. SEQUENCE  →  4. DETAIL  →  5. VERIFY
   Context       Chunks           Order           Prompts       Checkpoints
```

---

## Step 1: Discovery - Files to Check

| File | Extract |
|------|---------|
| `.github/copilot-instructions.md` | Coding rules |
| `CLAUDE.md` | AI-specific rules |
| `CONTRIBUTING.md` | Contribution guidelines |
| `package.json` | Scripts, dependencies |
| `tsconfig.json` / lint config | Code style |
| `src/` structure | Architecture patterns |
| `tests/` or `__tests__/` | Testing patterns |

**Key Question:** What conventions must this plan follow?

---

## Step 2: Decompose - Chunk Categories

| Category | Contains |
|----------|----------|
| Foundation | Setup, config, tooling |
| Data Layer | Models, schemas, DB |
| Core Logic | Services, business rules |
| Interface | Routes, UI, API |
| Integration | Wiring, middleware |
| Polish | Docs, cleanup |

**Key Question:** What are the smallest testable units?

---

## Step 3: Sequence - Dependency Rules

1. Data before logic
2. Logic before interface
3. Foundation before features
4. Utilities before consumers
5. Tests alongside code

**Key Question:** What must exist before this step?

---

## Step 4: Detail - Prompt Structure

```markdown
## Step N.N: [Name]

### Context
[Why this step, what it builds on]

### Conventions
[Project patterns to follow]

### Instructions
1. Create file: `path/to/file.ts`
   [Code example]
2. [Next specific action]

### Tests
- [ ] Test case 1
- [ ] Test case 2

### Acceptance Criteria
- [ ] [Verifiable criterion]

### Verification
```bash
[Commands to run]
```
```

**Key Question:** Can an agent execute this without guessing?

---

## Step 5: Verify - Checkpoint Types

| Type | When | Command |
|------|------|---------|
| Build | After code changes | `npm run build` |
| Lint | After code changes | `npm run lint` |
| Test | After each step | `npm test -- [filter]` |
| Manual | After features | Manual testing |
| E2E | After phases | Full flow test |

**Key Question:** How do we know this step succeeded?

---

## Master Prompt

```
Create an implementation plan from this spec.

<SPEC>
[spec content]
</SPEC>

<PROJECT_CONTEXT>
[discovery results or "New project"]
</PROJECT_CONTEXT>

Steps:
1. Extract all features and requirements
2. Decompose into testable chunks
3. Sequence by dependencies
4. Write detailed prompts with:
   - Context and conventions
   - Specific file paths and code
   - Tests and acceptance criteria
   - Verification commands
5. Add phase checkpoints

Output: implementation-plan.md + todo.md
```

---

## Anti-Patterns

| ❌ Don't | ✅ Do |
|---------|-------|
| "Implement the service" | Specify exact methods, files, patterns |
| Skip verification | Add commands for each step |
| Giant steps | Break into testable chunks |
| Ignore conventions | Do discovery first |
| Create orphaned code | Ensure every step integrates |

---

## Quality Checklist

Before executing plan:

- [ ] All spec requirements mapped to steps
- [ ] No step depends on a later step
- [ ] Each step has verification commands
- [ ] Project conventions documented
- [ ] Reference files identified
- [ ] Checkpoints after each phase
- [ ] Final checklist covers success criteria

---

## File Organization

All docs in centralized `docs/` directory:

```
docs/
├── specs/[project]/spec.md              # Input: specification
├── plans/[project]/
│   ├── implementation-plan.md           # Output: detailed plan
│   └── todo.md                          # Output: checklist
└── context/[project]/discovery.md       # Context: conventions
```

**Workflow:**
1. Read: `docs/specs/[project]/spec.md`
2. Discover: `docs/context/[project]/discovery.md`
3. Plan: `docs/plans/[project]/implementation-plan.md`
4. Track: `docs/plans/[project]/todo.md`
