# run with `bundle exec ruby examples/usa.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_the_United_States
# Thirteen horizontal stripes alternating red and white; in the canton, one
# white star for each state (50 stars as of 1960) arranged in horizontal rows
# (of alternating numbers of six and five stars per row as of 1960) on a blue
# field.

flag = Vexillogram.new('United States of America', aspect_ratio: '10:19') do
  stripe_height = 1.0/13

  13.times.map {|stripe_no|
    add(
      Vexillogram::Element::HorizontalBand.new(
        color: stripe_no.even? ? :red : :white,
        from: stripe_no * stripe_height,
        to: (stripe_no * stripe_height) + stripe_height
      )
    )
  }

  # USA flag's canton is not actually one-quarter of the flag; because there are
  # an off number of stripes, it's a little taller than 50% of the total height.
  canton_height = (1.0/13) * 7
  add(
    Vexillogram::Element::Canton.new(
      color: :blue,
      height: canton_height
    ) {
      row_spacing = (canton_height / 9) # 9 is number of rows of stars
      col_spacing = (0.5 / 6) # 6 is number of stars in an even numbered row
      star_size = 0.03
      9.times.map{|row|
        stars_on_row = row.even? ? 6 : 5
        stars_on_row.times.map { |col|
          col_offset = (row.odd? ? (star_size*1.25) : 0.0)
          Vexillogram::Element::Star.new(
            translate_y: (row_spacing * row) + (row_spacing/2),
            translate_x: (col_spacing * col) + (col_spacing/2) + col_offset,
            color: :white,
            size: star_size,
            points: 5
          )
        }
      }.flatten
    }
  )
end

flag.save
# => "usa.svg"
