module Vexillogram::Element
  class HorizontalBand < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        from: 0,
        to: 1
      }

      super
    end

    def draw(flag)
      Victor::SVG.new.tap{ | el|
        el.element(
          :rect,
          x: 0,
          y: flag.image_height*@opts[:from],
          width: flag.image_width,
          height: flag.image_height*@opts[:to] - flag.image_height*@opts[:from],
          rx: 0, fill: @opts[:color])
      }
    end
  end
end
