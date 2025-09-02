# Fetch and Analyze GitHub Issue

## Arguments
- GitHub issue URL (required): The full URL to a GitHub issue to fetch and analyze

Issue URL: $ARGUMENTS

## Instructions

You are being asked to fetch a GitHub issue, cache all its data, and write an analysis report. Follow these steps:

### Prerequisites
- Ensure `.work/` directory exists and that you know what subfolder to store your notes and data in
- Verify the provided URL is a valid GitHub issue URL

### Execution Steps

1. **Parse the GitHub URL**:
   - Extract owner, repo, and issue number from the URL
   - Example: `https://github.com/owner/repo/issues/123` → owner=owner, repo=repo, issue=123

2. **Create Issue-Specific Directory**:
   - Create subdirectory for issue: `.work/<your_folder>/issue-<issue_number>/`

3. **Fetch Issue Data Using gh CLI**:
   - Get issue details, comments, timeline events, linked PRs, etc.
   - Save to: `.work/<your_folder>/issue-<issue_number>/`

4. **Write Analysis Report**:
   Create `.work/<your_folder>/issue-<issue_number>-summary.md` with the following structure:
   
   ```markdown
   # Issue Analysis: [Title]
   
   **Issue**: #<number> in <owner>/<repo>
   **URL**: <original_url>
   **State**: <open/closed>
   **Created**: <date>
   **Last Updated**: <date>
   
   ## Summary
   [2-3 sentence executive summary of the issue]
   
   ## Key Points
   - [Main problem or request]
   - [Important context or constraints]
   - [Current status or blockers]
   
   ## Labels & Metadata
   - **Labels**: [list labels]
   - **Assignees**: [list assignees or "Unassigned"]
   - **Milestone**: [milestone or "None"]
   
   ## Discussion Highlights
   [Summarize key points from comments, organized by theme]
   
   ### Proposed Solutions
   - [Solution 1 mentioned by @user]
   - [Solution 2 mentioned by @user]
   
   ### Concerns/Blockers
   - [Any concerns raised]
   - [Technical blockers identified]
   
   ## Linked Pull Requests
   [List any PRs that reference this issue]
   
   ## Next Steps
   [Based on the discussion, what are the logical next steps?]
   
   ## Raw Data
   All original data saved in:
   - `filename1` - contents
   - `filename2` - contents
   ```

5. **Display Summary**:
   After saving all data, display:
   ```
   GitHub Issue Fetched & Analyzed
   ================================
   • Issue: #<number> - <title>
   • Location: .work/issues/<repo>-<issue_number>/
   • Files Created:
     - .work/<your_folder>/issue-<issue_number>-summary.md (analysis report)
     - .work/<your_folder>/issue-<issue_number>/file1 (contents)
     - .work/<your_folder>/issue-<issue_number>/file2 (contents)
     - [any other fetched files]
   
   Summary:
   <display the executive summary from the report>
   ```

### Error Handling
- If URL is invalid or not a GitHub issue, explain the expected format
- If gh CLI fails, check if user is authenticated (`gh auth status`)
- If issue is not accessible, report permission issue

### Notes
- The analysis should focus on understanding the problem, not solving it
- Identify patterns in the discussion (repeated requests, confusion points, etc.)
- Note any decisions that have been made or deferred
- Note any external resources that could not be fetched automatically but which may be relevant
