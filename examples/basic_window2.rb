# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window { # args can alternatively be set via properties with 4th arg has_menubar=true by default
  title 'hello world'
  content_size 300, 200
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
