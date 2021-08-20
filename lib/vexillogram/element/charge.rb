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

            centre_x = ((flag.image_width*flag.aspect_proportion)*(element.width))
            centre_y = ((flag.image_height*flag.aspect_proportion)*(element.height))

            g(transform: "translate(#{(flag.image_width/2)-centre_x} #{(flag.image_height/2)-centre_y})") {
              append element.draw(flag)
            }
          end
        end
      }
    end
  end
end
