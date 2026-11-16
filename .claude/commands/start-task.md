---
description: Start work on a GitHub issue safely (branch, read docs, plan)
argument-hint: <issue-number>
---

Start work on GitHub issue #$ARGUMENTS.

1. Read `CLAUDE.md`, `docs/ARCHITECTURE.md` and `docs/GAME_DESIGN.md`.
2. Run `gh issue view $ARGUMENTS` to read the task. If `gh` isn't available, ask me to paste it.
3. `git checkout main && git pull origin main`, then create a branch `feature/<short-name>` (or `fix/...` for bugs).
4. Read the existing code in the area this task touches.
5. Before writing code, reply with a short plan:
   - Files you will create or change
   - Any files owned by another system that you'd need to touch (and ask me first)
   - Any remotes or config you'll add
   - What must exist in Studio (models, parts, UI) for this to work
6. Wait for me to say "go" before implementing.
