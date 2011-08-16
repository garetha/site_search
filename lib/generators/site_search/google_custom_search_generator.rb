module SiteSearch
  module Generators
    class GoogleCustomSearchGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_google_custom_search
        copy_file "google_custom_search.yml", "config/google_custom_search.yml"
        copy_file "load_site_search_config.rb", "config/initializers/load_site_search_config.rb"
      end
    end
  end
end