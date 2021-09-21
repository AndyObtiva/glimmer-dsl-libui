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
  
  def glimmer_dsl_libui_file
    File.expand_path('../lib/glimmer-dsl-libui', __dir__)
  end
  
  def launch
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
              begin
                meta_example_file = File.join(Dir.home, '.meta_example.rb')
                File.write(meta_example_file, @nwme.text)
                result = `ruby -r #{glimmer_dsl_libui_file} #{meta_example_file} 2>&1`
                msg_box(w, 'Error Running Example', result) if result.include?('error')
              rescue => e
                puts 'Unable to write code changes! Running original example...'
                system "ruby -r #{glimmer_dsl_libui_file} #{file_path_for(@examples[@rbs.selected])}"
              end
            end
          }
        }
        vertical_box {
          @nwme = non_wrapping_multiline_entry {
            text File.read(file_path_for(@examples[@rbs.selected]))
          }
        }
      }
    }.show
  end
end

MetaExample.new.launch
