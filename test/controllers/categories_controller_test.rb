require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get Deals' do
    get categories_Deals_url
    assert_response :success
  end
end
