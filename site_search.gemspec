# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "SiteSearch"
  s.author = "Gareth Allen"
  s.email = "gaz.allen12@gmail.co.uk"
  s.homepage = "http://github.com/garetha/site_search"
  s.summary = "Provides site searching capabilities to rack applications using the Google Custom Search API"
  s.description = "SiteSearch allows for multiple Google Custom Search engines to be configured, and provides JSON and Atom formats"
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.version = "0.0.1"
end