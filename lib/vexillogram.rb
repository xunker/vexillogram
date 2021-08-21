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
require_relative 'vexillogram/element/defacement'
require_relative 'vexillogram/element/disc'
require_relative 'vexillogram/element/field'
require_relative 'vexillogram/element/horizontal_band'
require_relative 'vexillogram/element/maple_leaf'
require_relative 'vexillogram/element/nordic_cross'
require_relative 'vexillogram/element/pale'
require_relative 'vexillogram/element/star'
require_relative 'vexillogram/element/vertical_band'

class Vexillogram
  attr_accessor :name, :image_width, :image_height, :hoist_width, :fly_length, :field, :elements, :svg

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
      svg << element.draw(self)
    end

    if @opts.fetch(:border)
      svg.rect x: 0, y: 0, width: image_width, height: image_height, rx: 0, style: { stroke: 'black', fill: nil, fill_opacity: 0 }
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
