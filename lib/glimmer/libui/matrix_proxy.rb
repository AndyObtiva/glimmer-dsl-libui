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
    # Proxy for LibUI matrix objects
    #
    # Follows the Proxy Design Pattern
    class MatrixProxy < ControlProxy
      def libui_api_keyword
        'draw_matrix'
      end
      
      def clone
        MatrixProxy.new('matrix', nil, [@libui.M11, @libui.M12, @libui.M21, @libui.M22, @libui.M31, @libui.M32])
      end
      
      def dup
        clone
      end
      
      private
      
      def build_control
        @libui = ::LibUI::FFI::DrawMatrix.malloc
        if @args.empty?
          ::LibUI.draw_matrix_set_identity(@libui)
        else
          @libui.M11 = @args[0].to_f
          @libui.M12 = @args[1].to_f
          @libui.M21 = @args[2].to_f
          @libui.M22 = @args[3].to_f
          @libui.M31 = @args[4].to_f
          @libui.M32 = @args[5].to_f
        end
      end
    end
    TransformProxy = MatrixProxy # alias
  end
end
