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
    # Proxy for LibUI date time picker objects
    #
    # Follows the Proxy Design Pattern
    class DateTimePickerProxy < ControlProxy
      def libui_api_keyword
        'date_time_picker'
      end
      
      def time(value = nil)
        if value.nil?
          @time ||= ::LibUI::FFI::TM.malloc
          ::LibUI.date_time_picker_time(@libui, @time)
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
          new_time = ::LibUI::FFI::TM.malloc
          # TODO consider whether to start off by reading current time first and amending it or to start with fresh default time attributes
          new_time.tm_sec = value[:sec] unless value[:sec].nil?
          new_time.tm_min = value[:min] unless value[:min].nil?
          new_time.tm_hour = value[:hour] unless value[:hour].nil?
          new_time.tm_mday = value[:mday] unless value[:mday].nil?
          new_time.tm_mon = value[:mon] - 1 unless value[:mon].nil?
          new_time.tm_year = value[:year] - 1900 unless value[:year].nil?
          new_time.tm_wday = value[:wday] - 1 unless value[:wday].nil?
          new_time.tm_yday = value[:yday] - 1 unless value[:yday].nil?
          new_time.tm_isdst = value[:dst] ? 1 : 0 unless value[:dst].nil?
          ::LibUI.date_time_picker_set_time(@libui, new_time)
          Fiddle.free new_time
        end
      end
      alias set_time time
      alias time= time
      
      def destroy
        Fiddle.free @time unless @time.nil?
        super
      end
    end
  end
end
