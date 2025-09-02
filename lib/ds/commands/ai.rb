require 'ds'

module Ds
  module Commands
    class Ai < Ds::Command
      def call(args, _name)
        category = args.shift || 'help'
        case category
        when 'work' then AiWork.new.call(args)
        when 'bug' then AiBug.new.call(args)
        when 'issue' then AiIssue.new.call(args)
        when 'fix' then AiFix.new.call(args)
        when 'help' then show_help
        else
          puts CLI::UI.fmt("{{red:Unknown AI category: #{category}}}")
          puts
          show_help
          exit 1
        end
      end

      def self.help
        "AI-powered workflow commands"
      end

      private

      def show_help
        puts CLI::UI.fmt("{{bold:AI subcommands:}}")
        puts
        puts CLI::UI.fmt("{{command:ds ai work init}} [topic]")
        puts "  Initialize work context for organizing research"
        puts
        puts CLI::UI.fmt("{{command:ds ai bug investigate}}")
        puts "  Investigate a bug based on issue description"
        puts
        puts CLI::UI.fmt("{{command:ds ai bug theorize}}")
        puts "  Theorize about bug causes"
        puts
        puts CLI::UI.fmt("{{command:ds ai issue get}} <issue-number>")
        puts "  Fetch and analyze an issue"
        puts
        puts CLI::UI.fmt("{{command:ds ai fix tests}}")
        puts "  Fix failing tests"
        puts
      end
    end

    class AiWork < Ds::Command
      def call(args, _name)
        action = args.shift || 'help'
        case action
        when 'init'
          topic = args.join(' ') unless args.empty?
          Utils::AiWorkflow.execute('claude/commands/work/init.md', 
            arguments: topic || 'current branch')
        else
          puts CLI::UI.fmt("{{red:Unknown work action: #{action}}}")
          puts "Available: init"
        end
      end
    end

    class AiBug < Ds::Command
      def call(args, _name)
        action = args.shift || 'help'
        case action
        when 'investigate'
          Utils::AiWorkflow.execute('claude/commands/bug/1-investigate.md')
        when 'theorize'
          Utils::AiWorkflow.execute('claude/commands/bug/2-theorize.md')
        when 'test'
          test_action = args.shift || 'help'
          case test_action
          when 'design'
            Utils::AiWorkflow.execute('claude/commands/bug/3-design-tests-to-reproduce.md')
          when 'write'
            Utils::AiWorkflow.execute('claude/commands/bug/4-write-tests-to-reproduce.md')
          else
            puts CLI::UI.fmt("{{red:Unknown test action: #{test_action}}}")
            puts "Available: design, write"
          end
        else
          puts CLI::UI.fmt("{{red:Unknown bug action: #{action}}}")
          puts "Available: investigate, theorize, test design, test write"
        end
      end
    end

    class AiIssue < Ds::Command
      def call(args, _name)
        action = args.shift || 'help'
        case action
        when 'get'
          issue_number = args.shift
          unless issue_number
            puts CLI::UI.fmt("{{red:Issue number required}}")
            exit 1
          end
          Utils::AiWorkflow.execute('claude/commands/work/issue-get.md',
            arguments: issue_number)
        else
          puts CLI::UI.fmt("{{red:Unknown issue action: #{action}}}")
          puts "Available: get"
        end
      end
    end

    class AiFix < Ds::Command
      def call(args, _name)
        action = args.shift || 'help'
        case action
        when 'tests'
          Utils::AiWorkflow.execute('claude/commands/core/fix-tests.md')
        else
          puts CLI::UI.fmt("{{red:Unknown fix action: #{action}}}")
          puts "Available: tests"
        end
      end
    end
  end
end