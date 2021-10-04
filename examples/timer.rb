# frozen_string_literal: true

require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      if @th.alive?
        Process.kill(:SIGKILL, @pid)
        @pid = nil
      else
        @pid = nil
      end
    end
  end

  def play_alarm
    stop_alarm
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@alarm_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def setup_timer
    unless @setup_timer
      Glimmer::LibUI.timer(1) do
        if @started
          seconds = @sec_spinbox.value
          minutes = @min_spinbox.value
          hours = @hour_spinbox.value
          if seconds > 0
            @sec_spinbox.value = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              @min_spinbox.value = minutes -= 1
              @sec_spinbox.value = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                @hour_spinbox.value = hours -= 1
                @min_spinbox.value = minutes = MINUTE_MAX
                @sec_spinbox.value = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  @played = true
                end
              end
            end
          end
        end
      end
      @setup_timer = true
    end
  end

  def create_gui
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            @hour_spinbox = spinbox(0, HOUR_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @min_spinbox = spinbox(0, MINUTE_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @sec_spinbox = spinbox(0, SECOND_MAX) {
              stretchy false
              value 0
            }
          }
          horizontal_box {
            @start_button = button('Start') {
              on_clicked do
                @start_button.enabled = false
                @stop_button.enabled = true
                @started = true
                @played = false
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
