# Architecture

## How the code is organised

```
src/
├── Server/                     → ServerScriptService.Server   (server only)
│   ├── init.server.luau          loader: requires Services, calls Init → Start
│   └── Services/                 one file per server system
├── Client/                     → StarterPlayerScripts.Client  (each player)
│   ├── init.client.luau          loader: requires Controllers, calls Init → Start
│   └── Controllers/              one file per client system
└── Shared/                     → ReplicatedStorage.Shared     (both sides)
    ├── Remotes.luau              every RemoteEvent declared here
    ├── Config/GameConfig.luau    tuning numbers
    └── Util/                     helper modules
```

### Lifecycle
1. Loader requires every module (files starting with `_` are skipped).
2. `Init()` runs on all of them — set up state and listeners. No calling other services.
3. `Start()` runs on all of them — now they can talk to each other.

### Server vs client
- **Services (server)**: game rules, currency, damage, saving data. Source of truth.
- **Controllers (client)**: UI, input, camera, sounds, visual effects. Only *asks* the server.
- **Remotes**: the only bridge between them. Server validates every request.

## Who owns what: Rojo (Git) vs Studio

| Content | Owned by | Edited where |
|---|---|---|
| Everything in `src/` (scripts) | **Git + Rojo** | VS Code / Claude Code |
| Workspace (map, parts, terrain) | **Studio** | Team Create place |
| Models/assets in ReplicatedStorage/ServerStorage (outside `Shared`) | **Studio** | Team Create place |
| StarterGui layouts built visually | **Studio** | Team Create place |
| Lighting, sounds, SoundService | **Studio** | Team Create place |

Rule: Rojo only manages the three folders above (`Server`, `Client`, `Shared`).
It leaves everything else in Studio alone. **Never edit those three folders inside Studio.**

## System ownership

Fill this in as you assign work. One owner per system; others ask before editing.

| System | File(s) | Owner |
|---|---|---|
| Player setup / leaderstats | `Services/PlayerService.luau` | _unassigned_ |
| Remotes | `Shared/Remotes.luau` | everyone (add only) |
| Game config | `Shared/Config/GameConfig.luau` | everyone (add only) |
