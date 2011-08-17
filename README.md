# SiteSearch

This gem provides a simple and extremely flexible way to include site-wide searching in Rack based web applications, such as Ruby on Rails.

## Installation

Install the latest stable release:

	[sudo] gem install site_search

In Rails, add it to your Gemfile:

``` ruby
gem 'site_search'
```

## Getting Started

Start off by generating the required config and initializer files:

    Rails 3

	    rails generate site_search:google_custom_search

	Rails 2.3

	    ruby script/generate site_search:google_custom_search

this should give you files in:

	config/initializers/load_site_search_config.rb
	config/google_custom_search.yml

## Configuring SiteSearch

SiteSearch currently only supports Google Custom Search and allows for multiple search engines to be configured and utilized.

Edit the google_custom_search.yml file in config/

``` yaml
production:
  api_key: "YOUR-API-KEY"
  search_engines:
    your_search_engine:
        cx: "YOUR-CX-RECORD"
```

An initializer file is required to load the config settings, if you're using Rails, one is created for you:

## Using SiteSearch

In your controller create an instance of the GoogleSearch class by passing the name of the search engine and the search arguments:

``` ruby
@search = SiteSearch::GoogleSearch.new(:your_search_engine, params[:query_string])
```

You can then access the results in the view like so:

``` ruby
<% @search.results.each do |result| %>
    <%= result.title %>
    <%= result.text %>
    <%= result.url %>
<% end %>
```

You can also access the raw document that is received from the Google Custom Search API.

``` ruby
@search.raw
```

The GoogleSearch class also accepts optional query parameters(check out the [Google Custom Search API](http://code.google.com/apis/customsearch/v1/using_rest.html#query-params) for details), for example the alt parameter for specifying the format
of the response, can either be json(default) or atom.

``` ruby
@search = SiteSearch::GoogleSearch.new(:your_search_engine, params[:query_string], {:alt=>'atom'})
```

## Contributing to SiteSearch

Contributions are appreciated and pull requests are very welcome. Before submitting a pull request,
please make sure that your changes are well tested.

## License

Copyright (c) 20011 Gareth Allen

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.