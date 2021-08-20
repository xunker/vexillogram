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
          y: flag.hoist_width_to_image_height(@opts[:from]),
          width: flag.fly_length_to_image_width(1),
          height: flag.hoist_width_to_image_height(@opts[:to]) - flag.hoist_width_to_image_height(@opts[:from]),
          rx: 0, fill: @opts[:color])
      }
    end
  end
end
