#!/usr/bin/sh
# setup-redaction.sh
# Run this once after cloning the repo to install the clean/smudge filters.
# It configures a git filter called "btfl-redact" that automatically strips
# sensitive fields (mcu_id, signature) from any staged files  matched by
# .gitattributes.

set -eu

REPO_ROOT="$(git rev-parse --show-toplevel)"

# 1. Install the clean filter (runs when staging / adding files)
git config filter.btfl-redact.clean "${REPO_ROOT}/scripts/btfl-clean.sh"

# 2. Optional: smudge is a no-op (files stay redacted in the working tree too)
git config filter.btfl-redact.smudge cat

# 3. Mark it as required so git errors out if the filter script is missing,
#    rather than silently committing unredacted data.
git config filter.btfl-redact.required true

echo "✔ btfl-redact filter installed."
echo "  Make sure .gitattributes includes: * filter=btfl-redact"
