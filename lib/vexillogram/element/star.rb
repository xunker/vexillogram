module Vexillogram::Element
  class Star < Base
    def initialize(opts = {}, &blk)
      @defaults = { points: 5, size: 0.25, inner_size: nil, relative_to: :fly_length }
      super
    end

    # Build stars by plotting 2 n-gons (where n is number of points on the star), with
    # one of the n-gons proportionally smaller than the other and rotated. Zip these two n-gons
    # together and plot it as a polygon
    def polygon_points
      return @polygon_points if @polygon_points

      inner_size = @opts.fetch(:inner_size, nil) || @opts[:size]/(@opts[:points]*0.5)

      @polygon_points = generate_polygon_points(@opts[:size])
      @polygon_points = @polygon_points.zip(generate_polygon_points(inner_size, 180/@opts[:points]))

      # it's nested too deeply now, so we flatten it totally and re-pair it
      @polygon_points = @polygon_points.flatten.each_slice(2).map
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

    def primitives
      Vexillogram::Primitive::Polygon.new(
        build_primitive_attributes(
          points: polygon_points,
          relative_to: @opts.fetch(:relative_to)
        )
      )

    end

    private

    def generate_polygon_points(circle_d, rotation_offset = 0)
      circle_d = circle_d
      points = @opts[:points]

      circle_r = circle_d/2

      x = 0
      y = -circle_r
      side_angle = 360/points
      points.times.map{ |idx|
        degrees = (idx * (side_angle)) + rotation_offset

        radians = degrees * Math::PI/180

        x_rot = x * Math.cos(radians) - y * Math.sin(radians)
        y_rot = x * Math.sin(radians) + y * Math.cos(radians)

        [x_rot, y_rot]
      }
    end
  end
end
