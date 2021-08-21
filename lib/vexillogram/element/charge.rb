module Vexillogram::Element
  class Charge < Base
    def initialize(opts = {}, &blk)
      @defaults = { }
      super

      @elements = []
      @elements += Array(instance_eval(&blk)).flatten if block_given?
    end

    def draw(flag)
      Victor::SVG.new.tap {|svg|
        @elements.map do |element|
          svg.build do
            x_translation = flag.image_width.to_f/2
            y_translation = flag.image_height.to_f/2

            g(transform: "translate(#{x_translation} #{y_translation})") {
              append element.draw(flag)
            }
          end
        end
      }
    end
  end
end
