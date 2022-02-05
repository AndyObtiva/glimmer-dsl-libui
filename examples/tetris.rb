require 'glimmer-dsl-libui'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = {r: 192, g: 192, b: 192}
    
  def initialize
    @game = Model::Game.new
  end
  
  def launch
    create_gui
    register_observers
    @game.start!
    @main_window.show
  end
  
  def create_gui
    menu_bar
    
    @main_window = window('Glimmer Tetris') {
      content_size Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE + 98
      resizable false
      
      vertical_box {
        label { # filler
          stretchy false
        }
        
        score_board(block_size: BLOCK_SIZE) {
          stretchy false
        }
        
        @playfield_blocks = playfield(playfield_width: Model::Game::PLAYFIELD_WIDTH, playfield_height: Model::Game::PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
      }
    }
  end
  
  def register_observers
    observe(@game, :game_over) do |game_over|
      if game_over
        @pause_menu_item.enabled = false
        show_game_over_dialog
      else
        @pause_menu_item.enabled = true
        start_moving_tetrominos_down
      end
    end
    
    Model::Game::PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PLAYFIELD_WIDTH.times do |column|
        observe(@game.playfield[row][column], :color) do |new_color|
          Glimmer::LibUI.queue_main do
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @playfield_blocks[row][column]
            block[:background_square].fill = color
            block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
            block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          end
        end
      end
    end
    
    Model::Game::PREVIEW_PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PREVIEW_PLAYFIELD_WIDTH.times do |column|
        preview_updater = proc do
          Glimmer::LibUI.queue_main do
            new_color = @game.preview_playfield[row][column].color
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @preview_playfield_blocks[row][column]
            if @game.show_preview_tetromino?
              block[:background_square].fill = color
              block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
              block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
            else
              transparent_color = {r: 255, g: 255, b: 255, a: 0}
              block[:background_square].fill = transparent_color
              block[:top_bevel_edge].fill = transparent_color
              block[:right_bevel_edge].fill = transparent_color
              block[:bottom_bevel_edge].fill = transparent_color
              block[:left_bevel_edge].fill = transparent_color
              block[:border_square].stroke = transparent_color
            end
          end
        end
        observe(@game.preview_playfield[row][column], :color, &preview_updater)
        observe(@game, :show_preview_tetromino, &preview_updater)
      end
    end

    observe(@game, :score) do |new_score|
      Glimmer::LibUI.queue_main do
        @score_label.text = new_score.to_s
      end
    end

    observe(@game, :lines) do |new_lines|
      Glimmer::LibUI.queue_main do
        @lines_label.text = new_lines.to_s
      end
    end

    observe(@game, :level) do |new_level|
      Glimmer::LibUI.queue_main do
        @level_label.text = new_level.to_s
      end
    end
  end
  
  def menu_bar
    menu('Game') {
      @pause_menu_item = check_menu_item('Pause') {
        enabled false
        checked <=> [@game, :paused]
      }
      
      menu_item('Restart') {
        on_clicked do
          @game.restart!
        end
      }
      
      separator_menu_item
      
      menu_item('Exit') {
        on_clicked do
          exit(0)
        end
      }
      
      quit_menu_item if OS.mac?
    }
    
    menu('View') {
      check_menu_item('Show Next Block Preview') {
        checked <=> [@game, :show_preview_tetromino]
      }
      
      separator_menu_item
      
      menu_item('Show High Scores') {
        on_clicked do
          show_high_scores
        end
      }
      
      menu_item('Clear High Scores') {
        on_clicked {
          @game.clear_high_scores!
        }
      }
      
      separator_menu_item
    }

    menu('Options') {
      radio_menu_item('Instant Down on Up Arrow') {
        checked <=> [@game, :instant_down_on_up]
      }
      
      radio_menu_item('Rotate Right on Up Arrow') {
        checked <=> [@game, :rotate_right_on_up]
      }
      
      radio_menu_item('Rotate Left on Up Arrow') {
        checked <=> [@game, :rotate_left_on_up]
      }
    }

    menu('Help') {
      if OS.mac?
        about_menu_item {
          on_clicked do
            show_about_dialog
          end
        }
      end
      
      menu_item('About') {
        on_clicked do
          show_about_dialog
        end
      }
    }
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: , &extra_content)
    blocks = []
    vertical_box {
      padded false
      
      playfield_height.times.map do |row|
        blocks << []
        horizontal_box {
          padded false
          
          playfield_width.times.map do |column|
            blocks.last << block(row: row, column: column, block_size: block_size)
          end
        }
      end
      
      extra_content&.call
    }
    blocks
  end
  
  def block(row: , column: , block_size: , &extra_content)
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Glimmer::LibUI.interpret_color(Model::Block::COLOR_CLEAR)
    block[:area] = area {
      block[:background_square] = square(0, 0, block_size) {
        fill color
      }
      
      block[:top_bevel_edge] = polygon {
        point_array 0, 0, block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT
      }
      
      block[:right_bevel_edge] = polygon {
        point_array block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size, block_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:bottom_bevel_edge] = polygon {
        point_array block_size, block_size, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:left_bevel_edge] = polygon {
        point_array 0, 0, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:border_square] = square(0, 0, block_size) {
        stroke COLOR_GRAY
      }
      
      on_key_down do |key_event|
        case key_event
        in ext_key: :down
          if OS.windows?
            # rate limit downs in Windows as they go too fast when key is held
            @queued_downs ||= 0
            if @queued_downs < 2
              @queued_downs += 1
              Glimmer::LibUI.timer(0.01, repeat: false) do
                @game.down! if @queued_downs < 2
                @queued_downs -= 1
              end
            end
          else
            @game.down!
          end
        in key: ' '
          @game.down!(instant: true)
        in ext_key: :up
          case @game.up_arrow_action
          when :instant_down
            @game.down!(instant: true)
          when :rotate_right
            @game.rotate!(:right)
          when :rotate_left
            @game.rotate!(:left)
          end
        in ext_key: :left
          @game.left!
        in ext_key: :right
          @game.right!
        in modifier: :shift
          @game.rotate!(:right)
        in modifier: :control
          @game.rotate!(:left)
        else
          # Do Nothing
        end
      end
      
      extra_content&.call
    }
    block
  end
  
  def score_board(block_size: , &extra_content)
    vertical_box {
      horizontal_box {
        label # filler
        grid {
          stretchy false
          
          label('Score') {
            left 0
            top 0
            halign :fill
          }
          @score_label = label {
            left 0
            top 1
            halign :center
          }
    
          label('Lines') {
            left 1
            top 0
            halign :fill
          }
          @lines_label = label {
            left 1
            top 1
            halign :center
          }
    
          label('Level') {
            left 2
            top 0
            halign :fill
          }
          @level_label = label {
            left 2
            top 1
            halign :center
          }
        }
        label # filler
      }
      
      horizontal_box {
        label # filler
        @preview_playfield_blocks = playfield(playfield_width: Model::Game::PREVIEW_PLAYFIELD_WIDTH, playfield_height: Model::Game::PREVIEW_PLAYFIELD_HEIGHT, block_size: block_size)
        label # filler
      }
    
      extra_content&.call
    }
  end
  
  def start_moving_tetrominos_down
    unless @tetrominos_start_moving_down
      @tetrominos_start_moving_down = true
      tetromino_move = proc do
        @game.down! if !@game.game_over? && !@game.paused?
        Glimmer::LibUI.timer(@game.delay, repeat: false, &tetromino_move)
      end
      Glimmer::LibUI.timer(@game.delay, repeat: false, &tetromino_move)
    end
  end
  
  def show_game_over_dialog
    Glimmer::LibUI.queue_main do
      msg_box('Game Over!', "Score: #{@game.high_scores.first.score}\nLines: #{@game.high_scores.first.lines}\nLevel: #{@game.high_scores.first.level}")
      @game.restart!
    end
  end
  
  def show_high_scores
    Glimmer::LibUI.queue_main do
      game_paused = !!@game.paused
      @game.paused = true
      if @game.high_scores.empty?
        high_scores_string = "No games have been scored yet."
      else
        high_scores_string = @game.high_scores.map do |high_score|
          "#{high_score.name} | Score: #{high_score.score} | Lines: #{high_score.lines} | Level: #{high_score.level}"
        end.join("\n")
      end
      msg_box('High Scores', high_scores_string)
      @game.paused = game_paused
    end
  end
  
  def show_about_dialog
    Glimmer::LibUI.queue_main do
      msg_box('About', 'Glimmer Tetris - Glimmer DSL for LibUI Example - Copyright (c) 2021-2022 Andy Maleh')
    end
  end
end

Tetris.new.launch
