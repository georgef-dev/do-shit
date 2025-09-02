require 'ds'
require 'fileutils'

module Ds
  module Utils
    class AiWorkflow
      PROMPTS_DIR = File.join(File.dirname(__FILE__), '../../../prompts')
      
      class << self
        def load_prompt(prompt_path)
          full_path = File.join(PROMPTS_DIR, prompt_path)
          unless File.exist?(full_path)
            raise "Prompt file not found: #{prompt_path}"
          end
          
          File.read(full_path)
        end
        
        def execute(prompt_path, variables = {})
          template = load_prompt(prompt_path)
          
          # Replace variables in template
          variables.each do |key, value|
            template.gsub!("$#{key.to_s.upcase}", value.to_s)
          end
          
          # Copy to clipboard for Claude
          copy_to_clipboard(template)
          
          puts CLI::UI.fmt("{{green:✓}} AI prompt prepared and copied to clipboard")
          puts CLI::UI.fmt("{{bold:Instructions:}}")
          puts "1. Open Claude (claude.ai or Claude desktop app)"
          puts "2. Paste the prompt (Cmd+V)"
          puts "3. Claude will guide you through the workflow"
          puts
          puts CLI::UI.fmt("{{cyan:Preview:}}")
          puts template.lines.first(10).join
          puts "..." if template.lines.count > 10
        end
        
        private
        
        def copy_to_clipboard(text)
          IO.popen('pbcopy', 'w') { |io| io.write(text) }
        end
      end
    end
  end
end