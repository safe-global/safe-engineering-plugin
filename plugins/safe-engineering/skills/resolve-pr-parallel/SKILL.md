# Resolve PR Comments in Parallel

---
name: resolve-pr-parallel
description: This skill should be used when resolving all PR comments using parallel processing. Use when addressing PR review feedback, resolving review threads, or batch-fixing PR comments.
argument-hint: "[optional: PR number or current PR]"
disable-model-invocation: true
allowed-tools: Bash(gh *), Bash(git *), Read
---

## Overview

This workflow enables resolving multiple PR review comments simultaneously by spawning parallel agents for each thread.

## Key Workflow Steps

**1. Analyze:** Execute the get-pr-comments script to fetch unresolved review threads with file paths, line numbers, and comment bodies.

**2. Plan:** Organize feedback into categories—code changes, questions, style fixes, and test needs.

**3. Implement (Parallel):** Launch individual resolver agents concurrently for each unresolved item rather than sequentially.

**4. Commit & Resolve:** Apply changes, commit with PR reference, and programmatically mark threads as resolved via GraphQL.

**5. Verify:** Re-fetch comments to confirm all threads are addressed, expecting an empty result.

## Supporting Resources

Two main scripts facilitate execution:
- [get-pr-comments](./scripts/get-pr-comments) — GraphQL query retrieving unresolved review threads
- [resolve-pr-thread](./scripts/resolve-pr-thread) — GraphQL mutation marking threads as resolved by ID

## Detailed Workflow

### 1. Analyze

Get all unresolved comments for PR:

```bash
gh pr status
scripts/get-pr-comments PR_NUMBER
# Or with explicit repo:
scripts/get-pr-comments PR_NUMBER safe-global/safe-wallet-monorepo
```

### 2. Plan

Create a TodoWrite list of all unresolved items grouped by type.

### 3. Implement (PARALLEL)

Spawn a pr-comment-resolver agent for each unresolved item in parallel.

So if there are 3 comments, spawn 3 pr-comment-resolver agents in parallel:

1. Task pr-comment-resolver(comment1)
2. Task pr-comment-resolver(comment2)
3. Task pr-comment-resolver(comment3)

Always run all in parallel subagents/Tasks for each Todo item.

### 4. Commit & Resolve

- Commit changes
- For each resolved thread, run: `scripts/resolve-pr-thread THREAD_ID`
- Push to remote

### 5. Verify

Run `scripts/get-pr-comments PR_NUMBER` again to confirm all comments are resolved. They should return empty. If not, repeat the process from step 1.

## Success Indicators

All review threads are addressed, changes are committed and pushed, threads show as resolved on GitHub, and verification returns no remaining unresolved items.
