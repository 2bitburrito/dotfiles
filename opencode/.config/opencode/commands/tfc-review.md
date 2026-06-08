---
description: Review the current branch or PR against the correct base branch using Jira, Confluence DLCM guidance, PR comments, and the Tao of TFC.
---

Review the current branch, diff, or PR using TFC ticket context, DLCM guidance, PR discussion, and the Tao of TFC.

Arguments:
- `$1`: optional explicit base branch. If omitted, determine it from the PR or branch ancestry. If there is a release branch this work is based on, review against that release branch instead of `main`. If the base branch is still unclear, ask the user.

Workflow:
1. Determine the correct review base.
2. If there is an open PR, use `gh pr view --json baseRefName,title,body,url` to identify the base branch and review target.
3. If the branch is clearly based on a release branch, review against that release branch instead of `main`.
4. If the base branch is still ambiguous, ask the user before continuing.
5. Review the full branch diff against the chosen base, not just the latest commit.
6. Use Jira via the Atlassian MCP to find the primary ticket and any directly relevant related or linked tickets. Look in likely places such as the branch name, PR title, PR body, and recent commit messages.
7. Use Confluence via the Atlassian MCP to find the DLCM and any repo-specific behaviours that apply to the repository under review. If relevant behaviours are defined for this repo, follow them strictly.
8. Use the GitHub CLI to read current PR comments before writing the review. Prefer `gh pr view --comments` and `gh api repos/<owner>/<repo>/pulls/<number>/comments` when needed.
9. Read `~/Documents/Projects/the-tao-of-tfc/README.md` and apply the Tao of TFC guidance that materially affects correctness, consistency, determinism, or maintainability.
10. Check for obvious duplication in the PR that should instead reuse existing code, helpers, abstractions, or tests from elsewhere in the repo.
11. Review for:
- correctness and regressions
- mismatches with ticket requirements
- DLCM or repo behaviour violations
- Tao of TFC violations that materially affect consistency, determinism, or maintainability
- duplication or missed reuse
- missing or weak tests
12. Avoid repeating PR feedback that has already been raised unless it remains unresolved and important.
13. If evidence is incomplete, say what is missing and what assumption was made.

Output requirements:
- Return findings in this order:
- `Bugs And Feedback`
- `Nits`
- `Test Gaps`
- Put all substantive findings first, ordered by severity.
- Number every issue in `Bugs And Feedback`, `Nits`, and `Test Gaps` with stable labels so follow-up questions can reference them, e.g. `B1`, `B2`, `N1`, `T1`.
- Include file and line references when reviewing code.
- Call out the Jira tickets and DLCM sections used when they materially affect the review.
- Call out the Tao of TFC sections used when they materially affect the review.
- Keep ticket requirements distinct from inferred recommendations.
- State explicitly when a section has no findings.
