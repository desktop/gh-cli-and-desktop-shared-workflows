# Usage Examples for Calling Repositories

This document provides examples of how to use these shared workflows from the `cli/cli` and `desktop/desktop` repositories.

## For desktop/desktop Repository

Create or update `.github/workflows/triage.yml`:

```yaml
name: Issue and PR Triaging
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
    with:
      help_wanted_url: 'https://github.com/desktop/desktop/labels/help%20wanted'
    permissions:
      issues: write

  label-external-pr:
    if: github.event_name == 'pull_request_target'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-external-pr.yml@main
    with:
      repository_org: 'desktop'
      labels_to_add: 'external,needs-triage'
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
    with:
      log_menu_path: '`Help` > `Show Logs in Finder/Explorer`'
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

  no-response:
    if: github.event_name == 'issue_comment'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-no-response-close.yml@main
    with:
      days_until_close: 14
      response_required_label: 'more-info-needed'
    permissions:
      issues: write
```

Create `.github/workflows/stale.yml`:

```yaml
name: Mark Stale Issues
on:
  schedule:
    - cron: '30 1 * * *'

jobs:
  stale:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-stale-issues.yml@main
    with:
      stale_issue_label: 'stale,needs-triage'
      start_date: '2024-11-25T00:00:00Z'
      days_before_stale: 365
      days_before_close: -1
      days_before_pr_stale: -1
      exempt_issue_labels: 'never-stale,help wanted'
    permissions:
      issues: write
```

## For cli/cli Repository

Create or update `.github/workflows/triage.yml`:

```yaml
name: Issue and PR Triaging
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
    with:
      help_wanted_url: 'https://github.com/cli/cli/labels/help%20wanted'
    permissions:
      issues: write

  label-external-pr:
    if: github.event_name == 'pull_request_target'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-label-external-pr.yml@main
    with:
      repository_org: 'cli'
      labels_to_add: 'external,needs-triage'
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
    with:
      log_menu_path: '`gh --version` output and relevant logs'
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

  no-response:
    if: github.event_name == 'issue_comment'
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-no-response-close.yml@main
    with:
      days_until_close: 14
      response_required_label: 'more-info-needed'
    permissions:
      issues: write
```

Create `.github/workflows/stale.yml`:

```yaml
name: Mark Stale Issues
on:
  schedule:
    - cron: '30 1 * * *'

jobs:
  stale:
    uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-stale-issues.yml@main
    with:
      stale_issue_label: 'stale,needs-triage'
      start_date: '2024-11-25T00:00:00Z'
      days_before_stale: 365
      days_before_close: -1
      days_before_pr_stale: -1
      exempt_issue_labels: 'never-stale,help wanted'
    permissions:
      issues: write
```

## Customization Options

Each workflow accepts inputs that can be customized per repository. See the main README.md for a complete list of available inputs for each workflow.

### Key Differences Between Repositories

The main differences in usage between `cli/cli` and `desktop/desktop`:

1. **help_wanted_url**: Points to repository-specific help wanted label
2. **repository_org**: Set to 'cli' or 'desktop' for PR external checks
3. **log_menu_path**: Desktop uses GUI menu path, CLI can reference CLI commands
4. All other options can be customized as needed per repository

## Version Pinning

The examples above use `@main` to always use the latest version. For production use, consider pinning to a specific version or SHA:

```yaml
uses: desktop/gh-cli-and-desktop-shared-workflows/.github/workflows/triage-close-invalid.yml@v1.0.0
```

## Testing

When testing these workflows in a new repository:

1. Start with a single workflow to ensure proper permissions
2. Monitor the Actions tab for any errors
3. Gradually add more workflows as each one is verified
4. Adjust inputs based on repository-specific needs
