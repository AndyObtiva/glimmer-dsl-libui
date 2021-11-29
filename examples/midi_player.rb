# frozen_string_literal: true

require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'
  
  attr_accessor :selected_file

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox { |c|
          items @midi_files.map { |path| File.basename(path) }
          # data-bind selected item (String) to self.selected_file with on-read/on-write converters and after_write operation
          selected_item <=> [self, :selected_file, on_read: ->(f) {File.basename(f.to_s)}, on_write: ->(f) {File.join(@music_directory, f)}, after_write: -> { play_midi if @th&.alive? }]
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
