# Bug Re-Investigation After Failed Theories

## Arguments
None required (assumes previous theories tested and failed)

If you don't know what issue I'm talking about, stop and ask me.

Issue details should be at `.work/<your_folder>/issue-<issue_number>/`
Previous investigation should be at `.work/<your_folder>/bug-<issue_number>-investigation-report.md`
Previous theories should be at `.work/<your_folder>/bug-<issue_number>-theories.md`
Failed test results should be at `.work/<your_folder>/bug-<issue_number>-test-results-*.md`

## Instructions

Conduct a deeper, more creative investigation based on lessons learned from failed reproduction attempts.

### Goals
- Challenge every assumption made in the initial investigation
- Explore overlooked code paths and system interactions
- Question the accuracy of our understanding of the bug's symptoms
- Identify gaps in test setup that may have prevented reproduction

### Expanded Investigation Focus

**Alternative Code Paths:**
- Search for indirect ways the bug could manifest (event handlers, callbacks, async operations)
- Look for code paths that only execute under specific configurations or feature flags
- Investigate middleware, interceptors, or decorators that could alter behavior
- Check for race conditions or timing-dependent code paths
- Explore error recovery paths that might mask or transform the original issue

**Environmental & Contextual Factors:**
- Database state or migration-dependent behavior
- Cache layers that could affect reproduction
- Third-party service interactions or API dependencies
- Platform-specific or browser-specific code branches
- User permissions, roles, or tenant-specific logic

**Test Setup Deficiencies:**
- Were our mocks too simplified?
- Did we miss crucial initialization or configuration?
- Are there hidden dependencies we didn't account for?
- Could the bug require a specific sequence of operations before manifesting?
- Are there global state mutations we overlooked?

**Questioning Core Assumptions:**
- Is the reported bug actually the root issue or a symptom?
- Could multiple bugs be interacting?
- Are we testing the right version/branch of the code?
- Is the bug's description accurate or could user reports be misleading?
- Could the bug be intermittent due to external factors?

### Creative Exploration Techniques
- Search for similar bugs in git history that were fixed
- Look for TODO/FIXME comments near relevant code
- Check for recent refactors that might have introduced issues
- Examine code coverage to find untested paths
- Review error logs or monitoring data if available
- Consider how the system behaves at edge cases or boundary conditions

### Output
Write an expanded investigation report to `.work/<your_folder>/bug-<issue_number>-investigation-round2.md` including:
- Summary of what previous theories revealed about our misconceptions
- Newly discovered code paths and interactions
- Environmental factors that were previously overlooked
- Test setup gaps identified from failed reproductions
- Challenged assumptions and new understanding
- Additional context from git history, comments, or documentation
- Unexplored attack vectors for reproducing the bug

Focus on bringing genuinely new information and perspectives that weren't considered in the initial investigation.