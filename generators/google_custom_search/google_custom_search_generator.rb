class GoogleCustomSearchGenerator < Rails::Generator::Base

  def manifest # this method is default entrance of generator
    record do |m| #Convenience method for generator subclasses to record a manifest.
      m.template "google_custom_search.yml",File.join("config","google_custom_search.yml")
      m.template "load_site_search_config.rb",File.join("config","initializers","load_site_search_config.rb")
    end
  end

end