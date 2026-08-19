<!-- markdownlint-disable -->

# Hardening Report: Azure--acr-build/v1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **Azure--acr-build/v1** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses `actions/checkout@master`, which is pinned to a mutable branch name rather than an immutable 40-character commit SHA. This means the action code can change at any time without notice, enabling supply-chain attacks.

Locations:

- `.github/workflows/build.yaml:7`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key, and the single `build` job also has no `permissions:` key. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially write) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/build.yaml:1`

### script-injection (severity: high)

Rule (b) violation: entrypoint.sh expands multiple workflow-caller-controlled environment variables without double-quoting, allowing shell metacharacter injection. Unquoted expansions include: `${INPUT_BUILD_ARGS}` (line 8), `${INPUT_SERVICE_PRINCIPAL}` (line 22), `${INPUT_SERVICE_PRINCIPAL_PASSWORD}` (line 22), `${INPUT_TENANT}` (line 22), `${INPUT_REGISTRY}` (line 25), `${INPUT_DOCKERFILE}` (line 25), `${INPUT_REPOSITORY}` (line 25), `${INPUT_TAG}` (line 25), `${INPUT_BRANCH}` (line 25), `${INPUT_FOLDER}` (line 25), and `${GIT_ACCESS_TOKEN_FLAG}` (line 25). These are all set from Docker action inputs supplied by the calling workflow and must be double-quoted to prevent command injection via shell metacharacters (`;`, `|`, `&`, `$(...)`, etc.).

Locations:

- `entrypoint.sh:8`
- `entrypoint.sh:22`
- `entrypoint.sh:25`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions, script-injection

**Notes:**

1. build.yaml: Pinned actions/checkout@master to @61b9e3751b92087fd0b06925ba6dd6314e06f089 # master. Added `permissions: {}` at top-level and job level to enforce least privilege.
2. entrypoint.sh: Double-quoted all previously unquoted variable expansions: INPUT_SERVICE_PRINCIPAL, INPUT_SERVICE_PRINCIPAL_PASSWORD, INPUT_TENANT, INPUT_REGISTRY, INPUT_DOCKERFILE, INPUT_REPOSITORY, INPUT_TAG, INPUT_BRANCH, INPUT_FOLDER, and GIT_ACCESS_TOKEN_FLAG. INPUT_BUILD_ARGS was already guarded by a -n check; the resulting BUILD_ARGS string (a list of --build-arg flags) is now tokenized into a bash array via xargs+printf NUL-delimited loop and expanded as "${BUILD_ARGS_ARRAY[@]}" to keep each flag as a separate argument. GIT_ACCESS_TOKEN_FLAG is initialized to empty string before the conditional block to avoid any unbound-variable issues.

