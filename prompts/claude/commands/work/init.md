# Initialize Work Context

## Arguments
- `topic` (optional): The topic/project name for organizing work notes. If not provided, uses the current git branch name.

Topic: $ARGUMENTS

## Instructions

You are being asked to initialize a work context for organizing research, investigations, and project notes. Follow these guidelines:

### Work Directory Setup

1. **Base Directory**: All work notes are stored in `.work/` at the project root (this folder is git-ignored)
2. **Topic Subfolder**: 
   - If a topic is provided as an argument, use `.work/<topic>/` as the working directory
   - If no topic is provided, use the current git branch name (replace `/` with nested subdirectories)
   - Example: branch `feature/auth/oauth` → `.work/feature/auth/oauth/`

3. **Initialize or Resume**:
   - If the directory doesn't exist, create it
   - If it exists, read ALL files within to understand the current work context

### Automatic Documentation Behavior

**IMPORTANT**: From now on in this conversation, you MUST automatically save work to the `.work/` folder without being explicitly asked:

1. **Research & Investigation Reports**: 
   - Whenever researching or investigating something, save findings as markdown reports
   - Use descriptive filenames like `api-investigation.md`, `error-analysis.md`, etc.

2. **Fetched Data & Downloads**:
   - Create a `cache/` subdirectory for all fetched/downloaded content
   - Save ALL external data fetched (GitHub issues, API responses, documentation, etc.) to `cache/`
   - Write summary reports in the main work directory referencing cached data

3. **Phase Organization**:
   - For distinct project phases, create subdirectories (e.g., `phase1-research/`, `phase2-implementation/`)
   - Keep related work grouped together

4. **File Naming**:
   - Use descriptive, timestamp-prefixed names when appropriate
   - Example: `2024-01-15-github-issue-123.md`, `api-schema-analysis.md`

### Execution Steps

1. Determine the work directory path:
   - Parse the topic argument if provided
   - Otherwise, get current git branch name and convert to path
   
2. Check if directory exists:
   - If not: Create the directory structure
   - If yes: Read all files recursively (ignore other unrelated subfolders in `.work/`)

3. Generate and display summary:
   ```
   Work Context Initialized
   ========================
   • Directory: .work/<path>/
   • Status: [New workspace | Existing workspace with X files]
   
   [If existing workspace, add:]
   Previous Work Summary:
   • [Brief bullet points of what was found]
   • [Key findings or decisions made]
   • [Current phase/status of work]
   ```

### Ongoing Behavior

After initialization, for the remainder of the conversation:
- Save ALL research, analysis, and investigation results to the work directory
- Organize downloads and fetched data in `cache/` subdirectory  
- Create phase-specific subdirectories as work progresses
- Write comprehensive markdown reports without being asked
- Update existing reports when new information is discovered

Remember: The user should never need to ask you to save work - it should be automatic whenever you gather information, research topics, or analyze code.
