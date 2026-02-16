# Safe Engineering Plugin

[![Based on](https://img.shields.io/badge/based%20on-compound--engineering-blue)](https://github.com/EveryInc/compound-engineering-plugin)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

AI-powered development tools for the Safe-wallet monorepo. Specialized agents for TypeScript/React/Next.js code review, feature architecture validation, multi-chain patterns, Redux store design, and Safe SDK integration.

> **Based on [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) by [Kieran Klaassen](https://github.com/kieranklaassen) (EveryInc)**
>
> This plugin adapts the compound-engineering plugin for Safe-wallet specific patterns and workflows. We are grateful to Kieran and the EveryInc team for creating the original plugin and making it open source under the MIT license.

## Installation

### Claude Code CLI

```bash
# Add the marketplace
/plugin marketplace add https://github.com/safe-global/safe-engineering-plugin

# Install the plugin
/plugin install safe-engineering
```

### Manual Installation

Clone to your `.claude/plugins/` directory:

```bash
git clone https://github.com/safe-global/safe-engineering-plugin ~/.claude/plugins/safe-engineering
```

## Workflow

The compound engineering workflow makes each unit of work easier than the last:

```
Plan -> Work -> Review -> Compound -> Repeat
```

| Command | Purpose |
|---------|---------|
| `/workflows:brainstorm` | Explore requirements and approaches before planning |
| `/workflows:plan` | Turn feature ideas into detailed implementation plans |
| `/workflows:work` | Execute plans with worktrees and task tracking |
| `/workflows:review` | Multi-agent code review with Safe-wallet specific checks |
| `/workflows:compound` | Document learnings to make future work easier |

## Technology Stack

This plugin is optimized for the Safe-wallet monorepo:

| Category | Technology |
|----------|------------|
| **Web Framework** | Next.js 15, React 19, TypeScript 5.9 |
| **Mobile Framework** | Expo 54, React Native, Tamagui |
| **UI Libraries** | MUI 6.3 (web), Tamagui (mobile), `@safe-global/theme` |
| **State Management** | Redux Toolkit 2.11, RTK Query, redux-persist |
| **Web3** | ethers.js 6.14, Safe SDK (`@safe-global/protocol-kit`, `@safe-global/api-kit`) |
| **Testing** | Jest, MSW, Cypress, Maestro |
| **Package Manager** | Yarn 4 workspaces |

## Components

| Component | Count |
|-----------|-------|
| Agents | 22 |
| Commands | 15 |
| Skills | 12 |
| MCP Servers | 1 |

## Agents

### Review Agents (12)

| Agent | Description |
|-------|-------------|
| `safe-typescript-reviewer` | TypeScript review with Safe-wallet patterns, feature architecture, no `any` types |
| `safe-feature-architecture-reviewer` | Validate lazy-loading patterns, feature.ts structure, ESLint import compliance |
| `safe-multichain-reviewer` | Validate chainId/safeAddress pairing, chain-specific configurations |
| `safe-store-reviewer` | Redux patterns, RTK Query, cross-platform compatibility |
| `safe-sdk-reviewer` | Safe SDK usage patterns, transaction building, owner validation |
| `security-sentinel` | Web3 security, Safe SDK patterns, multi-sig security, OWASP |
| `architecture-strategist` | Feature architecture, workspace structure, cross-platform code sharing |
| `performance-oracle` | Bundle size, lazy loading, React hook optimization |
| `pattern-recognition-specialist` | Analyze code for patterns and anti-patterns |
| `code-simplicity-reviewer` | Final pass for simplicity and minimalism |
| `data-integrity-guardian` | Database integrity and data consistency |
| `agent-native-reviewer` | Verify features are agent-native (action + context parity) |

### Research Agents (5)

| Agent | Description |
|-------|-------------|
| `best-practices-researcher` | Gather external best practices and examples |
| `framework-docs-researcher` | Research framework documentation (Next.js, MUI, Safe SDK) |
| `git-history-analyzer` | Analyze git history and code evolution |
| `repo-research-analyst` | Research repository structure and conventions |
| `learnings-researcher` | Search documented solutions for institutional knowledge |

### Design Agents (3)

| Agent | Description |
|-------|-------------|
| `design-implementation-reviewer` | Verify UI implementations match Figma designs (MUI/Tamagui) |
| `design-iterator` | Iteratively refine UI through systematic design iterations |
| `figma-design-sync` | Synchronize web implementations with Figma designs |

### Workflow Agents (3)

| Agent | Description |
|-------|-------------|
| `bug-reproduction-validator` | Systematically reproduce and validate bug reports |
| `pr-comment-resolver` | Address PR comments and implement fixes |
| `spec-flow-analyzer` | Analyze user flows and identify gaps in specifications |

## Commands

### Workflow Commands (5)

| Command | Description |
|---------|-------------|
| `/workflows:brainstorm` | Explore requirements and approaches before planning |
| `/workflows:plan` | Create implementation plans with research |
| `/workflows:review` | Run comprehensive code reviews with Safe-wallet reviewers |
| `/workflows:work` | Execute work items systematically with worktrees |
| `/workflows:compound` | Document solved problems to compound team knowledge |

### Utility Commands (10)

| Command | Description |
|---------|-------------|
| `/deepen-plan` | Enhance plans with parallel research agents |
| `/changelog` | Create engaging changelogs for recent merges |
| `/create-agent-skill` | Create or edit Claude Code skills |
| `/generate_command` | Generate new slash commands |
| `/heal-skill` | Fix skill documentation issues |
| `/lfg` | Full autonomous engineering workflow |
| `/plan_review` | Multi-agent plan review in parallel |
| `/resolve_parallel` | Resolve TODO comments in parallel |
| `/resolve_todo_parallel` | Resolve todo items in parallel |
| `/test-browser` | Browser testing with agent-browser |

## Skills

### Architecture & Development

| Skill | Description |
|-------|-------------|
| `compound-docs` | Capture solved problems as categorized documentation |
| `create-agent-skills` | Expert guidance for creating Claude Code skills |
| `frontend-design` | Create production-grade frontend interfaces (MUI, React) |
| `skill-creator` | Guide for creating effective Claude Code skills |
| `agent-native-architecture` | Agent-native application design patterns |

### Workflow

| Skill | Description |
|-------|-------------|
| `file-todos` | File-based todo tracking system |
| `git-worktree` | Manage Git worktrees for parallel development |
| `brainstorming` | Feature ideation and exploration |

### Browser & Automation

| Skill | Description |
|-------|-------------|
| `agent-browser` | CLI-based browser automation for testing |
| `mobile-mcp` | Mobile device automation for iOS/Android simulators and devices |
| `resolve-pr-parallel` | Resolve PR review comments in parallel with GraphQL scripts |

### Optional

| Skill | Description |
|-------|-------------|
| `gemini-imagegen` | Generate and edit images (design mockups) |

## MCP Servers

| Server | Description |
|--------|-------------|
| `context7` | Framework documentation lookup (Next.js, React, MUI, Safe SDK) |

## Safe-Wallet Specific Patterns

### Feature Architecture

Features MUST follow the lazy-loading pattern:

```typescript
// feature.ts - FLAT structure, DIRECT imports, NO hooks
import MyComponent from './components/MyComponent'
import { myService } from './services/myService'

export default {
  MyComponent,  // PascalCase = component (stub renders null)
  myService,    // camelCase = service (undefined when not ready)
  // NO hooks! Hooks go in index.ts
}
```

### Multi-Chain

Always pair chainId with safeAddress:

```typescript
// CORRECT
const safeKey = `${chainId}:${safeAddress}`
function getSafe(chainId: string, safeAddress: string) { ... }

// WRONG - NEVER do this
function getSafe(safeAddress: string) { ... }  // Missing chainId!
```

### Redux Testing

Test state changes, not action dispatches:

```typescript
// CORRECT - Test actual state
const state = store.getState()
expect(state.safes[`${chainId}:${safeAddress}`]).toEqual(safeInfo)

// WRONG - Only tests action was called
expect(dispatch).toHaveBeenCalledWith(setSafe(safeInfo))
```

### Type Safety

NEVER use `any`:

```typescript
// WRONG
const data: any = await fetchData()

// CORRECT
const data: SafeInfo = await fetchData<SafeInfo>()
```

## Running Tests

```bash
# Web App
yarn workspace @safe-global/web type-check
yarn workspace @safe-global/web lint
yarn workspace @safe-global/web test
yarn workspace @safe-global/web cypress:run

# Mobile App
yarn workspace @safe-global/mobile type-check
yarn workspace @safe-global/mobile lint
yarn workspace @safe-global/mobile test
```

## Credits

This plugin is based on the [compound-engineering plugin](https://github.com/EveryInc/compound-engineering-plugin) created by [Kieran Klaassen](https://github.com/kieranklaassen) at [EveryInc](https://every.to). The original plugin provides a powerful framework for AI-assisted engineering workflows.

We have adapted it for Safe-wallet specific patterns including:
- Feature architecture with lazy-loading
- Multi-chain validation (chainId + safeAddress)
- Safe SDK integration patterns
- Redux testing patterns
- TypeScript strict type safety

## Philosophy

**Each unit of engineering work should make subsequent units easier - not harder.**

This is the core principle of compound engineering. By documenting learnings, following consistent patterns, and using AI-assisted workflows, we make the codebase easier to work with over time, not harder.

## License

MIT - See [LICENSE](LICENSE) for details.

---

**Learn more about compound engineering:**
- [Compound engineering: how Every codes with agents](https://every.to/chain-of-thought/compound-engineering-how-every-codes-with-agents)
- [The story behind compounding engineering](https://every.to/source-code/my-ai-had-already-fixed-the-code-before-i-saw-it)
