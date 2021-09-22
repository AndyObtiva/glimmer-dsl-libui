# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Grid') {
  grid {
    4.times { |left_value|
      4.times { |top_value|
        label("(#{left_value}, #{top_value}) xspan1\nyspan1") {
          left left_value
          top top_value
          hexpand true
          vexpand true
        }
      }
    }
    label("(0, 4) xspan2\nyspan1 more text fits horizontally") {
      left 0
      top 4
      xspan 2
    }
    label("(2, 4) xspan2\nyspan1 more text fits horizontally") {
      left 2
      top 4
      xspan 2
    }
    label("(0, 5) xspan1\nyspan2\nmore text\nfits vertically") {
      left 0
      top 5
      yspan 2
    }
    label("(0, 7) xspan1\nyspan2\nmore text\nfits vertically") {
      left 0
      top 7
      yspan 2
    }
    label("(1, 5) xspan3\nyspan4 a lot more text fits horizontally than before\nand\neven\na lot\nmore text\nfits vertically\nthan\nbefore") {
      left 1
      top 5
      xspan 3
      yspan 4
    }
  }
}.show
