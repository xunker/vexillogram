# frozen_string_literal: true

# class Vexillogram
#   module Element
#   end
# end
module Vexillogram::Element
end

require 'victor'

require_relative "vexillogram/version"
require_relative 'vexillogram/element'
require_relative 'vexillogram/primitive'

class Vexillogram
  attr_accessor :name, :image_width, :image_height, :hoist_width, :fly_length, :field, :elements

  def initialize(name = nil, opts = {}, &blk)
    @opts = {
      aspect_ratio: '2:3',
      image_width: 200,
      image_height: nil,
      field: '#fff',
      border: true
    }.merge(opts)

    @field = @opts[:field]
    @image_width = @opts[:image_width].to_i
    @image_height = @opts[:image_height].to_i

    if @opts[:aspect_ratio] && ([@opts[:hoist_width], @opts[:fly_length]].map(&:to_s).join.length < 1)
      @hoist_width, @fly_length = @opts[:aspect_ratio].split(':').map(&:to_f)
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
    [hoist_width, fly_length].join(':')
  end

  def aspect_proportion
    hoist_width / fly_length
  end

  def fly_length_to_image_width(fl)
    image_width * fl
  end

  def hoist_width_to_image_height(hw)
    image_height * hw
  end

  def save(filename = nil)
    # @svg = Victor::SVG.new width: @image_width, height: @image_height, style: { background: field }
    @svg = Victor::SVG.new width: @image_width, height: @image_height



    @elements.each do |element|
      # instance_eval(&element.draw)
      # @svg << element.draw(self)
      primitives = Array(element.primitives).flatten

      @svg << Victor::SVG.new.tap {|svg_partial|
        primitives.each do |primitive|
          svg_partial.element primitive.svg_shape, primitive.svg_attributes(self)
        end
      }
    end

    if @opts.fetch(:border)
      @svg.rect x: 0, y: 0, width: image_width, height: image_height, rx: 0, style: { stroke: 'black', fill: nil, fill_opacity: 0 }
    end

    filename ||= [name, :svg].join('.').gsub(/\s+/, '_').downcase
    @svg.save(filename)
  end

  def add(*elements)
    @elements += Array(elements).flatten
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
  class Error < StandardError; end
  # Your code goes here...
end
