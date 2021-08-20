module Vexillogram::Element
  class Base
    def initialize(opts = {}, &blk)
      @opts = (@defaults || {}).merge(color: '#fff').merge(opts)
    end
  end
end
