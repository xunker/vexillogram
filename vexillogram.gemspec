# frozen_string_literal: true

require_relative "lib/vexillogram/version"

Gem::Specification.new do |spec|
  spec.name          = "vexillogram"
  spec.version       = Vexillogram::VERSION
  spec.authors       = ["Matthew Nielsen"]
  spec.email         = ["xunker@pyxidis.org"]

  spec.summary       = "Generate flag images from vexillographical terms"
  spec.description   = "Generate SVG image of a flag using a DSL based on standard vexillographical vocabulary"
  spec.homepage      = "https://github.com/xunker/vexillogram"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/xunker/vexillogram"
  spec.metadata["changelog_uri"] = "https://github.com/xunker/vexillogram/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # https://github.com/DannyBen/victor
  spec.add_dependency 'victor', ">= 0.3.3"
  # https://github.com/leejarvis/slop
  spec.add_dependency 'slop', ">= 4.0.0"

  spec.add_development_dependency 'byebug'
end
