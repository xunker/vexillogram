https://en.wikipedia.org/wiki/Glossary_of_vexillology
https://www.reddragonflagmakers.co.uk/pages/glossary-of-terms
https://flags.fandom.com/wiki/VexiWiki:Glossary

Dictionary of Vexillology: Introduction: https://www.fotw.info/flags/vxt-dvex.html
Dictionary of Vexillology: Index of Terms (A-B): https://www.fotw.info/flags/vxt_dvia.html

THIS!!: Dictionary of Vexillology: Proposed Vexillological Conventions: https://www.crwflags.com/fotw/flags/vxt_dvcv.html

Pennant-style flags: https://en.wikipedia.org/wiki/Pennon
https://en.wikipedia.org/wiki/List_of_non-rectangular_flags
"triangular, tapering or triangular swallowtail"

https://en.wikipedia.org/wiki/List_of_aspect_ratios_of_national_flags

Uses: https://en.wikipedia.org/wiki/Vexillological_symbol
`uses :civil, :state`
`uses :civil; uses << :state`

Blazon: https://en.wikipedia.org/wiki/Blazon
a blazon is a formal description of a coat of arms, flag or similar emblem, from which the reader can reconstruct the appropriate image.
https://drawshield.net/create/

# thigns to imp,ement

* Border/bordure
* Canton
* Impale/Impaled
  1. (v) In heraldry a term for the marshalling of (or having earlier marshalled) two sets of arms side-by-side on a shield or banner of arms to indicate marriage or alliance – empale (see also ‘banner of arms’, ‘coat of arms 2)’, ‘dimidiated’, ‘entire 1)’, ‘escutcheon of pretence 2), ‘marshalling’, ‘point-in-point’, ‘quarter the arms’ and ‘quartering 1)’)
  2. (v) On flags as above, but the images placed on a flag need not be arms as defined herein.
* Quadrisection
  - aka Quartering
* Greek Cross (Switzerland)
* Symmetric cross
* Nordic Cross
* Pale
* Fess
* Bend
* Chevron
* Pall
  - An example of a pall placed horizontally (fesswise) is the green portion of the South African national flag.
* Saltire
* Defacement
  - Defacement, in heraldry and vexillology, is the addition of a symbol or charge to another flag
  - For our purposes, can be a synonym for Charge

# --- test exmples

```ruby
flag = RubyVexillology.new('USA') do
  format :quadrilateral # default
  aspect_ratio '2:3'    # default
  canton do # upper hoist quarter by default
    color :blue # or hex/cmyk/pantone value
  end
end

# https://en.wikipedia.org/wiki/Flag_of_Denmark
# A red field charged with a white Nordic cross that extends to the edges; the vertical part of the
# cross is shifted to the hoist side.
# https://en.wikipedia.org/wiki/Nordic_cross_flag
flag = RubyVexillology.new('Denmark') do
  format :quadrilateral # default
  aspect_ratio '14:17'    # default

  field(:red) do
    charge do # charge is implicit and not needed, but allowed. Assumes horiz/vert centered
      cross do
        color :white
        style :nordic # centre of the cross shifted towards the hoist
        # Dimensions: 3:1:3 width / 3:1:4.5 to 3:1:5.25 length.
      end
    end
  end
end

# https://en.wikipedia.org/wiki/Flag_of_Sweden
# A blue field charged with a yellow Nordic cross that extends to the edges; the vertical part of
# the cross is shifted to the hoist side.
flag = RubyVexillology.new('Sweden') do
  format :quadrilateral # default
  aspect_ratio '14:17'    # default

  field :blue
  charge do
    cross do
      color :yellow
      style :nordic # centre of the cross shifted towards the hoist
      # Dimensions: 5:2:9 horizontally and 4:2:4 vertically.
    end
  end
end

# https://www.crwflags.com/fotw/flags/ch.html
flag = RubyVexillology.new('Switzerland') do
  format :quadrilateral # default
  aspect_length 1 # The span of a flag along the side at right angles to the flagpole
  aspect_width 1 # The span of a flag down the side parallel to the flagpole.
                 # syn: aspect_breadth

  field :red

  cross(:white) do # centered is default
    # style :equilateral
    # arm_width flag_width / 4.6
    # arm_length arm_width * 1.17

    # or

    arm_length flag_length * 1.375
    arm_width flag_width / 4.6
  end
end

# https://en.wikipedia.org/wiki/Flag_of_Burkina_Faso
# Two horizontal bands of red and green with a yellow five-pointed star in the center.
flag = RubyVexillology.new('Burkina Faso') do
  aspect_ratio '2:3'
  stripe(:horizontal, :red).over( # syn. band()
    stripe(:horizontal, :green)
  )

  charge do
    star do
      color :yellow
      points 5 # default
    end
  end
end

# https://en.wikipedia.org/wiki/Flag_of_Austria
# A horizontal triband of red (top and bottom) and white.
flag = RubyVexillology.new('Austria') do
  aspect_ratio '2:3'

  horizontal do
    triband( # top to bottom
      band(:red),
      band(:white),
      band(:red)
    )
  end

  # or
  horizontal.triband( :red, :white, :red )
end

# https://en.wikipedia.org/wiki/Flag_of_France
# A vertical tricolour of blue, white, and red
flag = RubyVexillology.new('France') do
  aspect_ratio '2:3'

  vertical do
    tricolor( # hoist to fly
      band(:blue),
      band(:white),
      band(:red)
    )
  end

  # or
  vertical.tricolor( :blue, :white, :red )
end


flag = RubyVexillology.new('Nepal') do
  format :pennon
  variant :dual_triangle_lower_points
end

flag.save('flag.png')
flag.save('flag.svg', format: :svg)
flag.to_svg.save('flag.svg')
```
