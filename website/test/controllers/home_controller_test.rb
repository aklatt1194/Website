require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get word_search" do
    get :word_search
    assert_response :success
  end

end
