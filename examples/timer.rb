require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  attr_accessor :hour, :min, :sec, :started, :played
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    @hour = @min = @sec = 0
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
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
          seconds = @sec
          minutes = @min
          hours = @hour
          if seconds > 0
            self.sec = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              self.min = minutes -= 1
              self.sec = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                self.hour = hours -= 1
                self.min = minutes = MINUTE_MAX
                self.sec = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                self.started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  self.played = true
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
            spinbox(0, HOUR_MAX) {
              stretchy false
              value <=> [self, :hour]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, MINUTE_MAX) {
              stretchy false
              value <=> [self, :min]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, SECOND_MAX) {
              stretchy false
              value <=> [self, :sec]
            }
          }
          horizontal_box {
            button('Start') {
              enabled <= [self, :started, on_read: :!]
              
              on_clicked do
                self.started = true
                self.played = false
              end
            }
            
            button('Stop') {
              enabled <= [self, :started]
              
              on_clicked do
                self.started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
