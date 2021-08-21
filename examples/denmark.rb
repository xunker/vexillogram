# run with `bundle exec ruby examples/denmark.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Denmark
# A red field charged with a white Nordic cross that extends to the edges; the vertical part of the cross is shifted to the hoist side. Dimensions: 3:1:3 width / 3:1:4.5 to 3:1:5.25 length.
# Aspect: 14:17

flag = Vexillogram.new('Denmark', aspect_ratio: '14:17') do
  add(Vexillogram::Element::Field.new(color: 'red'))

  add(
    Vexillogram::Element::Charge.new {
      Vexillogram::Element::NordicCross.new(color: 'white', horizontal: '3:1:4.5', vertical: '3:1:3')
    }
  )
end

flag.save
# => "denmark.svg"
