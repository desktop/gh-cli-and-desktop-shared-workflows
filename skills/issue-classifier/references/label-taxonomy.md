# Label Taxonomy

Reference for labels used across `desktop/desktop` and `cli/cli`.

## Issue Type Labels

| Label | Meaning |
|-------|---------|
| `bug` | Confirmed bugs or reports very likely to be bugs |
| `enhancement` | Feature requests and improvements |
| `invalid` | Spam, malformed, off-topic, or not actionable |
| `suspected-spam` | Alternative to `invalid` for suspected spam |
| `off-topic` | Issues unrelated to the project |

## Priority Labels (Bugs Only)

| Label | Criteria |
|-------|----------|
| `priority-1` | Affects many users, prevents core functions, data loss/corruption, security vulnerability |
| `priority-2` | Affects multiple users, significant disruption, no workaround |
| `priority-3` | Few users affected, cosmetic, workaround exists |

## Status Labels

| Label | Meaning |
|-------|---------|
| `needs-triage` | Auto-added to all new issues/PRs; removed when triaged |
| `more-info-needed` | Need clarification from author (auto-close timer: 14 days) |
| `unable-to-reproduce` | Cannot reproduce (auto-adds `more-info-needed`, posts comment, starts timer) |
| `investigation-needed` | Likely bugs not yet reliably reproduced |
| `stale` | Auto-applied after 365 days of inactivity (NOT auto-closed) |
| `never-stale` | Protects important issues from stale marking |

## PR-Specific Labels

| Label | Meaning |
|-------|---------|
| `external` | Pull requests from outside the core team |
| `ready-for-review` | PR is valid and ready for engineering review |
| `no-help-wanted-issue` | PR not linked to a help-wanted issue (auto-closes) |
| `help wanted` | Issues ideal for external contributors |
| `good first issue` | Issues ideal for brand new contributors |

## Platform Labels

| Label | Scope |
|-------|-------|
| `windows` | Windows-specific issues |
| `macOS` | macOS-specific issues |
| `linux` | Linux-specific issues |

## Command Labels (cli/cli)

For CLI issues, add the relevant command label: `gh-pr`, `gh-issue`, `gh-repo`, `gh-browse`, `gh-auth`, `gh-run`, `gh-workflow`, `gh-release`, `gh-gist`, `gh-api`, `gh-search`, `gh-status`, `gh-project`, `gh-codespace`, `gh-extension`, `gh-config`, `gh-secret`, `gh-variable`, `gh-cache`, `gh-attestation`, `gh-label`, `gh-ruleset`, `gh-ssh-key`, `gh-gpg-key`, `gh-org`, `gh-copilot`

## Category Labels (desktop/desktop)

| Label | Scope |
|-------|-------|
| `accessibility` | Accessibility improvements |
| `performance` | Performance-related issues |
| `diff` | Diff view (split or unified) |
| `git` | Related to embedded Git version |
| `electron` | Electron framework, may need upstream fixes |
| `codemirror` | CodeMirror editor, may need upstream fixes |
| `integrations` | Editor and shell integrations |
| `themes` | Light/dark theme issues |
| `proxy` | Proxy-related issues |
| `copilot` | GitHub Copilot integration |

## Automated Workflow Effects

| Label Applied | Automation Triggered |
|---------------|---------------------|
| `needs-triage` | Auto-added on open; removed when classified or closed |
| `more-info-needed` | Auto-closes after 14 days without response |
| `unable-to-reproduce` | Auto-adds `more-info-needed` + posts comment |
| `enhancement` | Auto-posts backlog comment |
| `invalid` | Auto-closes immediately |
| `suspected-spam` | Auto-closes immediately |
| `off-topic` | Auto-posts explanation + closes |
| `no-help-wanted-issue` | Auto-posts explanation + closes |
| `ready-for-review` | Auto-removes `needs-triage` + posts comment |
