require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test "a search returns results" do
    visit new_search_path
    assert page.has_content?('New Search')

    fill_in 'query', :with => 'application'
    click_button 'Search'

    assert page.has_content?("Search results for 'application'")
  end

  test "a search returns no results" do
    visit new_search_path
    assert page.has_content?('New Search')

    fill_in 'query', :with => 'hello'
    click_button 'Search'

    assert page.has_content?("No results for 'hello'")
  end

end
