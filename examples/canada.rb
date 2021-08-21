# run with `bundle exec ruby examples/canada.rb`
require_relative '../lib/vexillogram'

# https://en.wikipedia.org/wiki/Flag_of_Canada
# Aspect: 1:2
# Wikipedia describes the Canadian flag as:
#
# > A vertical triband of red (hoist-side and fly-side) and white (double width) with the
# > red maple leaf centred on the white band.
#
# Canada, however, disagrees: (https://www.canada.ca/en/canadian-heritage/services/flag-canada-description.html)
#
# > The National Flag of Canada is a red flag[...]. In its centre is a white
# > square the width of the Flag[...]
#
# I would call that design a Pale, and since this is *my* rodeo I shall.

# proportions from https://www.canada.ca/en/canadian-heritage/services/flag-canada-description.html and
# https://en.wikipedia.org/wiki/Flag_of_Canada#/media/File:Flag_of_Canada_(construction_sheet_-_leaf_geometry).svg

flag = Vexillogram.new('Canada', image_width: 200, aspect_ratio: '1:2') do
  add(Vexillogram::Element::Field.new(color: 'red'))

  add(
    Vexillogram::Element::Pale.new(color: :white, vertical: '16:32:16')
  )

  add(
    # Defacement uses same code as Charge, different is purely linguistic
    Vexillogram::Element::Defacement.new {
      Vexillogram::Element::MapleLeaf.new
    }
  )
end

flag.save
# => "canada.svg"
