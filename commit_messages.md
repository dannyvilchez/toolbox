# Git Commit Message Google Style Guide

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Rules

Type: Describes the kind of change. Common types:

- feat: New feature
- fix: Bug fix
- docs: Documentation only
- style: Formatting (no code change)
- refactor: Code change that isn’t a fix or feature
- test: Adding or fixing tests
- chore: Other changes (build, CI, etc.)

Scope (optional): A module or package affected (e.g., parser, api, ui)

Subject:

- Max 72 chars
- Imperative mood (e.g., “fix bug” not “fixed bug”)
- No period at end

Body (optional):

- Explains what and why, not how
- Wrap at 72 chars

Footer (optional):

- For breaking changes, deprecations, or issue refs
- Examples:
  - BREAKING CHANGE: API no longer accepts nulls
  - Fixes #123

**Example**

```
feat(parser): support YAML frontmatter

Adds YAML frontmatter parsing to improve Markdown support.

Fixes #42
```
