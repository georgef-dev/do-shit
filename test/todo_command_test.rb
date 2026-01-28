require 'test_helper'
require 'ds/commands/todo'

module Ds
  class TodoCommandTest < Minitest::Test
    include CLI::Kit::Support::TestHelper

    def test_todo_add_with_description
      out, err = capture_io do
        TodoAdd.new.call(['fix', 'flaky', 'test'], 'todo-add')
      end
      
      assert_match(/Would add task/, out)
      assert_match(/fix flaky test/, out)
    end

    def test_todo_add_without_description
      assert_raises SystemExit do
        capture_io do
          TodoAdd.new.call([], 'todo-add')
        end
      end
    end

    def test_todo_list_default_status
      out, err = capture_io do
        TodoList.new.call([], 'todo-list')
      end
      
      assert_match(/Would list tasks/, out)
      assert_match(/todo/, out)
    end

    def test_todo_list_with_status
      out, err = capture_io do
        TodoList.new.call(['--status=done'], 'todo-list')
      end
      
      assert_match(/Would list tasks/, out)
      assert_match(/done/, out)
    end

    def test_todo_done_with_valid_id
      out, err = capture_io do
        TodoDone.new.call(['42'], 'todo-done')
      end
      
      assert_match(/Would mark task/, out)
      assert_match(/#42/, out)
    end

    def test_todo_done_without_id
      assert_raises SystemExit do
        capture_io do
          TodoDone.new.call([], 'todo-done')
        end
      end
    end

    def test_todo_done_with_invalid_id
      assert_raises SystemExit do
        capture_io do
          TodoDone.new.call(['abc'], 'todo-done')
        end
      end
    end

    def test_todo_main_command_routes_to_add
      out, err = capture_io do
        Todo.new.call(['add', 'test', 'task'], 'todo')
      end
      
      assert_match(/Would add task/, out)
    end

    def test_todo_main_command_routes_to_list
      out, err = capture_io do
        Todo.new.call(['list'], 'todo')
      end
      
      assert_match(/Would list tasks/, out)
    end

    def test_todo_main_command_routes_to_done
      out, err = capture_io do
        Todo.new.call(['done', '1'], 'todo')
      end
      
      assert_match(/Would mark task/, out)
    end

    def test_todo_main_command_unknown_subcommand
      assert_raises SystemExit do
        capture_io do
          Todo.new.call(['unknown'], 'todo')
        end
      end
    end

    def test_todo_help
      out, err = capture_io do
        Todo.new.call(['help'], 'todo')
      end
      
      assert_match(/Todo subcommands/, out)
      assert_match(/ds todo add/, out)
      assert_match(/ds todo list/, out)
      assert_match(/ds todo done/, out)
    end
  end
end
