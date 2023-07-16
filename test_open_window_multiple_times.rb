#!/usr/bin/ruby

require 'glimmer-dsl-libui'

include Glimmer

def show_win
  window('foo') {
    button('Boom') {
      on_clicked {
        puts "boom"
      }
    }
  }.show
  return "done"
end

show_win
show_win
show_win
