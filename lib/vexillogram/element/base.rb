module Vexillogram::Element
  class Base
    def initialize(opts = {}, &blk)
      @opts = {color: '#fff'}.merge(@defaults || {}).merge(opts)
    end
  end
end
