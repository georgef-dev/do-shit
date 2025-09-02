# Bug Reproduction Test Design

## Arguments
Theory selection: $ARGUMENTS

If you don't know what issue I'm talking about, stop and ask me.

Issue details should be at `.work/<your_folder>/issue-<issue_number>/`
Initial investigation should be at `.work/<your_folder>/bug-<issue_number>-investigation-report.md`
Theories should be at `.work/<your_folder>/bug-<issue_number>-theories.md`

## Instructions

Design concrete, implementable tests that will reproduce the bug if the selected theory is correct.

### Goals
- Create test scenarios that isolate the theorized failure condition
- Ensure tests exercise the exact business logic where the bug supposedly resides
- Design tests that PASS when the bug is present (asserting buggy behavior)
- Follow existing patterns and conventions in the codebase

### Planning Phase
- Identify the minimal conditions needed to trigger the bug
- Determine what components need to be tested in isolation vs integration
- Plan data fixtures and test harness requirements
- Consider timing, ordering, and concurrency aspects if relevant
- Map out assertion strategies that would detect the bug's presence

### Research Phase
- Find the most appropriate existing test file location
- Study test patterns, fixtures, and helpers used in that area
- Document available test utilities, mocks, and factories
- Note naming conventions and organizational patterns
- Understand the testing framework conventions

### Critical Analysis
Explain in detail:
- Why these test scenarios target the specific failure mode in the theory
- How the test isolates the theorized bug from other variables
- What business logic paths the test will exercise
- Why success/failure of these tests validates or refutes the theory

### Output
Write a comprehensive test design to `.work/<your_folder>/bug-<issue_number>-test-design-<theory>.md` including:

**Test Strategy:**
- Test scenario description(s)
- Required setup and preconditions
- Expected outcomes if theory is correct
- Rationale connecting test design to the specific theory

**Implementation Details:**
- Target test file path with justification
- Specific test case designs with:
  - Test names following local conventions
  - Exact setup steps using existing helpers
  - Assertions that pass when bug exists
  - Cleanup/teardown requirements
- Code snippets showing test structure (not full implementation)
- References to similar existing tests
- List of any new fixtures or helpers needed

**IMPORTANT:** 
- Your design should reproduce the bug in one or at most two test cases
- Simple is better than complex—the reproduction test should be *short*
- If you need more test cases, revisit your assumptions

Do not implement tests yet. Focus on thorough planning and concrete design that can be directly implemented.