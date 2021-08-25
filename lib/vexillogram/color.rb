module Vexillogram::Color
  TINCTURES = {
    gules: :red,
    sable: :black,
    azure: :blue,
    vert: :green,
    purpure: :purple,
    blue_de_ciel: '#87CEEB', # #87CEEB, Bleu celeste, Sky Blue, Bleu de Ciel
    blue_celeste: :blue_de_ciel,
    brunâtre: :brown,
    brunatre: :brunâtre,
    carnation: '#FFDAB9', # pale or white human skin,
    cendrée: :grey, # cinder, ash grey
    cendree: :cendrée,
    cinder: :cendrée,
    ochre: '#CC7722', # both red and yellow
    rose: :pink
  }

  METALS = {
    argent: :white,
    or: :yellow,
    copper: '#FCC6B2',
    buff: '#E0AB76'
  }

  STAINS = {
    murrey: '#8b004b', # mulberry
    sanguine: :fire_brick, # blood red
    tenné: '#c67000', # tawny
    tenne: :tenné
  }

  COLORS = TINCTURES.merge(METALS).merge(STAINS)

  def self.resolve_color(clr)
    while !(lookup_color = COLORS[clr]).nil?
      clr = lookup_color
    end
    clr
  end
end
