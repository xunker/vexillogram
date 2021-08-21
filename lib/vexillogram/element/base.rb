module Vexillogram::Element
  class Base
    def initialize(opts = {}, &blk)
      @opts = {color: '#fff', show_bounds: false}.merge(@defaults || {}).merge(opts)
    end
  end
end
