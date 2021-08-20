module Vexillogram::Element
  class Canton < Base
    def initialize(opts = {}, &blk)
      super
    end

    def draw(flag)
      Victor::SVG.new.tap{ | el|
        el.element :rect, x: 0, y: 0, width: flag.image_width/2, height: flag.image_height/2, rx: 0, fill: @opts[:color]
      }
    end
  end
end
