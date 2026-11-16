---
description: Check, commit, push and open a PR for the current task
---

Finish the current task:

1. Run `stylua src` and `selene src`. Fix every error.
2. If the Roblox Studio MCP is connected, playtest with `start_stop_play`, read `get_console_output`, and fix any errors caused by this change. If not connected, say so.
3. `git status` — make sure only files related to this task changed. If anything unrelated changed, tell me and don't commit it.
4. Commit with a conventional message, e.g. `feat(shop): add buy button`.
5. Push the branch and open a PR to `main` with `gh pr create`, filling in `.github/pull_request_template.md`. Link the issue with "Closes #N".
6. Do NOT merge.
7. Reply with: files changed, how to test, what must exist in Studio, known issues.
