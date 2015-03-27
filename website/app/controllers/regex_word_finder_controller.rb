class RegexWordFinderController < ApplicationController
  respond_to :html, :js

  def index
    @words = nil
  end

  def word_search
    @words = []
    pattern = params[:pattern].downcase.tr('^a-z_*', '')
    letters = params[:letters].downcase.tr('^a-z_*', '')

    letters_regex = '[' + letters + ']'

    if letters.include? '_'
      letters_regex = '.'
    end

    general_regex_text = '^' + pattern.gsub('_', letters_regex).gsub('*',
      letters_regex + '*') + '$'

    pattern_regex = Regexp.new general_regex_text

    words_set = Hash.new FALSE

    # Pass 1
    text=File.open(File.expand_path('app/assets/ospd.txt')).read
    text.each_line do |line|
        line = line.tr('^a-z', '')
        unless line.match(pattern_regex).nil?
            words_set[line] = TRUE
        end
    end

    # Pass 2
    words_set.each_key do |word|
        letters_set = Hash.new 0

        letters_pool = pattern.gsub('_', '').gsub('*', '') + letters

        letters_pool.each_char do |c|
          letters_set[c] = letters_set[c] + 1
        end

        unless can_make_word_with_letters(word, letters_set)
          words_set.delete word
        end
    end

    # Assemble results
    words_set.each_key do |word|
        @words << word
    end
  end

  private

  def can_make_word_with_letters(word, letters)
    word.each_char do |c|
      if letters[c] > 0
        letters[c] = letters[c] - 1
      elsif letters['_'] > 0
        letters['_'] = letters['_'] - 1
      else
        return FALSE
      end
    end
    TRUE
  end

end
