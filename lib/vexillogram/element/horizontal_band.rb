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
      opts.fetch(:to) - opts.fetch(:from)
    end

    def height
      1
    end

    def primitives
      Vexillogram::Primitive::Rect.new(
        color: @opts[:color],
        x: 0,
        y: @opts[:from],
        width: 1,
        height: @opts[:to] - @opts[:from]
      )
    end
  end
end
