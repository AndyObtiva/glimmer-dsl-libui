# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Grid', 400) {
  tab {
    tab_item('Horizontal Arrangement') {
      grid {
        label('One') {
          left 0
          top 0
        }
        label('Two') {
          left 1
          top 0
        }
        label('Three') {
          left 2
          top 0
        }
        label('Four') {
          left 3
          top 0
        }
      }
    }
    tab_item('Vertical Arrangement') {
      grid {
        label('One') {
          left 0
          top 0
        }
        label('Two') {
          left 0
          top 1
        }
        label('Three') {
          left 0
          top 2
        }
        label('Four') {
          left 0
          top 3
        }
      }
    }
  }
}.show
