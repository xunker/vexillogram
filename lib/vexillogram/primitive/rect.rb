module Vexillogram::Primitive
  class Rect < Base
    def initialize(opts = {}, &blk)
      @defaults = {
        color: :white,
        stroke: nil,
        x: 0,
        y: 0,
        width: 1,
        height: 1,
        corner_r: 0
      }

      super
    end

    def svg_attributes(flag)
      {
        fill: @opts.fetch(:color),
        stroke: @opts.fetch(:stroke, nil),
        x: flag.fly_length_to_image_width(@opts.fetch(:x)),
        y: flag.hoist_width_to_image_height(@opts.fetch(:y)),
        width: flag.fly_length_to_image_width(@opts.fetch(:width)),
        height: flag.hoist_width_to_image_height(@opts.fetch(:height)),
        rx: flag.fly_length_to_image_width(@opts.fetch(:corner_r)),
      }

    end

    def svg_shape
      :rect
    end
  end
end
