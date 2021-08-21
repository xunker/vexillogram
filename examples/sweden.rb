# run with `bundle exec ruby examples/sweden.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Sweden
# A blue field charged with a yellow Nordic cross that extends to the edges; the vertical part of the cross is shifted to the hoist side. Dimensions: 5:2:9 horizontally and 4:2:4 vertically.
# Aspect: 5:8

flag = Vexillogram.new('Sweden', aspect_ratio: '5:8') do
  add(Vexillogram::Element::Field.new(color: 'blue'))

  add(
    Vexillogram::Element::NordicCross.new(color: 'yellow', horizontal: '5:2:9', vertical: '4:2:4')
  )
end

flag.save
# => "sweden.svg"
