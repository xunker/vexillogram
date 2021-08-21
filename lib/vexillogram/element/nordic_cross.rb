module Vexillogram::Element
  class NordicCross < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        horizontal: [0.2, 0.2, 0.6],
        vertical: [0.4, 0.2, 0.4]
      }

      super

      if @opts.fetch(:horizontal).to_s.include?(':')
        @opts[:horizontal] = parse_proportions_from_string(@opts.fetch(:horizontal))
      end

      if @opts.fetch(:vertical).to_s.include?(':')
        @opts[:vertical] = parse_proportions_from_string(@opts.fetch(:vertical))
      end
    end

    def width
      0
    end

    def height
      0
    end

    # expecting a string that looks like "nn:nn:nn", ex: "2:2:8"
    # returns array of input split by colon
    # converts number to relative float of they are not already like that
    def parse_proportions_from_string(proportions_string)
      proportions = proportions_string.split(':')[0..2].map(&:to_f)

      total = proportions.inject(:+)
      # adjust them to proportions relative to each other if they don't seem to be already
      return proportions if total <= 1.0

      proportions.map{|p| p.to_f / total.to_f}
    end

    def draw(flag)
      Victor::SVG.new.tap{ |svg|
        # vertical
        svg.element(
          :rect,
          x: -flag.fly_length_to_image_width(0.5),
          y: -flag.hoist_width_to_image_height(@opts[:vertical][0]/4),
          width: flag.fly_length_to_image_width(1),
          height: flag.hoist_width_to_image_height(@opts[:vertical][1]),
          rx: 0, fill: @opts[:color]
        )

        # horizontal
        svg.element(
          :rect,
          x: -flag.fly_length_to_image_width(@opts[:horizontal][0]/2),
          y: -flag.hoist_width_to_image_height(0.5),
          width: flag.fly_length_to_image_width(@opts[:horizontal][1]),
          height: flag.hoist_width_to_image_height(1),
          rx: 0, fill: @opts[:color]
        )

      }
    end
  end
end
