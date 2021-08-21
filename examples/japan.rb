# run with `bundle exec ruby examples/japan.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Japan
# Aspect: 2:3
# A red disc centered on a white rectangular banner
#
# Proportions from https://commons.wikimedia.org/wiki/File:Construction_sheet_of_the_Japanese_flag.svg

flag = Vexillogram.new('Japan', image_width: 200, aspect_ratio: '2:3') do
  add(Vexillogram::Element::Field.new(color: :white))

  add(
    Vexillogram::Element::Charge.new {
      Vexillogram::Element::Disc.new(color: :red, diameter: 0.6, relative_to: :hoist_width)
    }
  )
end

flag.save
# => "japan.svg"
