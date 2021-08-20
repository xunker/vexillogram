# frozen_string_literal: true

# class Vexillogram
#   module Element
#   end
# end
module Vexillogram::Element
end

require_relative "vexillogram/version"

require 'victor'

# require base element first before other elements
require_relative 'vexillogram/element/base'
require_relative 'vexillogram/element/canton'
require_relative 'vexillogram/element/charge'
require_relative 'vexillogram/element/field'
require_relative 'vexillogram/element/horizontal_band'
require_relative 'vexillogram/element/star'
require_relative 'vexillogram/element/vertical_band'


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
  class Error < StandardError; end
  # Your code goes here...
end
