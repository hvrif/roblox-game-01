# Team workflow

## The golden rules
1. **`main` is always playable.** Nobody pushes directly to it.
2. **One task = one branch = one PR.**
3. **One owner per system.** Ask before editing someone else's system.
4. **Only the Lead publishes** to the live game.

## Daily loop (each developer + their Claude)

```
1. Pick an issue on the GitHub Project board → assign yourself → move to "In Progress"
2. git checkout main && git pull
3. git checkout -b feature/<short-name>
4. rojo serve            (in this folder)
5. Open your PERSONAL test place in Studio → Rojo plugin → Connect
6. Tell Claude: "Work on issue #12" (or use /start-task 12)
7. Test in Studio
8. Claude opens a PR → teammate reviews → Lead merges
```

## Places: who connects Rojo where

This matters. Two people syncing different branches into the same Team Create place = chaos.

| Place | Who uses it | Rojo? |
|---|---|---|
| **Personal test place** (one per dev) | You + your Claude | Yes — your branch |
| **Dev place** (Team Create) | Builders + everyone for group testing | Only the Lead, syncing `main` |
| **Live place** | Players | Lead publishes from Dev place after testing |

How to make your personal test place:
1. Open the Dev (Team Create) place in Studio.
2. **File → Save to File As…** → `my-test.rbxl` (ignored by Git).
3. Open `my-test.rbxl`, connect Rojo. Re-save a fresh copy when builders change the map.

## Pull requests
- Use the template. Fill in "How to test".
- At least **one other person** reviews. Claude can help review: `/review-pr <number>`.
- CI must pass (formatting + lint).
- Lead merges with **Squash and merge**.

## Branch names
- `feature/<thing>` — new feature
- `fix/<thing>` — bug fix
- `chore/<thing>` — tooling, docs

## Releasing
1. Lead pulls `main`, connects Rojo to the **Dev place**, syncs.
2. Group playtest in Dev place (multiplayer test: Test → Clients and Servers → 2+ players).
3. If good, Lead publishes to Live.
4. Tag the release: `git tag v0.1.0 && git push --tags`.
