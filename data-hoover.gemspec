# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_hoover/version'

Gem::Specification.new do |spec|
  spec.name          = 'data-hoover'
  spec.version       = DataHoover::VERSION
  spec.authors       = ['Thomas Larrieu', 'Bryan Frimin']
  spec.email         = %w(thomas.larrieu@gmail.com friminb@gmail.com)

  spec.summary       = 'Event sourcing for human beings'
  spec.description   = 'This gem exposes a simple API to implement event' \
    'sourcing in your app.'
  spec.homepage      = 'https://github.com/jobteaser/data-hoover'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  # TODO: this should be an optional dependency (segment)
  spec.add_dependency 'analytics-ruby'
end
