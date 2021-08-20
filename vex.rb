#!/usr/bin/env ruby

# https://github.com/DannyBen/victor
require 'victor'

# svg = Victor::SVG.new width: 140, height: 100, style: { background: '#ddd' }

# svg.build do
#   rect x: 10, y: 10, width: 120, height: 80, rx: 10, fill: '#666'

#   circle cx: 50, cy: 50, r: 30, fill: 'yellow'
#   circle cx: 58, cy: 32, r: 4, fill: 'black'
#   polygon points: %w[45,50 80,30 80,70], fill: '#666'

#   3.times do |i|
#     x = 80 + i*18
#     circle cx: x, cy: 50, r: 4, fill: 'yellow'
#   end
# end

# svg.save 'pacman'

# https://www.crwflags.com/fotw/flags/faq.html
# vexillogram. A picture or design specification of a flag.

class Vexillogram
  attr_accessor :name, :image_width, :image_height, :aspect_width, :aspect_length, :field, :elements, :svg

  def initialize(name = nil, opts = {}, &blk)
    opts = {
      aspect_ratio: '2:3',
      image_width: 200,
      image_height: nil,
      field: '#fff'
    }.merge(opts)

    @field = opts[:field]
    @image_width = opts[:image_width].to_i
    @image_height = opts[:image_height].to_i

    if opts[:aspect_ratio] && ([opts[:aspect_width], opts[:aspect_length]].map(&:to_s).join.length < 1)
      @aspect_width, @aspect_length = opts[:aspect_ratio].split(':').map(&:to_f)
    end

    if (@image_height.zero?)
      @image_height = (@image_width * aspect_proportion).round(2)
    elsif (@image_width.zero?)
      @image_width = (@image_height * aspect_proportion).round(2)
    end

    @name = name

    @elements = []

    instance_eval(&blk) if block_given?
    # yield(self) if block_given?
  end

  def aspect_ratio
    [aspect_width, aspect_length].join(':')
  end

  def aspect_proportion
    aspect_width / aspect_length
  end

  def save(filename = nil)
    # @svg = Victor::SVG.new width: @image_width, height: @image_height, style: { background: field }
    @svg = Victor::SVG.new width: @image_width, height: @image_height

    svg.rect x: 0, y: 0, width: image_width, height: image_height, rx: 0, style: { stroke: 'black', fill: 'white' }

    @elements.each do |element|
      # instance_eval(&element.draw)
      svg << element.draw(self)
    end

    filename ||= [name, :svg].join('.')
    @svg.save(filename)
  end

  def proportion_to_pixels(proportion_name, proportion_number)
    case proportion_name
    when :aspect_width
      (aspect_width / image_height) * (aspect_width * proportion_number)
    when :aspect_length
      (aspect_length / image_width) * (aspect_length * proportion_number)
    end
  end

  def add(element)
    @elements << element
  end

  def field(color = nil, opts = {})
    color ||= opts[:color]
    opts[:color] ||= color
    @elements << Elements::Field.new(opts)
  end

  def canton(color = nil, opts = {})
    color ||= opts[:color]
    opts[:color] ||= color

    @elements << Elements::Canton.new(opts)
  end

  module Elements
    class Base
      def initialize(opts = {}, &blk)
        @opts = (@defaults || {}).merge(color: '#fff').merge(opts)
      end
    end

    class HorizontalBand < Base
      def initialize(opts = {}, &blk)
        @defaults = {
          from: 0,
          to: 1
        }

        super
      end

      def draw(flag)
        Victor::SVG.new.tap{ | el|
          el.element(
            :rect,
            x: 0,
            y: flag.image_height*@opts[:from],
            width: flag.image_width,
            height: flag.image_height*@opts[:to] - flag.image_height*@opts[:from],
            rx: 0, fill: @opts[:color])
        }
      end
    end

    class VerticalBand < Base
      def initialize(opts = {}, &blk)
        @defaults = {
          from: 0,
          to: 1
        }
      end

      def draw(flag)
        Victor::SVG.new.tap{ | el|
          el.element(
            :rect,
            x: flag.image_width*@opts[:from],
            y: 0,
            width: flag.image_width*@opts[:to] - flag.image_width*@opts[:from],
            height: flag.image_height,
            rx: 0, fill: @opts[:color])
        }
      end
    end

    class Field < Base
      def initialize(opts = {}, &blk)
        super

        @elements = []
        if block_given?
          @elements += Array(instance_eval(&blk)).flatten
        else
          @elements << HorizontalBand.new(color: @opts[:color], from: 0, to: 1)
        end
      end

      # def draw(flag)
      #   HorizontalBand.new(color: @opts[:color], from: 0, to: 1).draw(flag)
      # end

      def draw(flag)
      #   @elements << HorizontalBand.new(color: @opts[:color], from: 0, to: 1)
      #   @elements << VerticalBand.new(color: '#f0f', from: 0.33, to: 0.66)

        Victor::SVG.new.tap {|svg|
          @elements.map do |element|
            svg << element.draw(flag)
          end
        }
      end
    end

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
    end

    class Canton < Base
      def initialize(opts = {}, &blk)
        super
      end

      def draw(flag)
        Victor::SVG.new.tap{ | el|
          el.element :rect, x: 0, y: 0, width: flag.image_width/2, height: flag.image_height/2, rx: 0, fill: @opts[:color]
        }
      end
    end
  end
end

flag = Vexillogram.new('Burkina Faso', image_width: 500) do
  add(Vexillogram::Elements::Field.new {
    [
      Vexillogram::Elements::HorizontalBand.new(color: 'red', from: 0, to: 0.5),
      Vexillogram::Elements::HorizontalBand.new(color: 'green', from: 0.5, to: 1.0)
    ]
  })

  add(
    Vexillogram::Elements::Charge.new {
      Vexillogram::Elements::Star.new(color: 'yellow', size: 0.25)
    }
  )
end

flag.save
