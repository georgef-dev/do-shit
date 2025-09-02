# Bug Investigation

## Arguments
None required (assumes issue already chosen and fetched)
If you don't know what issue I'm talking about, stop and ask me.

Issue details should be at `.work/<your_folder>/issue-<issue_number>/`

## Instructions

Conduct a comprehensive investigation of the bug based on the issue description and codebase analysis.

### Goals
- Map out ALL potentially relevant code paths, even tangentially related ones
- Identify cross-component interactions that could contribute to the issue
- Document system behaviors, assumptions, and edge cases
- Uncover hidden dependencies or side effects

### Investigation Scope
- Search for all code related to the issue's symptoms and affected features
- Trace data flow through the system from input to output
- Examine error handling, state management, and concurrency patterns
- Review recent changes to related code areas
- Identify similar patterns elsewhere that work correctly (for comparison)

### Output
Write a comprehensive investigation report to `.work/<your_folder>/bug-<issue_number>-investigation-report.md` including:
- All relevant code locations with explanations of their roles
- System architecture insights related to the issue
- Data flow diagrams or descriptions
- Potential failure points (even unlikely ones)
- Environmental factors that could influence behavior
- Historical context from git history if relevant

Do not theorize about causes yet. Focus purely on gathering and documenting facts about the system.
