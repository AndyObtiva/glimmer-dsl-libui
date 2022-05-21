require 'forwardable'
  
module Glimmer
  module LibUI
    # GUI View objects that can be represented by PerfectShape objects
    module PerfectShaped
      extend Forwardable
      
      def_delegators :perfect_shape,
                     :min_x, :min_y, :max_x, :max_y, :center_point, :center_x, :center_y
      
      # Returns if shape contains point on the inside when outline is false (default)
      # or if point is on the outline when outline is true
      # distance_tolerance is used when outline is true to enable a fuzz factor in
      # determining if a point lies on the outline (e.g. makes it easier to select
      # a shape by mouse)
      def contain?(*point, outline: false, distance_tolerance: 0)
        perfect_shape&.contain?(*point, outline: outline, distance_tolerance: distance_tolerance)
      end
      
      # Returns if shape includes point on the inside when filled
      # or if shape includes point on the outline when stroked
      def include?(*point)
        if fill.empty?
          contain?(*point, outline: true, distance_tolerance: ((stroke[:thickness] || 1) - 1))
        else
          contain?(*point)
        end
      end
      
      # Returns bounding box Array consisting of
      # [minx, miny, width, height]
      def bounding_box
        perfect_shape_bounding_box = perfect_shape&.bounding_box
        return if perfect_shape_bounding_box.nil?
        [
          perfect_shape_bounding_box.x,
          perfect_shape_bounding_box.y,
          perfect_shape_bounding_box.width,
          perfect_shape_bounding_box.height,
        ]
      end
      
      # moves by x delta and y delta. Classes must implement
      def move_by(x_delta, y_delta)
        # No Op
      end
      alias translate move_by
      
      def move(x, y)
        x_delta = x - perfect_shape.min_x
        y_delta = y - perfect_shape.min_y
        move_by(x_delta, y_delta)
      end
      
      # Returns PerfectShape object matching this shape to enable
      # executing computational geometry algorithms
      #
      # Including classes must implement
      def perfect_shape
        # No Op
      end
    end
  end
end
