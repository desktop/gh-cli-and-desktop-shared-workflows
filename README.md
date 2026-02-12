# GH CLI and Desktop Shared Workflows

Shared GitHub Actions workflows for issue and PR triaging, used by the GH CLI and GitHub Desktop teams.

## Available Workflows

| Workflow | Description | Trigger |
|----------|-------------|---------|
| [`triage-label-incoming.yml`](.github/workflows/triage-label-incoming.yml) | Adds `needs-triage` label to new/reopened issues | `issues: [opened, reopened, unlabeled]` |
| [`triage-close-invalid.yml`](.github/workflows/triage-close-invalid.yml) | Closes issues/PRs labeled `invalid` or `suspected-spam` | `issues/pull_request_target: [labeled]` |
| [`triage-close-single-word-issues.yml`](.github/workflows/triage-close-single-word-issues.yml) | Closes issues with single-word titles | `issues: [opened]` |
| [`triage-close-off-topic.yml`](.github/workflows/triage-close-off-topic.yml) | Comments and closes `off-topic` issues | `issues: [labeled]` |
| [`triage-enhancement-comment.yml`](.github/workflows/triage-enhancement-comment.yml) | Posts backlog comment on `enhancement` label | `issues: [labeled]` |
| [`triage-unable-to-reproduce-comment.yml`](.github/workflows/triage-unable-to-reproduce-comment.yml) | Requests more info on `unable-to-reproduce` label | `issues: [labeled]` |
| [`triage-remove-needs-triage.yml`](.github/workflows/triage-remove-needs-triage.yml) | Removes `needs-triage` when end-state labels are added | `issues: [labeled]` |
| [`triage-on-issue-close.yml`](.github/workflows/triage-on-issue-close.yml) | Removes `needs-triage` on issue close | `issues: [closed]` |
| [`triage-no-response-close.yml`](.github/workflows/triage-no-response-close.yml) | Closes `more-info-needed` issues after 14 days | `issue_comment` + `schedule` |
| [`triage-stale-issues.yml`](.github/workflows/triage-stale-issues.yml) | Marks stale issues after inactivity | `schedule` |
| [`triage-label-external-pr.yml`](.github/workflows/triage-label-external-pr.yml) | Labels PRs from external contributors | `pull_request_target: [opened, reopened]` |
| [`triage-close-from-default-branch.yml`](.github/workflows/triage-close-from-default-branch.yml) | Closes accidental PRs from default branch | `pull_request_target: [opened]` |
| [`triage-pr-requirements.yml`](.github/workflows/triage-pr-requirements.yml) | Checks external PRs for body + `help-wanted` issue | `pull_request_target: [labeled, edited]` + `schedule` |
| [`triage-close-no-help-wanted.yml`](.github/workflows/triage-close-no-help-wanted.yml) | Closes PRs without a `help-wanted` issue | `pull_request_target: [labeled]` |
| [`triage-ready-for-review.yml`](.github/workflows/triage-ready-for-review.yml) | Removes `needs-triage` and acknowledges PR | `pull_request_target: [labeled]` |
| [`triage-discuss.yml`](.github/workflows/triage-discuss.yml) | Creates linked discussion in internal repo | `issues/pull_request_target: [labeled]` |
| [`triage-detect-spam.yml`](.github/workflows/triage-detect-spam.yml) | AI-powered spam detection on new issues | `issues: [opened]` |

## Required Labels

Repositories using these workflows need the following labels:

| Label | Used by | Purpose |
|-------|---------|---------|
| `needs-triage` | label-incoming, remove-needs-triage, on-issue-close, label-external-pr, ready-for-review, pr-requirements, stale-issues | Main triage tracking label |
| `invalid` | close-invalid, detect-spam | Marks issues/PRs as invalid; auto-closes |
| `suspected-spam` | close-invalid, detect-spam | Marks suspected spam; auto-closes |
| `enhancement` | enhancement-comment, remove-needs-triage | Triggers backlog comment; end-state label |
| `more-info-needed` | unable-to-reproduce-comment, no-response-close | Requests more info; auto-closes after 14 days |
| `unable-to-reproduce` | unable-to-reproduce-comment | Triggers reproduction request comment |
| `off-topic` | close-off-topic | Auto-closes with explanation |
| `external` | label-external-pr, pr-requirements | Applied to PRs from non-org contributors |
| `help-wanted` | pr-requirements | Must be on issues linked by external PRs |
| `no-help-wanted-issue` | close-no-help-wanted | Auto-closes PRs without help-wanted issue |
| `ready-for-review` | ready-for-review, remove-needs-triage | Marks triaged PRs ready for review |
| `unmet-requirements` | pr-requirements | PRs that don't meet minimum requirements |
| `stale` | stale-issues | Applied to inactive issues |
| `discuss` | discuss | Triggers linked internal discussion |
| `priority-1` | remove-needs-triage | End-state label; removes needs-triage |
| `priority-2` | remove-needs-triage | End-state label; removes needs-triage |
| `priority-3` | remove-needs-triage | End-state label; removes needs-triage |

## Usage

To use these workflows, create thin workflow files in your repository's `.github/workflows/` directory that reference these shared workflows via `workflow_call`.

We recommend splitting into separate files by trigger type:

| File | Triggers | Purpose |
|------|----------|---------|
| `triage-issues.yml` | `issues` | All issue triage workflows |
| `triage-prs.yml` | `pull_request_target` | All PR workflows (isolated permissions) |
| `triage-scheduled-tasks.yml` | `schedule` + `issue_comment` | No-response close, PR requirements check, stale issues |
| `detect-spam.yml` | `issues: [opened]` | AI spam detection (requires secrets) |

**See [`example-usage/`](example-usage/) for ready-to-use workflow files** — copy them to your repo's `.github/workflows/` directory and customize inputs as needed.

### Configurable Inputs

Each workflow accepts optional inputs to customize behavior (labels, timeframes, messages, etc.). Click through to any workflow file above to see its available inputs and defaults.

Key inputs that differ between repositories:

| Input | Description | Example values |
|-------|-------------|----------------|
| `help_wanted_url` | URL to help-wanted label | `https://github.com/your-org/your-repo/labels/help%20wanted` |
| `repository_org` | Org name for external PR detection | `cli`, `desktop` |
| `log_menu_path` | How users access logs | GUI menu path vs CLI command |
| `default_branch` | Default branch name | `main`, `trunk`, `development` |
| `target_repo` | Internal repo for discuss workflow | `your-org/internal-repo` |
| `project_context` | Project description for spam detection | Free text |

### Version Pinning

The examples use `@main` for the latest version. For production, consider pinning to a specific SHA:

```yaml
uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-invalid.yml@abc123
```
