# Safe Engineering Plugin Development

## Attribution

This plugin is based on the [compound-engineering plugin](https://github.com/EveryInc/compound-engineering-plugin) (v2.28.0) by [Kieran Klaassen](https://github.com/kieranklaassen) (EveryInc).

When making changes to this plugin, maintain attribution to the original work.

## Versioning Requirements

**IMPORTANT**: Every change to this plugin MUST include updates to all three files:

1. **`.claude-plugin/plugin.json`** - Bump version using semver
2. **`CHANGELOG.md`** - Document changes using Keep a Changelog format
3. **`README.md`** - Verify/update component counts and tables

### Version Bumping Rules

- **MAJOR** (1.0.0 -> 2.0.0): Breaking changes, major reorganization
- **MINOR** (1.0.0 -> 1.1.0): New agents, commands, or skills
- **PATCH** (1.0.0 -> 1.0.1): Bug fixes, doc updates, minor improvements

### Pre-Commit Checklist

Before committing ANY changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md component counts verified
- [ ] README.md tables accurate (agents, commands, skills)
- [ ] plugin.json description matches current counts

## Directory Structure

```
safe-engineering-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin metadata
│   └── marketplace.json     # Marketplace catalog
├── agents/
│   ├── review/             # Code review agents (12)
│   ├── research/           # Research agents (5)
│   ├── design/             # Design agents (3)
│   └── workflow/           # Workflow agents (3)
├── commands/
│   ├── workflows/          # Core workflow commands
│   └── *.md                # Utility commands
├── skills/
│   └── */SKILL.md          # All skills
├── README.md               # User documentation
├── CHANGELOG.md            # Version history
└── CLAUDE.md               # Development guidelines (this file)
```

## Safe-Specific Agents

The following agents are Safe-wallet specific and should be maintained with Safe patterns:

| Agent | Purpose |
|-------|---------|
| `safe-typescript-reviewer` | TypeScript + feature architecture + no `any` |
| `safe-feature-architecture-reviewer` | Lazy-loading patterns validation |
| `safe-multichain-reviewer` | chainId:safeAddress pairing |
| `safe-store-reviewer` | Redux patterns + cross-platform |
| `safe-sdk-reviewer` | Safe SDK integration patterns |

## Command Naming Convention

**Workflow commands** use `workflows:` prefix to avoid collisions with built-in commands:
- `/workflows:plan` - Create implementation plans
- `/workflows:review` - Run comprehensive code reviews
- `/workflows:work` - Execute work items systematically
- `/workflows:compound` - Document solved problems

## Skill Compliance Checklist

When adding or modifying skills, verify compliance with skill-creator spec:

### YAML Frontmatter (Required)

- [ ] `name:` present and matches directory name (lowercase-with-hyphens)
- [ ] `description:` present and uses **third person** ("This skill should be used when...")

### Reference Links (Required if references/ exists)

- [ ] All files in `references/` are linked as `[filename.md](./references/filename.md)`
- [ ] No bare backtick references like `` `references/file.md` ``

### Quick Validation

```bash
# Count agents
ls agents/review/*.md agents/research/*.md agents/design/*.md agents/workflow/*.md | wc -l

# Count commands
ls commands/*.md commands/workflows/*.md | wc -l

# Count skills
ls -d skills/*/ | wc -l
```

## Safe-Wallet Patterns to Maintain

When updating agents, ensure these patterns are enforced:

### Feature Architecture

```typescript
// CORRECT: feature.ts flat structure
export default {
  MyComponent,  // PascalCase = component
  myService,    // camelCase = service
  // NO hooks! Hooks go in index.ts
}
```

### Multi-Chain

```typescript
// CORRECT: Always pair chainId with safeAddress
const safeKey = `${chainId}:${safeAddress}`
function getSafe(chainId: string, safeAddress: string) { ... }
```

### Redux Testing

```typescript
// CORRECT: Test state changes
expect(state.safes[`${chainId}:${safeAddress}`]).toEqual(safeInfo)

// WRONG: Test action dispatches
expect(dispatch).toHaveBeenCalledWith(setSafe(safeInfo))
```

### Type Safety

```typescript
// NEVER use any - use unknown with type guards
const data: unknown = await response.json()
if (isSafeInfo(data)) {
  // Now typed as SafeInfo
}
```

## Updating from Upstream

When compound-engineering releases new features:

1. Review changes in upstream CHANGELOG
2. Assess relevance to Safe-wallet
3. Adapt agents/commands as needed (don't just copy)
4. Update Safe-specific examples and patterns
5. Test with Safe-wallet monorepo
6. Update CHANGELOG with attribution
