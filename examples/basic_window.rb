# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200, 1) {
  on_closing do
    puts 'Bye Bye'
  end
}.show
