require 'ds'

module Ds
  module Utils
    class GitUtils
      class << self
        def current_branch
          Ds::Config.current_branch
        end

        def is_worktree_branch_checked_out?(branch_name)
          result = Shell.git("branch", capture_output: true, raise_on_error: false)
          result[:stdout].lines.any? { |line| line.strip.start_with?("+ #{branch_name}") }
        end

        def fetch_main
          if is_worktree_branch_checked_out?('main')
            puts "Branch 'main' is checked out on a different worktree; skipping fetch"
            'main'
          else
            puts "Fetching branch 'main' from remote 'origin'"
            Shell.git("fetch origin main")
            'FETCH_HEAD'
          end
        end

        def detach_head
          puts "Detaching current HEAD"
          Shell.git("checkout HEAD~0")
        end

        def reset_to_main(branch_name, main_ref, detached_mode: false)
          if detached_mode
            puts "Not resetting or attaching a branch"
            Shell.git("checkout -f #{main_ref}~0")
            clean_untracked
          else
            if is_worktree_branch_checked_out?(branch_name)
              puts "Branch '#{branch_name}' is checked out on a different worktree; not resetting or attaching a branch"
              Shell.git("checkout -f #{main_ref}~0")
              clean_untracked
            else
              puts "Resetting and attaching branch '#{branch_name}'"
              Shell.git("branch -f #{branch_name} #{main_ref}")
              Shell.git("checkout -f #{branch_name}")
              puts "Resetting working directory state"
              Shell.git("reset --hard #{main_ref}")
              clean_untracked
              puts "Ensuring upstream is set up correctly for '#{branch_name}'"
              Shell.git("branch --set-upstream-to=origin/main #{branch_name}")
            end
          end
        end

        def clean_untracked
          puts "Cleaning untracked files"
          Shell.git("clean -f")
        end
      end
    end
  end
end