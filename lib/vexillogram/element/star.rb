module Vexillogram::Element
  class Star < Base
    POINTS = [
      [0.5, 0.05],
      [0.2, 0.9],
      [0.95, 0.3],
      [0.05, 0.3],
      [0.8, 0.9]
    ]

    def initialize(opts = {}, &blk)
      @defaults = { points: 5, size: 0.25 }
      super
    end

    def width
      POINTS.map(&:first).max * @opts[:size]
    end

    def height
      POINTS.map(&:last).max * @opts[:size]
    end

    def draw(flag)
      points = POINTS.map{|a,b|
        [(a*flag.image_width)*@opts[:size], (b*flag.image_height)*@opts[:size]]
      }

      Victor::SVG.new.tap {|svg|
        svg.polygon points: points, fill: @opts[:color]
      }

    end
  end
end
