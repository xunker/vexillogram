module Vexillogram::Element
  class VerticalBand < Base
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
          x: flag.fly_length_to_image_width(@opts[:from]),
          y: 0,
          width: flag.fly_length_to_image_width(@opts[:to]) - flag.fly_length_to_image_width(@opts[:from]),
          height: flag.hoist_width_to_image_height(1),
          rx: 0, fill: @opts[:color])
      }
    end
  end
end
