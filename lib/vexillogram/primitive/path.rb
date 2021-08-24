module Vexillogram::Primitive
  class Path < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        color: :white,
        d: []
      }

      super
    end

    def svg_attributes(flag)
      {
        fill: @opts.fetch(:color),
        d: @opts.fetch(:d),
        transform: transform(flag)
      }
    end

    def svg_shape
      :path
    end
  end
end
