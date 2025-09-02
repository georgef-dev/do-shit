require 'open3'
require 'ds'

module Ds
  module Utils
    class Shell
      class << self
        def execute(command, capture_output: true, raise_on_error: true)
          if capture_output
            stdout, stderr, status = Open3.capture3(command)
            
            if raise_on_error && !status.success?
              raise "Command failed: #{command}\nSTDERR: #{stderr}"
            end
            
            { stdout: stdout, stderr: stderr, success: status.success?, status: status }
          else
            system(command)
          end
        end

        def git(command, **options)
          execute("git #{command}", **options)
        end

        def in_directory(dir)
          original_dir = Dir.pwd
          Dir.chdir(dir)
          yield
        ensure
          Dir.chdir(original_dir)
        end
      end
    end
  end
end