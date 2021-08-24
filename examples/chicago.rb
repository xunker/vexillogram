# run with `bundle exec ruby examples/chicago.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Chicago
# Aspect: 2:3
# Argent four mullets of six points gules in fess between two bars bleu de ciel.
#
# > The flag of Chicago consists of two blue horizontal bars, or stripes, on a field of white, each
# > bar one-sixth the height of the full flag, and placed slightly less than one-sixth of the way
# > from the top and bottom. Four bright red stars, with six sharp points each, are set side by
# > side, close together, in the middle third of the surface of the flag.

flag = Vexillogram.new('Chicago', image_width: 200, aspect_ratio: '2:3') do
  add(Vexillogram::Element::Field.new(color: :white))

  stripe_width = (1.0/6.0).round(2)
  stripe_offset = (1.0/5.9).round(2)

  add([
    Vexillogram::Element::HorizontalBand.new(
      color: '#87CEEB', from: stripe_offset, to: stripe_width+stripe_offset
    ),

    Vexillogram::Element::HorizontalBand.new(
      color: '#87CEEB', from: 1.0 - (stripe_width+stripe_offset), to: 1.0 - stripe_offset
    )
  ])

  add(
    Vexillogram::Element::Charge.new(arrangement: :in_fess) {
      [
        Vexillogram::Element::Star.new(color: :red, points: 6, size: 0.25, relative_to: :hoist_width),
        Vexillogram::Element::Star.new(color: :red, points: 6, size: 0.25, relative_to: :hoist_width),
        Vexillogram::Element::Star.new(color: :red, points: 6, size: 0.25, relative_to: :hoist_width),
        Vexillogram::Element::Star.new(color: :red, points: 6, size: 0.25, relative_to: :hoist_width)
      ]
    }
  )
end

flag.save
# => "chicago.svg"

