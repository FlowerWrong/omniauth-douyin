require_relative 'lib/omniauth/douyin/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-douyin'
  spec.version       = Omniauth::Douyin::VERSION
  spec.authors       = ['flowerwrong']
  spec.email         = ['']

  spec.summary       = 'Douyin oauth2 strategy for OmniAuth 1.0'
  spec.description   = 'Douyin oauth2 strategy for OmniAuth 1.0'
  spec.homepage      = 'https://github.com/FlowerWrong/omniauth-douyin'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/FlowerWrong/omniauth-douyin'
  spec.metadata['changelog_uri'] = 'https://github.com/FlowerWrong/omniauth-douyin'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth', '>= 1.9.1'
  spec.add_dependency 'omniauth-oauth2', '>= 1.7.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
end
