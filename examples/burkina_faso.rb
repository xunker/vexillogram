# run with `bundle exec ruby examples/burkina_faso.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Burkina_Faso
# Two horizontal bands of red and green with a yellow five-pointed star in the center.
# Aspect: 2:3

flag = Vexillogram.new('Burkina Faso', image_width: 1000) do
  add(Vexillogram::Element::Field.new {
    [
      Vexillogram::Element::HorizontalBand.new(color: 'red', from: 0, to: 0.5),
      Vexillogram::Element::HorizontalBand.new(color: 'green', from: 0.5, to: 1.0)
    ]
  })

  add(
    Vexillogram::Element::Charge.new {
      Vexillogram::Element::Star.new(color: 'yellow', size: 0.25, points: 5)
    }
  )
end

flag.save
# => "burkina_faso.svg"
