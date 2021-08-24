module Vexillogram::Element
  class HorizontalBand < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        from: 0,
        to: 1
      }

      super
    end

    def width
      1
    end

    def height
      opts.fetch(:to) - opts.fetch(:from)
    end

    def primitives
      Vexillogram::Primitive::Rect.new(
        build_primitive_attributes(
          x: 0,
          y: @opts[:from],
          width: 1,
          height: @opts[:to] - @opts[:from]
        )
      )
    end
  end
end
