module Vexillogram::Element
  class Disc < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        radius: 0.25,
        relative_to: :hoist_width
      }

      super

      if @opts.fetch(:diameter, nil)
        @opts[:radius] = @opts.fetch(:diameter)/2
      end
    end

    def width
      0.00 # ensure centered when charged/defaced
    end

    def height
      0.00 # ensure centered when charged/defaced
    end

    def draw(flag)
      radius = case @opts.fetch(:relative_to)
        when :hoist_width, :hoist
          flag.hoist_width_to_image_height(@opts.fetch(:radius))
        else
          flag.fly_length_to_image_width(@opts.fetch(:radius))
        end

      Victor::SVG.new.tap {|svg|
        svg.circle(cx: 0, cy: 0, r: radius, fill: @opts.fetch(:color))
      }
    end
  end
end
