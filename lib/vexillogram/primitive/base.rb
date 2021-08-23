module Vexillogram::Primitive
  class Base
    def initialize(opts = {})
      @opts = {
        x_offset: 0,
        y_offset: 0
      }.merge(@defaults || {}).merge(opts)
    end

    def x_offset
      @opts.fetch(:x_offset)
    end

    def y_offset
      @opts.fetch(:y_offset)
    end

    def x_offset=(val)
      @opts[:x_offset] = val
    end

    def y_offset=(val)
      @opts[:y_offset] = val
    end
  end
end
