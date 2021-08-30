module Vexillogram::Element
  class Triangle < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        base: :hoist, # :hoist, :fly, :upper, :lower
        hoist_width: 1,
        apex: 0.5
      }
      super
    end

    def polygon_points
      return @polygon_points if @polygon_points


      @polygon_points = generate_polygon_points
    end

    def width
      max_x - min_x
    end

    def height
      max_y - min_y
    end

    def min_x
      polygon_points.map(&:first).min
    end

    def max_x
      polygon_points.map(&:first).max
    end

    def min_y
      polygon_points.map(&:last).min
    end

    def max_y
      polygon_points.map(&:last).max
    end

    def x_origin
      0.5
    end

    def y_origin
      0.5
    end

    def base?(side)
      @opts.fetch(:base).to_sym == side
    end

    def primitives
      Vexillogram::Primitive::Polygon.new(
        build_primitive_attributes(
          points: polygon_points
        )
      )

    end

    private

    def generate_polygon_points
      if base?(:hoist)
        [
          [0, 0],
          [0, @opts.fetch(:hoist_width)],
          [@opts.fetch(:fly_length), @opts.fetch(:apex)],
          [0, 0]
        ]
      else
        raise 'base on other edges not yet implemented'
      end
    end
  end
end
