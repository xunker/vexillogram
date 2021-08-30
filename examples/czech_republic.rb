# run with `bundle exec ruby examples/czech_republic.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_the_Czech_Republic
# Aspect: 2:3
# Two equal horizontal bands of white (top) and red with a blue isosceles triangle based on the
# hoist side.
#
# Measurements: https://en.wikipedia.org/wiki/File:Czech_flag_construction.svg

flag = Vexillogram.new('Czech Republic', aspect_ratio: '2:3') do
  add(
    [
      Vexillogram::Element::HorizontalBand.new(color: :white, from: 0, to: 0.5),
      Vexillogram::Element::HorizontalBand.new(color: :red, from: 0.5, to: 1.0),
      Vexillogram::Element::Charge.new {
        Vexillogram::Element::Triangle.new(color: :blue, hoist_width: 1, fly_length: 0.5, apex: 0.5, base: :hoist)
      }
    ]
  )
end

flag.save
# => "czech_republic.svg"

