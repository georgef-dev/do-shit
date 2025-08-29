require 'ds'

module Ds
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Ds::Resolver.call(args)
      Ds::Executor.call(cmd, command_name, args)
    end
  end
end
