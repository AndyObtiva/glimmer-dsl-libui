# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Notepad', 500, 300) {
  non_wrapping_multiline_entry
}.show
