require 'ds'

module Ds
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(default: 'help')

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Help,    'help',    'ds/commands/help'
    register :Git,     'git',     'ds/commands/git'
    register :Ai,      'ai',      'ds/commands/ai'
  end
end
