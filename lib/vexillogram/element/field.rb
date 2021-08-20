module Vexillogram::Element
  class Field < Base
    def initialize(opts = {}, &blk)
      super

      @elements = []
      if block_given?
        @elements += Array(instance_eval(&blk)).flatten
      else
        @elements << HorizontalBand.new(color: @opts[:color], from: 0, to: 1)
      end
    end

    # def draw(flag)
    #   HorizontalBand.new(color: @opts[:color], from: 0, to: 1).draw(flag)
    # end

    def draw(flag)
    #   @elements << HorizontalBand.new(color: @opts[:color], from: 0, to: 1)
    #   @elements << VerticalBand.new(color: '#f0f', from: 0.33, to: 0.66)

      Victor::SVG.new.tap {|svg|
        @elements.map do |element|
          svg << element.draw(flag)
        end
      }
    end
  end
end
