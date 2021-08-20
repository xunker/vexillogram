module Vexillogram::Element
  class Star < Base
    def initialize(opts = {}, &blk)
      @defaults = { points: 5, size: 0.25 }
      super
    end

    def polygon_points
      return @polygon_points if @polygon_points

      circle_d = @opts[:size]
      points = @opts[:points]

      circle_r = circle_d/2

      x = 0
      y = -circle_r

      @polygon_points = []

      side_angle = 360/points
      points.times do |idx|
        degrees = idx * (side_angle*2)

        radians = degrees * Math::PI/180

        x_rot = x * Math.cos(radians) - y * Math.sin(radians)
        y_rot = x * Math.sin(radians) + y * Math.cos(radians)

        @polygon_points << [x_rot, y_rot]
      end

      @polygon_points
    end

    def width
      polygon_points.map(&:first).max * @opts[:size]
    end

    def height
      polygon_points.map(&:last).max * @opts[:size]
    end

    def draw(flag)
      Victor::SVG.new.tap{ |svg|

        # Hacky way to do start with even number of points
        # Draw them twice: first time will have half the number of points,
        # second time will be rotated 180 degrees, e voila!
        iterations = @opts[:points].even? ? 2 : 1
        iterations.times do |iteration|
          svg.g(transform: "rotate(#{180 * iteration} 0 0)") {

            svg.polygon(
              points: polygon_points.map{|x,y|
                [
                  # scaled using image width only so proportion is kept
                  flag.fly_length_to_image_width(x),
                  flag.fly_length_to_image_width(y)
                ]
              },
              fill: @opts[:color]
            )
          }
        end
      }
    end
  end
end
