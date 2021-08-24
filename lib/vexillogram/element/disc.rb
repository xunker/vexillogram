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
      radius
    end

    def height
      radius
    end

    def primitives
      Vexillogram::Primitive::Circle.new(
        color: @opts.fetch(:color),
        cx: 0,
        cy: 0,
        radius: @opts.fetch(:radius),
        translate_x: translate_x,
        translate_y: translate_y
      )
    end
  end
end
