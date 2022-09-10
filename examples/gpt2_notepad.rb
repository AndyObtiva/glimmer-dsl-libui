# frozen_string_literal: true

require 'onnxruntime'
require 'blingfire'
require 'numo/narray'
require 'fileutils'
require 'glimmer-dsl-libui'

# GPT-2 model
# Transformer-based language model for text generation.
# https://github.com/onnx/models/tree/main/text/machine_comprehension/gpt-2
class GPT2TextPredictor
  attr_accessor :text
  
  def initialize
    @text = ''
    base_dir = File.join(Dir.home, '.gpt2-notepad')
    FileUtils.mkdir_p(base_dir)
    Dir.chdir(__dir__) do
      downloaded_files = %w[
        https://github.com/microsoft/BlingFire/raw/master/dist-pypi/blingfire/gpt2.bin
        https://github.com/microsoft/BlingFire/raw/master/dist-pypi/blingfire/gpt2.i2w
        https://github.com/onnx/models/raw/main/text/machine_comprehension/gpt-2/model/gpt2-lm-head-10.onnx
      ].map do |url|
        fname = File.join(base_dir, File.basename(url))
        next(fname) if File.exist?(fname)
    
        print "Downloading #{fname}..."
        require 'open-uri'
        File.binwrite(fname, URI.open(url).read)
        puts 'done'
        fname
      end
      @encoder = BlingFire.load_model(downloaded_files[0])
      @decoder = BlingFire.load_model(downloaded_files[1])
      @model = OnnxRuntime::Model.new(downloaded_files[2])
    end
  end
  
  def softmax(y)
    Numo::NMath.exp(y) / Numo::NMath.exp(y).sum(1, keepdims: true)
  end
  
  def predict(a, prob: true)
    outputs = @model.predict({ input1: [[a]] })
    logits = Numo::DFloat.cast(outputs['output1'][0])
    logits = logits[true, -1, true]
    return logits.argmax unless prob
  
    log_probs = softmax(logits)
    idx = log_probs.sort_index
    i = (log_probs[idx].cumsum < rand).count
    idx[i]
  end
  
  def predict_text(max = 30)
    a = @encoder.text_to_ids(text)
    max.times do
      id = predict(a)
      a << id
      break if id == 13 # .
    end
    self.text = @decoder.ids_to_text(a)
  end
end

class GPT2Notepad
  include Glimmer::LibUI::Application
  
  before_body do
    @text_predictor = GPT2TextPredictor.new
  end
  
  body {
    window('Notepad', 500, 300) {
      vertical_box {
        padded true
        
        horizontal_box {
          stretchy false
          
          button('Clear') {
            on_clicked do
              @text_predictor.text = ''
            end
          }
          
          button('Continue the sentence(s)') {
            on_clicked do
              if @text_predictor.text.empty?
                msg_box('Empty!', 'Please enter some text first.')
              else
                @text_predictor.predict_text
              end
            end
          }
        }
        
        multiline_entry {
          text <=> [@text_predictor, :text]
        }
      }
    }
  }
end

GPT2Notepad.launch
