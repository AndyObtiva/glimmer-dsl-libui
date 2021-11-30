# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'glimmer/libui/control_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI date time picker objects
      #
      # Follows the Proxy Design Pattern
      class DateTimePickerProxy < ControlProxy
        def libui_api_keyword
          'date_time_picker'
        end
        
        def time(value = nil)
          @time ||= ::LibUI::FFI::TM.malloc
          ::LibUI.date_time_picker_time(@libui, @time)
          if value.nil?
            {
              sec: @time.tm_sec,
              min: @time.tm_min,
              hour: @time.tm_hour,
              mday: @time.tm_mday,
              mon: @time.tm_mon + 1,
              year: @time.tm_year + 1900,
              wday: @time.tm_wday + 1,
              yday: @time.tm_yday + 1,
              dst: @time.tm_isdst == 1
            }
          else
            @time.tm_sec = value[:sec] unless value[:sec].nil?
            @time.tm_min = value[:min] unless value[:min].nil?
            @time.tm_hour = value[:hour] unless value[:hour].nil?
            @time.tm_mday = value[:mday] unless value[:mday].nil?
            @time.tm_mon = value[:mon] - 1 unless value[:mon].nil?
            @time.tm_year = value[:year] - 1900 unless value[:year].nil?
            ::LibUI.date_time_picker_set_time(@libui, @time)
          end
        end
        alias set_time time
        alias time= time
        
        def destroy
          Fiddle.free @time unless @time.nil?
          super
        end
        
        def data_bind_write(property, model_binding)
          handle_listener('on_changed') { model_binding.call(time) } if property == 'time'
        end
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
