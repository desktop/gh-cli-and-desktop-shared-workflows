#!/bin/bash

# Check if an issue is spam or not and output "PASS" (not spam) or "FAIL" (spam).
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

_user_prompt_template='
<TITLE>
{{ .title }}
</TITLE>

<BODY>
{{ .body }}
</BODY>
'

_user_prompt="$(gh issue view --json title,body --template "$_user_prompt_template" "$_issue_url")"

# Generate dynamic prompts for inference
_system_prompt="$($SPAM_DIR/generate-sys-prompt.sh)"
_model="${MODEL:-openai/gpt-4o-mini}"
_final_prompt="$(_system="$_system_prompt" _user="$_user_prompt" _model="$_model" yq eval ".model = strenv(_model) | .messages[0].content = strenv(_system) | .messages[1].content = strenv(_user)" "$SPAM_DIR/check-issue-prompts.yml")"

gh extension install github/gh-models 2>/dev/null

_result="$(gh models run --file <(echo "$_final_prompt") | cat)"

if [[ "$_result" != "PASS" && "$_result" != "FAIL" ]]; then
    echo "error: expected PASS or FAIL but got an unexpected result: $_result" >&2
    exit 1
fi

echo "$_result"
