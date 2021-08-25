module Vexillogram::Element
  class Base
    def initialize(opts = {}, &blk)
      @opts = {
        color: '#fff',
        show_bounds: false,
        translate_x: 0,
        translate_y: 0
      }.merge(@defaults || {}).merge(opts)
    end

    def build_primitive_attributes(opts = {})
      {
        color: Vexillogram::Color.resolve_color(@opts.fetch(:color)),
        show_bounds: @opts.fetch(:show_bounds),
        translate_x: translate_x,
        translate_y: translate_y
      }.merge(opts)
    end

    def translate_x
      @opts.fetch(:translate_x)
    end

    def translate_y
      @opts.fetch(:translate_y)
    end

    def translate_x=(val)
      @opts[:translate_x] = val
    end

    def translate_y=(val)
      @opts[:translate_y] = val
    end

    def x_origin
      0
    end

    def y_origin
      0
    end
  end
end
