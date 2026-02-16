# Global Development Standards

Global instructions for all projects. Project-specific CLAUDE.md files override these defaults.

## Philosophy

- **No speculative features** — Don't add features, flags, or configuration unless users actively need them
- **No premature abstraction** — Don't create utilities until you've written the same code three times
- **Clarity over cleverness** — Prefer explicit, readable code over dense one-liners
- **Justify new dependencies** — Each dependency is attack surface and maintenance burden
- **Replace, don't deprecate** — When a new implementation replaces an old one, remove the old one entirely. No backward-compatible shims, dual config formats, or migration paths
- **Finish the job** — Handle the edge cases you can see. Clean up what you touched. But don't invent new scope
- **Agent-native by default** — Design so agents can achieve any outcome users can. Tools are atomic primitives; features are outcomes described in prompts

## Code Quality

### Hard limits

1. ≤100 lines/function, cyclomatic complexity ≤8
2. ≤5 positional params
3. 100-char line length
4. No `any` in TypeScript — use `unknown` with type guards
5. Google-style docstrings on non-trivial public APIs

### Zero warnings policy

Fix every warning from every tool — linters, type checkers, compilers, tests. If a warning truly can't be fixed, add an inline ignore with a justification comment.

### Error handling

- Fail fast with clear, actionable messages
- Never swallow exceptions silently
- Include context (what operation, what input, suggested fix)


## Testing

**Test behavior, not implementation.** Tests should verify what code does, not how. If a refactor breaks your tests but not your code, the tests were wrong.

**Test edges and errors, not just the happy path.** Empty inputs, boundaries, malformed data, missing files, network failures — bugs live in edges.

**Mock boundaries, not logic.** Only mock things that are slow (network, filesystem), non-deterministic (time, randomness), or external services.

## Workflow

**Before committing:**
1. Re-read your changes for unnecessary complexity
2. Run relevant tests
3. Run linters and type checker — fix everything before committing

**Commits:**
- Imperative mood, ≤72 char subject line, one logical change per commit
- Never push directly to protected branches (main/master/dev) — use feature branches and PRs
- Never commit secrets, API keys, or credentials

## Reviewing Code

Evaluate in order: architecture → code quality → tests → performance.

For each issue: describe concretely with file:line references, present options with tradeoffs, recommend one, and ask before proceeding.
