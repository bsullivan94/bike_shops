require_relative 'lib/bike_shops/version'

Gem::Specification.new do |spec|
  spec.name          = "bike_shops"
  spec.version       = BikeShops::VERSION
  spec.authors       = ["crisp-reducer-1650"]
  spec.email         = ["“brodysullivan0@gmail.com”"]

  spec.summary       = %q{BikeShops CLI Gem}
  spec.description   = %q{Provides CLI you can run to find bike shops by location from Yelp API.}
  spec.homepage      = "https://github.com/bsullivan94/bike_shops"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  #spec.bindir        = "exe"
  spec.executables   = ["bike_shops"]
  spec.require_paths = ["lib"]

  spec.add_dependency "http"
  spec.add_development_dependency "pry"
end
