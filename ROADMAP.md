# ds Roadmap

This document outlines the planned features and development phases for `ds`.  
Features are tracked as checklists so progress can be marked off as they’re completed.

---

## ✨ Phase 1 (MVP)
- [x] CLI structure
  - [x] Support `ds <tool> <action>` pattern
  - [x] Add `ds help` to list tools and actions
- [ ] Define CONFIG structure and defaults
- [ ] CLI commands
  - [ ] `ds cd`
    - Change directory to `[CONFIG][SRC_DIR]/$1` if exists.
    - Asks if should clone from `[CONFIG][GH_ORG]/$1` if directory doesn't exist.
    - If `[CONFIG]` required settings not set, default to `~/src/github.com/$1`.
      - Allow expect input to be `org||user/repository`.
  - [ ] `ds todo`
     - [ ] `ds todo add "fix flaky test"`
     - [ ] `ds todo list --status=todo`
     - [ ] `ds todo done 42`
- [ ] Rails API backend
  - [ ] User authentication (API key/token)
  - [ ] Task model (title, description, status, due date, tags)
  - [ ] CRUD endpoints for tasks
- [ ] Local CLI config for API token/endpoint

---

## ✨ Phase 2
- [ ] JWT or OAuth authentication  
- [ ] Projects/contexts for grouping tasks  
- [ ] Filtering/search (status, tags, due dates)  
- [ ] Background jobs for reminders/recurring tasks  
- [ ] CLI improvements
  - [ ] Pretty tables
  - [ ] Colorized output
  - [ ] `ds config`

---

## ✨ Phase 3 (Open Source Ready)
- [ ] Contribution guidelines  
- [ ] GitHub Actions (CI, tests, linting)  
- [ ] Documentation and usage examples  
- [ ] Optional web dashboard (Rails + Hotwire)  

---

## ✨ Phase 4 (One day)
- [ ] Multi-tenant accounts  
- [ ] Webhooks (GitHub, Google Calendar, Slack)  
- [ ] Notifications (email, Slack, Discord)  
