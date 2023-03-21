# Vexillogram

Generate SVG image of a flag using a DSL based on standard vexillographical terms

## Description

> vexillogram (noun): A picture or design specification of a flag

The _Vexillogram_ gem implements a DSL (domain-specific language) that will output an SVG image of a flag, using the terms from vexillography (the study of flags).

### Example

The vexillographic description of the [flag of Burkina Faso](https://en.wikipedia.org/wiki/Flag_of_Burkina_Faso) is:

> Two horizontal bands of red and green with a yellow five-pointed star in the center. Proportion 2:3.

This can be translated in the _vexillogram_ DSL like this:

```ruby
Vexillogram.new('Burkina Faso', aspect_ratio: '2:3') do
  add(Vexillogram::Element::Field.new {
    [
      Vexillogram::Element::HorizontalBand.new(color: :gules, from: 0, to: 0.5),
      Vexillogram::Element::HorizontalBand.new(color: :vert, from: 0.5, to: 1.0),
      Vexillogram::Element::Charge.new {
        Vexillogram::Element::Star.new(color: :or, size: 0.25, points: 5)
      }
    ]
  })
end
```

..which will output the image as:

![Generated Flag of Burkina Faso](examples/burkina_faso.svg)

### More Examples

You can find all of the current examples in [the examples directory](examples/EXAMPLES.md).

## Scope and Purpose

_Vexillogram_ and the DSL is uses are meant to be __descriptive__, not __definitive__. The focus is on approximation, not completeness.

This means a flag description is not expected to include exact details, and the rendered output should not be expected to completely match the official version of the flag. Things such as exact size and placement of elements, complex representations, or anything involving precise detail are not the focus of this project.

## Installation

> 🚨 IMPORTANT:
>
> This gem is **not yet** in rubygems.org, so you must check out this code manually in
> order to use it. Thus, the instructions below are _not yet applicable_.

Add this line to your application's Gemfile:

```ruby
gem 'vexillogram'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install vexillogram

## Usage

See [examples](/examples).

JSON format and parser are also planned

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## To-Do

The to-do list is long and will probably always be, as long as humans keep using flags.
### Elements

* Border/bordure
* Canton
  - File present but not tested
* Impale/Impaled
  1. (v) In heraldry a term for the marshalling of (or having earlier marshalled) two sets of arms side-by-side on a shield or banner of arms to indicate marriage or alliance – empale (see also ‘banner of arms’, ‘coat of arms 2)’, ‘dimidiated’, ‘entire 1)’, ‘escutcheon of pretence 2), ‘marshalling’, ‘point-in-point’, ‘quarter the arms’ and ‘quartering 1)’)
  2. (v) On flags as above, but the images placed on a flag need not be arms as defined herein.
* Quadrisection
  - aka Quartering
* Greek Cross (Switzerland)
* Symmetric cross
* Fess
* Bend / Bend Sinister
* Chevron / Chevron Reversed / Chevron Arched or Enarched
* Pall
* Saltire
  - "diagonal cross as large as the flag with its endpoints on all four corners of the flag" (https://flags.fandom.com/wiki/VexiWiki:Glossary#S)
* Text Element
* "Placeholder" element
  - an enclosed primitive (rect, circle, poly) that contains text. The text names the Element that would be here if available
  - Example: Utah state flag, the Great Seal replaced placeholder of aproximate size and colour with text that reads "GREAT SEAL OF UTAH"
  - Clip the text to bounds of the placeholder
* Triangle
  - isosceles: a triangle that has two sides of equal length
  - "A horizontal charge whose apex lies along the meridian, and which may extend up to or slightly exceeding one-half the length of a flag, but whose base generally (but not exclusively) occupies the full width of the hoist" https://www.fotw.info/flags/vxt-dvt4.html#triangle
  - Example usage: Cuba, Czechia, Djibouti
  - Also: Voided Triangle
  - Also: Pile https://www.fotw.info/flags/vxt-dvp4.html#pile
    * "an isosceles triangle as long as the flag, with the hoist as its base"
    * AKA Triangle Throughout: https://www.fotw.info/flags/vxt-dvt4.html#triangle

### Arrangements of Charges
* Use "meridian" term: https://www.fotw.info/flags/vxt-dvm2.html#meridian
* Use Upper Hoist / Upper Fly term: https://flags.fandom.com/wiki/VexiWiki:Glossary#U
  - Assume there is a Lower Hoist and Lower Fly term as well
* Per Fess
* Per Pale
* Per Pall
* Per Saltire
* Per Bend
  * two separate objects or charges are placed across each other diagonally on a flag, shield or banner of arms - saltirewise, in_saltire

### Core

* A json format to represent the description of a flag, like the Ruby code but language-agnostic
  - A parser, to generate an SVG from a json description
  - A generator, to output a json description from the given Ruby code
* Patterns within an element to use with or instead of a colour (see https://en.wikipedia.org/wiki/Variation_of_the_field)
  * option to specify external file to use as pattern
* Shapes/Aspect Ratios
  - Nepal
  - Inclined-Fly
  - Pennon/Pennant, Swallow-tail, etc

## Contributing

Contributions of code **and** knowledge are welcome. There are many vexillographic conventions and terms that are still not universally agreed upon and civil discussion of the best way to handle these cases is always helpful.

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vexillogram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/vexillogram/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vexillogram project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vexillogram/blob/main/CODE_OF_CONDUCT.md).
