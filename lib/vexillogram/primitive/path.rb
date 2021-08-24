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
      build_svg_attributes(
        flag,
        d: @opts.fetch(:d)
      )
    end

    def svg_shape
      :path
    end
  end
end
