# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_audio_sequencer/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_audio_sequencer"
  spec.version       = EasyAudioSequencer::VERSION
  spec.authors       = ["Jonathan Slate"]
  spec.email         = ["jslate@patientslikeme.com"]
  spec.summary       = %q{A ruby sequencer using easy_audio}
  spec.description   = %q{I took the sample sequencer code from lsegal's easy_audio gem and created a gem out of it.}
  spec.homepage      = "https://github.com/jslate/easy_audio_sequencer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 0'
end
