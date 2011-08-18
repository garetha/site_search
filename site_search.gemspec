# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "site_search"
  s.author = "Gareth Allen"
  s.email = "gaz.allen12@gmail.co.uk"
  s.homepage = "http://github.com/garetha/site_search"
  s.summary = "Provides site searching capabilities to rack applications using the Google Custom Search API"
  s.description = "SiteSearch allows for multiple Google Custom Search engines to be configured, and provides JSON and Atom formats"
  s.files = Dir["{app,lib,config,generators}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.require_path = "lib"
  s.version = "0.0.5"

  s.add_dependency('json')

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end