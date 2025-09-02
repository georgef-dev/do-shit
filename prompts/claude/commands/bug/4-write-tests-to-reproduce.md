# Bug Reproduction Test Implementation

## Arguments
None required (assumes test design complete)

Issue details should be at `.work/<your_folder>/issue-<issue_number>/`
Initial investigation should be at `.work/<your_folder>/bug-<issue_number>-investigation-report.md`
Theories should be at `.work/<your_folder>/bug-<issue_number>-theories.md`
Plan to reproduce bug according to the chosen theory should be at `.work/<your_folder>/bug-<issue_number>-repro-plan-<theory>.md`
Detailed test implementation plan should be at `.work/<your_folder>/bug-<issue_number>-test-design-<theory>.md`

## Instructions

Implement and iterate on tests until they successfully reproduce the bug (pass while asserting buggy behavior exists).

### Goals
- Write tests that demonstrate the bug's presence
- Ensure tests pass with current buggy code
- Validate that the theory about the bug is correct

### Implementation Requirements
- Follow the test design document exactly
- Write tests that PASS by asserting the buggy behavior is present
- Use existing test patterns and helpers from the codebase
- Ensure tests are deterministic and reliable
- Keep iterating until tests consistently pass with bug present

### Success Criteria
Tests are successful when:
- They run without errors
- They PASS while asserting the bug exists
- They exercise the exact code path identified in the theory
- They fail if you temporarily "fix" the theorized issue

### Failure Handling
If tests cannot pass (cannot reproduce the bug):
- Document what was attempted and why it failed
- Analyze what the test results reveal about the theory
- Propose alternative theories based on test behavior
- Consider if the bug requires different conditions than theorized

* IMPORTANT: ideally your plan should be able to reproduce the bug in one or at most two test cases. If you need to include more test cases than that, stop and revisit your assumptions.
* IMPORTANT: simple is better than complex. The reproduction test should ideally be *short*.

### Output
Write a test results report to `.work/<your_folder>/bug-<issue_number>-test-results-<theory>.md` including:

If successful:
- Test file path and test names
- Confirmation that tests pass with bug present
- Evidence that the theory is validated
- Next steps for fixing the bug

If unsuccessful:
- What was attempted and code snippets
- Why the tests don't reproduce the bug
- What this reveals about the theory's validity
- Alternative theories to explore
- Lessons learned about the system behavior

Continue iterating until either the bug is reproduced or you have strong evidence the theory is incorrect.
