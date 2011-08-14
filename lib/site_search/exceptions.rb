module SiteSearch
  # A general SiteSearch exception
  class Error < StandardError; end

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