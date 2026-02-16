You are installing or updating Safe's Claude Code configuration into the user's `~/.claude/` directory.

This command must be run from within the cloned `safe-engineering-plugin` repo. To update config later, `git pull` and re-run `/safe:config`.

## Source files

All files are read from the local repo. The base path is the repo root (current working directory).

Text files (read with Read tool):
- `config/settings.json`
- `config/claude-md-template.md`
- `config/mcp-template.json`
- `config/scripts/statusline.sh`
- `config/sounds/peon/play-sound.sh`

Binary files (copy with `cp`):
- `config/sounds/peon/work-work.mp3`
- `config/sounds/peon/yes-me-lord.mp3`
- `config/sounds/peon/i-can-do-that.mp3`
- `config/sounds/peon/ready-to-work.mp3`
- `config/sounds/peon/jobs-done.mp3`
- `config/sounds/peon/work-complete.mp3`

## Steps

1. **Verify location.** Check that `config/settings.json` exists in the current directory. If not, tell the user to `cd` into the cloned `safe-engineering-plugin` repo and try again.

2. **Inventory what exists.** Read `~/.claude/settings.json`, `~/.claude/CLAUDE.md`, `~/.mcp.json`, `~/.claude/statusline.sh`, and check for `~/.claude/sounds/peon/`. Note which files exist and which don't.

3. **Ask the user what to install.** Use AskUserQuestion with a single multi-select question. List each component with a short description. Pre-label components that are missing from `~/.claude/` as recommended. Components:
   - **settings.json** — sandbox, permissions, hooks (rm -rf blocker, push-to-main blocker), Warcraft peon sound hooks, statusline config
   - **CLAUDE.md** — global development standards, Safe-wallet patterns, TypeScript conventions
   - **MCP servers** — Linear, Notion, Playwright, Mobile MCP, Figma
   - **Statusline script** — two-line status bar with context usage, cost, duration, cache hit rate
   - **Warcraft peon sounds** — "Work work!", "Yes me lord", "Job's done!" and more, triggered by Claude Code hooks

4. **Read selected source files** from the local repo.

5. **For each selected component, install it:**

   - **settings.json**: If `~/.claude/settings.json` doesn't exist, write it directly. If it does exist, read both files and merge the repo's keys into the existing file. Preserve any user-specific keys that don't conflict (`model`, `enabledPlugins`, `permissions.allow`, `permissions.additionalDirectories`). For `permissions.deny`, merge arrays (union of both). For `hooks`, merge by event type. For `sandbox`, prefer the repo template. Show the user the merged result and ask for confirmation before writing.

   - **CLAUDE.md**: If `~/.claude/CLAUDE.md` doesn't exist, write the template. If it already exists, tell the user it exists and ask whether to overwrite, skip, or show a diff. Never silently overwrite — it likely has personal customizations.

   - **MCP servers**: If `~/.mcp.json` doesn't exist, write the template. If it exists, read it, merge any missing server entries from the template, and show the result before writing. Never remove existing servers.

   - **Statusline script**: Write to `~/.claude/statusline.sh` and `chmod +x` it. Safe to overwrite — it has no user customization.

   - **Warcraft peon sounds**: Create `~/.claude/sounds/peon/` directory. `cp` all .mp3 files and `play-sound.sh` from the local repo. `chmod +x play-sound.sh`. Safe to overwrite.

6. **Post-install.** Summarize what was installed/updated. If CLAUDE.md was installed, suggest they review and customize it. Remind them to restart Claude Code for hooks and sounds to take effect.
