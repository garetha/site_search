class SearchesController < ApplicationController
  rescue_from SiteSearch::NoResults do |exception|
    flash[:error] = exception.to_s
    render 'show'
  end

  def new
  end

  def show
  end

  def create
    @query = params[:query]
    @search = SiteSearch::GoogleSearch.new(@query, :atom)
    render 'show'
  end
end