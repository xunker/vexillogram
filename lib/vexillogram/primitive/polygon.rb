module Vexillogram::Primitive
  class Polygon < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        color: :white,
        points: [],
        relative_to: :hoist_width,
      }

      super
    end

    def svg_attributes(flag)
      # scaled using image width or image height alone so proportion is kept
      scaled_points = @opts.fetch(:points).map{|x,y|
        case @opts.fetch(:relative_to)
          when :hoist_width, :hoist
            [
              flag.hoist_width_to_image_height(x),
              flag.hoist_width_to_image_height(y)
            ]
          else
            [
              flag.fly_length_to_image_width(x),
              flag.fly_length_to_image_width(y)
            ]
          end
      }

      build_svg_attributes(
        flag,
        points: scaled_points
      )
    end

    def svg_shape
      :polygon
    end
  end
end
