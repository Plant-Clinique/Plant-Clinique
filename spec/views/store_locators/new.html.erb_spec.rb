require 'rails_helper'

RSpec.describe "store_locators/new", type: :view do
  before(:each) do
    assign(:store_locator, StoreLocator.new())
  end

  it "renders new store_locator form" do
    render

    assert_select "form[action=?][method=?]", store_locators_path, "post" do
    end
  end
end
