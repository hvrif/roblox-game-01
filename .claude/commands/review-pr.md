---
description: Review a teammate's pull request
argument-hint: <pr-number>
---

Review PR #$ARGUMENTS. Do not change code or merge — only review.

1. `gh pr view $ARGUMENTS` and `gh pr diff $ARGUMENTS`.
2. Check against `CLAUDE.md`:
   - Stays in scope? Touches other systems' files without saying so?
   - Server-authoritative? Every remote argument validated (type, range, cooldown)?
   - Any Studio-owned content expected but not documented?
   - Follows folder structure and naming?
   - Anything that could break `main` or other people's systems?
3. Reply with: **Approve / Request changes**, then a short list of issues ranked by severity, each with file + line and a suggested fix.
4. If I say so, post it with `gh pr review $ARGUMENTS --comment --body "..."`.
