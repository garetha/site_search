require 'test_helper'
require 'rexml/document'
require 'json'

class SiteSearchTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, SiteSearch
  end

  test "json" do
    search = SiteSearch::GoogleSearch.new(:appslite, 'application', :json)
    json = JSON.parse(search.raw)
    assert_kind_of Hash, json
  end

  test "atom" do
    search = SiteSearch::GoogleSearch.new(:appslite, 'application', :atom)
    xml = REXML::Document.new(search.raw)
    assert_kind_of REXML::Document, xml
  end
end
