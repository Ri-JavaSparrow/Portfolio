require 'test_helper'

class PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get portfolio_top_url
    assert_response :success
  end

end
