class RegexWordFinderController < ApplicationController
  respond_to :html, :js

  def index
    @words = nil
  end

  def word_search
    @words = []
    pattern = params[:pattern].downcase.tr('a-z', '')
    letters = params[:letters].downcase.tr('a-z', '')

    letters_regex = '[' + letters + ']'

    general_regex_text = pattern.gsub(/_/, letters_regex).gsub(/\*/,
                                                          letters_regex + '*')
    pattern_regex = Regex.new general_regex_text

    words_set = Hash.new False
  end
end
