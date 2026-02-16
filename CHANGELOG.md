# Changelog

All notable changes to the safe-engineering plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2026-02-16

### Added

- **Team config distribution** — New `config/` directory with opinionated defaults for all Safe engineers, inspired by [trailofbits/claude-code-config](https://github.com/trailofbits/claude-code-config)
- **`/safe:config` command** — Setup command that installs and updates all config components. Run from the cloned repo; to update, `git pull` and re-run.
- **`config/settings.json`** — Security-hardened defaults: sandbox config, deny rules for credentials/secrets/crypto wallets, `rm -rf` blocker, push-to-main blocker, extended thinking, Warcraft peon sound hooks, statusline
- **`config/mcp-template.json`** — Default MCP servers: Linear, Notion, Playwright, Mobile MCP, Figma
- **`config/claude-md-template.md`** — Global CLAUDE.md with Safe-wallet patterns (feature architecture, multi-chain, Redux testing, type safety), code quality standards, and workflow conventions
- **`config/scripts/statusline.sh`** — Two-line status bar showing model, git branch, context usage progress bar, session cost, duration, and cache hit rate (based on trailofbits/claude-code-config)
- **Warcraft peon sounds** — 7 sound files (`config/sounds/peon/`) with `play-sound.sh` dispatcher mapped to Claude Code hooks: "Work work!" on permission prompts, "Job's done!" on completion, "Ready to work" on session start

## [1.1.0] - 2026-02-16

### Changed

- **`resolve_pr_parallel`** - Migrated from command to skill with GraphQL scripts for fetching and resolving PR review threads, matching upstream compound-engineering structure
  - Added `scripts/get-pr-comments` — GraphQL query to fetch unresolved review threads (adapted for `safe-global` repos)
  - Added `scripts/resolve-pr-thread` — GraphQL mutation to mark threads as resolved
  - Updated SKILL.md with detailed workflow steps and script references

### Fixed

- Updated component counts: 15 commands, 12 skills (was incorrectly showing 17 commands, 10 skills)

## [1.0.0] - 2026-02-02

### Added

Initial release of safe-engineering plugin, adapted from [compound-engineering v2.28.0](https://github.com/EveryInc/compound-engineering-plugin).

#### Safe-Specific Review Agents

- **`safe-typescript-reviewer`** - TypeScript review with Safe-wallet patterns, feature architecture validation, strict no `any` types policy
- **`safe-feature-architecture-reviewer`** - Validates lazy-loading patterns, feature.ts flat structure, ESLint import compliance, hook placement rules
- **`safe-multichain-reviewer`** - Validates chainId/safeAddress pairing, chain-specific configurations, unique Safe identifier patterns
- **`safe-store-reviewer`** - Redux patterns, RTK Query usage, state keyed by chainId:safeAddress, cross-platform compatibility
- **`safe-sdk-reviewer`** - Safe SDK usage patterns (`@safe-global/protocol-kit`, `@safe-global/api-kit`), transaction building, owner/threshold validation

#### General Review Agents (Adapted)

- **`security-sentinel`** - Web3 security, Safe SDK patterns, multi-sig security, OWASP compliance
- **`architecture-strategist`** - Feature architecture, workspace structure, cross-platform code sharing
- **`performance-oracle`** - Bundle size, lazy loading, React hook optimization
- **`pattern-recognition-specialist`** - Code pattern analysis
- **`code-simplicity-reviewer`** - Simplification opportunities
- **`data-integrity-guardian`** - Database integrity and data consistency
- **`agent-native-reviewer`** - Agent-native architecture verification

#### Research Agents

- **`best-practices-researcher`** - External best practices
- **`framework-docs-researcher`** - Framework documentation (Next.js, MUI, Safe SDK)
- **`git-history-analyzer`** - Git history analysis
- **`repo-research-analyst`** - Repository structure research
- **`learnings-researcher`** - Institutional knowledge search

#### Design Agents

- **`design-implementation-reviewer`** - Figma design verification for MUI/Tamagui
- **`design-iterator`** - Iterative UI refinement
- **`figma-design-sync`** - Design synchronization

#### Workflow Agents

- **`bug-reproduction-validator`** - Bug reproduction
- **`pr-comment-resolver`** - PR comment resolution
- **`spec-flow-analyzer`** - User flow analysis

#### Commands

Core workflow commands:
- `/workflows:brainstorm` - Feature ideation
- `/workflows:plan` - Implementation planning
- `/workflows:review` - Multi-agent code review with Safe-specific agents
- `/workflows:work` - Systematic work execution
- `/workflows:compound` - Knowledge documentation

Utility commands:
- `/deepen-plan`, `/changelog`, `/create-agent-skill`, `/generate_command`, `/heal-skill`, `/lfg`, `/plan_review`, `/resolve_parallel`, `/resolve_todo_parallel`, `/test-browser`

#### Skills

- `compound-docs`, `create-agent-skills`, `frontend-design`, `skill-creator`, `agent-native-architecture`, `file-todos`, `git-worktree`, `brainstorming`, `agent-browser`, `gemini-imagegen`, `mobile-mcp`, `resolve-pr-parallel`

#### MCP Server

- `context7` - Framework documentation lookup

### Credits

This plugin is based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) by [Kieran Klaassen](https://github.com/kieranklaassen) (EveryInc). Special thanks to:

- **Kieran Klaassen** - Original compound-engineering plugin creator
- **EveryInc team** - For open-sourcing the plugin under MIT license
- **Community contributors** to compound-engineering

### Summary

- 22 agents (5 Safe-specific + 17 adapted from compound-engineering)
- 15 commands
- 12 skills
- 1 MCP server
