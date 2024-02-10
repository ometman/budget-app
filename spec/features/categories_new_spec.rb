require 'rails_helper'

RSpec.describe 'categories/new', type: :view do
  before(:each) do
    assign(:category, Category.new)
  end

  it 'renders the new category form' do
    render

    assert_select 'form[action=?][method=?]', user_categories_path(current_user), 'post' do
      assert_select 'input[name=?]', 'category[name]'
      # Add more assertions for other form fields if necessary
      assert_select 'input[type=?]', 'submit'
    end
  end
end
