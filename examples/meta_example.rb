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
  
  def file_path_for(example)
    File.join(File.expand_path('.', __dir__), "#{example.underscore}.rb")
  end
  
  def launch
    menu('File') {
      quit_menu_item
    }
    
    window('Meta-Example', 700, 500) { |w|
      margined true
      
      horizontal_box {
        vertical_box {
          @rbs = radio_buttons {
            stretchy false
            items examples
            selected 0
            
            on_selected do
              @nwme.text = File.read(file_path_for(@examples[@rbs.selected]))
            end
          }
          button('Launch') {
            stretchy false
            
            on_clicked do
              system "ruby -r puts_debuggerer -r #{File.expand_path('../lib/glimmer-dsl-libui', __dir__)} #{file_path_for(@examples[@rbs.selected])}"
            end
          }
        }
        vertical_box {
          @nwme = non_wrapping_multiline_entry {
            read_only true
            text File.read(file_path_for(@examples[@rbs.selected]))
          }
        }
      }
    }.show
  end
end

MetaExample.new.launch
