#!/bin/bash

# Performs spam detection on an issue and labels it if it's spam.
#
# Regardless of the spam detection result, the script always exits with a zero
# exit code, unless there's a runtime error.

set -euo pipefail

SPAM_DIR="$(dirname "$(realpath "$0")")"

_issue_url="$1"
if [[ -z "$_issue_url" ]]; then
    echo "error: issue URL is empty" >&2
    exit 1
fi

_result="$("$SPAM_DIR/check-issue.sh" "$_issue_url")"

if [[ "$_result" == "PASS" ]]; then
    echo "detected as not-spam: $_issue_url"
    exit 0
fi

echo "detected as spam: $_issue_url"

gh issue edit --add-label "${SPAM_LABEL:-suspected-spam}" "$_issue_url"

echo "issue labeled as suspected spam: $_issue_url"
