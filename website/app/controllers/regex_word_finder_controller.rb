class RegexWordFinderController < ApplicationController
  respond_to :html, :js

  def index
    @words = nil
  end

  def word_search
    @words = []
    @words << params[:pattern]
  end
end
