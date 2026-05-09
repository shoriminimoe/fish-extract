# Repository Review — Recommendations

A review of `fish-extract` performed against the working tree. Items are
grouped by priority and reference the exact file/line where applicable.

## Priority 1 — Correctness bugs

### 1. `command -v gtar` leaks the resolved path to stdout

**File:** `functions/extract.fish:12`

In fish, `command -v gtar` is equivalent to `command --search gtar` and
prints the resolved path on stdout when found. Users on macOS with
`gnu-tar` installed will see something like `/opt/homebrew/bin/gtar`
printed before extraction begins.

```fish
if command -v gtar          # leaks to stdout
    set tar gtar
else
    set tar tar
end
```

Fix: use the quiet form, which only sets the exit status.

```fish
if command -q gtar
    set tar gtar
else
    set tar tar
end
```

### 2. Variables leak into the caller's scope

**File:** `functions/extract.fish:15,17,20,22`

`set tar ...`, `set failed false`, and the loop variable `file` are not
declared with `--local`, so they persist in the calling shell after
`extract` returns and may shadow user variables.

```fish
set --local tar tar
set --local failed false
for file in $argv          # `file` is already loop-local; fine
```

### 3. Failure detection after the `*` fall-through is misleading

**File:** `functions/extract.fish:90-98`

When no extension matches, the code prints an error and sets
`failed=true`, then falls through to `test $status -ne 0`. At that point
`$status` is the result of `set failed true` (always 0), so the second
`Failed to extract` branch is dead for that case. It works today, but the
control flow is fragile: any future addition of a command after `set
failed true` would change behavior.

Suggested cleanup — capture status explicitly per case, or `continue`
after the unmatched-extension error:

```fish
case '*'
    echo >&2 "extract: failed to extract '$file': no extractor implemented for file type"
    set failed true
    continue
end

if test $status -ne 0
    ...
end
```

### 4. `unlz4` invocation is brittle

**File:** `functions/extract.fish:73`

```fish
unlz4 "$file" (string replace --regex '.lz4$' '' "$file")
```

The regex `'.lz4$'` matches any character followed by `lz4`, not a
literal dot. For `foo.lz4` it works by accident. Use `'\.lz4$'`. Also,
if a file with the target name already exists, `unlz4` will fail without
a clear hint — consider passing `--keep` for symmetry with the other
cases that use `--keep`/`-k`.

## Priority 2 — UX and ergonomics

### 5. No `--help` / `-h` flag

`extract --help` currently falls into the `*` case and prints
"no extractor implemented for file type". Use `argparse`:

```fish
function extract -d "Extract archives"
    argparse --name=extract h/help -- $argv
    or return 1

    if set -q _flag_help; or test (count $argv) -lt 1
        _extract_help
        return 0
    end
    ...
end
```

### 6. `x` wrapper missing description and `--wraps`

**File:** `functions/x.fish`

```fish
function x --wraps extract -d "Alias of extract"
    extract $argv
end
```

`--wraps extract` makes fish reuse `extract`'s completions for `x`.

### 7. README omits the `x` alias

`functions/x.fish` ships an alias but `README.md` never mentions it.
Add a one-line note under **Usage**.

### 8. No `extract -t DIR` (extract-to-directory) option

A common request. Optional, but easy to add via `argparse`:

```fish
argparse --name=extract h/help t/target= -- $argv
```

…and `cd` into `$_flag_target` (creating it) inside the loop. Nice-to-have.

## Priority 3 — Tests

### 9. Tests pollute the working directory

**File:** `tests/file-types.fish`

The test creates `bwah`, `bwah.tar`, etc. in the repo root (hence the
`bwah*` line in `.gitignore`). Run inside a temp dir:

```fish
set --local tmpdir (mktemp -d)
pushd $tmpdir
source $__fish_test_helper_dir/../functions/extract.fish
...
popd
rm -rf $tmpdir
```

This eliminates the need for the `.gitignore` workaround and prevents
local test runs from leaving artifacts.

### 10. No assertion that extracted content matches the original

The tests check that `bwah` exists after extraction, but not that its
contents are the original. A trivial `echo "hello" > bwah` plus
`@test "content matches" (cat bwah) = hello` per case would catch silent
corruption.

### 11. CI does not test "missing dependency" paths

If `7zz` or `lrzip` is unavailable, `extract` should fail cleanly. There
is no test for a tool-not-installed scenario. Optional.

## Priority 4 — CI and tooling

### 12. Mixed `actions/checkout` versions

**File:** `.github/workflows/ci.yaml`

`lint` and `test` use `actions/checkout@v3`; `install` uses `@v4`.
Standardize on `@v4`.

### 13. Workflow lacks `permissions:` block

GitHub-recommended hardening. Add at the top level:

```yaml
permissions:
  contents: read
```

### 14. `fail-fast` hides matrix failures

```yaml
strategy:
  fail-fast: false
  matrix:
    os: [ubuntu-latest, macos-latest]
```

When the macOS leg fails, you currently lose Linux output (and vice
versa).

### 15. Trigger ignores feature branches

```yaml
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]
```

`pull_request` already covers PRs into `main` regardless of source
branch, so this is fine for PRs. Consider also running on tag pushes if
you ever cut releases.

### 16. No apt/Homebrew caching

Each run reinstalls all archive tools. `actions/cache` keyed on
`tests/install-dependencies.sh` would shave minutes off CI.

### 17. Hardcoded 7zip download with no checksum

**File:** `tests/install-dependencies.sh:23`

```bash
wget -O "$tmpdir/7zip.tar.xz" https://www.7-zip.org/a/7z2405-linux-x64.tar.xz
```

Pin a SHA256 and verify after download:

```bash
echo "<sha256>  $tmpdir/7zip.tar.xz" | sha256sum -c -
```

Also: `7zip` is now in the Ubuntu archive (`apt install 7zip` provides
`7zz` on 24.04+). Prefer the package once the runner image supports it.

### 18. Stale pre-commit hook versions

**File:** `.pre-commit-config.yaml`

- `pre-commit-fish v1.2` → check upstream for a newer tag.
- `gitlint v0.17.0` (2022) → `v0.19.x`.

Run `pre-commit autoupdate` periodically.

## Priority 5 — Documentation and project hygiene

### 19. Add a CI badge to the README

```markdown
[![CI](https://github.com/shoriminimoe/fish-extract/actions/workflows/ci.yaml/badge.svg)](https://github.com/shoriminimoe/fish-extract/actions/workflows/ci.yaml)
```

### 20. Add a short "Development" / "Contributing" section

How to run the tests locally (`fishtape tests/file-types.fish`),
install dependencies, and run pre-commit. A small `CONTRIBUTING.md`
also signals the project accepts PRs.

### 21. Add an issue / PR template

`.github/ISSUE_TEMPLATE/bug_report.md` (asking for fish version, OS,
file extension, and reproduction) cuts triage time.

### 22. Consider a `CHANGELOG.md`

`fisher` users have no other way to learn what changed between
versions. Even a thin "Keep a Changelog" file helps.

## Summary punch list

| # | Item | Effort |
|---|------|--------|
| 1 | `command -q gtar` | trivial |
| 2 | `set --local` everywhere | trivial |
| 3 | Restructure failure detection | small |
| 4 | Fix `unlz4` regex | trivial |
| 5 | Add `argparse --help` | small |
| 6 | `x` wrapper `--wraps`/`-d` | trivial |
| 9 | Run tests in tempdir | small |
| 12 | Bump checkout to v4 | trivial |
| 13 | Add `permissions: contents: read` | trivial |
| 14 | `fail-fast: false` | trivial |
| 17 | Verify 7zip checksum or use apt package | small |
| 18 | `pre-commit autoupdate` | trivial |
| 19 | Add CI badge | trivial |
