require 'test_helper'
require 'rexml/document'
require 'json'

class SiteSearchTest < ActiveSupport::TestCase

  test "default is json" do
    search = SiteSearch::GoogleSearch.new(:appslite, 'application')
    json = JSON.parse(search.raw)
    assert_kind_of Hash, json
  end

  test "json" do
    search = SiteSearch::GoogleSearch.new(:appslite, 'application', {:alt=>'json'})
    json = JSON.parse(search.raw)
    assert_kind_of Hash, json
  end

  test "atom" do
    search = SiteSearch::GoogleSearch.new(:appslite, 'application', {:alt=>'atom'})
    xml = REXML::Document.new(search.raw)
    assert_kind_of REXML::Document, xml
  end
end
