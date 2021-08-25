module Vexillogram::Primitive
  class Base
    def initialize(opts = {})
      @opts = {
        translate_x: 0,
        translate_y: 0
      }.merge(@defaults || {}).merge(opts)
    end

    def build_svg_attributes(flag, opts = {})
      {
        fill: Vexillogram::Color.resolve_color(@opts.fetch(:color)),
        transform: transform(flag)
      }.merge(opts)
    end

    def transform(flag)
      return unless [@opts[:translate_x], @opts[:translate_y]].any?(&:positive?)
      "translate(#{flag.fly_length_to_image_width(@opts[:translate_x])} #{flag.hoist_width_to_image_height(@opts[:translate_y])})"
    end
  end
end
