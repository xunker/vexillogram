module Vexillogram::Primitive
  class Circle < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        color: :white,
        radius: 0.25,
        relative_to: :hoist_width,
        cx: 0,
        cy: 0
      }

      super
    end

    def svg_attributes(flag)
      radius = case @opts.fetch(:relative_to)
        when :hoist_width, :hoist
          flag.hoist_width_to_image_height(@opts.fetch(:radius))
        else
          flag.fly_length_to_image_width(@opts.fetch(:radius))
        end

      {
        fill: @opts.fetch(:color),
        stroke: @opts.fetch(:stroke, nil),
        cx: flag.fly_length_to_image_width(@opts.fetch(:cx)),
        cy: flag.hoist_width_to_image_height(@opts.fetch(:cy)),
        r: radius,
        transform: transform(flag)
      }
    end

    def svg_shape
      :circle
    end
  end
end
