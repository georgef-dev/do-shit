require 'ds'

module Ds
  class Config
    class << self
      def git_root
        @git_root ||= `git rev-parse --show-toplevel 2>/dev/null`.strip
        raise GitError, "Not in a git repository" if @git_root.empty?
        @git_root
      end

      def current_branch
        `git branch --show-current 2>/dev/null`.strip
      end

      def work_dir
        File.join(git_root, '.work')
      end

      def worktree_name
        # Extract worktree name from git worktree list
        worktree_list = `git worktree list --porcelain 2>/dev/null`
        current_path = Dir.pwd
        
        worktree_list.each_line do |line|
          if line.start_with?('worktree ')
            path = line.sub('worktree ', '').strip
            if current_path.start_with?(path)
              return File.basename(path)
            end
          end
        end
        
        'root'
      end

      def branch_name_for_worktree
        wt_name = worktree_name
        if wt_name == 'root'
          'main'
        else
          "main-#{wt_name}"
        end
      end
    end
  end

  class GitError < StandardError; end
  class WorkContextError < StandardError; end
end