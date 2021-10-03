# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Grid') {
  tab {
    tab_item('Span') {
      grid {
        4.times { |top_value|
          4.times { |left_value|
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
    }
    tab_item('Expand') {
      grid {
        label("(0, 0) hexpand/vexpand\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true
          vexpand true
        }
        label("(1, 0)") {
          left 1
          top 0
        }
        label("(0, 1)") {
          left 0
          top 1
        }
        label("(1, 1)") {
          left 1
          top 1
        }
      }
    }
    tab_item('Align') {
      grid {
        label("(0, 0) halign/valign fill\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :fill
          valign :fill
        }
        label("(1, 0) halign/valign start") {
          left 1
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :start
          valign :start
        }
        label("(0, 1) halign/valign center") {
          left 0
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :center
          valign :center
        }
        label("(1, 1) halign/valign end") {
          left 1
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :end
          valign :end
        }
      }
    }
  }
}.show
