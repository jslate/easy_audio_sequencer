# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_audio_sequencer/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_audio_sequencer"
  spec.version       = EasyAudioSequencer::VERSION
  spec.authors       = ["Jonathan Slate"]
  spec.email         = ["jslate@patientslikeme.com"]
  spec.summary       = %q{Packaging lsegal's example sequencer from his easy_audio into a gem.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
