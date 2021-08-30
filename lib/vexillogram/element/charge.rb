module Vexillogram::Element
  class Charge < Base
    ARRANGEMENT_SYNONYMS = {
      vertical: %i[vertical vertically in_pale palewise per_pale],
      horizontal: %i[horizontal horizontally in_fess fesswise per_fess],
    }
    def initialize(opts = {}, &blk)
      @defaults = {
        arrangement: :horizontal
      }
      super

      @elements = []
      @elements += Array(instance_eval(&blk)).flatten if block_given?

      if @elements.length == 1
        @elements.last.translate_x = 0.5 - @elements.last.x_origin
        @elements.last.translate_y = 0.5 - @elements.last.y_origin
      elsif @elements.length > 1
        # get width of middle elements, and half the width of the first and last
        total_width_of_elements = (@elements[1..-2].map(&:width) + [@elements.first, @elements.last].map{|e| e.width/2}).inject(:+)

        initial_x_offset = (1.0 - total_width_of_elements)/2

        @elements.each_with_index do |element, idx|
          # centre symetric elements
          raise 'Vertical Charge arrangement not yet implemented' if vertical?

          if horizontal?
            element.translate_x = (initial_x_offset) + (element.width*(idx))
            element.translate_y = 0.5
          end

          if vertical?
            raise 'vertical charge arrangement not yet implemented'
          end
        end
      end
    end

    def horizontal?
      ARRANGEMENT_SYNONYMS[:horizontal].include? @opts[:arrangement]
    end

    def vertical?
      ARRANGEMENT_SYNONYMS[:vertical].include? @opts[:arrangement]
    end

    def width
      1
    end

    def height
      1
    end

    def primitives
      @elements.map(&:primitives)
    end

    def draw(flag)
      total_width_of_elements = 0 # set by horizontal arrangement
      total_height_of_elements = 0 # set by vertical arrangement

      # if @elements.length > 1
        raise 'Vertical Charge arrangement not yet implemented' if vertical?

        if horizontal?
          # total width of middle items plus width on centre of first and last
          total_width_of_elements = @elements[1..-2].map(&:width).inject(:+)
          total_width_of_elements = total_width_of_elements.to_f + @elements.first.width/2
          total_width_of_elements = total_width_of_elements.to_f + @elements.last.width/2
        end
      # end

      Victor::SVG.new.tap {|svg|
        x_translation = flag.image_width.to_f/2
        y_translation = flag.image_height.to_f/2

        # if @elements.length > 1
          raise 'Vertical Charge arrangement not yet implemented' if vertical?

          if horizontal?
            x_translation -= flag.fly_length_to_image_width(total_width_of_elements)/2
          end
        # end

        @elements.each_with_index.map do |element, idx|
          group_el = svg.build do


            g(transform: "translate(#{x_translation} #{y_translation})") {
              append element.draw(flag)
            }
          end

          x_translation += flag.fly_length_to_image_width(element.width)

          group_el
        end
      }
    end
  end
end
