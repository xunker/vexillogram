module Vexillogram::Element
  class VerticalBand < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        from: 0,
        to: 1
      }

      super
    end

    def width
      opts.fetch(:to) - opts.fetch(:from)
    end

    def height
      1
    end

    def primitives
      Vexillogram::Primitive::Rect.new(
        build_primitive_attributes(
          x: @opts[:from],
          y: 0,
          width: @opts[:to] - @opts[:from],
          height: 1
        )
      )
    end
  end
end
