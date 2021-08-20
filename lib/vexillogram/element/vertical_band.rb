module Vexillogram::Element
  class VerticalBand < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        from: 0,
        to: 1
      }
    end

    def draw(flag)
      Victor::SVG.new.tap{ | el|
        el.element(
          :rect,
          x: flag.image_width*@opts[:from],
          y: 0,
          width: flag.image_width*@opts[:to] - flag.image_width*@opts[:from],
          height: flag.image_height,
          rx: 0, fill: @opts[:color])
      }
    end
  end
end
