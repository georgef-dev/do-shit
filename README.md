# ds (do-shit)

`ds` is a developer productivity tool, a mix of a todo app with some commands to reduce daily friction.  
It’s designed to simplify common developer tasks, right from the terminal.

---

## 🎯 Goals

- Provide a **CLI-first workflow** for managing developer tasks and developer workflows.  
- Store tasks, notes, and contexts with a **persistent backend service**.  
- Be **open source and extensible**, allowing others to build integrations and new tools.  
- Serve as a playground for experimenting with **Rails 8, Ruby CLI, API design, and developer tooling**.  
- Establish a clean **command pattern** so `ds` can grow into a multi-tool CLI.

---

## 🧩 CLI Structure

Commands follow the pattern:

`ds [options]`

This makes `ds` feel like a toolbox of developer utilities, each tool focused on a specific domain.

### Examples
- `ds git sync` – Run git sync workflow (local helper tool)  
- `ds todo add "fix flaky test"` – Add a new task (API-backed)  
- `ds todo list --status=todo` – List open tasks  
- `ds todo done 42` – Mark task #42 as complete  
- `ds config set api_token <TOKEN>` – Configure API access  

Future examples might include:
- `ds notes add "architecture decision record"`  
- `ds infra uptime` – Check services from your homelab  

---

## ❓ Open Questions
- Should authentication start **simple (API key)** or jump to **JWT/OAuth** early?  
- Do we want to support **SQLite for quick setup** or start with **Postgres only**?  
- CLI integration:
  - Build CLI as a **separate gem** or keep it in the same repo as backend?  
  - Should CLI talk only to the API, or allow **offline/local mode** too?  
- Long-term: should the project target **individual devs only** or expand to **teams/SaaS**?

---

## 🛠️ Tech Stack Choices
- **Backend**: Rails 8 (API-only mode)  
- **Database**: PostgreSQL (SQLite optional for dev/testing)  
- **Auth**: Start with API tokens, migrate to JWT/OAuth2  
- **Background Jobs**: GoodJob or Sidekiq  
- **CLI**: Ruby (potentially with [Shopify CLI-Kit/UI](https://github.com/Shopify/cli-kit))  
- **Testing**: RSpec (backend), Minitest or RSpec (CLI)  
- **CI/CD**: GitHub Actions  

---

## 📜 License

Do Shit (`ds`) is released under the [MIT License](https://opensource.org/license/MIT).
