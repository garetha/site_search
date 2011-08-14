class ResultItem
  attr_accessor :url, :text, :page, :html

  def initialize(item)
    @url = item['link']
    @text = item['snippet']
    @page = item['displayLink']
    @html = item['htmlSnippet']
  end

end