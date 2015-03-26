require 'test_helper'

class RegexWordFinderControllerTest < ActionController::TestCase
  test "should get word_search" do
    get :word_search
    assert_response :success
  end

end
