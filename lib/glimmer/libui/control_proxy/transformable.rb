# Copyright (c) 2021-2024 Andy Maleh
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

require 'glimmer/libui/control_proxy/matrix_proxy'

module Glimmer
  module LibUI
    # This is meant to be prepended (not included) because it changes behavior of instance draw method
    # Adds transform property to controls/shapes
    # Automatically applies transform property at the beginning of draw operation and undoes it at the end
    # Stacks up with Parent module (must include Parent beforehand)
    # Expects transformable to implement redraw method
    module Transformable
      def post_initialize_child(child, add_child: true)
        if child.is_a?(ControlProxy::MatrixProxy)
          super(child, add_child: false)
          self.transform = child if child.keyword == 'transform'
        else
          super(child, add_child: add_child)
        end
      end
    
      # Returns transform or sets it. Expects transformable to implement redraw method (delegating work to area).
      def transform(matrix = nil, &transform_body_block)
        if matrix.nil?
          if transform_body_block
            # TODO Consider using alternate version of Engine call instead: Glimmer::DSL::Engine.interpret('transform', &transform_body_block) (or delete this comment if not needed)
            Glimmer::DSL::Engine.interpret_expression(Glimmer::DSL::Libui::ControlExpression.new, 'transform', &transform_body_block)
          else
            @transform
          end
        else
          @transform = matrix
          redraw
        end
      end
      alias transform= transform
      alias set_transform transform
      
      # Apply transform matrix to coordinate system
      def apply_transform(area_draw_params)
        ::LibUI.draw_transform(area_draw_params[:context], @transform.libui) unless @transform.nil?
      end
      
      # Inverse of apply_transform (applies inverse transformation to undo initial transformation)
      def undo_transform(area_draw_params)
        unless @transform.nil?
          inverse_transform = @transform.clone
          inverse_transform.invert
          ::LibUI.draw_transform(area_draw_params[:context], inverse_transform.libui)
        end
      end
      
      def draw(area_draw_params)
        apply_transform(area_draw_params)
        super(area_draw_params)
        undo_transform(area_draw_params)
      end
    end
  end
end
