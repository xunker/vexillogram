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

  # USA flag's canton is not actually one-quarter of the flag; because there are an off number of
  # stripes, it's a little taller than 50% of the total height.
  canton_height = (1.0/13) * 7
  add(
    Vexillogram::Element::Canton.new(
      color: :blue,
      height: canton_height, width: 0.5
    ) {
      stars_rows = [6, 5, 6, 5, 6, 5, 6, 5, 6]
      row_spacing = (canton_height / (stars_rows.length))
      col_spacing = (0.5 / 6)
      star_size = 0.025
      stars_rows.each_with_index.map{|star_count, row|
        star_count.times.map { |col|
          Vexillogram::Element::Star.new(
            translate_y: (row_spacing * row) + (row_spacing/2),
            translate_x: (col_spacing * col) + (col_spacing/2) + (row.odd? ? star_size*1.75 : 0.0),
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
