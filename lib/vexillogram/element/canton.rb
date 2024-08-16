# In vexillography, the canton is a rectangular emblem placed at the top left of a flag, usually
# occupying up to a quarter of a flag's area.
# https://en.wikipedia.org/wiki/Canton_(flag)
module Vexillogram::Element
  class Canton < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        color: :white,
        width: 0.5,
        height: 0.5
      }
      super

      @elements = []
      @elements += Array(instance_eval(&blk)).flatten if block_given?
    end

    # def draw(flag)
    #   Victor::SVG.new.tap{ | el|
    #     svg_els = []
    #     svg_els << el.element(:rect, x: 0, y: 0, width: flag.image_width/2, height: flag.image_height/2, rx: 0, fill: @opts[:color])

    #     @elements.each_with_index do |element, idx|
    #       puts element.inspect
    #       svg_els << element.draw(flag)
    #     end

    #     svg_els
    #   }
    # end

    def width
      @opts.fetch(:width)
    end

    def height
      @opts.fetch(:height)
    end

    def primitives
      prims = []
      prims << Vexillogram::Primitive::Rect.new(
        build_primitive_attributes(
          x: 0,
          y: 0,
          width: width,
          height: height
        )
      )

      prims << @elements.map(&:primitives)
      prims
    end
  end
end
