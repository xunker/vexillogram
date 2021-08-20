# run with `bundle exec ruby examples/burkina_faso.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_France
# A vertical tricolour of blue, white, and red
# Aspect: 2:3

flag = Vexillogram.new('France') do
  add(Vexillogram::Element::Field.new {
    [
      Vexillogram::Element::VerticalBand.new(color: 'blue', from: 0, to: 0.33),
      Vexillogram::Element::VerticalBand.new(color: 'white', from: 0.33, to: 0.66),
      Vexillogram::Element::VerticalBand.new(color: 'red', from: 0.66, to: 1)
    ]
  })
end

flag.save
# => "france.svg"
