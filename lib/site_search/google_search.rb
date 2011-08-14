module SiteSearch
  require 'uri'
  require 'net/https'

  class GoogleSearch
    require 'json'
    require 'rexml/document'
    attr_reader :results, :total, :start_index

    def initialize(query, format=:json)
      @query = query
      @results = []
      doc = get_document(set_uri(format))
      case format
        when :json
          then parse_json(doc)
        when :atom
          then parse_atom(doc)
      end
    end

    private
    def set_uri(format)
      cx = "009686358712893010562:1sgasn_tetk"
      key = "AIzaSyB8yG2b3JbJignXug-ejxEPbe8WQMqSDLE"
      params = "key=#{key}&cx=#{cx}&q=#{@query}&alt=#{format}"
      return URI.parse("https://www.googleapis.com/customsearch/v1?#{params}")
    end

    def get_document(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      return http.request(Net::HTTP::Get.new(uri.request_uri))
    end

    def parse_json(doc)
      results_hash = JSON.parse(doc.body)

      results_hash['queries']['request'].each do |r|
        @total =r['totalResults']
        @start_index = r['startIndex']
      end

      raise NoResults.new(nil, @query) if @total.to_i < 1

      items = results_hash['items']
      items.each do |item|
        @results << ResultItem.new(item)
      end
    end

    def parse_atom(doc)
      atom = REXML::Document.new(doc.body)

      @total = atom.elements["//opensearch:totalResults"].text
      raise NoResults.new(nil, @query) if @total.to_i < 1

      @start_index = atom.elements["//opensearch:startIndex"].text

      REXML::XPath.each(atom, "//entry").each do |el|
        item = {}
        item.store('link',el.elements["link"].attributes["href"])
        item.store('displayLink',el.elements["link"].attributes["title"])
        item.store('htmlSnippet',el.elements["summary"].text)
        if item['htmlSnippet'].is_a? String
          item.store('snippet',(item['htmlSnippet']).gsub(/<\/?[^>]*>/, ""))
        end
        @results << ResultItem.new(item)
      end

    end

  end

end