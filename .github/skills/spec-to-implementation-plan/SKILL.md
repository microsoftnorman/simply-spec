---
name: spec-to-implementation-plan
description: Expert guide for transforming project specifications into comprehensive, executable implementation plans. Use this when asked to create implementation plans, break down specs into tasks, or prepare step-by-step coding instructions for AI agents.
license: MIT
---

# Spec to Implementation Plan

This skill transforms project specifications into detailed, executable implementation plans that AI coding agents can follow precisely. It analyzes existing project context (instructions, architecture, testing patterns) to create plans that integrate seamlessly with the codebase.

## When to Use This Skill

- Converting a spec.md into an actionable implementation plan
- Breaking down features into implementable steps
- Creating prompt sequences for AI coding agents
- Planning refactoring or migration work
- Preparing detailed technical tasks from PRDs

## Prerequisites

Before creating an implementation plan:

1. **Spec document exists** (`spec.md` or equivalent)
2. **Access to the codebase** (if extending existing project)
3. **Understanding of project conventions** (or ability to discover them)

---

## The Implementation Planning Process

### Overview

```
┌──────────────────┐
│  1. DISCOVERY    │  Analyze existing project context
├──────────────────┤
│  2. DECOMPOSE    │  Break spec into logical chunks
├──────────────────┤
│  3. SEQUENCE     │  Order tasks by dependencies
├──────────────────┤
│  4. DETAIL       │  Write executable prompts
├──────────────────┤
│  5. VERIFY       │  Add checkpoints & criteria
└──────────────────┘
```

---

## Step 1: Discovery - Analyze Project Context

Before writing any plan, gather critical context from the existing project.

### Files to Analyze

| File/Pattern | What to Extract |
|--------------|-----------------|
| `.github/copilot-instructions.md` | Copilot-specific guidelines |
| `.github/instructions/*.md` | Additional instruction files |
| `CLAUDE.md` / `.claude/settings.json` | Claude-specific instructions |
| `CONTRIBUTING.md` | Contribution guidelines |
| `README.md` | Project overview, setup instructions |
| `package.json` / `pyproject.toml` / `Cargo.toml` | Dependencies, scripts, tooling |
| `tsconfig.json` / `eslint.config.*` / `.prettierrc` | Code style configuration |
| `jest.config.*` / `vitest.config.*` / `pytest.ini` | Testing configuration |
| `.env.example` | Required environment variables |
| `src/` structure | Architectural patterns |
| `tests/` structure | Testing patterns |

### Discovery Checklist

```markdown
## Project Context Discovery

### Instruction Files Found
- [ ] .github/copilot-instructions.md
- [ ] CONTRIBUTING.md
- [ ] CLAUDE.md
- [ ] Other: ___

### Architecture Patterns
- [ ] Directory structure analyzed
- [ ] Naming conventions identified
- [ ] Module/component patterns documented
- [ ] Import/export patterns noted

### Testing Patterns
- [ ] Test framework: ___
- [ ] Test file naming: ___
- [ ] Test directory structure: ___
- [ ] Mocking patterns: ___
- [ ] Coverage requirements: ___

### Code Style
- [ ] Linter: ___
- [ ] Formatter: ___
- [ ] Type checking: ___
- [ ] Key conventions: ___

### Build & Deploy
- [ ] Build command: ___
- [ ] Dev command: ___
- [ ] CI/CD pipeline: ___
```

### Discovery Prompt

Use this prompt to analyze an existing project:

```
Analyze this project's structure and conventions to prepare for implementation planning.

Look for and summarize:

1. **Instruction Files**: Check for .github/copilot-instructions.md, CONTRIBUTING.md, 
   CLAUDE.md, or any files that define how code should be written

2. **Architecture**: 
   - Directory structure (src/, lib/, components/, etc.)
   - File naming patterns (camelCase, kebab-case, etc.)
   - Module organization (by feature, by type, etc.)
   - Key abstractions (services, repositories, controllers, etc.)

3. **Testing**:
   - Test framework and configuration
   - Test file locations and naming
   - Common test patterns and utilities
   - Coverage requirements

4. **Code Style**:
   - Linting rules
   - Formatting configuration
   - Type strictness level
   - Import ordering conventions

5. **Dependencies & Scripts**:
   - Key dependencies used
   - Available npm/make/cargo scripts
   - Dev vs production setups

Output a "Project Context Summary" I can use when creating implementation plans.
```

---

## Step 2: Decompose - Break Spec into Chunks

Transform the spec into logical implementation chunks.

### Decomposition Principles

1. **Single Responsibility**: Each chunk does one thing well
2. **Testable**: Each chunk can be verified independently  
3. **Buildable**: Each chunk produces working code
4. **Incremental**: Each chunk builds on previous chunks
5. **Integrated**: No orphaned or dead code

### Chunk Categories

| Category | Description | Typical Size |
|----------|-------------|--------------|
| **Foundation** | Project setup, config, tooling | 1-3 chunks |
| **Data Layer** | Models, schemas, database | 2-5 chunks |
| **Core Logic** | Services, business rules | 3-10 chunks |
| **Interface** | API routes, UI components | 3-10 chunks |
| **Integration** | Wiring, middleware, glue | 1-3 chunks |
| **Polish** | Docs, error handling, logging | 1-3 chunks |

### Decomposition Template

```markdown
## Implementation Chunks

### Foundation
- [ ] F1: Project initialization and tooling setup
- [ ] F2: Configuration and environment setup

### Data Layer  
- [ ] D1: Database schema / data models
- [ ] D2: Data access layer / repositories
- [ ] D3: Seed data / migrations (if needed)

### Core Logic
- [ ] C1: [Core feature 1] service
- [ ] C2: [Core feature 2] service
- [ ] C3: [Shared utilities]

### Interface
- [ ] I1: [API routes / UI for feature 1]
- [ ] I2: [API routes / UI for feature 2]
- [ ] I3: [Shared components / middleware]

### Integration
- [ ] G1: Wire services to routes
- [ ] G2: Error handling & middleware
- [ ] G3: Authentication / authorization

### Polish
- [ ] P1: Documentation
- [ ] P2: Final testing & cleanup
```

---

## Step 3: Sequence - Order by Dependencies

Arrange chunks in implementation order based on dependencies.

### Dependency Rules

1. **Data before logic**: Models exist before services use them
2. **Logic before interface**: Services exist before routes call them
3. **Foundation before features**: Setup before implementation
4. **Utilities before consumers**: Shared code before specific code
5. **Tests alongside code**: Write tests with or immediately after code

### Sequencing Prompt

```
Given these implementation chunks, determine the optimal order:

<CHUNKS>
[List your chunks]
</CHUNKS>

For each chunk, identify:
1. What it depends on (must come before)
2. What depends on it (must come after)
3. Can it be parallelized with other chunks?

Output a sequenced list with dependency notes:

Step N: [Chunk ID] - [Name]
  Depends on: [previous chunks]
  Enables: [future chunks]
  Parallel with: [other chunks at same level] or "None"
```

### Typical Sequence Pattern

```
Phase 1: Setup (can be one chunk)
├── Project init, deps, config

Phase 2: Data Layer (sequential)
├── Step 2.1: Schema/Models
├── Step 2.2: Data access layer
└── Step 2.3: [Validation schemas]

Phase 3: Core Logic (may parallelize)
├── Step 3.1: Service A
├── Step 3.2: Service B (parallel with 3.1 if independent)
└── Step 3.3: Service C (depends on A or B)

Phase 4: Interface (sequential within feature)
├── Step 4.1: Routes for Service A
├── Step 4.2: Routes for Service B
└── Step 4.3: Shared middleware

Phase 5: Integration (sequential)
├── Step 5.1: Wire everything together
├── Step 5.2: End-to-end testing
└── Step 5.3: Documentation
```

---

## Step 4: Detail - Write Executable Prompts

Transform each chunk into a detailed, self-contained prompt.

### Prompt Structure

Each implementation prompt must include:

```markdown
## Step N: [Descriptive Name]

### Context
[Why this step exists, what it builds on, what it enables]

### Project Conventions (from discovery)
[Relevant conventions this step must follow]

### Requirements
[Specific requirements from the spec for this step]

### Implementation Instructions

[Detailed, step-by-step instructions including:]
1. Files to create/modify
2. Exact code patterns to follow
3. Tests to write
4. Integration points

### Acceptance Criteria
- [ ] [Specific, verifiable criterion]
- [ ] [Tests passing]
- [ ] [Functionality working]

### Verification Commands
```bash
[Commands to verify this step is complete]
```

### Troubleshooting
[Common issues and how to resolve them]
```

### Prompt Writing Guidelines

#### Be Specific About Files

**Good:**
```
Create file: src/services/user.service.ts

This file should:
- Export a class UserService
- Have methods: create, findById, findAll, update, delete
- Use the Prisma client from src/lib/prisma.ts
- Follow the pattern in src/services/product.service.ts
```

**Bad:**
```
Create the user service
```

#### Reference Existing Patterns

**Good:**
```
Follow the existing pattern in src/routes/product.routes.ts:
- Use the validate() middleware from src/middleware/validate.ts
- Use asyncHandler wrapper for async routes
- Return responses in format: { data: result }
```

**Bad:**
```
Create routes like the other routes
```

#### Include Test Instructions

**Good:**
```
Create tests in src/services/__tests__/user.service.test.ts:

Test cases:
1. create() - creates user with valid data
2. create() - throws on duplicate email
3. findById() - returns user when exists
4. findById() - returns null when not exists
5. update() - updates fields correctly
6. delete() - soft deletes user

Use the test database setup from tests/setup.ts
Mock external services using vi.mock()
```

**Bad:**
```
Write some tests
```

#### Specify Error Handling

**Good:**
```
Error handling:
- Validation errors: throw ValidationError (caught by errorHandler, returns 400)
- Not found: throw NotFoundError (caught by errorHandler, returns 404)
- Duplicate: throw ConflictError (caught by errorHandler, returns 409)

Import error classes from src/errors/index.ts
```

**Bad:**
```
Handle errors appropriately
```

---

## Step 5: Verify - Add Checkpoints

Add verification points throughout the plan.

### Checkpoint Types

| Type | When | What to Check |
|------|------|---------------|
| **Build** | After code changes | `npm run build` passes |
| **Lint** | After code changes | `npm run lint` passes |
| **Test** | After each step | Relevant tests pass |
| **Manual** | After features | Feature works as expected |
| **Integration** | After major phases | System works end-to-end |

### Checkpoint Template

```markdown
### Checkpoint: [Name]

**Type**: Build / Lint / Test / Manual / Integration

**Commands**:
```bash
npm run build
npm run lint
npm test -- --grep "user"
```

**Expected Results**:
- [ ] Build completes without errors
- [ ] No lint warnings
- [ ] All user tests pass (X tests)

**If Failing**:
1. Check error message for specific file/line
2. Common issue: [description] → Fix: [solution]
3. If stuck, share full error output for debugging
```

### Milestone Checkpoints

Add major checkpoints after each phase:

```markdown
## Milestone: Data Layer Complete

Before proceeding to Core Logic, verify:

- [ ] All models defined in Prisma schema
- [ ] `npm run db:push` completes successfully
- [ ] Can create/read records via Prisma Studio
- [ ] All data validation schemas defined and exported
- [ ] Type definitions generated and importable

**Verification**:
```bash
npm run db:push
npx prisma studio  # Manually verify tables exist
npm run build      # Ensure types compile
```
```

---

## Complete Plan Template

### File: `implementation-plan.md`

```markdown
# Implementation Plan: [Project Name]

Generated: [Date]
Based on: [spec.md location]
Target: [AI agent / tool]

## Project Context Summary

### Discovered Conventions
- **Architecture**: [pattern]
- **Testing**: [framework, patterns]
- **Code Style**: [linter, formatter]
- **Key Dependencies**: [list]

### Instruction Files Applied
- [List all instruction files found and their key rules]

---

## Implementation Overview

| Phase | Steps | Estimated Complexity |
|-------|-------|---------------------|
| Foundation | 2 | Low |
| Data Layer | 3 | Medium |
| Core Logic | 4 | High |
| Interface | 3 | Medium |
| Integration | 2 | Medium |
| **Total** | **14** | |

---

## Phase 1: Foundation

### Step 1.1: Project Initialization

[Full prompt with context, conventions, instructions, verification]

### Step 1.2: Configuration Setup

[Full prompt...]

### Checkpoint: Foundation Complete
[Verification steps]

---

## Phase 2: Data Layer

### Step 2.1: Database Schema

[Full prompt...]

[Continue for all steps...]

---

## Phase N: Final Integration

### Step N.1: End-to-End Wiring

[Full prompt...]

### Step N.2: Documentation

[Full prompt...]

---

## Final Verification Checklist

### Functional Requirements
- [ ] [Requirement from spec]: Verified by [test/manual check]

### Non-Functional Requirements  
- [ ] [Performance target]: Verified by [how]
- [ ] [Security requirement]: Verified by [how]

### Success Criteria from Spec
- [ ] [Criterion 1]
- [ ] [Criterion 2]

---

## Rollback Points

If implementation fails at any point:

| Failed At | Rollback To | How |
|-----------|-------------|-----|
| Phase 2 | Phase 1 complete | `git checkout [commit]` |
| Phase 3 | Phase 2 complete | `git checkout [commit]` |

---

## Notes for AI Agent

1. Execute steps sequentially unless noted as parallelizable
2. Run verification commands after each step before proceeding
3. If a step fails, provide full error output before attempting fix
4. Commit after each successful checkpoint
5. Reference discovered conventions in [Project Context Summary]
```

---

## Master Prompt for Plan Generation

Use this prompt to generate an implementation plan from a spec:

```
Create a comprehensive implementation plan from this specification.

<SPEC>
[Paste spec.md content]
</SPEC>

<PROJECT_CONTEXT>
[Paste discovery results OR "New project - no existing context"]
</PROJECT_CONTEXT>

Follow these steps:

1. **Analyze the spec**: Extract all features, requirements, and technical decisions

2. **Decompose into chunks**: Break down into Foundation, Data Layer, Core Logic, 
   Interface, Integration, and Polish chunks. Each chunk should be:
   - Single responsibility
   - Independently testable
   - Building on previous chunks
   - Producing working code

3. **Sequence by dependencies**: Order chunks so each step has all prerequisites complete

4. **Write detailed prompts**: For each step, include:
   - Context (what it builds on, what it enables)
   - Project conventions to follow
   - Specific implementation instructions
   - Files to create/modify with exact patterns
   - Tests to write
   - Acceptance criteria
   - Verification commands

5. **Add checkpoints**: After each phase, include verification milestones

6. **Create final checklist**: Map spec requirements to verification steps

Output format:
- implementation-plan.md: The complete implementation plan
- todo.md: A checkbox checklist for tracking progress

Make steps small enough to implement safely but large enough to make meaningful progress.
Ensure no orphaned code - every step integrates with previous work.
Include specific code patterns, file paths, and test cases throughout.
```

---

## Example: Converting TaskFlow Spec to Plan

### Input (Spec excerpt)
```markdown
## Feature: Task Management
- Create task with title, description, due date, priority
- Update any task field
- Soft delete with restore capability
```

### Output (Plan excerpt)
```markdown
## Step 3.1: Task Service

### Context
Implements core business logic for task management. Builds on the Prisma schema 
from Step 2.1 and validation schemas from Step 2.3. Routes in Step 4.1 will 
consume this service.

### Project Conventions
- Services are classes exported from src/services/
- Use dependency injection for Prisma client
- Throw custom errors from src/errors/
- All methods are async

### Implementation Instructions

Create file: `src/services/task.service.ts`

```typescript
import { prisma } from '../lib/prisma';
import { CreateTaskInput, UpdateTaskInput, TaskQuery } from '../schemas/task.schema';
import { NotFoundError } from '../errors';

export class TaskService {
  async create(data: CreateTaskInput) {
    // Generate UUID, create with Prisma
    // Handle tag connections if tagIds provided
  }
  
  async findAll(query: TaskQuery) {
    // Build where clause from query
    // Exclude soft-deleted (deletedAt is null)
    // Apply pagination
    // Return { tasks, total, page, limit }
  }
  
  // ... other methods
}

export const taskService = new TaskService();
```

Create file: `src/services/__tests__/task.service.test.ts`

Test cases:
1. create() with valid data returns task with id
2. create() with tagIds connects tags
3. findAll() excludes soft-deleted tasks
4. findAll() filters by status correctly
5. findAll() paginates correctly
6. update() sets completedAt when status → COMPLETED
7. delete() sets deletedAt (soft delete)
8. restore() clears deletedAt

### Acceptance Criteria
- [ ] TaskService class exported
- [ ] All CRUD methods implemented
- [ ] Soft delete working
- [ ] Tag relationships handled
- [ ] All 8 test cases passing

### Verification
```bash
npm test -- src/services/__tests__/task.service.test.ts
```
```

---

## Anti-Patterns to Avoid

❌ **Vague steps**: "Implement the service" → Specify exact methods, patterns, files

❌ **Missing dependencies**: Step requires code from a later step → Resequence

❌ **No verification**: Step has no way to confirm completion → Add tests/commands

❌ **Giant steps**: "Build the entire API" → Break into route groups

❌ **Ignoring conventions**: Plan doesn't follow existing patterns → Do discovery first

❌ **Orphaned code**: Utilities created but never used → Ensure integration

❌ **Missing context**: Assumes agent knows project → Include relevant conventions

---

## Quality Checklist

Before finalizing an implementation plan:

### Completeness
- [ ] All spec requirements mapped to steps
- [ ] All steps have clear acceptance criteria
- [ ] Verification commands for each step
- [ ] Final checklist covers all success criteria

### Sequencing
- [ ] No step depends on a later step
- [ ] Each step produces working code
- [ ] Tests written alongside implementation
- [ ] Checkpoints after each phase

### Clarity
- [ ] File paths are explicit
- [ ] Code patterns shown, not described
- [ ] Errors handling specified
- [ ] Project conventions documented

### Integration
- [ ] No orphaned code
- [ ] Each step builds on previous
- [ ] Final integration step wires everything
- [ ] End-to-end verification included

---

## File Organization

All documentation should be stored in the centralized `docs/` directory:

```
docs/
├── README.md                         # Documentation overview
├── specs/
│   └── [project-name]/
│       └── spec.md                   # Source specification
├── plans/
│   └── [project-name]/
│       ├── implementation-plan.md    # Detailed step-by-step plan
│       └── todo.md                   # Progress checklist
└── context/
    └── [project-name]/
        └── discovery.md              # Project conventions
```

### Standard Workflow

1. Read spec from: `docs/specs/[project]/spec.md`
2. Create discovery at: `docs/context/[project]/discovery.md`
3. Generate plan at: `docs/plans/[project]/implementation-plan.md`
4. Track progress in: `docs/plans/[project]/todo.md`

### Keeping Documents Updated

| Document | Update When |
|----------|-------------|
| `spec.md` | Requirements change, scope changes |
| `discovery.md` | Project conventions change |
| `implementation-plan.md` | Steps complete, new steps added |
| `todo.md` | After each completed step |

### Cross-References

In implementation plans, always link to source:
```markdown
**Based on:** [../../specs/project-name/spec.md](../../specs/project-name/spec.md)
**Context:** [../../context/project-name/discovery.md](../../context/project-name/discovery.md)
```

---

## Summary

1. **Discover** project context (instructions, architecture, testing patterns)
2. **Decompose** spec into logical, testable chunks
3. **Sequence** chunks by dependency order
4. **Detail** each chunk with explicit instructions and code patterns
5. **Verify** with checkpoints, milestones, and final checklist

A great implementation plan turns a spec into a paint-by-numbers guide that an AI agent can execute confidently, step by step, on a tightrope—no guessing required.
