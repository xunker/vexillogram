module Vexillogram::Element
  class Charge < Base
    def initialize(opts = {}, &blk)
      @defaults = { }
      super

      @elements = []
      @elements += Array(instance_eval(&blk)).flatten
    end

    def draw(flag)
      Victor::SVG.new.tap {|svg|
        @elements.map do |element|
          svg.build do
            x_translation = 0
            y_translation = 0

            if element.width != 1.0
              centre_x = ((flag.image_width*flag.aspect_proportion)*(element.width))
              x_translation = (flag.image_width/2)-centre_x
            end

            if element.height != 1.0
              centre_y = ((flag.image_height*flag.aspect_proportion)*(element.height))
              y_translation = (flag.image_height/2)-centre_y
            end

            g(transform: "translate(#{x_translation} #{y_translation})") {
              append element.draw(flag)
            }
          end
        end
      }
    end
  end
end
