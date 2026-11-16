# CLAUDE.md — Rules for Claude working on this repo

You are a developer on a small Roblox team. Several humans each run their own Claude Code
session on this repo at the same time. Your job is to build the task you were given
**without breaking anyone else's work**.

Read these before starting any task:
- `docs/ARCHITECTURE.md` — how the code is organised and who owns what
- `docs/GAME_DESIGN.md` — what the game is
- `docs/WORKFLOW.md` — branches, PRs and publishing

---

## 1. Before you write code
- Confirm which **GitHub issue / task** you are working on. If the human didn't say, ask.
- Confirm you are on a **feature branch**, never `main`. If on `main`, create one:
  `git checkout -b feature/<short-name>` (or `fix/<short-name>`).
- Run `git pull origin main` so you start from the latest code.
- Read the existing files in the area you'll touch. Follow the patterns already there.

## 2. Scope — stay in your lane
- Only edit files your task needs. If you must change a file owned by another system
  (see the Ownership table in `docs/ARCHITECTURE.md`), **stop and tell the human first**.
- Never rewrite or "clean up" code unrelated to your task.
- Never delete another service, controller or remote.
- Shared files (`src/Shared/Remotes.luau`, `src/Shared/Config/GameConfig.luau`):
  **add** entries, don't rename or remove existing ones.

## 3. Where code goes (Rojo-managed)
| What | Where | Becomes in Studio |
|---|---|---|
| Server systems | `src/Server/Services/<Name>Service.luau` | ServerScriptService.Server.Services |
| Client systems (UI, input, FX) | `src/Client/Controllers/<Name>Controller.luau` | StarterPlayerScripts.Client.Controllers |
| Shared modules, types, config | `src/Shared/...` | ReplicatedStorage.Shared |
| New remote events | add name to `REMOTE_NAMES` in `src/Shared/Remotes.luau` | ReplicatedStorage.Remotes |

- New service/controller: copy the `_Template.luau` next to it. Must return a table with
  `Name`, optional `Init` and `Start`. No yielding in `Init`. Talk to other systems in `Start`.
- Use `--!strict` at the top of every file.
- File names: `PascalCase.luau`. Variables/functions: `camelCase`. Constants: `UPPER_SNAKE`.

## 4. Rojo vs Studio — critical
- **Scripts live in Git.** Edit the `.luau` files in `src/`. Rojo syncs them into Studio.
- **Never edit a Rojo-managed script inside Studio** (including through the Roblox Studio
  MCP `multi_edit` tool). Rojo will overwrite it and the change will be lost.
- **Studio owns the world**: Workspace, models, terrain, UI layouts made in Studio, sounds,
  lighting. You may inspect these with MCP tools, but only modify them when the human asks.
- If a script needs a model/part, reference it by path (e.g. `workspace:WaitForChild("Map")`)
  and note it in your final report so the builder knows it must exist.

## 5. Roblox security rules (non-negotiable)
- The **server decides** everything that matters: currency, damage, rewards, inventory, stats.
- The client only **asks** (via `Remotes.FireServer`). The server validates every argument:
  type, range, length, cooldown, and whether the player is allowed.
- Never put secrets or admin checks in client or Shared code.
- Use `DataStoreService` only from server code, wrapped in `pcall`, with retries.
- Avoid `while true do` loops without `task.wait()`. Prefer events over polling.

## 6. Testing — don't claim it works without checking
1. `stylua src` then `selene src` — fix all errors.
2. If the Roblox Studio MCP is connected and `rojo serve` is running:
   - `start_stop_play` to playtest, `get_console_output` to read errors.
   - Fix any errors or warnings your change caused.
3. If you can't playtest, say so clearly in your report.

## 7. Finishing a task
- Commit with a clear message: `feat(inventory): add item pickup` / `fix(shop): stop negative coins`.
- Push your branch and open a PR to `main` using the PR template (`gh pr create` if available).
- **Never merge into `main` yourself.** A human reviews and merges.
- Reply to the human with:
  - Files changed and why
  - How to test it in Studio
  - Anything a builder/designer must create in Studio
  - Known issues or TODOs
- If you changed how systems connect, update `docs/ARCHITECTURE.md` in the same PR.
