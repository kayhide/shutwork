require_relative 'lib/shutwork/version'

Gem::Specification.new do |spec|
  spec.name          = "shutwork"
  spec.version       = Shutwork::VERSION
  spec.authors       = ["Hideaki Kawai"]
  spec.email         = ["kayhide@gmail.com"]

  spec.summary       = "Chatwork CLI"
  spec.description   = "Chatwork CLI"
  spec.homepage      = "http://github.com/kayhide/shutwork"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", [">= 1.0.0", "< 2.0"]
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
