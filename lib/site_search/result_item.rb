class ResultItem
  attr_reader :url, :text, :title, :html

  # Creates attributes that can easily be accessed from the view
  def initialize(item)
    @url = item['link']
    @text = item['snippet']
    @title = item['displayLink']
    @html = item['htmlSnippet']
  end

end