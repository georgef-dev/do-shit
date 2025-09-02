require 'ds'

module Ds
  module Commands
    class Git < Ds::Command
      def call(args, _name)
        subcommand = args.shift || 'help'
        case subcommand
        when 'main' then GitMain.new.call(args, 'git-main')
        when 'prs' then GitPrs.new.call(args, 'git-prs')
        when 'status' then GitStatus.new.call(args, 'git-status')
        when 'help' then show_help
        else
          puts CLI::UI.fmt("{{red:Unknown git subcommand: #{subcommand}}}")
          puts
          show_help
          exit 1
        end
      end

      def self.help
        "Git workflow utilities"
      end

      private

      def show_help
        puts CLI::UI.fmt("{{bold:Git subcommands:}}")
        puts
        puts CLI::UI.fmt("{{command:ds git main}} [-d]")
        puts "  Reset to main branch with proper worktree handling"
        puts "  -d: detached mode (don't attach to branch)"
        puts
        puts CLI::UI.fmt("{{command:ds git prs}}")
        puts "  Interactive menu for listing and opening PRs"
        puts
        puts CLI::UI.fmt("{{command:ds git status}} [added|deleted|modified|renamed|untracked]")
        puts "  Filter git status output by change type"
        puts
      end
    end

    class GitMain < Ds::Command
      def call(args, _name)
        detached_mode = args.include?('-d')
        
        begin
          Utils::GitUtils.detach_head
          main_ref = Utils::GitUtils.fetch_main
          branch_name = Ds::Config.branch_name_for_worktree
          Utils::GitUtils.reset_to_main(branch_name, main_ref, detached_mode: detached_mode)
          
          puts CLI::UI.fmt("{{green:Successfully reset to main}}")
        rescue => e
          puts CLI::UI.fmt("{{red:Error: #{e.message}}}")
          exit 1
        end
      end

      def self.help
        "Reset to main branch with worktree support"
      end
    end

    class GitPrs < Ds::Command
      def call(args, _name)
        begin
          interactive_pr_selection  # Always show interactive menu
        rescue => e
          puts CLI::UI.fmt("{{red:Error: #{e.message}}}")
          exit 1
        end
      end

      def self.help
        "List graphite PRs and optionally open them"
      end

      private

      def list_prs
        # List graphite PRs and associated links - try unbuffer first, fallback to direct command
        begin
          result = Utils::Shell.execute("unbuffer gt log --no-interactive 2>/dev/null", raise_on_error: false)
          if result[:success]
            output = result[:stdout]
          else
            # Fallback without unbuffer
            result = Utils::Shell.execute("gt log --no-interactive")
            output = result[:stdout]
          end
          
          # Filter lines with branches or PRs
          filtered_lines = output.lines.select do |line|
            line.match?(/[◉◯─┘│]/) || line.match?(/https/)
          end
          
          # Add tabs before https lines for formatting
          formatted_output = filtered_lines.map do |line|
            if line.match?(/https/)
              "\t#{line}"
            else
              line
            end
          end.join
          
          puts formatted_output
        rescue => e
          puts CLI::UI.fmt("{{red:Error running gt command: #{e.message}}}")
          puts "Make sure 'gt' (graphite) is installed and you're in a graphite-tracked repository"
        end
      end

      def get_graphite_output
        result = Utils::Shell.execute("gt log --no-interactive", raise_on_error: false)
        unless result[:success]
          raise "Error running gt command - make sure graphite is installed"
        end
        result[:stdout]
      end

      def extract_pr_urls
        output = get_graphite_output
        output.lines.grep(/https/).map do |line|
          line.match(/(https:\/\/[^\s]+)/)&.captures&.first
        end.compact
      end

      def extract_pr_numbers
        output = get_graphite_output
        output.lines.grep(/PR #(\d+)/).map do |line|
          line.match(/PR #(\d+)/)&.captures&.first&.to_i
        end.compact
      end

      def extract_pr_info
        output = get_graphite_output
        prs = []
        
        lines = output.lines
        lines.each_with_index do |line, index|
          if line.match(/PR #(\d+)/)
            pr_number = $1.to_i
            pr_title = line.match(/\) (.+)$/)&.captures&.first || "Unknown"
            
            # Look for URL in next line
            url_line = lines[index + 1]
            url = url_line&.match(/(https:\/\/[^\s]+)/)&.captures&.first
            
            if url
              prs << { number: pr_number, title: pr_title, url: url }
            end
          end
        end
        
        prs
      end

      def open_first_pr
        prs = extract_pr_info
        if prs.empty?
          puts CLI::UI.fmt("{{yellow:No PRs found}}")
          return
        end
        
        pr = prs.first
        puts "Opening PR ##{pr[:number]}: #{pr[:title]}"
        Utils::Shell.execute("open -a \"Google Chrome\" \"#{pr[:url]}\"", raise_on_error: false)
      end

      def open_last_pr
        prs = extract_pr_info
        if prs.empty?
          puts CLI::UI.fmt("{{yellow:No PRs found}}")
          return
        end
        
        pr = prs.last
        puts "Opening PR ##{pr[:number]}: #{pr[:title]}"
        Utils::Shell.execute("open -a \"Google Chrome\" \"#{pr[:url]}\"", raise_on_error: false)
      end

      def open_pr_by_number(pr_number)
        prs = extract_pr_info
        pr = prs.find { |p| p[:number] == pr_number }
        
        unless pr
          puts CLI::UI.fmt("{{yellow:PR ##{pr_number} not found in current graphite stack}}")
          return
        end
        
        puts "Opening PR ##{pr[:number]}: #{pr[:title]}"
        Utils::Shell.execute("open -a \"Google Chrome\" \"#{pr[:url]}\"", raise_on_error: false)
      end

      def interactive_pr_selection
        prs = extract_pr_info
        
        # Build menu options
        options = []
        options << "List all PRs"
        options << "Open first PR" if prs.any?
        options << "Open last PR" if prs.any?
        options << "Open PR by number..." if prs.any?
        options << "Exit"
        
        selected = CLI::UI::Prompt.ask("Git PRs - What would you like to do?", options: options)
        
        case selected
        when "List all PRs"
          list_prs
          puts
          interactive_pr_selection  # Show menu again after listing
        when "Open first PR"
          open_first_pr
        when "Open last PR"
          open_last_pr
        when "Open PR by number..."
          pr_number = CLI::UI::Prompt.ask("Enter PR number to open:")
          if pr_number.match?(/^\d+$/)
            open_pr_by_number(pr_number.to_i)
          else
            puts CLI::UI.fmt("{{red:Invalid PR number: #{pr_number}}}")
            interactive_pr_selection
          end
        when "Exit"
          # Exit cleanly
          return
        end
      end
    end

    class GitStatus < Ds::Command
      def call(args, _name)
        filter = args.shift
        
        begin
          if filter.nil?
            # No filter - show interactive menu
            interactive_status_menu
          else
            # Direct filter provided
            show_filtered_status(filter)
          end
        rescue => e
          puts CLI::UI.fmt("{{red:Error: #{e.message}}}")
          exit 1
        end
      end

      def self.help
        "Filter git status by change type"
      end

      private

      def interactive_status_menu
        options = [
          "Show all changes",
          "Show added files",
          "Show deleted files",
          "Show modified files",
          "Show renamed files",
          "Show untracked files",
          "Exit"
        ]
        
        selected = CLI::UI::Prompt.ask("Git Status - Filter by type:", options: options)
        
        case selected
        when "Show all changes"
          Utils::Shell.execute("git status", capture_output: false)
        when "Show added files"
          show_filtered_status("added")
        when "Show deleted files"
          show_filtered_status("deleted")
        when "Show modified files"
          show_filtered_status("modified")
        when "Show renamed files"
          show_filtered_status("renamed")
        when "Show untracked files"
          show_filtered_status("untracked")
        when "Exit"
          return
        end
      end

      def show_filtered_status(filter_type)
        pattern = case filter_type.downcase
        when "a", "add", "added"
          "^A"
        when "d", "del", "delete", "deleted"
          "^D"
        when "m", "mod", "modify", "modified"
          "^.M"
        when "r", "move", "moved", "rename", "renamed"
          "^R"
        when "u", "untrack", "untracked"
          "^\\?"
        else
          puts CLI::UI.fmt("{{red:Unknown filter type: #{filter_type}}}")
          puts "Valid types: added, deleted, modified, renamed, untracked"
          return
        end
        
        result = Utils::Shell.execute("git status --short")
        filtered = result[:stdout].lines.select { |line| line.match?(/#{pattern}/) }
        
        if filtered.empty?
          puts CLI::UI.fmt("{{yellow:No #{filter_type} files found}}")
        else
          puts CLI::UI.fmt("{{bold:#{filter_type.capitalize} files:}}")
          filtered.each do |line|
            # Remove status code and print just the filename
            filename = line.sub(/^..\s+/, '')
            puts "  #{filename.strip}"
          end
        end
      end
    end
  end
end