module SiteSearch
  module Generators
    class GoogleCustomSearchGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_google_custom_search
        copy_file "google_custom_search.yml", "config/google_custom_search.yml"
      end
    end
  end
end