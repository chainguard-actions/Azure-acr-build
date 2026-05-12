# Hardening Report: Azure--acr-build/v1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `ff50f15e4b79bfbf764dafdfd2579175a6ea9771`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **Azure--acr-build/v1** was hardened automatically. 0 finding(s) were identified and resolved across 1 iteration(s).

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the base image in Dockerfile from the mutable `mcr.microsoft.com/azure-cli` (no tag) to `mcr.microsoft.com/azure-cli@sha256:925b5871029fe16b82650c8298201e5dd91ac8122c7af1d150b57edc8c9f316a # latest`. The second `FROM runtime` in the multi-stage build references the already-pinned stage alias and requires no change.

