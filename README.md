# SkeletonCrew 🦴 — an AI employee team for solo / non-technical founders

**English** · [한국어](./README.ko.md)

> *Skeleton crew*: the minimum staff needed to keep an operation running. A solo founder runs an entire company with nothing but an **AI skeleton crew**.

A bundle of **9 AI employees** (Claude Code custom subagents) that takes a single idea — handed over by a **solo developer or a non-developer** — and carries it all the way through **product → free-tier operation → scale-up**, in conversation with the PM. Version-controlled and shared via git.

## What it does
- **Idea → product**: the PM shapes specs/PRDs, designer & engineers build, QA & security gate, devops ships.
- **Runs for free**: every employee knows [free-for-dev](https://github.com/ripienaar/free-for-dev) — hosting, DB, CDN, LLM inference on free tiers.
- **Never goes stale**: when upstream tools & knowledge evolve, `sync` keeps the employees' awareness current.

## The crew
| Employee | Role |
|----------|------|
| `product-manager` | idea → spec / PRD / roadmap |
| `product-designer` | UX/UI & design system |
| `ai-engineer` | AI/LLM features |
| `backend-developer` | API · DB · logic |
| `frontend-developer` | UI implementation |
| `qa-engineer` | real-run bug verification |
| `security-officer` | pre-launch security gate |
| `devops-engineer` | deploy · infra · monitoring (SRE) |
| `growth-marketer` | GTM & growth |

Standard pipeline: **PM → designer / engineers → QA → security → devops → growth.** Employees never talk to each other directly — everything routes through you (the CEO).

## How to call the crew

**1. By name (most reliable).** Just put the employee's name in a normal sentence — any language works (it's not an `@` mention).
```
have product-manager turn this idea into a PRD
get backend-developer to find the root cause of this bug
ask qa-engineer to test the login flow
```

**2. Auto-delegation (no name).** Describe the task and the main agent routes it by each employee's `description`.
```
what should I do first to productize this idea?   → product-manager
this screen looks bland, design it                → product-designer
is it safe to ship security-wise?                 → security-officer
let's deploy                                      → devops-engineer
```

**3. In parallel.** Independent work can run several employees at once.
```
for this idea: PM writes the PRD and the designer drafts mockups, in parallel
```

> Each employee works in its **own context** and returns only the final result to the main chat, so delegating big tasks keeps your main thread clean.

## Customize — rename employees, tweak personas, add new ones
Every employee is a single file: `agents/<name>.md`.
```markdown
---
name: product-manager      # ← the call handle. Rename this and you call them by the new name.
description: when to use this employee   # ← drives auto-delegation; make triggers concrete
---
(system prompt = persona, mindset, skills, working style, collaboration)
```
- **Rename an employee** → change the `name:` field (and the filename to match). e.g. `name: cto` → now you call `cto`.
- **Add a new employee** → drop in a new `.md` in the same format.
- **Tune a persona** → edit the body **outside** the `<!-- managed -->` block (that block is auto-synced; everything else is yours).
- **Auto-delegation not firing?** → make the `description` more specific with trigger phrases.

After editing, the change is live immediately (`~/.claude/agents` is symlinked to this repo) — then `git commit` / `push`.

## Four upstream sources
| Source | Type | Role |
|--------|------|------|
| [garrytan/gstack](https://github.com/garrytan/gstack) | skill | execution tools. auto-updated via `/gstack-upgrade` |
| [phuryn/pm-skills](https://github.com/phuryn/pm-skills) | skill | PM · strategy · GTM. updated via marketplace |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | knowledge | autonomous-research methodology → injected into personas |
| [ripienaar/free-for-dev](https://github.com/ripienaar/free-for-dev) | knowledge | free-tier catalog → injected into personas |

> Skills update through their own updaters, so they are **not** vendored into this repo — copying them would go stale instantly and bloat the repo. Employees reference skills **by name**, so tool improvements flow in automatically. The repo only tracks a **snapshot** of which skills exist and how that changes over time. See [`REFERENCES.md`](./REFERENCES.md).

## Install (new machine)
```bash
git clone https://github.com/hwanython/skeletoncrew-agents.git
cd skeletoncrew-agents && ./install.sh   # symlinks ~/.claude/agents → this repo
```

## Management routine
```bash
bash sync/sync.sh     # 1) snapshot the skill catalog  2) fetch knowledge sources  3) summarize changes (SYNC-REPORT.md)
                      # then tell Claude: "update the agents per sync/SYNC.md"
```
Only the `<!-- managed -->` block is regenerated; handwritten personas are preserved.

## Layout
```
agents/            9 personas (core = handwritten, <!-- managed --> = auto-synced)
sources/
  sources.json     4 sources + employee mapping
  manifests/       skill-catalog snapshot (change history)
  knowledge/       distilled digests (free-for-dev, autoresearch)
sync/              snapshot.py · sync.sh · SYNC.md (the AI-side procedure)
install.sh         wire into ~/.claude
```

## License
[MIT](./LICENSE) © 2026 hwanython
