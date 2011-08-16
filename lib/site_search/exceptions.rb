module SiteSearch
  # A general SiteSearch exception
  class Error < StandardError; end

  # The search engine could not be located due to an invalid cx record
  class InvalidSearchRequest < Error; end

  # The search engine has not been configured in the config yaml file
  class UndefinedSearchEngine < Error; end

  # The search engine has restricted access, likely cause is exceeding the Google Custom Search request limit
  class ForbiddenAccessToSearchEngine < Error; end

  # You can rescue from this error in the controller to display the error message provided or the default message
  class NoResults < Error
    attr_reader :query
    attr_writer :default_message

    def initialize(message = nil, query = nil)
      @message = message
      @query = query
      @default_message = "No results for '#{@query}'"
    end

    def to_s
      @message || @default_message
    end
  end

end