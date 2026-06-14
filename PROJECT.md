# GyroERP — Project & ticket workflow

This document defines the **standard way** to create, track, and complete work across
all GyroERP repositories using **GitHub Issues** and **GitHub Projects**.

---

## Overview

| Tool | Role |
|------|------|
| **GitHub Issues** | Source of truth for *what* to do (spec, discussion, acceptance criteria) |
| **GitHub Projects** | Source of truth for *status* (Backlog → Done) across all repos |
| **Pull Requests** | Implementation linked to issues via `Fixes #123` |

**Organization project board:** [GyroERP Development](https://github.com/orgs/GyroERP/projects/3)

---

## Ticket types

Always create tickets using an **issue template** — never a blank issue.

| Template | Prefix | Label | When to use |
|----------|--------|-------|-------------|
| **Bug report** | `[Bug]:` | `type:bug` | Incorrect or broken behavior |
| **Feature request** | `[Feature]:` | `type:feature` | New capability or improvement |
| **Task** | `[Task]:` | `type:task` | Docs, CI, refactor, tooling, chores |
| **Epic** | `[Epic]:` | `type:epic` | Large initiative spanning multiple issues/repos |

### Where to open the issue

Open the issue in the **repository where the code will change**:

| Work affects | Create issue in |
|--------------|-----------------|
| API, Django, business logic | [GyroERP/backend](https://github.com/GyroERP/backend/issues/new/choose) |
| Web UI | [GyroERP/frontend](https://github.com/GyroERP/frontend/issues/new/choose) |
| Schemas, migrations, SQL | [GyroERP/database](https://github.com/GyroERP/database/issues/new/choose) |
| Org profile, shared templates | [GyroERP/.github](https://github.com/GyroERP/.github/issues/new/choose) |

Org-wide templates live in this repo and apply as defaults across the organization.

---

## Labels

Apply labels for filtering on the project board and in search.

### Type (set automatically by templates)

- `type:bug` · `type:feature` · `type:task` · `type:epic`

### Priority (add manually or from template field)

- `priority:critical` — production down, data loss, security-adjacent
- `priority:high` — major feature or serious bug
- `priority:medium` — normal work
- `priority:low` — nice to have

### Module (ERP area)

- `module:platform` · `module:inventory` · `module:sales` · `module:purchasing`
- `module:finance` · `module:operations` · `module:admin`

### Status

- `status:blocked` — waiting on dependency, decision, or external input

---

## Project board — status workflow

Use the **Status** field on [GyroERP Development](https://github.com/orgs/GyroERP/projects):

| Status | Meaning |
|--------|---------|
| **Backlog** | Accepted idea, not scheduled |
| **Ready** | Spec clear, ready to pick up |
| **In progress** | Actively being worked |
| **In review** | Pull request open |
| **Done** | Merged and verified |
| **Blocked** | Cannot proceed |

### Project custom fields

| Field | Values |
|-------|--------|
| **Priority** | Critical · High · Medium · Low |
| **Ticket type** | Bug · Feature · Task · Epic |
| **Module** | Platform · Inventory · Sales · Purchasing · Finance · Operations · Admin |

---

## End-to-end workflow

### 1. Create a ticket

1. Go to **Issues → New issue** in the target repo.
2. Choose the correct template (Bug / Feature / Task / Epic).
3. Fill all required fields.
4. Submit — the issue is created with the correct `type:*` label.

### 2. Add to the project board

1. Open [GyroERP Development](https://github.com/orgs/GyroERP/projects/3).
2. Click **Add item** → search the issue number → add it.
3. Set **Status** to `Backlog` or `Ready`.
4. Set **Priority**, **Type**, and **Module** fields to match the issue.

> Tip: Pin the project board in the org for quick access.

### 3. Start work

1. Move the card to **In progress**.
2. **Always branch from `development`** (backend), not `main`:

```bash
git fetch origin
git checkout development
git pull origin development
git checkout -b feature/123-short-description   # features
git checkout -b fix/123-short-description       # bugs
```

Use the **issue number** in the branch name. See [backend BRANCHING.md](https://github.com/GyroERP/backend/blob/development/BRANCHING.md).

### 4. Open a pull request

PR title format:

```
type: short description (#123)
```

**Feature/fix PRs target `development`**, not `main`.

Examples:

- `feat: add GyroERP kernel scaffold (#12)`
- `fix: correct invoice total rounding (#87)`

PR body must include:

```markdown
Fixes GyroERP/backend#123

## Summary
Brief description of the change.

## Test plan
- [ ] ...
```

Use the correct repo prefix: `GyroERP/backend#`, `GyroERP/frontend#`, or `GyroERP/database#`.

### 5. Promote through release pipeline (backend)

After merge to `development`, code moves via **promotion PRs**:

```
development → staging → beta-release → release/x.y.z → main
```

Each stage requires CI + QA sign-off. See [RELEASE.md](https://github.com/GyroERP/backend/blob/development/RELEASE.md).

### 6. Review and merge

1. Move the project card to **In review**.
2. Wait for **CI checks** to pass.
3. Obtain **one approving review** (branch protection).
4. Merge via GitHub UI.
5. Move the card to **Done** when deployed to the target environment.

---

## Branching rules (backend)

| Rule | Requirement |
|------|-------------|
| New feature/fix | Branch from `development` |
| Branch name | `feature/<issue#>-name` or `fix/<issue#>-name` |
| Direct push to protected branches | **Never** |
| Production release | Only via `release/x.y.z` → `main` + tag `vX.Y.Z` |

Full details: [BRANCHING.md](https://github.com/GyroERP/backend/blob/development/BRANCHING.md)

---

## Epics and sub-tasks

For large work:

1. Create an **Epic** issue.
2. Create child **Feature** / **Task** issues linked in the epic description.
3. Add all issues to the project board.
4. Close the epic when all children are **Done**.

---

## What NOT to track as public issues

| Situation | Action |
|-----------|--------|
| Security vulnerability | Email [security@gyroerp.com](mailto:security@gyroerp.com) — see [SECURITY.md](https://github.com/GyroERP/backend/blob/main/SECURITY.md) |
| Commercial licensing | Email [licensing@gyroerp.com](mailto:licensing@gyroerp.com) |
| Legal / trademarks | Email [legal@gyroerp.com](mailto:legal@gyroerp.com) |
| Customer data or secrets | Never paste in issues |

---

## Quick links

- [Organization profile](https://github.com/GyroERP)
- [Project board](https://github.com/orgs/GyroERP/projects/3)
- [Backend issues](https://github.com/GyroERP/backend/issues)
- [Frontend issues](https://github.com/GyroERP/frontend/issues)
- [Database issues](https://github.com/GyroERP/database/issues)
- [Contributing](https://github.com/GyroERP/backend/blob/main/CONTRIBUTING.md)

---

*GyroERP by Muhammad Ahsan — structured operations for the modern enterprise.*
