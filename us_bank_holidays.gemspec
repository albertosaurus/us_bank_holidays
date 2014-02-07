# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'us_bank_holidays/version'

Gem::Specification.new do |spec|
  spec.name          = "us_bank_holidays"
  spec.version       = UsBankHolidays::VERSION
  spec.authors       = ["Arthur Shagall"]
  spec.email         = ["arthur.shagall@gmail.com"]
  spec.description   = %q{Simplify working with US bank holidays.}
  spec.summary       = %q{Patches Date to add methods to make dealing with US bank holidays simpler.}
  spec.homepage      = "https://github.com/albertosaurus/us_bank_holidays"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/) - ['.gitignore', '.rvmrc', '.rspec']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
