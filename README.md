# Betaflight Config Redaction

Sensitive fields are automatically stripped from `BTFL_cli_backup_*.txt` files
before they are committed, using a git
[clean filter](https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes#_keyword_expansion).

## What gets redacted

| Field | Why |
|---|---|
| `mcu_id` | Unique hardware serial number of the flight controller MCU |
| `signature` | Firmware signing token (usually empty, but sensitive if present) |

## Setup (once per clone)

```bash
chmod +x scripts/btfl-clean.sh
./setup-redaction.sh
```

This registers a filter called `btfl-redact` in your local `.git/config`.
The `.gitattributes` file (checked in) tells git which files to apply it to.

## How it works

- **On `git add`**: the clean filter pipes each matching file through
  `scripts/btfl-clean.sh`, which replaces sensitive values with `REDACTED`.
- **In your working directory**: files remain unmodified with your real values.
- **In commits and on GitHub**: only the redacted versions appear.

## Verifying it works

```bash
# Stage a config file
git add BTFL_cli_backup_PIOLHO_*.txt

# Inspect what git actually stored (should show REDACTED)
git show :BTFL_cli_backup_PIOLHO_*.txt | grep -E 'mcu_id|signature|pilot_name|craft_name'
```
