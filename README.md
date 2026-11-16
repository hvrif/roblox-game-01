# roblox-game-01

Team Roblox project. Scripts live in Git and sync to Studio with Rojo.
Each developer builds with their own Claude Code session connected to their own Roblox Studio.

**New here? Do the setup below once, then read `docs/WORKFLOW.md`.**

---

## One-time setup (each developer, ~30 min)

### 1. Accounts
- [ ] Roblox account, joined the team's Roblox **Group** (ask the Lead for an invite)
- [ ] Age check done on Roblox (needed for Team Create)
- [ ] GitHub account, accepted the invite to the team's GitHub **organisation**

### 2. Install tools
| Tool | Get it |
|---|---|
| Roblox Studio | https://create.roblox.com |
| Git | https://git-scm.com |
| GitHub CLI (`gh`) | https://cli.github.com → then run `gh auth login` |
| VS Code | https://code.visualstudio.com (accept the recommended extensions when prompted) |
| Claude Code | https://docs.claude.com/en/docs/claude-code |
| Rokit (toolchain manager) | https://github.com/rojo-rbx/rokit |

### 3. Get the code + toolchain
```bash
git clone https://github.com/<YOUR-ORG>/roblox-game-01.git
cd roblox-game-01
rokit install          # installs the exact Rojo / StyLua / Selene versions from aftman.toml
rojo plugin install    # installs the Rojo plugin into Roblox Studio
```

### 4. Connect Claude Code to Roblox Studio (MCP)
1. Open Roblox Studio (latest version).
2. **Assistant → … → Manage MCP Servers** → turn on **Enable Studio as MCP server**.
3. Under **Quick connect**, turn on **Claude Code**.
   If that doesn't work, run this in a terminal instead:
   - Windows: `claude mcp add roblox-studio -- cmd.exe /c %LOCALAPPDATA%\Roblox\mcp.bat`
   - Mac: `claude mcp add roblox-studio -- /Applications/RobloxStudio.app/Contents/MacOS/StudioMCP`
4. Restart Claude Code. Ask it: *"List my open Roblox Studio windows."* It should find yours.

> Each person's Claude only controls **their own** Studio on **their own** computer. Git is what keeps everyone in sync.

### 5. Make your personal test place
See "Places" in `docs/WORKFLOW.md`. Short version: open the team's Dev place → **File → Save to File As** → `my-test.rbxl` → open it → Rojo plugin → **Connect** (after running `rojo serve`).

---

## Everyday commands
```bash
rojo serve          # sync your files into Studio (keep running while you work)
stylua src          # format code
selene src          # lint code
```

In Claude Code:
- `/start-task 12` — begin work on issue #12 (makes a branch, reads docs, plans first)
- `/finish-task` — check, commit, push and open a PR
- `/review-pr 15` — have Claude review a teammate's PR

## Project layout
```
src/Server/Services/       server systems (game rules, currency, data)
src/Client/Controllers/    client systems (UI, input, effects)
src/Shared/                shared modules, Remotes, Config
docs/                      design, architecture, workflow, team
CLAUDE.md                  rules every Claude session follows
```
