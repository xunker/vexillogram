module Vexillogram::Element
  class Star < Base
    POINTS = [
      [0.5, 0.05],
      [0.2, 0.9],
      [0.95, 0.3],
      [0.05, 0.3],
      [0.8, 0.9]
    ]

    def initialize(opts = {}, &blk)
      @defaults = { points: 5, size: 0.25 }
      super
    end

    def width
      POINTS.map(&:first).max * @opts[:size]
    end

    def height
      POINTS.map(&:last).max * @opts[:size]
    end

    def draw(flag)
      points = POINTS.map{|a,b|
        [(a*flag.image_width)*@opts[:size], (b*flag.image_height)*@opts[:size]]
      }

      Victor::SVG.new.tap {|svg|
        svg.polygon points: points, fill: @opts[:color]
      }

    end

    def draw(flag)
      # rdx = 40
      # # points = (1..360).map do |grado|
      # # points = (1..6).map do |grado|
      # points = 0.step(359*1, 72).map do |grado|
      #   x = ((Math.sin grado) * (rdx)) + (rdx)
      #   y = ((Math.cos grado) * rdx) + rdx
      #   puts [x.to_i, y.to_i].inspect
      #   [x.to_i, y.to_i]
      # end

      svg = Victor::SVG.new
      # Victor::SVG.new.tap {|svg|
      #   svg.polygon points: points, fill: @opts[:color]
      # }
      # def circle(x0, y0, radius, stroke_color = ChunkyPNG::Color::BLACK, fill_color = ChunkyPNG::Color::TRANSPARENT)
      #   stroke_color = ChunkyPNG::Color.parse(stroke_color)
      #   fill_color   = ChunkyPNG::Color.parse(fill_color)

      # code lifted from https://github.com/wvanbergen/chunky_png/blob/master/lib/chunky_png/canvas/drawing.rb#L241
      radius = 10
      x0 = 0
      y0 = 0
      fill_color = :transparent
      # fill_color = :blue
      stroke_color = :yellow


      f = 1 - radius
      dd_f_x = 1
      dd_f_y = -2 * radius
      x = 0
      y = radius

      svg.circle(cx: x0, cy: y0 + radius, r: 2, fill: stroke_color)
      svg.circle(cx: x0, cy: y0 - radius, r: 2, fill: stroke_color)
      svg.circle(cx: x0 + radius, cy: y0, r: 2, fill: stroke_color)
      svg.circle(cx: x0 - radius, cY: y0, r: 2, fill: stroke_color)

      lines = [radius - 1] unless fill_color == :transparent

      while x < y

        if f >= 0
          y -= 1
          dd_f_y += 2
          f += dd_f_y
        end

        x += 1
        dd_f_x += 2
        f += dd_f_x

        unless fill_color == :transparent
          lines[y] = lines[y] ? [lines[y], x - 1].min : x - 1
          lines[x] = lines[x] ? [lines[x], y - 1].min : y - 1
        end

        svg.circle(cx: x0 + x, cy: y0 + y, r: 2, fill: stroke_color)
        svg.circle(cx: x0 - x, cy: y0 + y, r: 2, fill: stroke_color)
        svg.circle(cx: x0 + x, cy: y0 - y, r: 2, fill: stroke_color)
        svg.circle(cx: x0 - x, cy: y0 - y, r: 2, fill: stroke_color)

        unless x == y
          svg.circle(cx: x0 + y, cy: y0 + x, r: 2, fill: stroke_color)
          svg.circle(cx: x0 - y, cy: y0 + x, r: 2, fill: stroke_color)
          svg.circle(cx: x0 + y, cy: y0 - x, r: 2, fill: stroke_color)
          svg.circle(cx: x0 - y, cy: y0 - x, r: 2, fill: stroke_color)
        end
      end

      unless fill_color == :transparent
        lines.each_with_index do |length, y_offset|
          if length > 0
            # line(x0 - length, y0 - y_offset, x0 + length, y0 - y_offset, fill_color)
            svg.line x1: x0 - length, y1: y0 - y_offset,  x2: x0 + length,  y2: y0 - y_offset, stroke: fill_color
          end
          if length > 0 && y_offset > 0
            # line(x0 - length, y0 + y_offset, x0 + length, y0 + y_offset, fill_color)
            svg.line x1: x0 - length, y1: y0 + y_offset,  x2: x0 + length,  y2: y0 + y_offset, stroke: fill_color
          end
        end
      end


      svg
    end
  end
end
