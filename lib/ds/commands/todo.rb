require 'ds'

module Ds
  module Commands
    class Todo < Ds::Command
      def call(args, _name)
        subcommand = args.shift || 'help'
        case subcommand
        when 'add' then TodoAdd.new.call(args, 'todo-add')
        when 'list' then TodoList.new.call(args, 'todo-list')
        when 'done' then TodoDone.new.call(args, 'todo-done')
        when 'help' then show_help
        else
          puts CLI::UI.fmt("{{red:Unknown todo subcommand: #{subcommand}}}")
          puts
          show_help
          exit 1
        end
      end

      def self.help
        "Manage tasks and todos"
      end

      private

      def show_help
        puts CLI::UI.fmt("{{bold:Todo subcommands:}}")
        puts
        puts CLI::UI.fmt("{{command:ds todo add}} <description>")
        puts "  Add a new task"
        puts
        puts CLI::UI.fmt("{{command:ds todo list}} [--status=todo|done]")
        puts "  List tasks (default: all open tasks)"
        puts
        puts CLI::UI.fmt("{{command:ds todo done}} <task-id>")
        puts "  Mark a task as complete"
        puts
      end
    end

    class TodoAdd < Ds::Command
      def call(args, _name)
        description = args.join(' ')
        
        if description.empty?
          puts CLI::UI.fmt("{{red:Error: Task description required}}")
          puts "Usage: ds todo add <description>"
          exit 1
        end
        
        # TODO: Implement API call to add task
        puts CLI::UI.fmt("{{yellow:⚠️  API integration not yet implemented}}")
        puts CLI::UI.fmt("Would add task: {{bold:#{description}}}")
      end

      def self.help
        "Add a new task"
      end
    end

    class TodoList < Ds::Command
      def call(args, _name)
        # Parse status filter
        status = 'todo' # Default to open tasks
        args.each do |arg|
          if arg.start_with?('--status=')
            status = arg.split('=', 2).last
          end
        end
        
        # TODO: Implement API call to list tasks
        puts CLI::UI.fmt("{{yellow:⚠️  API integration not yet implemented}}")
        puts CLI::UI.fmt("Would list tasks with status: {{bold:#{status}}}")
      end

      def self.help
        "List tasks"
      end
    end

    class TodoDone < Ds::Command
      def call(args, _name)
        task_id = args.shift
        
        if task_id.nil? || task_id.empty?
          puts CLI::UI.fmt("{{red:Error: Task ID required}}")
          puts "Usage: ds todo done <task-id>"
          exit 1
        end
        
        # Validate task_id is numeric
        unless task_id.match?(/^\d+$/)
          puts CLI::UI.fmt("{{red:Error: Task ID must be a number}}")
          exit 1
        end
        
        # TODO: Implement API call to mark task as done
        puts CLI::UI.fmt("{{yellow:⚠️  API integration not yet implemented}}")
        puts CLI::UI.fmt("Would mark task {{bold:##{task_id}}} as complete")
      end

      def self.help
        "Mark a task as complete"
      end
    end
  end
end
