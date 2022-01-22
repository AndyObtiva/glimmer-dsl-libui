# Copyright (c) 2021-2022 Andy Maleh
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
        
        def m11(value = nil)
          if value.nil?
            @libui.M11
          else
            @libui.M11 = value.to_f
          end
        end
        alias m11= m11
        alias set_m11 m11
        
        def m12(value = nil)
          if value.nil?
            @libui.M12
          else
            @libui.M12 = value.to_f
          end
        end
        alias m12= m12
        alias set_m12 m12
        
        def m21(value = nil)
          if value.nil?
            @libui.M21
          else
            @libui.M21 = value.to_f
          end
        end
        alias m21= m21
        alias set_m21 m21
        
        def m22(value = nil)
          if value.nil?
            @libui.M22
          else
            @libui.M22 = value.to_f
          end
        end
        alias m22= m22
        alias set_m22 m22
        
        def m31(value = nil)
          if value.nil?
            @libui.M31
          else
            @libui.M31 = value.to_f
          end
        end
        alias m31= m31
        alias set_m31 m31
        
        def m32(value = nil)
          if value.nil?
            @libui.M32
          else
            @libui.M32 = value.to_f
          end
        end
        alias m32= m32
        alias set_m32 m32
        
        def identity
          set_identity
        end
        
        def rotate(x = 0, y = 0, degrees)
          super(x, y, (Math::PI*2.0/360.0)*degrees)
        end
        
        def scale(x_center = 0, y_center = 0, x, y)
          super
        end
        
        def skew(x = 0, y = 0, x_amount, y_amount)
          super
        end
        
        def multiply(matrix)
          super(matrix.respond_to?(:libui) ? matrix.libui : matrix)
        end
        
        def invertible
          Glimmer::LibUI.integer_to_boolean(super, allow_nil: false)
        end
        alias invertible? invertible
        
        private
        
        def build_control
          @libui = ::LibUI::FFI::DrawMatrix.malloc
          if @args.empty?
            set_identity
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
end
