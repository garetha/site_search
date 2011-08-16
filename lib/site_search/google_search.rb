module SiteSearch
  require 'uri'
  require 'net/https'

  class GoogleSearch
    require 'json'
    require 'rexml/document'
    attr_reader :results, :total, :start_index, :raw

    alias_method :raw?, :raw

    def initialize(search_engine, query, options={})
      raise NoResults.new if query.blank?
      @query = escape_html(query).gsub(" ", '+')
      @results = []
      doc = get_document(set_uri(options, search_engine.to_s))
      @raw = doc.body
      case options[:alt]
        when 'atom' then parse_atom(doc)
        else parse_json(doc)
      end
    end

    private
    def escape_html(str)
      str.gsub(/<\/?[^>]*>/, "")
    end

    def set_uri(options, search_engine)
      raise(UndefinedSearchEngine, "'#{search_engine}' is undefined for #{self.class}") if !GOOGLE_SEARCH_CONFIG['search_engines'].has_key? search_engine

      key = GOOGLE_SEARCH_CONFIG['api_key']
      cx = GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['cx']

      params = "key=#{key}&cx=#{cx}&q=#{@query}"

      options_hash = {}

      options_hash.store('cref', GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['cref'])
      options_hash.store('lr', GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['lr'])
      options_hash.store('num', options[:num] || GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['num'])
      options_hash.store('safe', options[:safe] || GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['safe'])
      options_hash.store('start', options[:start] || GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['start'])
      options_hash.store('filter', options[:filter] || GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['filter'])
      options_hash.store('alt', options[:alt] || GOOGLE_SEARCH_CONFIG['search_engines'][search_engine]['alt'])

      options_hash.each do |k, v|
        params = params + "&#{k}=#{v}" if v.present?
      end

      return URI.parse("https://www.googleapis.com/customsearch/v1?#{params}")
    end

    def get_document(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      return http.request(Net::HTTP::Get.new(uri.request_uri))
    end

    def parse_json(doc)
      json = JSON.parse(doc.body)
      case doc
        when Net::HTTPSuccess
        then
          json['queries']['request'].each do |r|
            @total =r['totalResults']
            @start_index = r['startIndex']
          end
          raise NoResults.new(nil, @query) if @total.to_i < 1
          items = json['items']
          items.each do |item|
            @results << ResultItem.new(item)
          end
        when Net::HTTPForbidden then raise ForbiddenAccessToSearchEngine, json['error']['message']
        else raise InvalidSearchRequest, json['error']['message']
      end
    end

    def parse_atom(doc)
      atom = REXML::Document.new(doc.body)
      case doc
        when Net::HTTPSuccess
        then
          @total = atom.elements["//opensearch:totalResults"].text
          raise NoResults.new(nil, @query) if @total.to_i < 1
          @start_index = atom.elements["//opensearch:startIndex"].text
          REXML::XPath.each(atom, "//entry").each do |el|
            item = {}
            item.store('link', el.elements["link"].attributes["href"])
            item.store('displayLink', el.elements["link"].attributes["title"])
            item.store('htmlSnippet', el.elements["summary"].text)
            if item['htmlSnippet'].is_a? String
              item.store('snippet', escape_html(item['htmlSnippet']))
            end
            @results << ResultItem.new(item)
          end
        when Net::HTTPForbidden then raise ForbiddenAccessToSearchEngine, atom.elements["//internalReason"].text
        else raise InvalidSearchRequest, atom.elements["//internalReason"].text
      end
    end

  end

end