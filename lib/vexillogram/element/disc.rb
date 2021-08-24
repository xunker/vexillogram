module Vexillogram::Element
  class Disc < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        radius: 0.25,
        relative_to: :hoist_width,
        cx: 0,
        cy: 0
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
        build_primitive_attributes(
          radius: @opts.fetch(:radius),
          cx: @opts.fetch(:cx),
          cy: @opts.fetch(:cy)
        )
      )
    end
  end
end
