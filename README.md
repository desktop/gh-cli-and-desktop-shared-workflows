# gh-cli-and-desktop-shared-workflows

A home for GH CLI and Desktop shared action workflows. These workflows provide automated triaging and issue management capabilities that can be reused across repositories.

## Overview

This repository houses shared GitHub Actions workflows for issue and pull request triaging. These workflows are designed to be reusable and can be referenced from other repositories like `cli/cli` and `desktop/desktop`.

## Available Workflows

### 1. Close Invalid Issues/PRs (`triage-close-invalid.yml`)
Automatically closes issues and pull requests when labeled as `invalid` or `suspected-spam`.

**Triggers:**
- `issues: [labeled]`
- `pull_request_target: [labeled]`
- `workflow_call`

**Usage:**
```yaml
name: 'Triage: Close invalid issues/PRs'
on:
  issues:
    types: [labeled]
  pull_request_target:
    types: [labeled]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-invalid.yml@main
    permissions:
      contents: read
      issues: write
      pull-requests: write
```

### 2. Close Single-Word Issues (`triage-close-single-word-issues.yml`)
Automatically closes issues with single-word titles and labels them as invalid.

**Triggers:**
- `issues: [opened]`
- `workflow_call`

**Usage:**
```yaml
name: 'Triage: Close single-word issues'
on:
  issues:
    types: [opened]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-single-word-issues.yml@main
    permissions:
      issues: write
```

### 3. Comment on Feature Requests (`triage-feature-request-comment.yml`)
Adds a standardized comment when issues are labeled as `enhancement`.

**Triggers:**
- `issues: [labeled]` (triggers on `enhancement` label)
- `workflow_call`

**Inputs:**
- `help_wanted_url` (optional): Custom URL to the help wanted label

**Usage:**
```yaml
name: 'Triage: Comment on feature requests'
on:
  issues:
    types: [labeled]

jobs:
  comment:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-feature-request-comment.yml@main
    permissions:
      issues: write
```

### 4. Close Issues with No Response (`triage-no-response-close.yml`)
Closes issues that haven't received a response after a specified period.

**Triggers:**
- `issue_comment: [created]`
- `schedule: (cron: '5 * * * *')`
- `workflow_call`

**Inputs:**
- `days_until_close` (optional, default: 14): Number of days before closing
- `response_required_label` (optional, default: 'more-info-needed'): Label indicating response needed

**Usage:**
```yaml
name: 'Triage: Close issues with no response'
on:
  issue_comment:
    types: [created]
  schedule:
    - cron: '5 * * * *'

jobs:
  no-response:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-no-response-close.yml@main
    permissions:
      issues: write
```

### 5. Remove Labels on Issue Close (`triage-on-issue-close.yml`)
Removes the triage label when issues are closed.

**Triggers:**
- `issues: [closed]`
- `workflow_call`

**Inputs:**
- `labels_to_remove` (optional, default: 'needs-triage'): Labels to remove

**Usage:**
```yaml
name: 'Triage: Remove labels on issue close'
on:
  issues:
    types: [closed]

jobs:
  remove-label:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-on-issue-close.yml@main
    permissions:
      issues: write
```

### 6. Label External PRs (`triage-label-external-pr.yml`)
Labels pull requests from external contributors.

**Triggers:**
- `pull_request_target: [opened, reopened]`
- `workflow_call`

**Inputs:**
- `repository_org` (optional): Organization to check against (defaults to repo owner)
- `labels_to_add` (optional, default: 'external,needs-triage'): Labels to add

**Usage:**
```yaml
name: 'Triage: Label external PRs'
on:
  pull_request_target:
    types: [opened, reopened]

jobs:
  label:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-external-pr.yml@main
    permissions:
      pull-requests: write
      repository-projects: read
```

### 7. Remove Triage Label on Reply (`triage-remove-label-on-reply.yml`)
Removes the triage label when other labels are added to issues.

**Triggers:**
- `issues: [labeled]`
- `workflow_call`

**Inputs:**
- `label_to_remove` (optional, default: 'needs-triage'): Label to remove
- `excluded_labels` (optional, default: 'needs-triage,more-info-needed'): Labels that don't trigger removal

**Usage:**
```yaml
name: 'Triage: Remove triage label on reply'
on:
  issues:
    types: [labeled]

jobs:
  remove:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-remove-label-on-reply.yml@main
    permissions:
      issues: write
```

### 8. Mark Stale Issues (`triage-stale-issues.yml`)
Marks issues and PRs as stale after a period of inactivity.

**Triggers:**
- `schedule: (cron: '30 1 * * *')`
- `workflow_call`

**Inputs:**
- `stale_issue_label` (optional, default: 'stale,needs-triage')
- `start_date` (optional, default: '2024-11-25T00:00:00Z')
- `days_before_stale` (optional, default: 365)
- `days_before_close` (optional, default: -1)
- `days_before_pr_stale` (optional, default: -1)
- `exempt_issue_labels` (optional, default: 'never-stale, help wanted')

**Usage:**
```yaml
name: 'Triage: Mark stale issues and PRs'
on:
  schedule:
    - cron: '30 1 * * *'

jobs:
  stale:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-stale-issues.yml@main
    permissions:
      issues: write
```

### 9. Label Incoming Issues (`triage-label-incoming.yml`)
Labels new and reopened issues for triage.

**Triggers:**
- `issues: [opened, reopened, unlabeled]`
- `workflow_call`

**Inputs:**
- `triage_label` (optional, default: 'needs-triage')
- `more_info_label` (optional, default: 'more-info-needed')

**Usage:**
```yaml
name: 'Triage: Label incoming issues'
on:
  issues:
    types: [opened, reopened, unlabeled]

jobs:
  triage:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-incoming.yml@main
    permissions:
      issues: write
```

### 10. Comment on Unable-to-Reproduce (`triage-unable-to-reproduce-comment.yml`)
Adds a comment requesting more information when issues are labeled as unable to reproduce.

**Triggers:**
- `issues: [labeled]` (triggers on `unable-to-reproduce` label)
- `workflow_call`

**Inputs:**
- `more_info_label` (optional, default: 'more-info-needed')
- `unable_to_reproduce_label` (optional, default: 'unable-to-reproduce')
- `log_menu_path` (optional): Custom path to access logs

**Usage:**
```yaml
name: 'Triage: Comment on unable-to-reproduce'
on:
  issues:
    types: [labeled]

jobs:
  comment:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-unable-to-reproduce-comment.yml@main
    permissions:
      issues: write
```

### 11. Close Off-Topic Issues (`triage-close-off-topic.yml`)
Adds an explanation comment and closes issues labeled as `off-topic`.

**Triggers:**
- `issues: [labeled]` (triggers on `off-topic` label)
- `workflow_call`

**Usage:**
```yaml
name: 'Triage: Close off-topic issues'
on:
  issues:
    types: [labeled]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-off-topic.yml@main
    permissions:
      issues: write
```

### 12. Close PRs Without Help-Wanted Issue (`triage-close-no-help-wanted.yml`)
Adds an explanation comment and closes PRs labeled as `no-help-wanted-issue`.

**Triggers:**
- `pull_request_target: [labeled]` (triggers on `no-help-wanted-issue` label)
- `workflow_call`

**Usage:**
```yaml
name: 'Triage: Close PRs without help-wanted issue'
on:
  pull_request_target:
    types: [labeled]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-no-help-wanted.yml@main
    permissions:
      pull-requests: write
```

### 13. Mark PR Ready for Review (`triage-ready-for-review.yml`)
Removes the `needs-triage` label and posts an acknowledging comment when PRs are labeled as `ready-for-review`.

**Triggers:**
- `pull_request_target: [labeled]` (triggers on `ready-for-review` label)
- `workflow_call`

**Inputs:**
- `ready_label` (optional, default: 'ready-for-review'): Label that triggers this workflow
- `triage_label` (optional, default: 'needs-triage'): Triage label to remove

**Usage:**
```yaml
name: 'Triage: Mark PR ready for review'
on:
  pull_request_target:
    types: [labeled]

jobs:
  ready:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-ready-for-review.yml@main
    permissions:
      pull-requests: write
```

### 14. Create Discussion for Issue/PR (`triage-discuss.yml`)
Creates a linked discussion issue in an internal repository when the `discuss` label is added to an issue or PR. This provides a place for private team commentary tied to the public issue.

**Triggers:**
- `issues: [labeled]` (triggers on `discuss` label)
- `pull_request_target: [labeled]` (triggers on `discuss` label)
- `workflow_call`

**Inputs:**
- `target_repo` (required): Internal repository where discussion issues are created (e.g., `github/cli`)
- `discuss_label` (optional, default: 'discuss'): Label that triggers this workflow
- `target_label` (optional, default: 'triage'): Label to apply to the created discussion issue
- `cc_team` (optional): Team to cc on the discussion issue (e.g., `@github/cli`)

**Secrets:**
- `discussion_token` (required): Token with permissions to create issues in the target repo

**Usage:**
```yaml
name: 'Triage: Create discussion for issue/PR'
on:
  issues:
    types: [labeled]
  pull_request_target:
    types: [labeled]

jobs:
  discuss:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-discuss.yml@main
    with:
      target_repo: 'github/cli'
      cc_team: '@github/cli'
    secrets:
      discussion_token: ${{ secrets.CLI_DISCUSSION_TRIAGE_TOKEN }}
```

## Using These Workflows

To use these workflows in your repository, create thin workflow files in your `.github/workflows` directory that reference these shared workflows using the `uses` keyword with `workflow_call`.

### Example: Complete Triage Setup

Create the following files in your repository's `.github/workflows` directory:

**`.github/workflows/triage.yml`:**
```yaml
name: Issue Triage
on:
  issues:
    types: [opened, reopened, labeled, unlabeled, closed]
  pull_request_target:
    types: [opened, reopened, labeled]
  issue_comment:
    types: [created]

jobs:
  close-invalid:
    if: github.event_name == 'issues' || github.event_name == 'pull_request_target'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-invalid.yml@main
    permissions:
      contents: read
      issues: write
      pull-requests: write

  close-single-word:
    if: github.event_name == 'issues' && github.event.action == 'opened'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-single-word-issues.yml@main
    permissions:
      issues: write

  feature-request-comment:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-feature-request-comment.yml@main
    permissions:
      issues: write

  label-external-pr:
    if: github.event_name == 'pull_request_target'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-external-pr.yml@main
    permissions:
      pull-requests: write
      repository-projects: read

  triage-issues:
    if: github.event_name == 'issues'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-incoming.yml@main
    permissions:
      issues: write

  remove-triage-label:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-remove-label-on-reply.yml@main
    permissions:
      issues: write

  on-issue-close:
    if: github.event_name == 'issues' && github.event.action == 'closed'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-on-issue-close.yml@main
    permissions:
      issues: write

  unable-to-reproduce:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-unable-to-reproduce-comment.yml@main
    permissions:
      issues: write

  close-off-topic:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-off-topic.yml@main
    permissions:
      issues: write

  close-no-help-wanted:
    if: github.event_name == 'pull_request_target' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-no-help-wanted.yml@main
    permissions:
      pull-requests: write

  ready-for-review:
    if: github.event_name == 'pull_request_target' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-ready-for-review.yml@main
    permissions:
      pull-requests: write

  discuss:
    if: (github.event_name == 'issues' || github.event_name == 'pull_request_target') && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-discuss.yml@main
    with:
      target_repo: 'your-org/your-internal-repo'
      cc_team: '@your-org/your-team'
    secrets:
      discussion_token: ${{ secrets.DISCUSSION_TRIAGE_TOKEN }}

  no-response:
    if: github.event_name == 'issue_comment'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-no-response-close.yml@main
    permissions:
      issues: write
```

**`.github/workflows/stale.yml`:**
```yaml
name: Mark Stale Issues
on:
  schedule:
    - cron: '30 1 * * *'

jobs:
  stale:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-stale-issues.yml@main
    permissions:
      issues: write
```

## Generalization from desktop/desktop

These workflows have been generalized from the [desktop/desktop repository](https://github.com/desktop/desktop) with the following changes:

1. **Removed repository-specific checks**: The `github.repository == 'desktop/desktop'` condition has been removed to allow usage across multiple repositories.

2. **Added `workflow_call` trigger**: All workflows now support the `workflow_call` trigger, making them reusable.

3. **Added configurable inputs**: Many workflows now accept inputs to customize behavior (labels, timeframes, messages, etc.).

4. **Generalized messages and URLs**: Desktop-specific references have been made configurable or generalized to work with any repository.

5. **Maintained backward compatibility**: All original event triggers have been preserved, so these workflows can still function as standalone workflows if placed directly in a repository.

## Contributing

When adding new shared workflows or updating existing ones:

1. Ensure workflows are generalized and not specific to any single repository
2. Add appropriate `workflow_call` triggers and inputs
3. Maintain backward compatibility with direct usage
4. Document the workflow in this README
5. Test the workflow in at least one consumer repository

## License

See [LICENSE](LICENSE) file for details.
