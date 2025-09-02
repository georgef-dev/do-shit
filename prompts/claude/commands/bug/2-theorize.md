# Bug Theory Formation

## Arguments
None required (assumes issue already chosen and fetched)
If you don't know what issue I'm talking about, stop and ask me.

Issue details should be at `.work/<your_folder>/issue-<issue_number>/`
Initial investigation should be at `.work/<your_folder>/bug-<issue_number>-investigation-report.md`

## Instructions

Analyze the investigation findings and formulate three distinct theories about the bug's root cause.

### Goals
- Synthesize investigation data into plausible explanations
- Consider different failure modes and scenarios
- Rank theories by likelihood based on evidence

### Theory Requirements
Each theory should:
- Explain all observed symptoms
- Be grounded in specific code behaviors discovered during investigation
- Account for why the bug occurs intermittently (if applicable)
- Identify the precise conditions needed to trigger the bug
- Be distinct from other theories (not just variations)

### Output
Write a theory report to `.work/<your_folder>/bug-<issue_number>-theories.md` with:
- **Theory 1**: Most likely cause based on evidence
- **Theory 2**: Alternative explanation focusing on different component/interaction
- **Theory 3**: More far-fetched but plausible scenario

For each theory include:
- Root cause hypothesis
- Supporting evidence from investigation
- Trigger conditions
- Why this explains all symptoms
- What would need to be true for this theory to be correct

Do not attempt to prove or test theories yet. Focus on clear, testable hypotheses.
