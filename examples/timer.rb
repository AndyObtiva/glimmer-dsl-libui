# frozen_string_literal: true

require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  include Glimmer::FiddleConsumer
  
  VERSION = '0.0.1'

  def initialize
    @pid = nil
    @midi_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      if @th.alive?
        Process.kill(:SIGKILL, @pid)
        @pid = nil
      else
        @pid = nil
      end
    end
  end

  def play_midi
    stop_midi
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@midi_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Timer',
              "Written in Ruby\n" \
                "https://github.com/AndyObtiva/glimmer-dsl-libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
      quit_menu_item
    }
    
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            @hour_spinbox = spinbox(0, 60) {
              stretchy false
              value 60
            }
            label(':') {
              stretchy false
            }
            @min_spinbox = spinbox(0, 60) {
              stretchy false
              value 60
            }
          }
          horizontal_box {
            @start_button = button('Start') {
              on_clicked do
                @start_button.enabled = false
                @stop_button.enabled = true
                @started = true
                @played = false
                if @closure.nil?
                  @closure = fiddle_closure_block_caller(4, [0]) do
                    if @started
                      time = @min_spinbox.value
                      if time > 0
                        @min_spinbox.value = time -= 1
                      end
                      if time == 0
                        @start_button.enabled = true
                        @stop_button.enabled = false
                        @started = false
                        unless @played
                          play_midi
                          @played = true
                        end
                      end
                    end
                    1
                  end
                  ::LibUI.timer(1000, @closure)
                end
              end
            }
            
            @stop_button = button('Stop') {
              enabled false
              
              on_clicked do
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
