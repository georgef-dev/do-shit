# -*- encoding: utf-8 -*-
# stub: cli-kit 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cli-kit".freeze
  s.version = "5.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Burke Libbey".freeze, "Aaron Olson".freeze, "Lisa Ugray".freeze, "Don Kelly".freeze]
  s.bindir = "exe".freeze
  s.date = "1980-01-02"
  s.description = "Terminal UI framework extensions".freeze
  s.email = ["burke.libbey@shopify.com".freeze, "aaron.olson@shopify.com".freeze, "lisa.ugray@shopify.com".freeze, "don.kelly@shopify.com".freeze]
  s.executables = ["cli-kit".freeze]
  s.files = ["exe/cli-kit".freeze]
  s.homepage = "https://github.com/shopify/cli-kit".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.6.7".freeze
  s.summary = "Terminal UI framework extensions".freeze

  s.installed_by_version = "3.6.7".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<cli-ui>.freeze, ["~> 2.4".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0".freeze])
end
