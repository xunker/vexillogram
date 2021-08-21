module Vexillogram::Element
  class Charge < Base
    ARRANGEMENT_SYNONYMS = [
      %i[vertical vertically in_pale palewise per_pale],
      %i[horizontal horizontally in_fess fesswise per_fess],
    ]
    def initialize(opts = {}, &blk)
      @defaults = {
        arrangement: :horizontal
      }
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
