# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'facets'

class MetaExample
  include Glimmer
  
  def initialize
    @selected_example_index = 0
  end
  
  def examples
    if @examples.nil?
      example_files = Dir.glob(File.join(File.expand_path('.', __dir__), '**', '*.rb'))
      example_file_names = example_files.map { |f| File.basename(f, '.rb') }
      example_file_names = example_file_names.reject { |f| f == 'meta_example' || f.match(/\d$/) }
      @examples = example_file_names.map { |f| f.underscore.titlecase }
    end
    @examples
  end
  
  def examples_with_versions
    examples.map do |example|
      version_count_for(example) > 1 ? "#{example} (#{version_count_for(example)} versions)" : example
    end
  end
  
  def file_path_for(example)
    File.join(File.expand_path('.', __dir__), "#{example.underscore}.rb")
  end
  
  def version_count_for(example)
    Dir.glob(File.join(File.expand_path('.', __dir__), "#{example.underscore}*.rb")).select {|file| file.match(/\d\.rb$/)}.count + 1
  end
  
  def glimmer_dsl_libui_file
    File.expand_path('../lib/glimmer-dsl-libui', __dir__)
  end
  
  def selected_example
    examples[@selected_example_index]
  end
  
  def launch
    window('Meta-Example', 700, 500) {
      margined true
      
      horizontal_box {
        vertical_box {
          stretchy false
          
          @rbs = radio_buttons {
            stretchy false
            items examples_with_versions
            selected @selected_example_index
            
            on_selected do
              @selected_example_index = @rbs.selected
              example = selected_example
              @nwme.text = File.read(file_path_for(example))
              @sb.value = 1
            end
          }
          
          horizontal_box {
            label('Version') {
              stretchy false
            }
            
            @sb = spinbox(1, 100) {
              value 1
              
              on_changed do
                example = selected_example
                if @sb.value > version_count_for(example)
                  @sb.value -= 1
                else
                  version_number = @sb.value == 1 ? '' : @sb.value
                  example = "#{selected_example}#{version_number}"
                  @nwme.text = File.read(file_path_for(example))
                end
              end
            }
          }
          
          horizontal_box {
            stretchy false
            
            button('Launch') {
              on_clicked do
                begin
                  meta_example_file = File.join(Dir.home, '.meta_example.rb')
                  File.write(meta_example_file, @nwme.text)
                  result = `ruby -r #{glimmer_dsl_libui_file} #{meta_example_file} 2>&1`
                  msg_box('Error Running Example', result) if result.include?('error')
                rescue => e
                  puts 'Unable to write code changes! Running original example...'
                  system "ruby -r #{glimmer_dsl_libui_file} #{file_path_for(selected_example)}"
                end
              end
            }
            button('Reset') {
              on_clicked do
                @nwme.text = File.read(file_path_for(selected_example))
              end
            }
          }
        }
        
        @nwme = non_wrapping_multiline_entry {
          text File.read(file_path_for(selected_example))
        }
      }
    }.show
  end
end

MetaExample.new.launch
