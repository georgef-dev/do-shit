require 'cli/ui'
require 'cli/kit'

CLI::UI::StdoutRouter.enable

module Ds
  TOOL_NAME = 'ds'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/ds.log'

  autoload(:EntryPoint, 'ds/entry_point')
  autoload(:Commands,   'ds/commands')
  autoload(:Config,     'ds/config')

  module Utils
    autoload(:Shell,       'ds/utils/shell')
    autoload(:GitUtils,    'ds/utils/git_utils')
    autoload(:AiWorkflow,  'ds/utils/ai_workflow')
  end

  Command = CLI::Kit::BaseCommand

  Executor = CLI::Kit::Executor.new(log_file: LOG_FILE)
  Resolver = CLI::Kit::Resolver.new(
    tool_name: TOOL_NAME,
    command_registry: Ds::Commands::Registry
  )

  ErrorHandler = CLI::Kit::ErrorHandler.new(log_file: LOG_FILE)
end
