# gh-cli-and-desktop-shared-workflows

A home for GH CLI and Desktop shared action workflows. These workflows provide automated triaging and issue management capabilities that can be reused across repositories.

## Overview

This repository houses shared GitHub Actions workflows for issue and pull request triaging. These workflows are designed to be reusable and can be referenced from other repositories like `cli/cli` and `desktop/desktop`.

## Available Workflows

### 1. Close Invalid Issues/PRs (`close-invalid.yml`)
Automatically closes issues and pull requests when labeled as `invalid`.

**Triggers:**
- `issues: [labeled]`
- `pull_request_target: [labeled]`
- `workflow_call`

**Usage:**
```yaml
name: Close Invalid
on:
  issues:
    types: [labeled]
  pull_request_target:
    types: [labeled]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/close-invalid.yml@main
    permissions:
      contents: read
      issues: write
      pull-requests: write
```

### 2. Close Single-Word Issues (`close-single-word-issues.yml`)
Automatically closes issues with single-word titles and labels them as invalid.

**Triggers:**
- `issues: [opened]`
- `workflow_call`

**Usage:**
```yaml
name: Close Single-Word Issues
on:
  issues:
    types: [opened]

jobs:
  close:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/close-single-word-issues.yml@main
    permissions:
      issues: write
```

### 3. Feature Request Comment (`feature-request-comment.yml`)
Adds a standardized comment when issues are labeled as feature requests.

**Triggers:**
- `issues: [labeled]`
- `workflow_call`

**Inputs:**
- `help_wanted_url` (optional): Custom URL to the help wanted label

**Usage:**
```yaml
name: Feature Request Comment
on:
  issues:
    types: [labeled]

jobs:
  comment:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/feature-request-comment.yml@main
    permissions:
      issues: write
```

### 4. No Response (`no-response.yml`)
Closes issues that haven't received a response after a specified period.

**Triggers:**
- `issue_comment: [created]`
- `schedule: (cron: '5 * * * *')`
- `workflow_call`

**Inputs:**
- `days_until_close` (optional, default: 7): Number of days before closing
- `response_required_label` (optional, default: 'more-info-needed'): Label indicating response needed

**Usage:**
```yaml
name: No Response
on:
  issue_comment:
    types: [created]
  schedule:
    - cron: '5 * * * *'

jobs:
  no-response:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/no-response.yml@main
    permissions:
      issues: write
```

### 5. Remove Triage Label on Close (`on-issue-close.yml`)
Removes the triage label when issues are closed.

**Triggers:**
- `issues: [closed]`
- `workflow_call`

**Inputs:**
- `labels_to_remove` (optional, default: 'triage'): Labels to remove

**Usage:**
```yaml
name: On Issue Close
on:
  issues:
    types: [closed]

jobs:
  remove-label:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/on-issue-close.yml@main
    permissions:
      issues: write
```

### 6. Label External PRs (`pr-is-external.yml`)
Labels pull requests from external contributors.

**Triggers:**
- `pull_request_target: [opened, reopened]`
- `workflow_call`

**Inputs:**
- `repository_org` (optional): Organization to check against (defaults to repo owner)
- `labels_to_add` (optional, default: 'external,triage'): Labels to add

**Usage:**
```yaml
name: PR External
on:
  pull_request_target:
    types: [opened, reopened]

jobs:
  label:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/pr-is-external.yml@main
    permissions:
      pull-requests: write
      repository-projects: read
```

### 7. Remove Triage Label (`remove-triage-label.yml`)
Removes the triage label when other labels are added to issues.

**Triggers:**
- `issues: [labeled]`
- `workflow_call`

**Inputs:**
- `label_to_remove` (optional, default: 'triage'): Label to remove
- `excluded_labels` (optional, default: 'triage,more-info-needed'): Labels that don't trigger removal

**Usage:**
```yaml
name: Remove Triage Label
on:
  issues:
    types: [labeled]

jobs:
  remove:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/remove-triage-label.yml@main
    permissions:
      issues: write
```

### 8. Mark Stale Issues (`stale-issues.yml`)
Marks issues and PRs as stale after a period of inactivity.

**Triggers:**
- `schedule: (cron: '30 1 * * *')`
- `workflow_call`

**Inputs:**
- `stale_issue_label` (optional, default: 'stale, triage')
- `start_date` (optional, default: '2024-11-25T00:00:00Z')
- `days_before_stale` (optional, default: 365)
- `days_before_close` (optional, default: -1)
- `days_before_pr_stale` (optional, default: -1)
- `exempt_issue_labels` (optional, default: 'never-stale, help wanted')

**Usage:**
```yaml
name: Stale Issues
on:
  schedule:
    - cron: '30 1 * * *'

jobs:
  stale:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/stale-issues.yml@main
    permissions:
      issues: write
```

### 9. Triage Incoming Issues (`triage-issues.yml`)
Labels new and reopened issues for triage.

**Triggers:**
- `issues: [opened, reopened, unlabeled]`
- `workflow_call`

**Inputs:**
- `triage_label` (optional, default: 'triage')
- `more_info_label` (optional, default: 'more-info-needed')

**Usage:**
```yaml
name: Triage Issues
on:
  issues:
    types: [opened, reopened, unlabeled]

jobs:
  triage:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-issues.yml@main
    permissions:
      issues: write
```

### 10. Unable to Reproduce Comment (`unable-to-reproduce-comment.yml`)
Adds a comment requesting more information when issues are labeled as unable to reproduce.

**Triggers:**
- `issues: [labeled]`
- `workflow_call`

**Inputs:**
- `more_info_label` (optional, default: 'more-info-needed')
- `unable_to_reproduce_label` (optional, default: 'unable-to-reproduce')
- `log_menu_path` (optional): Custom path to access logs

**Usage:**
```yaml
name: Unable to Reproduce Comment
on:
  issues:
    types: [labeled]

jobs:
  comment:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/unable-to-reproduce-comment.yml@main
    permissions:
      issues: write
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
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/close-invalid.yml@main
    permissions:
      contents: read
      issues: write
      pull-requests: write

  close-single-word:
    if: github.event_name == 'issues' && github.event.action == 'opened'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/close-single-word-issues.yml@main
    permissions:
      issues: write

  feature-request-comment:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/feature-request-comment.yml@main
    permissions:
      issues: write

  label-external-pr:
    if: github.event_name == 'pull_request_target'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/pr-is-external.yml@main
    permissions:
      pull-requests: write
      repository-projects: read

  triage-issues:
    if: github.event_name == 'issues'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-issues.yml@main
    permissions:
      issues: write

  remove-triage-label:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/remove-triage-label.yml@main
    permissions:
      issues: write

  on-issue-close:
    if: github.event_name == 'issues' && github.event.action == 'closed'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/on-issue-close.yml@main
    permissions:
      issues: write

  unable-to-reproduce:
    if: github.event_name == 'issues' && github.event.action == 'labeled'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/unable-to-reproduce-comment.yml@main
    permissions:
      issues: write

  no-response:
    if: github.event_name == 'issue_comment'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/no-response.yml@main
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
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/stale-issues.yml@main
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
