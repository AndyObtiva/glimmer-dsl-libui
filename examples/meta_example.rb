# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'facets'

class MetaExample
  include Glimmer
  
  def examples
    if @examples.nil?
      example_files = Dir.glob(File.join(File.expand_path('.', __dir__), '**', '*.rb'))
      example_file_names = example_files.map { |f| File.basename(f, '.rb') }
      example_file_names = example_file_names.reject { |f| f == 'meta_example' }
      @examples = example_file_names.map { |f| f.underscore.titlecase }
    end
    @examples
  end
  
  def launch
    window('Meta-Example', 300) { |w|
      margined true
      
      vertical_box {
        rbs = radio_buttons {
          items examples
        }
        button('Launch') {
          stretchy false
          
          on_clicked do
            system "ruby -r puts_debuggerer -r #{File.expand_path('../lib/glimmer-dsl-libui', __dir__)} #{File.join(File.expand_path('.', __dir__), "#{@examples[rbs.selected].underscore}.rb")}"
          end
        }
      }
    }.show
  end
end

MetaExample.new.launch
