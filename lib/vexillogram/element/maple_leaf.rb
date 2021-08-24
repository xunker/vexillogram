module Vexillogram::Element
  class MapleLeaf < Base
    # Maple Leaf path data from https://upload.wikimedia.org/wikipedia/commons/f/fd/Maple_Leaf.svg
    SVG_PATH = "m-90 2030 45-863a95 95 0 0 0-111-98l-859 151 116-320a65 65 0 0 0-20-73l-941-762 212-99a65 65 0 0 0 34-79l-186-572 542 115a65 65 0 0 0 73-38l105-247 423 454a65 65 0 0 0 111-57l-204-1052 327 189a65 65 0 0 0 91-27l332-652 332 652a65 65 0 0 0 91 27l327-189-204 1052a65 65 0 0 0 111 57l423-454 105 247a65 65 0 0 0 73 38l542-115-186 572a65 65 0 0 0 34 79l212 99-941 762a65 65 0 0 0-20 73l116 320-859-151a95 95 0 0 0-111 98l45 863z"

    def initialize(opts = {}, &blk)
      @defaults = {
        color: :red,
        size: 1
      }

      super
    end

    def width
      0.00 # ensure centered when charged/defaced
    end

    def height
      0.00 # ensure centered when charged/defaced
    end

    def primitives
      Vexillogram::Primitive::Path.new(
        build_primitive_attributes(
          d: SVG_PATH.gsub(/\d+/){|x|
            # Here we do some really hacky scaling around the SVG path to make it resize
            # properly when the image output sizes changes.
            x = ((x.to_f / 30) * @opts[:size]).round(4) # divisor of 30 is the magic number
            x = "0" if x.zero?
            x
          }
        )
      )
    end

    # def draw(flag)
    #   Victor::SVG.new.tap{ |svg|
    #     svg.path(
    #       fill: @opts.fetch(:color),
    #       d: SVG_PATH.gsub(/\d+/){|x|
    #         # Here we do some really hacky scaling around the SVG path to make it resize
    #         # properly when the image output sizes changes.
    #         x = ((x.to_f * flag.fly_length_to_image_width(0.0001)) * @opts[:size]).round(4)
    #         x = "0" if x.zero?
    #         x
    #       }
    #     )
    #   }
    # end
  end
end
